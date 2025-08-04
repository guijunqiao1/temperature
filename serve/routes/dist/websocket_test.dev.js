"use strict";

// server.js
var WebSocket = require('ws');

var fs = require('fs');

var path = require('path'); // 创建一个 WebSocket 服务器


var wss = new WebSocket.Server({
  port: 3001
});
wss.on('connection', function (ws) {
  console.log('客户端已连接'); // 模拟从本地读取图像文件并发送给客户端

  var sendImage = function sendImage() {
    // 读取一个图片文件并将其发送给客户端
    var imgPath = path.join('./public/images/', '1.png'); // 你的测试图像路径

    var imgBuffer = fs.readFileSync(imgPath); // 向客户端发送图像数据

    ws.send(imgBuffer);
  }; // 每秒发送一次图像


  var intervalId = setInterval(sendImage, 1000); // 清理连接时的操作

  ws.on('close', function () {
    clearInterval(intervalId);
    console.log('客户端断开连接');
  });
});
console.log('WebSocket 服务器已启动，等待连接...');