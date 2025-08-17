"use strict";

Object.defineProperty(exports, "__esModule", {
  value: true
});
exports["default"] = void 0;

var _indexNode = _interopRequireDefault(require("../indexNode2.js"));

var _koaRouter = _interopRequireDefault(require("koa-router"));

var _dayjs = _interopRequireDefault(require("dayjs"));

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { "default": obj }; }

function _slicedToArray(arr, i) { return _arrayWithHoles(arr) || _iterableToArrayLimit(arr, i) || _nonIterableRest(); }

function _nonIterableRest() { throw new TypeError("Invalid attempt to destructure non-iterable instance"); }

function _iterableToArrayLimit(arr, i) { if (!(Symbol.iterator in Object(arr) || Object.prototype.toString.call(arr) === "[object Arguments]")) { return; } var _arr = []; var _n = true; var _d = false; var _e = undefined; try { for (var _i = arr[Symbol.iterator](), _s; !(_n = (_s = _i.next()).done); _n = true) { _arr.push(_s.value); if (i && _arr.length === i) break; } } catch (err) { _d = true; _e = err; } finally { try { if (!_n && _i["return"] != null) _i["return"](); } finally { if (_d) throw _e; } } return _arr; }

function _arrayWithHoles(arr) { if (Array.isArray(arr)) return arr; }

// 引入提供format使用环境的组件
var connection2; // 数据库连接对象

var SENSOR = new _koaRouter["default"](); // 创建 Koa 路由实例
// 数据库连接（立即执行异步函数）

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
          console.log("数据库连接成功");
          _context.next = 10;
          break;

        case 7:
          _context.prev = 7;
          _context.t0 = _context["catch"](0);
          console.log("数据库连接失败");

        case 10:
        case "end":
          return _context.stop();
      }
    }
  }, null, null, [[0, 7]]);
})();

SENSOR.get("/sensor_get", function _callee2(ctx) {
  var d_no, _ref, _ref2, rows, result, i, j, name, cable;

  return regeneratorRuntime.async(function _callee2$(_context2) {
    while (1) {
      switch (_context2.prev = _context2.next) {
        case 0:
          d_no = ctx.query.d_no; //动态获取数量

          _context2.next = 3;
          return regeneratorRuntime.awrap(connection2.execute("\n  SELECT *\n  FROM sensor_set\n  WHERE place = '".concat(d_no, "'\n  ")));

        case 3:
          _ref = _context2.sent;
          _ref2 = _slicedToArray(_ref, 1);
          rows = _ref2[0];
          console.log("rows:");
          console.log(rows); //拼接响应结果

          result = [];
          i = 1;

        case 10:
          if (!1) {
            _context2.next = 18;
            break;
          }

          if (!rows[0]['sensor' + i]) {
            _context2.next = 15;
            break;
          }

          i++;
          _context2.next = 16;
          break;

        case 15:
          return _context2.abrupt("break", 18);

        case 16:
          _context2.next = 10;
          break;

        case 18:
          for (j = 1; j < i; j++) {
            //获取到字段信息中的name、cable
            name = rows[0]['sensor' + j].split(":")[1];
            cable = rows[0]['sensor' + j].split(":")[0];
            result.push({
              name: name,
              cable: cable,
              id: j
            });
          }

          ctx.body = result;

        case 20:
        case "end":
          return _context2.stop();
      }
    }
  });
});
SENSOR.get("/sensor_change", function _callee3(ctx) {
  var _ctx$query, name, cable, d_no, id, all, _ref3, _ref4, rows;

  return regeneratorRuntime.async(function _callee3$(_context3) {
    while (1) {
      switch (_context3.prev = _context3.next) {
        case 0:
          _ctx$query = ctx.query, name = _ctx$query.name, cable = _ctx$query.cable, d_no = _ctx$query.d_no, id = _ctx$query.id; //定义综合内容变量

          all = cable + ":" + name + '传感器';
          _context3.next = 4;
          return regeneratorRuntime.awrap(connection2.execute("\n    UPDATE sensor_set\n    SET sensor".concat(id, " = \"").concat(all, "\"\n    WHERE place = \"").concat(d_no, "\"\n    ")));

        case 4:
          _ref3 = _context3.sent;
          _ref4 = _slicedToArray(_ref3, 1);
          rows = _ref4[0];
          ctx.body = 'ok';

        case 8:
        case "end":
          return _context3.stop();
      }
    }
  });
});
var _default = SENSOR;
exports["default"] = _default;