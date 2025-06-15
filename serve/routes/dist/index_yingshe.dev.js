"use strict";

Object.defineProperty(exports, "__esModule", {
  value: true
});
exports["default"] = void 0;

var _indexNode = _interopRequireDefault(require("../indexNode2.js"));

var _koaRouter = _interopRequireDefault(require("koa-router"));

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { "default": obj }; }

function _slicedToArray(arr, i) { return _arrayWithHoles(arr) || _iterableToArrayLimit(arr, i) || _nonIterableRest(); }

function _nonIterableRest() { throw new TypeError("Invalid attempt to destructure non-iterable instance"); }

function _iterableToArrayLimit(arr, i) { if (!(Symbol.iterator in Object(arr) || Object.prototype.toString.call(arr) === "[object Arguments]")) { return; } var _arr = []; var _n = true; var _d = false; var _e = undefined; try { for (var _i = arr[Symbol.iterator](), _s; !(_n = (_s = _i.next()).done); _n = true) { _arr.push(_s.value); if (i && _arr.length === i) break; } } catch (err) { _d = true; _e = err; } finally { try { if (!_n && _i["return"] != null) _i["return"](); } finally { if (_d) throw _e; } } return _arr; }

function _arrayWithHoles(arr) { if (Array.isArray(arr)) return arr; }

function _defineProperty(obj, key, value) { if (key in obj) { Object.defineProperty(obj, key, { value: value, enumerable: true, configurable: true, writable: true }); } else { obj[key] = value; } return obj; }

//此处获取到数据库链接配置对象
var connection2; //定义数据库连接对象

var Router1 = new _koaRouter["default"]();

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

Router1.get("/yingshe", function _callee2(ctx) {
  var dbResult, objectArray;
  return regeneratorRuntime.async(function _callee2$(_context2) {
    while (1) {
      switch (_context2.prev = _context2.next) {
        case 0:
          console.log("123");
          _context2.next = 3;
          return regeneratorRuntime.awrap(connection2.execute("\n    SELECT db_name, f_name ,is_show , type FROM t_field_mapper;\n  "));

        case 3:
          dbResult = _context2.sent;
          dbResult = dbResult[0];
          objectArray = dbResult.map(function (row) {
            var _ref;

            return _ref = {}, _defineProperty(_ref, row.db_name, row.f_name), _defineProperty(_ref, "is_show", row.is_show), _defineProperty(_ref, "type", row.type), _ref;
          });
          console.log("yingshe");
          console.dir(objectArray);
          ctx.body = objectArray;

        case 9:
        case "end":
          return _context2.stop();
      }
    }
  });
}); //行为映射表

Router1.get("/yingshe/action", function _callee3(ctx) {
  var dbResult, objectArray;
  return regeneratorRuntime.async(function _callee3$(_context3) {
    while (1) {
      switch (_context3.prev = _context3.next) {
        case 0:
          console.log("123");
          _context3.next = 3;
          return regeneratorRuntime.awrap(connection2.execute("\n    SELECT db_name, f_name FROM t_behavior_field_mapper;\n  "));

        case 3:
          dbResult = _context3.sent;
          dbResult = dbResult[0];
          objectArray = dbResult.map(function (row) {
            return _defineProperty({}, row.db_name, row.f_name);
          });
          console.log("yingshe/action" + objectArray);
          ctx.body = objectArray;

        case 8:
        case "end":
          return _context3.stop();
      }
    }
  });
});
Router1.get("/guijunqiao", function _callee4(ctx) {
  var _ref3, _ref4, rows;

  return regeneratorRuntime.async(function _callee4$(_context4) {
    while (1) {
      switch (_context4.prev = _context4.next) {
        case 0:
          _context4.next = 2;
          return regeneratorRuntime.awrap(connection2.execute("\n    SELECT p_name FROM t_field_mapper;\n  "));

        case 2:
          _ref3 = _context4.sent;
          _ref4 = _slicedToArray(_ref3, 1);
          rows = _ref4[0];
          ctx.body = rows;

        case 6:
        case "end":
          return _context4.stop();
      }
    }
  });
});
var _default = Router1;
exports["default"] = _default;