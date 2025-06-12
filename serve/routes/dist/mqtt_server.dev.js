"use strict";

Object.defineProperty(exports, "__esModule", {
  value: true
});
exports["default"] = void 0;

var _express = _interopRequireDefault(require("express"));

var _indexNode = _interopRequireDefault(require("../indexNode1.js"));

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { "default": obj }; }

function _slicedToArray(arr, i) { return _arrayWithHoles(arr) || _iterableToArrayLimit(arr, i) || _nonIterableRest(); }

function _nonIterableRest() { throw new TypeError("Invalid attempt to destructure non-iterable instance"); }

function _iterableToArrayLimit(arr, i) { if (!(Symbol.iterator in Object(arr) || Object.prototype.toString.call(arr) === "[object Arguments]")) { return; } var _arr = []; var _n = true; var _d = false; var _e = undefined; try { for (var _i = arr[Symbol.iterator](), _s; !(_n = (_s = _i.next()).done); _n = true) { _arr.push(_s.value); if (i && _arr.length === i) break; } } catch (err) { _d = true; _e = err; } finally { try { if (!_n && _i["return"] != null) _i["return"](); } finally { if (_d) throw _e; } } return _arr; }

function _arrayWithHoles(arr) { if (Array.isArray(arr)) return arr; }

//此处获取到数据库链接配置对象
var connection1; //定义数据库连接对象

(function _callee() {
  return regeneratorRuntime.async(function _callee$(_context) {
    while (1) {
      switch (_context.prev = _context.next) {
        case 0:
          _context.prev = 0;
          _context.next = 3;
          return regeneratorRuntime.awrap((0, _indexNode["default"])());

        case 3:
          connection1 = _context.sent;
          console.log("数据库1连接成功");
          _context.next = 10;
          break;

        case 7:
          _context.prev = 7;
          _context.t0 = _context["catch"](0);
          console.log("数据库1连接失败");

        case 10:
        case "end":
          return _context.stop();
      }
    }
  }, null, null, [[0, 7]]);
})();

var Router = (0, _express["default"])();
var sign = false; //用于标识接收方客户端对象是否处于链接状态的变量
//测试接口--用于获取到请求的报文信息

Router.post('/test', function _callee2(req, res) {
  var _ref, _ref2, rows;

  return regeneratorRuntime.async(function _callee2$(_context2) {
    while (1) {
      switch (_context2.prev = _context2.next) {
        case 0:
          console.log("test_result:"); //需要注意的是对经过包装的对象使用.log打印的时候不会呈现出来，必须使用.dir进行打印呈现

          console.dir(req.body);

          if (sign) {
            _context2.next = 8;
            break;
          }

          _context2.next = 5;
          return regeneratorRuntime.awrap(connection1.execute("\n    INSERT INTO mqtt_messages(topic,qos,payload,device_name)\n    VALUES (\"".concat(req.body.topic, "\",").concat(req.body.qos, ",\"").concat(req.body.payload, "\",\"").concat(from_username, "\")\n    ")));

        case 5:
          _ref = _context2.sent;
          _ref2 = _slicedToArray(_ref, 1);
          rows = _ref2[0];

        case 8:
          res.send("OK");

        case 9:
        case "end":
          return _context2.stop();
      }
    }
  });
}); // 测试接口--用于获取到客户端与broker之间的连接的情况

Router.post('/test/connected', function (req, res) {
  if (req.body.clientid = "get_client") {
    sign = true;
  }

  res.send("OK");
}); // 测试接口--用于获取到客户端与broker之间的连接的情况

Router.post('test/disconnect', function (req, res) {
  if (req.body.clientid = "get_client") {
    sign = false;
  }

  res.send("OK");
});
var _default = Router;
exports["default"] = _default;