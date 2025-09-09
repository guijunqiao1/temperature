import express from "express";
import cors from "cors";
import {spawn} from "child_process";
import { Readable } from "stream";

// const express = require('express');
// const cors = require('cors');
// const { spawn } = require('child_process');
// const { Readable } = require('stream');

// 基础配置
const RTSP_URLS = [
  "rtsp://admin:admin@192.168.1.11:554/Streaming/Channels/101?transport=tcp&buffer_size=512&fflags=nobuffer&flags=low_delay",
  "rtsp://admin:admin@192.168.1.12:554/Streaming/Channels/101?transport=tcp&buffer_size=512&fflags=nobuffer&flags=low_delay",
  "rtsp://admin:admin@192.168.1.13:554/Streaming/Channels/101?transport=tcp&buffer_size=512&fflags=nobuffer&flags=low_delay"
];

const JPEG_QUALITY = 75;
const FRAME_SCALE = 0.6;
const PORT = 5000;

// 初始化Express应用
const app = express();
app.use(cors());
app.use(express.json({ limit: '10mb' }));

// 存储每个摄像头的最新帧
let latestFrames = [null, null, null];

/**
 * 启动RTSP流捕获和处理
 * 使用ffmpeg将RTSP流转为JPEG帧
 */
function startStreamProcessing(camIndex, url) {
  console.log(`[摄像头${camIndex + 1}] 开始处理流: ${url}`);

  // ffmpeg命令参数 - 将RTSP流转为JPEG帧
  const ffmpegArgs = [
    '-rtsp_transport', 'tcp',
    '-i', url,
    '-vf', `scale=iw*${FRAME_SCALE}:ih*${FRAME_SCALE}`, // 缩放帧
    '-q:v', JPEG_QUALITY.toString(), // JPEG质量
    '-f', 'image2pipe', // 输出为图片流
    '-vcodec', 'mjpeg', // 编码格式
    'pipe:1' // 输出到标准输出
  ];

  // 启动ffmpeg进程
  const ffmpeg = spawn('ffmpeg', ffmpegArgs);
  
  // 收集JPEG数据
  let frameBuffer = [];
  const frameSeparator = Buffer.from([0xff, 0xd8]); // JPEG开始标记
  
  ffmpeg.stdout.on('data', (data) => {
    // 查找JPEG开始标记，分割帧
    let start = 0;
    for (let i = 0; i < data.length - 1; i++) {
      if (data[i] === 0xff && data[i + 1] === 0xd8) {
        if (frameBuffer.length > 0) {
          // 保存完整帧
          const frame = Buffer.concat([Buffer.concat(frameBuffer), data.slice(start, i)]);
          latestFrames[camIndex] = frame;
          frameBuffer = [];
        }
        start = i;
      }
    }
    // 添加剩余数据到缓冲区
    frameBuffer.push(data.slice(start));
  });

  // 错误处理
  ffmpeg.stderr.on('data', (data) => {
    // console.error(`[摄像头${camIndex + 1}] ffmpeg错误: ${data.toString().slice(0, 200)}`);
  });

  // 进程退出处理 - 自动重启
  ffmpeg.on('exit', (code) => {
    console.error(`[摄像头${camIndex + 1}] ffmpeg进程退出，代码: ${code}，将在5秒后重启`);
    latestFrames[camIndex] = null;
    setTimeout(() => startStreamProcessing(camIndex, url), 5000);
  });

  return ffmpeg;
}

// 视频流接口 - 提供MJPEG流
app.get('/stream/:camIndex', (req, res) => {
  const camIndex = parseInt(req.params.camIndex);
  
  // 验证摄像头索引
  if (isNaN(camIndex) || camIndex < 0 || camIndex >= RTSP_URLS.length) {
    return res.status(400).send(`无效的摄像头索引，有效范围: 0-${RTSP_URLS.length - 1}`);
  }

  // 设置响应头
  res.setHeader('Content-Type', 'multipart/x-mixed-replace; boundary=frame');
  res.setHeader('Cache-Control', 'no-cache');
  res.setHeader('Connection', 'keep-alive');

  // 定期发送最新帧
  const sendFrame = () => {
    if (res.destroyed) return;
    
    const frame = latestFrames[camIndex];
    if (frame) {
      res.write(`--frame\r\n`);
      res.write(`Content-Type: image/jpeg\r\n`);
      res.write(`Content-Length: ${frame.length}\r\n`);
      res.write(`\r\n`);
      res.write(frame);
      res.write(`\r\n`);
    }
    
    setTimeout(sendFrame, 50); // 约20FPS
  };

  sendFrame();

  // 客户端断开连接时清理
  res.on('close', () => {
    console.log(`[摄像头${camIndex + 1}] 客户端断开连接`);
  });
});

