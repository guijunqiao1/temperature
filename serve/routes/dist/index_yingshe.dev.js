"use strict";

Object.defineProperty(exports, "__esModule", {
  value: true
});
exports["default"] = void 0;

var _indexNode = _interopRequireDefault(require("../indexNode2.js"));

var _express = _interopRequireDefault(require("express"));

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { "default": obj }; }

function _defineProperty(obj, key, value) { if (key in obj) { Object.defineProperty(obj, key, { value: value, enumerable: true, configurable: true, writable: true }); } else { obj[key] = value; } return obj; }

//此处获取到数据库链接配置对象
var connection2; //定义数据库连接对象

var Router1 = (0, _express["default"])();

(function _callee() {
  return regeneratorRuntime.async(function _callee$(_context) {
    while (1) {
      switch (_context.prev = _context.next) {
        case 0:
          _context.prev = 0;
          _context.next = 3;
          return regeneratorRuntime.awrap((0, _indexNode["default"])());

        case 3:
          connection2 = _context.sent;
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

Router1.get("/yingshe", function _callee2(req, res) {
  var dbResult, objectArray;
  return regeneratorRuntime.async(function _callee2$(_context2) {
    while (1) {
      switch (_context2.prev = _context2.next) {
        case 0:
          console.log("123");
          _context2.next = 3;
          return regeneratorRuntime.awrap(connection2.execute("\n    SELECT db_name, f_name  FROM t_field_mapper;\n  "));

        case 3:
          dbResult = _context2.sent;
          dbResult = dbResult[0];
          objectArray = dbResult.map(function (row) {
            return _defineProperty({}, row.db_name, row.f_name);
          });
          console.log("yingshe");
          console.dir(objectArray);
          res.send(objectArray);

        case 9:
        case "end":
          return _context2.stop();
      }
    }
  });
}); //行为映射表

Router1.get("/yingshe/action", function _callee3(req, res) {
  var dbResult, objectArray;
  return regeneratorRuntime.async(function _callee3$(_context3) {
    while (1) {
      switch (_context3.prev = _context3.next) {
        case 0:
          console.log("123");
          _context3.next = 3;
          return regeneratorRuntime.awrap(connection2.execute("\n    SELECT db_name, f_name ,type,is_show FROM t_behavior_field_mapper;\n  "));

        case 3:
          dbResult = _context3.sent;
          dbResult = dbResult[0];
          objectArray = dbResult.map(function (row) {
            var _ref2;

            return _ref2 = {}, _defineProperty(_ref2, row.db_name, row.f_name), _defineProperty(_ref2, "type", row.type), _defineProperty(_ref2, "is_show", row.is_show), _ref2;
          });
          console.log("yingshe/action" + objectArray);
          res.send(objectArray);

        case 8:
        case "end":
          return _context3.stop();
      }
    }
  });
});
var _default = Router1;
exports["default"] = _default;