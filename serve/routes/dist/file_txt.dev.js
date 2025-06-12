"use strict";

Object.defineProperty(exports, "__esModule", {
  value: true
});
exports["default"] = void 0;

var _koaRouter = _interopRequireDefault(require("koa-router"));

var _fs = _interopRequireDefault(require("fs"));

var _path = _interopRequireDefault(require("path"));

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { "default": obj }; }

//用于接受映射数组获取请求的路由文件
var Router_file_txt = new _koaRouter["default"](); //表格的呈现-图像的呈现路由

Router_file_txt.get("/file_txt", function _callee(ctx) {
  var path, All_path;
  return regeneratorRuntime.async(function _callee$(_context) {
    while (1) {
      switch (_context.prev = _context.next) {
        case 0:
          path = ctx.query.path; //总路径

          console.log("当前的path的取值为：" + path);
          All_path = _path["default"].resolve('D:\\', 'source_find', path); //需要注意的是D:拼接的取值含义为当前的D盘下所对应上的D盘的工作目录

          console.log("当前总路径:" + All_path); //读取文本内容并返回

          console.log("查看文件内容:");
          console.dir(_fs["default"].readFileSync(All_path).toString("utf8"));
          ctx.body = _fs["default"].readFileSync(All_path).toString("utf8"); // 把可读流赋给 ctx.body

        case 7:
        case "end":
          return _context.stop();
      }
    }
  });
});
var _default = Router_file_txt;
exports["default"] = _default;