// 图片编码接口 - 处理Base64图片
app.post('/image/encode', (req, res) => {
  try {
    if (!req.body || !req.body.image) {
      return res.status(400).send('缺少image字段');
    }

    // 提取Base64数据
    const base64Data = req.body.image.split(',')[1] || req.body.image;
    const buffer = Buffer.from(base64Data, 'base64');
    
    // 直接返回（实际应用中可添加处理逻辑）
    res.send(buffer.toString('base64'));
  } catch (error) {
    console.error('图片处理错误:', error);
    res.status(500).send('图片处理失败');
  }
});

//获取当前页面的截图
// app.get('/screenshot/:camIndex', (req, res) => {
//   try {
//     const camIndex = parseInt(req.params.camIndex);
    
//     // 验证摄像头索引
//     if (isNaN(camIndex) || camIndex < 0 || camIndex >= RTSP_URLS.length) {
//       return res.status(400).send(`无效的摄像头索引，有效范围: 0-${RTSP_URLS.length - 1}`);
//     }

//     const frame = latestFrames[camIndex];
    
//     // 检查是否有可用帧
//     if (!frame) {
//       return res.status(503).send('当前无可用画面，请稍后重试');
//     }

//     // 设置响应头为JPEG图片
//     res.setHeader('Content-Type', 'image/jpeg');
//     res.setHeader('Cache-Control', 'no-cache, no-store, must-revalidate');
//     res.setHeader('Pragma', 'no-cache');
//     res.setHeader('Expires', '0');
    
//     // 发送图片数据
//     res.send(frame);
//   } catch (error) {
//     console.error('截图接口错误:', error);
//     res.status(500).send('获取截图失败');
//   }
// });
// 1. 顶部引入所需模块（fs 是 Node.js 内置模块，无需额外安装）
// const fs = require('fs');
// const path = require('path');
import fs from "fs";
import { dirname } from "path";
import path from "path";
import { fileURLToPath } from 'url';
// 创建 __dirname 替代
const __filename = fileURLToPath(import.meta.url);
const __dirname = dirname(path.dirname(__filename));

// 2. （可选）定义图片保存目录（建议统一管理截图文件）
// 确保目录存在，不存在则自动创建
const SCREENSHOT_DIR = path.join(__dirname, 'screenshots');
if (!fs.existsSync(SCREENSHOT_DIR)) {
  fs.mkdirSync(SCREENSHOT_DIR, { recursive: true }); // recursive: true 支持创建多级目录
}

// 3. 带本地保存功能的截图接口
app.get('/screenshot/:camIndex', (req, res) => {
  try {
    const camIndex = parseInt(req.params.camIndex);
    
    // 验证摄像头索引
    if (isNaN(camIndex) || camIndex < 0 || camIndex >= RTSP_URLS.length) {
      return res.status(400).send(`无效的摄像头索引，有效范围: 0-${RTSP_URLS.length - 1}`);
    }

    const frame = latestFrames[camIndex];
    
    // 检查是否有可用帧
    if (!frame) {
      return res.status(503).send('当前无可用画面，请稍后重试');
    }

    // --------------------------
    // 核心：保存图片到服务器本地
    // --------------------------
    // 生成唯一文件名（避免重复）：摄像头索引_时间戳.jpg
    const timestamp = new Date().getTime(); // 时间戳（毫秒级，确保唯一）
    const fileName = `cam_${camIndex + 1}_${timestamp}.jpg`; // 例：cam_1_1718888888888.jpg
    const savePath = path.join(SCREENSHOT_DIR, fileName); // 完整保存路径

    // 写入文件（frame 是二进制 Buffer，直接写入即可）
    fs.writeFile(savePath, frame, (writeErr) => {
      if (writeErr) {
        console.error(`[摄像头${camIndex + 1}] 截图保存失败:`, writeErr);
        // 注意：保存失败不影响接口返回图片，仅打印错误日志
      } else {
        console.log(`[摄像头${camIndex + 1}] 截图已保存: ${savePath}`);
      }
    });

    // --------------------------
    // 原有逻辑：返回图片给前端
    // --------------------------
    res.setHeader('Content-Type', 'image/jpeg');
    res.setHeader('Cache-Control', 'no-cache, no-store, must-revalidate');
    res.setHeader('Pragma', 'no-cache');
    res.setHeader('Expires', '0');
    res.send(frame);

  } catch (error) {
    console.error('截图接口错误:', error);
    res.status(500).send('获取截图失败');
  }
});



// 启动服务
function startServer() {
  // 启动所有摄像头流处理
  const ffmpegProcesses = RTSP_URLS.map((url, index) => 
    startStreamProcessing(index, url)
  );

  // 启动HTTP服务器
  app.listen(PORT, () => {
    console.log(`服务器已启动，地址: http://0.0.0.0:${PORT}`);
    console.log(`可用流地址:`);
    RTSP_URLS.forEach((_, index) => {
      console.log(`- 摄像头${index + 1}: http://0.0.0.0:${PORT}/stream/${index}`);
    });
  });

  // 处理退出信号
  process.on('SIGINT', () => {
    console.log('正在关闭服务...');
    ffmpegProcesses.forEach(proc => proc.kill());
    process.exit();
  });
}

// 启动应用
startServer();
