"use strict";

Object.defineProperty(exports, "__esModule", {
  value: true
});
exports["default"] = void 0;

var _promise = _interopRequireDefault(require("mysql2/promise"));

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { "default": obj }; }

//数据库连接配置文件
// 对mysql这个构造函数中的创建数据库的具体链接的方法进行具体的配置（即内容的重写）
function Config3() {
  var connection;
  return regeneratorRuntime.async(function Config3$(_context) {
    while (1) {
      switch (_context.prev = _context.next) {
        case 0:
          _context.prev = 0;
          _context.next = 3;
          return regeneratorRuntime.awrap(_promise["default"].createConnection({
            host: "127.0.0.1",
            password: "123456",
            database: "project02",
            port: 3306,
            user: "root"
          }));

        case 3:
          connection = _context.sent;
          //进行数据连接事件的绑定
          console.log("连接project3成功"); //返回连接实例

          return _context.abrupt("return", connection);

        case 8:
          _context.prev = 8;
          _context.t0 = _context["catch"](0);
          console.log("数据库2连接失败", _context.t0);
          throw _context.t0;

        case 12:
        case "end":
          return _context.stop();
      }
    }
  }, null, null, [[0, 8]]);
} //将具体的数据库链接配置(重写后的)函数进行暴露


var _default = Config3;
exports["default"] = _default;