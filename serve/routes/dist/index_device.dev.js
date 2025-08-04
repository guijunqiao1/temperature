"use strict";

Object.defineProperty(exports, "__esModule", {
  value: true
});
exports["default"] = void 0;

var _koaRouter = _interopRequireDefault(require("koa-router"));

var _indexNode = _interopRequireDefault(require("../indexNode2.js"));

var _indexNode2 = _interopRequireDefault(require("../indexNode1.js"));

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { "default": obj }; }

function _slicedToArray(arr, i) { return _arrayWithHoles(arr) || _iterableToArrayLimit(arr, i) || _nonIterableRest(); }

function _nonIterableRest() { throw new TypeError("Invalid attempt to destructure non-iterable instance"); }

function _iterableToArrayLimit(arr, i) { if (!(Symbol.iterator in Object(arr) || Object.prototype.toString.call(arr) === "[object Arguments]")) { return; } var _arr = []; var _n = true; var _d = false; var _e = undefined; try { for (var _i = arr[Symbol.iterator](), _s; !(_n = (_s = _i.next()).done); _n = true) { _arr.push(_s.value); if (i && _arr.length === i) break; } } catch (err) { _d = true; _e = err; } finally { try { if (!_n && _i["return"] != null) _i["return"](); } finally { if (_d) throw _e; } } return _arr; }

function _arrayWithHoles(arr) { if (Array.isArray(arr)) return arr; }

// 获取数据库链接配置对象
var connection2; // 定义数据库连接对象

var connection1; // 定义数据库连接对象

var Router2 = new _koaRouter["default"]();

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
          _context.next = 6;
          return regeneratorRuntime.awrap((0, _indexNode2["default"])());

        case 6:
          connection1 = _context.sent;
          console.log("数据库2连接成功");
          console.log("数据库1连接成功");
          _context.next = 15;
          break;

        case 11:
          _context.prev = 11;
          _context.t0 = _context["catch"](0);
          console.log("数据库2连接失败");
          console.log("数据库1连接失败");

        case 15:
        case "end":
          return _context.stop();
      }
    }
  }, null, null, [[0, 11]]);
})(); // 不需要分页的路由


Router2.get("/t_device/first", function _callee2(ctx) {
  var query, _ref, _ref2, results, formattedResults;

  return regeneratorRuntime.async(function _callee2$(_context2) {
    while (1) {
      switch (_context2.prev = _context2.next) {
        case 0:
          _context2.prev = 0;
          // 处理 undefined 情况
          query = "SELECT * FROM t_container ORDER BY ctime DESC"; // 使用 `await` 进行查询

          _context2.next = 4;
          return regeneratorRuntime.awrap(connection2.execute(query));

        case 4:
          _ref = _context2.sent;
          _ref2 = _slicedToArray(_ref, 1);
          results = _ref2[0];
          // 格式化数据
          formattedResults = results.map(function (row) {
            return [row.PID, row.VID, row.ctime];
          });
          console.log("rows:" + results);
          ctx.set("Content-Type", "application/json");
          ctx.body = JSON.stringify(formattedResults);
          _context2.next = 18;
          break;

        case 13:
          _context2.prev = 13;
          _context2.t0 = _context2["catch"](0);
          console.error("查询失败:", _context2.t0);
          ctx.status = 500;
          ctx.body = {
            error: "数据库查询失败"
          };

        case 18:
        case "end":
          return _context2.stop();
      }
    }
  }, null, null, [[0, 13]]);
}); // 不需要分页的路由 -- 多设备表格

Router2.get("/t_device", function _callee3(ctx) {
  var query, _ref3, _ref4, results, formattedResults;

  return regeneratorRuntime.async(function _callee3$(_context3) {
    while (1) {
      switch (_context3.prev = _context3.next) {
        case 0:
          _context3.prev = 0;
          console.log("成功进入当前路由");
          // 处理 undefined 情况
          query = "SELECT * FROM t_device"; // 使用 `await` 进行查询

          _context3.next = 5;
          return regeneratorRuntime.awrap(connection2.execute(query));

        case 5:
          _ref3 = _context3.sent;
          _ref4 = _slicedToArray(_ref3, 1);
          results = _ref4[0];
          // 格式化数据
          console.log("rows:" + results);
          ctx.set("Content-Type", "application/json");
          formattedResults = results.map(function (row) {
            return [row.device_name, row.number];
          });
          ctx.body = JSON.stringify(formattedResults);
          _context3.next = 19;
          break;

        case 14:
          _context3.prev = 14;
          _context3.t0 = _context3["catch"](0);
          console.error("查询失败:", _context3.t0);
          ctx.status = 500;
          ctx.body = {
            error: "数据库查询失败"
          };

        case 19:
        case "end":
          return _context3.stop();
      }
    }
  }, null, null, [[0, 14]]);
});
var _default = Router2;
exports["default"] = _default;