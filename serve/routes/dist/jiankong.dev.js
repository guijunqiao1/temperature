"use strict";

function _classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError("Cannot call a class as a function"); } }

function _defineProperties(target, props) { for (var i = 0; i < props.length; i++) { var descriptor = props[i]; descriptor.enumerable = descriptor.enumerable || false; descriptor.configurable = true; if ("value" in descriptor) descriptor.writable = true; Object.defineProperty(target, descriptor.key, descriptor); } }

function _createClass(Constructor, protoProps, staticProps) { if (protoProps) _defineProperties(Constructor.prototype, protoProps); if (staticProps) _defineProperties(Constructor, staticProps); return Constructor; }

var axios = require("axios");

var WebSocket = require('ws'); // MJPEG 解析器类


var MJPEGParser =
/*#__PURE__*/
function () {
  function MJPEGParser() {
    _classCallCheck(this, MJPEGParser);

    this.boundary = '--frame';
    this.buffer = Buffer.alloc(0);
    this.isParsingHeaders = true;
    this.contentLength = 0;
    this.currentFrameData = Buffer.alloc(0);
  }

  _createClass(MJPEGParser, [{
    key: "parse",
    value: function parse(chunk, callback) {
      // 将新数据添加到缓冲区
      this.buffer = Buffer.concat([this.buffer, chunk]);

      while (this.buffer.length > 0) {
        if (this.isParsingHeaders) {
          // 查找边界标记
          var boundaryIndex = this.buffer.indexOf(this.boundary);

          if (boundaryIndex === -1) {
            break; // 没有找到边界，等待更多数据
          } // 跳过边界标记


          this.buffer = this.buffer.slice(boundaryIndex + this.boundary.length); // 查找头部结束标记（两个换行符）

          var headerEndIndex = this.buffer.indexOf('\r\n\r\n');

          if (headerEndIndex === -1) {
            break; // 头部不完整，等待更多数据
          } // 解析头部


          var headerData = this.buffer.slice(0, headerEndIndex).toString();
          var contentLengthMatch = headerData.match(/Content-Length:\s*(\d+)/i);

          if (contentLengthMatch) {
            this.contentLength = parseInt(contentLengthMatch[1]);
            this.isParsingHeaders = false;
            this.currentFrameData = Buffer.alloc(0); // 跳过头部

            this.buffer = this.buffer.slice(headerEndIndex + 4);
          } else {
            // 没有找到 Content-Length，跳过这个块
            this.buffer = this.buffer.slice(headerEndIndex + 4);
          }
        } else {
          // 解析帧数据
          if (this.buffer.length >= this.contentLength) {
            // 提取完整的帧数据
            var frameData = this.buffer.slice(0, this.contentLength);
            this.currentFrameData = Buffer.concat([this.currentFrameData, frameData]); // 调用回调函数，传递完整的 JPEG 帧

            callback(this.currentFrameData); // 重置状态

            this.isParsingHeaders = true;
            this.contentLength = 0;
            this.currentFrameData = Buffer.alloc(0); // 移除已处理的数据

            this.buffer = this.buffer.slice(this.contentLength);
          } else {
            // 数据不够，等待更多数据
            break;
          }
        }
      }
    }
  }]);

  return MJPEGParser;
}(); //请求得到视频流内容


var jifang1_video;
var jifang2_video;
var jifang3_video; // 获取视频流的函数（修正端口为5000）

function getVideoStream(cameraIndex) {
  var response;
  return regeneratorRuntime.async(function getVideoStream$(_context) {
    while (1) {
      switch (_context.prev = _context.next) {
        case 0:
          _context.prev = 0;
          _context.next = 3;
          return regeneratorRuntime.awrap(axios({
            method: 'GET',
            url: "http://127.0.0.1:5000/stream/".concat(cameraIndex),
            // 修正端口
            responseType: 'stream'
          }));

        case 3:
          response = _context.sent;
          return _context.abrupt("return", response.data);

        case 7:
          _context.prev = 7;
          _context.t0 = _context["catch"](0);
          console.error("\u83B7\u53D6\u6444\u50CF\u5934".concat(cameraIndex, "\u89C6\u9891\u6D41\u5931\u8D25:"), _context.t0.message);
          return _context.abrupt("return", null);

        case 11:
        case "end":
          return _context.stop();
      }
    }
  }, null, null, [[0, 7]]);
}

