"use strict";

Object.defineProperty(exports, "__esModule", {
  value: true
});
exports["default"] = void 0;

var _koa = _interopRequireDefault(require("koa"));

var _path = _interopRequireDefault(require("path"));

var _cors = _interopRequireDefault(require("@koa/cors"));

var _koaMorgan = _interopRequireDefault(require("koa-morgan"));

var _koaStatic = _interopRequireDefault(require("koa-static"));

var _koaBodyparser = _interopRequireDefault(require("koa-bodyparser"));

var _koaViews = _interopRequireDefault(require("koa-views"));

var _url = require("url");

var _router = _interopRequireDefault(require("@koa/router"));

var _direct_control = require("./routes/direct_control.js");

var _index = _interopRequireDefault(require("./routes/index.js"));

var _index_yingshe = _interopRequireDefault(require("./routes/index_yingshe.js"));

var _index_device = _interopRequireDefault(require("./routes/index_device.js"));

var _index_error_msg = _interopRequireDefault(require("./routes/index_error_msg.js"));

var _index_history = _interopRequireDefault(require("./routes/index_history.js"));

var _index_action = _interopRequireDefault(require("./routes/index_action.js"));

var _direct = _interopRequireDefault(require("./routes/direct.js"));

var _http_server_get = _interopRequireDefault(require("./routes/http_server_get.js"));

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { "default": obj }; }

//KOA2
// 导入子路由（假设这些模块都使用 koa-router 创建）
// import Router_direct_control from './routes/direct_control.js';
function startServer() {
  return regeneratorRuntime.async(function startServer$(_context) {
    while (1) {
      switch (_context.prev = _context.next) {
        case 0:
          try {} catch (error) {
            console.error('服务器启动失败:', error);
          }

        case 1:
        case "end":
          return _context.stop();
      }
    }
  });
}

startServer();
var _default = app;
exports["default"] = _default;