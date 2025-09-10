import cv2              # 处理视频和图像的工具（比如读取摄像头、截图、修改图片）
import time             # 处理时间的工具（比如暂停程序、记录时间）
import threading        # 实现"多任务同时运行"的工具（比如一边读摄像头，一边处理网页请求）
import queue            # 实现"数据排队"的工具（多任务之间安全传递数据）
import logging          # 记录程序运行日志的工具（比如什么时候出错了、什么时候启动了）
import sys              # 与系统交互的工具（比如退出程序）
import numpy as np      # 处理数值和数组的工具（图像在电脑里就是数组）
import torch            # 深度学习计算工具（支持GPU加速）
import os               # 处理文件和文件夹的工具（比如创建文件夹、检查文件是否存在）
import base64           # 把图片转换成文本的编码工具（方便在网络上传输图片）
import json             # 处理JSON数据的工具
from datetime import datetime  # 处理日期时间的工具（比如给截图命名时加时间戳）
from flask import Flask, jsonify, Response, request  # 创建网页接口的工具
from flask_cors import CORS  # 新增：跨域支持
from ultralytics import YOLO  # 导入YOLO模型（用于智能识别物体的工具）

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
RTSP_PARAMS = "?transport=tcp&buffer_size=1024&fflags=nobuffer&flags=low_delay"     #优化视频流参数
FULL_URLS = [url + RTSP_PARAMS for url in RTSP_URLS]                                # 拼接后的完整地址（地址+参数）

# 截图保存路径
SCREENSHOT_SAVE_DIR = r"D:\results\screenshots"
os.makedirs(SCREENSHOT_SAVE_DIR, exist_ok=True)     #自动创建文件夹
logger.info(f"截图保存目录: {SCREENSHOT_SAVE_DIR} (可写: {os.access(SCREENSHOT_SAVE_DIR, os.W_OK)})")

# 新增：推理结果保存路径
INFERENCE_SAVE_DIR = r"D:\results\inference"
os.makedirs(INFERENCE_SAVE_DIR, exist_ok=True)     #自动创建文件夹
logger.info(f"推理结果保存目录: {INFERENCE_SAVE_DIR} (可写: {os.access(INFERENCE_SAVE_DIR, os.W_OK)})")

# 全局变量
frame_lock = threading.Lock()
encoded_frames = [None, None, None]  # 存储三个摄像头编码后的帧数据(用于网络显示图片)
raw_frames = [None, None, None]  # 存储原始帧用于显示
screenshot_queue = queue.Queue()  # 截图请求队列


# 视频质量参数
JPEG_QUALITY = 70           
FRAME_SCALE = 0.7
TARGET_DISPLAY_FPS = 50         #保证帧率为50帧


class FrameTimestamp:
    def __init__(self, frame):
        self.frame = frame
        self.timestamp = time.time() #记录帧的获取时间


def check_hardware_acceleration():
    logger.info("检查硬件加速支持...")
    try:
        test_cap = cv2.VideoCapture(FULL_URLS[0], cv2.CAP_FFMPEG)       #打开第一个摄像头
        test_cap.set(cv2.CAP_PROP_HW_ACCELERATION, cv2.VIDEO_ACCELERATION_D3D11)    #尝试使用D3D11加速
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


# 初始化YOLO模型（仅用于截图推理）
MODEL_PATH = 'yolo11n.pt'
logger.info(f"正在加载YOLO模型: {MODEL_PATH}")
try:
    model = YOLO(MODEL_PATH)
    if torch.cuda.is_available():
        logger.info("检测到CUDA GPU，使用GPU加速")
        device = "cuda"
        half_precision = True
    else:
        logger.info("使用CPU进行推理")
        device = "cpu"
        half_precision = False
    logger.info(f"设备: {device}, 半精度: {half_precision}")
    logger.info("模型加载成功")
except Exception as e:
    logger.error(f"模型加载失败: {e}")
    sys.exit(1)


