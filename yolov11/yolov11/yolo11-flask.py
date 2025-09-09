from flask import Flask, request, jsonify
from ultralytics import YOLO
import cv2
import base64
import numpy as np
from flask_cors import CORS
import torch


# 初始化 Flask 应用
app = Flask(__name__)
CORS(app)
app.config['MAX_CONTENT_LENGTH'] = 16 * 1024 * 1024  # 16MB
# 加载 YOLO 模型
model = YOLO("./yolo11n.pt")

@app.route('/infer', methods=['POST'])
def infer():
    # 获取请求中的 JSON 数据
    data = request.json
    if 'image' not in data:
        return jsonify({'error': 'No image provided'}), 400

    # 获取 Base64 图片数据
    base64_image = data['image']

    # 去掉可能存在的 MIME 类型前缀
    if base64_image.startswith('data:image/jpeg;base64,'):
        base64_image = base64_image.split('data:image/jpeg;base64,')[1]
    elif base64_image.startswith('data:image/png;base64,'):
        base64_image = base64_image.split('data:image/png;base64,')[1]
    elif base64_image.startswith('data:image/gif;base64,'):
        base64_image = base64_image.split('data:image/gif;base64,')[1]
    elif base64_image.startswith('data:image/bmp;base64,'):
        base64_image = base64_image.split('data:image/bmp;base64,')[1]
    elif base64_image.startswith('data:image/webp;base64,'):
        base64_image = base64_image.split('data:image/webp;base64,')[1]


    # 解码 Base64 图片
    try:
        image_data = base64.b64decode(base64_image)
        image_array = np.frombuffer(image_data, np.uint8)
        image = cv2.imdecode(image_array, cv2.IMREAD_COLOR)
    except Exception as e:
        return jsonify({'error': f'Failed to decode image: {str(e)}'}), 400

    # 检查图像是否为空
    if image is None or image.size == 0:
        return jsonify({'error': 'Failed to decode image: Image is empty'}), 400

    # 保存接收的图像
    cv2.imwrite('received_image.jpg', image)
    print("Received image saved as 'received_image.jpg'")

    # 使用 YOLO 模型进行推理
    try:
        results = model(image)
        # print(results.boxes)
    except Exception as e:
        return jsonify({'error': f'Inference failed: {str(e)}'}), 500

    # 获取推理结果
    detections = []
    if hasattr(results[0], 'boxes'):
        # print( results[0].boxes)
        for i, box in enumerate(results[0].boxes.xyxy):
            x1, y1, x2, y2 = box
            x1, y1, x2, y2 = int(x1), int(y1), int(x2), int(y2)
            conf = float(results[0].boxes.conf[i])
            cls = int(results[0].boxes.cls[i])
            label = f"{model.names[cls]}"
            detections.append({
                # 'xmin': x1,
                # 'ymin': y1,
                # 'xmax': x2,
                # 'ymax': y2,
                'label': label,
                'confidence': conf,
                'class': cls
            })
            # 绘制检测框和标签
            # cv2.rectangle(image, (x1, y1), (x2, y2), (0, 255, 0), 2)
            # cv2.putText(image, label, (x1, y1 - 10), cv2.FONT_HERSHEY_SIMPLEX, 0.5, (0, 255, 0), 2)

    # 保存推理后的图像
    test=results[0].plot()
    cv2.imwrite('inferred_image.jpg', test)
    print("Inferred image saved as 'inferred_image.jpg'")

    # 将处理后的图片编码为 Base64
    try:
        _, buffer = cv2.imencode('.jpg', test)
        processed_image_data = base64.b64encode(buffer).decode('utf-8')
    except Exception as e:
        return jsonify({'error': f'Failed to encode image: {str(e)}'}), 500

    # 返回推理结果和处理后的图片
    response = {
        'inference_results': detections,
        'processed_image': "data:image/jpeg;base64,"+processed_image_data
    }
    return jsonify(response)

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)