(function _callee() {
  var wss, cameras;
  return regeneratorRuntime.async(function _callee$(_context2) {
    while (1) {
      switch (_context2.prev = _context2.next) {
        case 0:
          wss = new WebSocket.Server({
            port: 4000
          });
          console.log("服务启动成功"); // 获取视频流

          _context2.prev = 2;
          _context2.next = 5;
          return regeneratorRuntime.awrap(getVideoStream(0));

        case 5:
          jifang1_video = _context2.sent;
          console.log("成功连接1号");
          _context2.next = 12;
          break;

        case 9:
          _context2.prev = 9;
          _context2.t0 = _context2["catch"](2);
          console.error("连接1号失败");

        case 12:
          _context2.prev = 12;
          _context2.next = 15;
          return regeneratorRuntime.awrap(getVideoStream(1));

        case 15:
          jifang2_video = _context2.sent;
          console.log("成功连接2号");
          _context2.next = 22;
          break;

        case 19:
          _context2.prev = 19;
          _context2.t1 = _context2["catch"](12);
          console.error("连接2号失败");

        case 22:
          _context2.prev = 22;
          _context2.next = 25;
          return regeneratorRuntime.awrap(getVideoStream(2));

        case 25:
          jifang3_video = _context2.sent;
          console.log("成功连接3号");
          _context2.next = 32;
          break;

        case 29:
          _context2.prev = 29;
          _context2.t2 = _context2["catch"](22);
          console.error("连接3号失败");

        case 32:
          // 定义多个摄像头，每个摄像头有一个唯一的 ID 和名称
          cameras = [{
            id: 'camera_1',
            // 摄像头的唯一标识符
            name: '机房1',
            // 摄像头名称
            capture: jifang1_video,
            // 摄像头视频流对象，0表示默认摄像头
            parser: new MJPEGParser() // 添加 MJPEG 解析器

          }, {
            id: 'camera_2',
            // 摄像头的唯一标识符
            name: '机房2',
            // 摄像头名称
            capture: jifang2_video,
            // 1表示第二个摄像头
            parser: new MJPEGParser() // 添加 MJPEG 解析器

          }, {
            id: 'camera_3',
            // 摄像头的唯一标识符
            name: '机房3',
            // 摄像头名称
            capture: jifang3_video,
            // 2表示第三个摄像头
            parser: new MJPEGParser() // 添加 MJPEG 解析器

          }];
          wss.on('connection', function (ws) {
            console.log('Client connected');
            var camera = cameras[0]; // 默认使用第一个摄像头
            // 处理客户端消息

            ws.on('message', function (message) {
              try {
                var data = JSON.parse(message.toString());

                if (data.action === 'selectCamera') {
                  var cameraIndex = parseInt(data.cameraIndex);

                  if (cameraIndex >= 0 && cameraIndex < cameras.length) {
                    camera = cameras[cameraIndex];
                    console.log("\u5BA2\u6237\u7AEF\u9009\u62E9\u6444\u50CF\u5934: ".concat(cameraIndex));
                  }
                }
              } catch (error) {
                console.error('处理消息失败:', error);
              }
            }); // 处理视频流数据 - 关键修改点

            if (camera.capture) {
              camera.capture.on('data', function (chunk) {
                if (ws.readyState === WebSocket.OPEN) {
                  // 使用 MJPEG 解析器处理数据，而不是直接发送原始块
                  camera.parser.parse(chunk, function (frameData) {
                    try {
                      ws.send(frameData); // 发送完整的 JPEG 帧
                    } catch (error) {
                      console.error('发送帧数据失败:', error);
                    }
                  });
                }
              });
              camera.capture.on('error', function (error) {
                console.error('视频流错误:', error);
              });
            } // 客户端断开时清理


            ws.on('close', function () {
              console.log('Client disconnected');
            });
          });

        case 34:
        case "end":
          return _context2.stop();
      }
    }
  }, null, null, [[2, 9], [12, 19], [22, 29]]);
})();