class VideoStream:
    def __init__(self, rtsp_url, camera_index):
        self.rtsp_url = rtsp_url                #摄像头地址
        self.camera_index = camera_index        #摄像头编号
        self.cap = None                         #视频捕获对象
        self.frame_queue = queue.Queue(maxsize=5)   #存储视频帧的队列
        self.running = True                     #是否继续工作
        self.retry_count = 0                    #已经重连的次数
        self.max_retries = 10                   #最多重试几次
        self.retry_delay = 2                    #每次重连间隔多少秒
        self.last_frame_time = time.time()
        self.frame_counter = 0
        self.hw_accel = check_hardware_acceleration()
        self.connect()
        self.thread = threading.Thread(target=self.capture_thread, daemon=True)
        self.thread.start()
        logger.info(f"摄像头{self.camera_index + 1}视频捕获线程已启动")

    def connect(self):      #连接摄像头函数
        if self.cap is not None:
            self.cap.release()
        logger.info(f"摄像头{self.camera_index + 1}尝试连接RTSP流: {self.rtsp_url}")
        try:
            os.environ["OPENCV_FFMPEG_CAPTURE_OPTIONS"] = "rtsp_transport;tcp|buffer_size;1024|flags;low_delay|analyzeduration;1000000|probesize;1000000"
            self.cap = cv2.VideoCapture(self.rtsp_url, cv2.CAP_FFMPEG)  #尝试第一次连接，连接视频流并且读取帧数据，第二个参数指定后端
            
            if not self.cap.isOpened():     #连接失败后的备用方案
                modified_url = self.rtsp_url
                if "?" not in modified_url:
                    modified_url += "?flags=low_delay"
                else:
                    modified_url += "&flags=low_delay"
                self.cap = cv2.VideoCapture(modified_url, cv2.CAP_FFMPEG)
                if not self.cap.isOpened():
                    logger.error(f"摄像头{self.camera_index + 1}连接失败")
                    return False

            self.cap.set(cv2.CAP_PROP_BUFFERSIZE, 1)#通过类实例self.cap调用VideoCapture中的set方法
            self.cap.set(cv2.CAP_PROP_FPS, TARGET_DISPLAY_FPS)  #检测目标帧率要求
            self.cap.set(cv2.CAP_PROP_HW_ACCELERATION, self.hw_accel)#硬件加速
            self.cap.set(cv2.CAP_PROP_FRAME_WIDTH, 1280)             #画面宽度
            self.cap.set(cv2.CAP_PROP_FRAME_HEIGHT, 720)             #画面高度
            
            try:        #尝试使用高级压缩格式
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
            if self.cap is None or not self.cap.isOpened():     #检查是否正常连接状态
                if not self.reconnect():                        #尝试重连
                    break
                continue
            try:
                ret, frame = self.cap.read()                    #获取视频帧
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


class ScreenshotHandler(threading.Thread):
    def __init__(self):
        super().__init__(daemon=True)
        self.running = True

    def run(self):
        logger.info("截图处理线程已启动")
        while self.running:
            try:
                # 等待截图请求
                request_data = screenshot_queue.get(timeout=1)
                camera_index, save_local, callback_queue = request_data
                
                # 获取原始帧
                with frame_lock:
                    frame = raw_frames[camera_index].copy() if raw_frames[camera_index] is not None else None
                
                if frame is None:
                    logger.warning(f"摄像头{camera_index + 1}无法获取帧进行截图")
                    callback_queue.put(None)
                    continue
                
                # 保存本地（如果需要）
                if save_local:
                    timestamp = datetime.now().strftime("%Y%m%d_%H%M%S")
                    img_path = os.path.join(SCREENSHOT_SAVE_DIR, f"screenshot_cam{camera_index + 1}_{timestamp}.png")
                    cv2.imwrite(img_path, frame)
                    logger.info(f"已保存截图到: {img_path}")
                
                # 使用 JPEG 格式编码，设置压缩质量
                ret, buffer = cv2.imencode('.jpg', frame, [int(cv2.IMWRITE_JPEG_QUALITY), JPEG_QUALITY])
                if ret:
                    base64_img = base64.b64encode(buffer).decode('utf-8')
                    processed_img = f"data:image/jpeg;base64,{base64_img}"
                    callback_queue.put(processed_img)
                else:
                    logger.error(f"摄像头{camera_index + 1}截图编码失败")
                    callback_queue.put(None)
                
            except queue.Empty:
                continue
            except Exception as e:
                logger.error(f"截图处理线程异常: {e}")
                time.sleep(0.1)


def take_screenshot(camera_index, save_local=True):             #获取摄像头编号截图并且默认保存在本地
    callback_queue = queue.Queue()                              #创建callback队列储存图片
    screenshot_queue.put((camera_index, save_local, callback_queue))    #选择的摄像头，是否要保存，保存的队列
    try:
        return callback_queue.get(timeout=5)                    #返回队列中的图片
    except queue.Empty:
        logger.error(f"获取摄像头{camera_index + 1}截图超时")
        return None


# 创建Flask应用并配置CORS（跨域支持）
app = Flask(__name__)
CORS(app, resources={
    r"/api/*": {"origins": "*"},  # 允许所有域名访问API接口
    r"/stream/*": {"origins": "*"},  # 允许所有域名访问视频流
    r"/infer": {"origins": "*"}  # 允许所有域名访问推理接口
})

@app.route('/api/detections', methods=['GET'])
def get_detections():
    return jsonify({"message": "实时检测已禁用，请使用/infer接口进行图片推理"})


