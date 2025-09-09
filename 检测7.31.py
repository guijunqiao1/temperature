import cv2              # 处理视频和图像的工具
import time             # 处理时间的工具
import threading        # 实现"多任务同时运行"的工具
import queue            # 实现"数据排队"的工具
import logging          # 记录程序运行日志的工具
import sys              # 与系统交互的工具
import numpy as np      # 处理数值和数组的工具
import os               # 处理文件和文件夹的工具
from flask import Flask, Response  # 创建网页接口的工具
from flask_cors import CORS  # 跨域支持

# 配置日志
logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s - %(levelname)s - %(message)s',
    handlers=[
        logging.StreamHandler(sys.stdout),
        logging.FileHandler('rtsp_stream.log')
    ]
)
logger = logging.getLogger('RTSP_Stream')

# 摄像头配置
RTSP_URLS = [
    "rtsp://admin:admin@192.168.1.11:554/Streaming/Channels/101",
    "rtsp://admin:admin@192.168.1.12:554/Streaming/Channels/101",
    "rtsp://admin:admin@192.168.1.13:554/Streaming/Channels/101"
]
RTSP_PARAMS = "?transport=tcp&buffer_size=1024&fflags=nobuffer&flags=low_delay"     # 优化视频流参数
FULL_URLS = [url + RTSP_PARAMS for url in RTSP_URLS]                                # 拼接后的完整地址

# 全局变量
frame_lock = threading.Lock()
encoded_frames = [None, None, None]  # 存储三个摄像头编码后的帧数据(用于网络显示图片)
raw_frames = [None, None, None]  # 存储原始帧用于显示

# 视频质量参数
JPEG_QUALITY = 70           
FRAME_SCALE = 0.7
TARGET_DISPLAY_FPS = 50         # 保证帧率为50帧


class FrameTimestamp:
    """带时间戳的视频帧"""
    def __init__(self, frame):
        self.frame = frame
        self.timestamp = time.time() # 记录帧的获取时间


def check_hardware_acceleration():
    """检查并启用硬件加速解码"""
    logger.info("检查硬件加速支持...")
    try:
        test_cap = cv2.VideoCapture(FULL_URLS[0], cv2.CAP_FFMPEG)       # 打开第一个摄像头
        test_cap.set(cv2.CAP_PROP_HW_ACCELERATION, cv2.VIDEO_ACCELERATION_D3D11)    # 尝试使用D3D11加速
        if test_cap.isOpened():
            logger.info("启用D3D11硬件加速（低延迟模式）")
            test_cap.release()
            return cv2.VIDEO_ACCELERATION_D3D11
    except:
        pass
    acceleration_options = {
        cv2.VIDEO_ACCELERATION_ANY: "ANY",
        cv2.VIDEO_ACCELERATION_VAAPI: "VAAPI",
        cv2.VIDEO_ACCELERATION_NONE: "NONE"
    }
    for accel, name in acceleration_options.items():
        try:
            test_cap = cv2.VideoCapture(FULL_URLS[0], cv2.CAP_FFMPEG)
            test_cap.set(cv2.CAP_PROP_HW_ACCELERATION, accel)
            if test_cap.isOpened():
                logger.info(f"支持硬件加速: {name}")
                test_cap.release()
                return accel
        except:
            continue
    logger.warning("未找到硬件加速支持，使用软件解码")
    return cv2.VIDEO_ACCELERATION_NONE


