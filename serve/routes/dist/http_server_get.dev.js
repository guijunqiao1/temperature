"use strict";

Object.defineProperty(exports, "__esModule", {
  value: true
});
exports["default"] = void 0;

var _koa = _interopRequireDefault(require("koa"));

var _koaRouter = _interopRequireDefault(require("koa-router"));

var _koaBody = require("koa-body");

var _indexNode = _interopRequireDefault(require("../indexNode2.js"));

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { "default": obj }; }

function _slicedToArray(arr, i) { return _arrayWithHoles(arr) || _iterableToArrayLimit(arr, i) || _nonIterableRest(); }

function _nonIterableRest() { throw new TypeError("Invalid attempt to destructure non-iterable instance"); }

function _iterableToArrayLimit(arr, i) { if (!(Symbol.iterator in Object(arr) || Object.prototype.toString.call(arr) === "[object Arguments]")) { return; } var _arr = []; var _n = true; var _d = false; var _e = undefined; try { for (var _i = arr[Symbol.iterator](), _s; !(_n = (_s = _i.next()).done); _n = true) { _arr.push(_s.value); if (i && _arr.length === i) break; } } catch (err) { _d = true; _e = err; } finally { try { if (!_n && _i["return"] != null) _i["return"](); } finally { if (_d) throw _e; } } return _arr; }

function _arrayWithHoles(arr) { if (Array.isArray(arr)) return arr; }

var app = new _koa["default"]();
var router = new _koaRouter["default"]();
app.use((0, _koaBody.koaBody)({
  urlencoded: true,
  json: true
}));
var connection1;

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
          console.log("数据库3连接成功");
          _context.next = 10;
          break;

        case 7:
          _context.prev = 7;
          _context.t0 = _context["catch"](0);
          console.log("数据库3连接失败");

        case 10:
        case "end":
          return _context.stop();
      }
    }
  }, null, null, [[0, 7]]);
})(); // HTTP 服务器端点


router.post('/sensor/data', function _callee2(ctx) {
  var _ctx$request$body, d_no, png, mp4, type, _ref, _ref2, rows1, time_base, obj, finalType, finalDNo;

  return regeneratorRuntime.async(function _callee2$(_context2) {
    while (1) {
      switch (_context2.prev = _context2.next) {
        case 0:
          _ctx$request$body = ctx.request.body, d_no = _ctx$request$body.d_no, png = _ctx$request$body.png, mp4 = _ctx$request$body.mp4, type = _ctx$request$body.type;
          console.log("接收到传感器数据", ctx.request.body);

          if (!(png > 0 && mp4 > 0)) {
            _context2.next = 15;
            break;
          }

          _context2.next = 5;
          return regeneratorRuntime.awrap(connection1.execute("SELECT p_name FROM t_behavior_field_mapper"));

        case 5:
          _ref = _context2.sent;
          _ref2 = _slicedToArray(_ref, 1);
          rows1 = _ref2[0];
          time_base = getFormattedDate();
          obj = {};
          rows1.forEach(function (item, index) {
            if (index === 0) obj[item.p_name] = png;else if (index === 1) obj[item.p_name] = mp4;
          });
          finalType = type || "实时数据";
          finalDNo = d_no || null;
          _context2.next = 15;
          return regeneratorRuntime.awrap(connection1.execute("\n      INSERT INTO t_behavior_data(d_no,field1,field2,c_time,type)\n      VALUES (\"".concat(finalDNo, "\",\"").concat(obj.P, "\",\"").concat(obj.V, "\",\"").concat(time_base, "\",\"").concat(finalType, "\")\n    ")));

        case 15:
          ctx.status = 200;
          ctx.body = 'OK';

        case 17:
        case "end":
          return _context2.stop();
      }
    }
  });
});
router.post('/miss_data', function _callee3(ctx) {
  var _ctx$request$body2, d_no, png, mp4, type, _ref3, _ref4, rows1, time_base, obj, finalType, finalDNo;

  return regeneratorRuntime.async(function _callee3$(_context3) {
    while (1) {
      switch (_context3.prev = _context3.next) {
        case 0:
          _ctx$request$body2 = ctx.request.body, d_no = _ctx$request$body2.d_no, png = _ctx$request$body2.png, mp4 = _ctx$request$body2.mp4, type = _ctx$request$body2.type;
          console.log("接收到保存数据", ctx.request.body);

          if (!(png > 0 && mp4 > 0)) {
            _context3.next = 15;
            break;
          }

          _context3.next = 5;
          return regeneratorRuntime.awrap(connection1.execute("SELECT p_name FROM t_behavior_field_mapper"));

        case 5:
          _ref3 = _context3.sent;
          _ref4 = _slicedToArray(_ref3, 1);
          rows1 = _ref4[0];
          time_base = getFormattedDate();
          obj = {};
          rows1.forEach(function (item, index) {
            if (index === 0) obj[item.p_name] = png;else if (index === 1) obj[item.p_name] = mp4;
          });
          finalType = type || "保存数据";
          finalDNo = d_no || null;
          _context3.next = 15;
          return regeneratorRuntime.awrap(connection1.execute("\n      INSERT INTO t_behavior_data(d_no,field1,field2,c_time,type)\n      VALUES (\"".concat(finalDNo, "\",\"").concat(obj.P, "\",\"").concat(obj.V, "\",\"").concat(time_base, "\",\"").concat(finalType, "\")\n    ")));

        case 15:
          ctx.status = 200;
          ctx.body = 'OK';

        case 17:
        case "end":
          return _context3.stop();
      }
    }
  });
});
var _default = router;
exports["default"] = _default;