@app.route('/stream/<int:camera_index>')
def video_feed(camera_index):
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
   # 用于构建 HTTP 响应的对象 ,通过调用generate()持续生成视频帧，multipart允许在单个http连接中连续发送多个数据块
   #x-mixed-replace：每个新数据块会替换前一个块（浏览器会动态更新内容）。
   #使用字符串frame区分不同的数据块
    response = Response(generate(), mimetype='multipart/x-mixed-replace; boundary=frame')  
    #指示Nginx等反向代理服务器不要缓冲响应数据，实时发送到客户端
    response.headers['X-Accel-Buffering'] = 'no'
    return response             #返回数据到网页端


@app.route('/api/screenshot/<int:camera_index>', methods=['GET'])       #动态参数路径，只接受GET请求
def api_screenshot(camera_index):
    if camera_index < 0 or camera_index >= len(RTSP_URLS):              #判断是否在有效范围内
        return jsonify({"error": "无效的摄像头索引"}), 400
    
    img_data = take_screenshot(camera_index, save_local=True)           #调用摄像头并且保存在本地
    if img_data:
        return jsonify({"screenshot": img_data})                        #返回base64编码的图片数据
    else:
        return jsonify({"error": "无法获取截图"}), 500


@app.route('/infer', methods=['POST'])
def infer():
    try:
        # 获取请求数据
        data = request.get_json()
        if not data or 'image' not in data:
            return jsonify({"error": "请求中缺少image字段"}), 400
        
        # 解析base64图片
        base64_str = data['image']
        if base64_str.startswith('data:image/png;base64,'):
            base64_str = base64_str[len('data:image/png;base64,'):]
        elif base64_str.startswith('data:image/jpeg;base64,'):
            base64_str = base64_str[len('data:image/jpeg;base64,'):]
        
        # 解码图片
        img_data = base64.b64decode(base64_str)
        np_arr = np.frombuffer(img_data, np.uint8)
        frame = cv2.imdecode(np_arr, cv2.IMREAD_COLOR)
        
        if frame is None:
            return jsonify({"error": "无法解码图片数据"}), 400
        
        # 执行目标检测
        results = model.predict(
            frame, 
            imgsz=512,
            conf=0.6,
            device=device, 
            half=half_precision,
            verbose=False,
            agnostic_nms=True,
            max_det=30
        )
        
        # 处理推理结果
        inference_results = []
        for box in results[0].boxes:
            class_id = int(box.cls)
            class_name = model.names[class_id]
            confidence = float(box.conf)
            
            inference_results.append({
                "class": class_id,
                "confidence": confidence,
                "label": class_name
            })
        
        # 使用 JPEG 编码，减小体积
        annotated_frame = results[0].plot()
        ret, buffer = cv2.imencode('.jpg', annotated_frame, [int(cv2.IMWRITE_JPEG_QUALITY), JPEG_QUALITY])
        if not ret:
            return jsonify({"error": "无法处理图片"}), 500
                    
        # 保存推理结果到本地
        timestamp = datetime.now().strftime("%Y%m%d_%H%M%S_%f")
        
        # 保存带检测框的图片
        img_save_path = os.path.join(INFERENCE_SAVE_DIR, f"infer_img_{timestamp}.png")
        cv2.imwrite(img_save_path, annotated_frame)
        logger.info(f"带检测框的图片已保存到: {img_save_path}")
        
        # 保存推理结果为JSON
        result_save_path = os.path.join(INFERENCE_SAVE_DIR, f"infer_result_{timestamp}.json")
        with open(result_save_path, 'w', encoding='utf-8') as f:
            json.dump(inference_results, f, ensure_ascii=False, indent=2)
        logger.info(f"推理结果数据已保存到: {result_save_path}")
        
        # 转换为base64返回
        base64_img = base64.b64encode(buffer).decode('utf-8')
        processed_image = f"data:image/jpeg;base64,{base64_img}"
        
        # 返回结果
        return jsonify({
            "inference_results": inference_results,
            "processed_image": processed_image,
            "save_info": {
                "image_path": img_save_path,
                "result_path": result_save_path
            }
        })
        
    except Exception as e:
        logger.error(f"推理接口异常: {e}")
        return jsonify({"error": str(e)}), 500


def run_flask():
    app.run(host='0.0.0.0', port=5000, threaded=True, use_reloader=False, debug=False)


def main():
    # 启动Flask服务器，线程服务函数为run_flask
    flask_thread = threading.Thread(target=run_flask, daemon=True)
    flask_thread.start()
    logger.info("Flask服务器已启动在 http://0.0.0.0:5000")

    # 初始化截图处理线程
    screenshot_handler = ScreenshotHandler()
    screenshot_handler.start()

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
        screenshot_handler.running = False
        for encoder in display_encoders:
            encoder.running = False
            
        for stream in streams:
            stream.release()
        logger.info("程序已正常退出")


if __name__ == "__main__":
    import os
    try:
        main()
    except Exception as e:
        logger.exception(f"程序发生未处理异常: {e}")
        sys.exit(1)