class VideoStream:
    """视频流捕获类"""
    def __init__(self, rtsp_url, camera_index):
        self.rtsp_url = rtsp_url                # 摄像头地址
        self.camera_index = camera_index        # 摄像头编号
        self.cap = None                         # 视频捕获对象
        self.frame_queue = queue.Queue(maxsize=5)   # 存储视频帧的队列
        self.running = True                     # 是否继续工作
        self.retry_count = 0                    # 已经重连的次数
        self.max_retries = 10                   # 最多重试几次
        self.retry_delay = 2                    # 每次重连间隔多少秒
        self.last_frame_time = time.time()
        self.frame_counter = 0
        self.hw_accel = check_hardware_acceleration()
        self.connect()
        self.thread = threading.Thread(target=self.capture_thread, daemon=True)
        self.thread.start()
        logger.info(f"摄像头{self.camera_index + 1}视频捕获线程已启动")

    def connect(self):      # 连接摄像头函数
        if self.cap is not None:
            self.cap.release()
        logger.info(f"摄像头{self.camera_index + 1}尝试连接RTSP流: {self.rtsp_url}")
        try:
            os.environ["OPENCV_FFMPEG_CAPTURE_OPTIONS"] = "rtsp_transport;tcp|buffer_size;1024|flags;low_delay|analyzeduration;1000000|probesize;1000000"
            self.cap = cv2.VideoCapture(self.rtsp_url, cv2.CAP_FFMPEG)  # 尝试第一次连接
            
            if not self.cap.isOpened():     # 连接失败后的备用方案
                modified_url = self.rtsp_url
                if "?" not in modified_url:
                    modified_url += "?flags=low_delay"
                else:
                    modified_url += "&flags=low_delay"
                self.cap = cv2.VideoCapture(modified_url, cv2.CAP_FFMPEG)
                if not self.cap.isOpened():
                    logger.error(f"摄像头{self.camera_index + 1}连接失败")
                    return False

            self.cap.set(cv2.CAP_PROP_BUFFERSIZE, 1)
            self.cap.set(cv2.CAP_PROP_FPS, TARGET_DISPLAY_FPS)  # 检测目标帧率要求
            self.cap.set(cv2.CAP_PROP_HW_ACCELERATION, self.hw_accel)  # 硬件加速
            self.cap.set(cv2.CAP_PROP_FRAME_WIDTH, 1280)             # 画面宽度
            self.cap.set(cv2.CAP_PROP_FRAME_HEIGHT, 720)             # 画面高度
            
            try:        # 尝试使用高级压缩格式
                self.cap.set(cv2.CAP_PROP_FOURCC, cv2.VideoWriter_fourcc(*'H264'))
            except:
                try:
                    self.cap.set(cv2.CAP_PROP_FOURCC, cv2.VideoWriter_fourcc(*'MJPG'))
                except:
                    logger.warning("无法设置解码器，使用默认解码器")

            actual_fps = self.cap.get(cv2.CAP_PROP_FPS)
            logger.info(f"摄像头{self.camera_index + 1}连接成功，实际帧率: {actual_fps} FPS")
            if actual_fps < TARGET_DISPLAY_FPS:
                logger.warning(f"摄像头{self.camera_index + 1}不支持 {TARGET_DISPLAY_FPS} FPS，实际支持: {actual_fps} FPS")
            self.retry_count = 0
            return True
        except Exception as e:
            logger.error(f"连接过程中发生异常: {e}")
            return False

    def capture_thread(self):
        logger.info(f"摄像头{self.camera_index + 1}视频捕获线程运行中...")
        while self.running:
            if self.cap is None or not self.cap.isOpened():     # 检查是否正常连接状态
                if not self.reconnect():                        # 尝试重连
                    break
                continue
            try:
                ret, frame = self.cap.read()                    # 获取视频帧
                if not ret:
                    logger.warning(f"摄像头{self.camera_index + 1}读取帧失败")
                    time.sleep(0.001)
                    continue
                self.frame_counter += 1
                self.last_frame_time = time.time()

                # 更新原始帧队列
                with frame_lock:
                    raw_frames[self.camera_index] = frame.copy()

                with self.frame_queue.mutex:
                    self.frame_queue.queue.clear()
                self.frame_queue.put(FrameTimestamp(frame), block=False)

            except Exception as e:
                logger.error(f"摄像头{self.camera_index + 1}捕获线程异常: {e}")
                time.sleep(0.001)

    def reconnect(self):
        self.retry_count += 1
        if self.retry_count > self.max_retries:
            logger.error(f"摄像头{self.camera_index + 1}超过最大重连次数，停止尝试")
            return False
        logger.info(f"摄像头{self.camera_index + 1}尝试重连（第{self.retry_count}次）...")
        time.sleep(self.retry_delay)
        return self.connect()

    def read(self):
        try:
            return self.frame_queue.get(timeout=0.5)
        except queue.Empty:
            if time.time() - self.last_frame_time > 5:
                logger.warning(f"摄像头{self.camera_index + 1}超过5秒未接收到新帧")
            return None

    def release(self):
        logger.info(f"摄像头{self.camera_index + 1}释放视频流资源...")
        self.running = False
        if self.cap is not None:
            self.cap.release()
        self.cap = None


class DisplayEncoder(threading.Thread):
    """显示编码线程，负责将原始帧编码为JPEG用于Web显示"""
    def __init__(self, camera_index):
        super().__init__(daemon=True)
        self.camera_index = camera_index
        self.running = True
        self.last_encode_time = time.time()
        self.frame_lock = frame_lock
        self.target_fps = TARGET_DISPLAY_FPS
        self.frame_interval = 1.0 / self.target_fps

    def run(self):
        logger.info(f"摄像头{self.camera_index + 1}显示编码线程已启动（目标{self.target_fps} FPS）")
        while self.running:
            try:
                current_time = time.time()
                
                # 控制编码速度
                if current_time - self.last_encode_time < self.frame_interval:
                    time.sleep(self.frame_interval / 2)
                    continue
                
                with self.frame_lock:
                    frame = raw_frames[self.camera_index].copy() if raw_frames[self.camera_index] is not None else None
                if frame is None:
                    time.sleep(0.001)
                    continue

                # 缩放帧
                if FRAME_SCALE < 1.0:
                    frame = cv2.resize(frame, (0, 0), fx=FRAME_SCALE, fy=FRAME_SCALE)

                # JPEG编码
                ret, jpeg = cv2.imencode(
                    '.jpg', 
                    frame, 
                    [
                        int(cv2.IMWRITE_JPEG_QUALITY), JPEG_QUALITY,
                        int(cv2.IMWRITE_JPEG_PROGRESSIVE), 0,
                        int(cv2.IMWRITE_JPEG_OPTIMIZE), 1
                    ]
                )

                # 更新编码帧缓存
                with self.frame_lock:
                    encoded_frames[self.camera_index] = jpeg.tobytes()
                
                self.last_encode_time = current_time

            except Exception as e:
                logger.error(f"摄像头{self.camera_index + 1}显示编码线程异常: {e}")
                time.sleep(0.001)


# 创建Flask应用并配置CORS（跨域支持）
app = Flask(__name__)
CORS(app, resources={
    r"/stream/*": {"origins": "*"}  # 允许所有域名访问视频流
})


@app.route('/stream/<int:camera_index>')
def video_feed(camera_index):
    """视频流接口，返回原始视频画面"""
    def generate():
        while True:
            with frame_lock:
                current_frame = encoded_frames[camera_index]
            if current_frame is not None:
                yield (b'--frame\r\n'
                       b'Content-Type: image/jpeg\r\n'
                       b'Cache-Control: no-store, no-cache, must-revalidate\r\n'
                       b'Pragma: no-cache\r\n'
                       b'Expires: 0\r\n'
                       b'\r\n' + current_frame + b'\r\n')
            time.sleep(0.001)
    
    response = Response(generate(), mimetype='multipart/x-mixed-replace; boundary=frame')  
    response.headers['X-Accel-Buffering'] = 'no'
    return response             # 返回数据到网页端


def run_flask():
    app.run(host='0.0.0.0', port=5000, threaded=True, use_reloader=False, debug=False)


def main():
    # 启动Flask服务器
    flask_thread = threading.Thread(target=run_flask, daemon=True)
    flask_thread.start()
    logger.info("Flask服务器已启动在 http://0.0.0.0:5000")

    # 初始化三个视频流
    logger.info(f"正在初始化RTSP流...")
    streams = [VideoStream(url, i) for i, url in enumerate(FULL_URLS)]

    # 初始化三个显示编码器线程
    display_encoders = [DisplayEncoder(i) for i in range(3)]
    for encoder in display_encoders:
        encoder.start()

    # 主线程监控状态
    try:
        while True:
            time.sleep(1)
            # 每10秒打印一次状态
            if time.time() % 10 < 0.1:
                for i in range(3):
                    logger.info(f"摄像头{i+1}状态 - "
                               f"捕获: {streams[i].frame_counter}帧, "
                               f"最后更新: {time.time()-streams[i].last_frame_time:.1f}秒前")

    except KeyboardInterrupt:
        logger.info("用户请求退出")
    finally:
        # 释放资源
        for encoder in display_encoders:
            encoder.running = False
            
        for stream in streams:
            stream.release()                    # 释放视频流资源
        logger.info("程序已正常退出")


if __name__ == "__main__":
    try:
        main()
    except Exception as e:
        logger.exception(f"程序发生未处理异常: {e}")
        sys.exit(1)
