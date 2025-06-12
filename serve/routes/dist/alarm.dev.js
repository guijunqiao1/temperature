"use strict";

Object.defineProperty(exports, "__esModule", {
  value: true
});
exports["default"] = void 0;

var _koaRouter = _interopRequireDefault(require("koa-router"));

var _indexNode = _interopRequireDefault(require("../indexNode1.js"));

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { "default": obj }; }

function _slicedToArray(arr, i) { return _arrayWithHoles(arr) || _iterableToArrayLimit(arr, i) || _nonIterableRest(); }

function _nonIterableRest() { throw new TypeError("Invalid attempt to destructure non-iterable instance"); }

function _iterableToArrayLimit(arr, i) { if (!(Symbol.iterator in Object(arr) || Object.prototype.toString.call(arr) === "[object Arguments]")) { return; } var _arr = []; var _n = true; var _d = false; var _e = undefined; try { for (var _i = arr[Symbol.iterator](), _s; !(_n = (_s = _i.next()).done); _n = true) { _arr.push(_s.value); if (i && _arr.length === i) break; } } catch (err) { _d = true; _e = err; } finally { try { if (!_n && _i["return"] != null) _i["return"](); } finally { if (_d) throw _e; } } return _arr; }

function _arrayWithHoles(arr) { if (Array.isArray(arr)) return arr; }

var Router_alarm = new _koaRouter["default"](); //在当前需要对Mysql数据库进行操作的文件中提前引入Mysql数据库的配置文件--需要注意的是indexNode文件中的其他引入的组件文件只是对indexNode本身编写的时候进行约束的文件

//此处获取到数据库链接配置对象
var connection; //定义数据库连接对象

(function _callee() {
  return regeneratorRuntime.async(function _callee$(_context) {
    while (1) {
      switch (_context.prev = _context.next) {
        case 0:
          _context.prev = 0;
          _context.next = 3;
          return regeneratorRuntime.awrap((0, _indexNode["default"])());

        case 3:
          connection = _context.sent;
          console.log("数据库5连接成功");
          _context.next = 10;
          break;

        case 7:
          _context.prev = 7;
          _context.t0 = _context["catch"](0);
          console.log("数据库5连接失败");

        case 10:
        case "end":
          return _context.stop();
      }
    }
  }, null, null, [[0, 7]]);
})(); //表格的呈现-图像的呈现路由


Router_alarm.get("/alarm", function _callee2(ctx) {
  var _ref, _ref2, results, formattedResult;

  return regeneratorRuntime.async(function _callee2$(_context2) {
    while (1) {
      switch (_context2.prev = _context2.next) {
        case 0:
          _context2.prev = 0;
          _context2.next = 3;
          return regeneratorRuntime.awrap(connection.query("SET SESSION group_concat_max_len = 1000000"));

        case 3:
          _context2.next = 5;
          return regeneratorRuntime.awrap(connection.query("\n      WITH latest_time_per_dno AS (\n          SELECT d_no, MAX(c_time) AS max_time \n          FROM t_data \n          GROUP BY d_no\n      )\n      SELECT \n          t.d_no, \n          GROUP_CONCAT(\n              CONCAT('[', \n                     '\"', t.field1, '\"', ',', \n                     '\"', t.field2, '\"', ',', \n                     '\"', t.field3, '\"', ',', \n                     '\"', t.field4, '\"', ',', \n                     '\"', t.c_time, '\"', \n              ']') ORDER BY t.c_time\n          ) AS data\n      FROM t_data t\n      JOIN latest_time_per_dno l \n        ON t.d_no = l.d_no\n        WHERE t.c_time BETWEEN (l.max_time - INTERVAL 5 MINUTE) AND l.max_time\n      GROUP BY t.d_no;\n    "));

        case 5:
          _ref = _context2.sent;
          _ref2 = _slicedToArray(_ref, 1);
          results = _ref2[0];
          formattedResult = results.map(function (row) {
            try {
              if (!row.data) return [row.d_no, []];
              var fixedData = "[".concat(row.data, "]");
              var data = JSON.parse(fixedData); // 遍历 data 数组，修改 c_time 格式（去掉秒数）

              data = data.map(function (entry) {
                return entry;
              });
              return [row.d_no, data];
            } catch (error) {
              console.error("JSON \u89E3\u6790\u5931\u8D25: ".concat(row.data), error);
              return [row.d_no, []];
            }
          }); //允许所有的来源

          ctx.set("Access-Control-Allow-Origin", "*");
          ctx.body = formattedResult;
          _context2.next = 16;
          break;

        case 13:
          _context2.prev = 13;
          _context2.t0 = _context2["catch"](0);
          console.log(_context2.t0);

        case 16:
        case "end":
          return _context2.stop();
      }
    }
  }, null, null, [[0, 13]]);
});
var _default = Router_alarm;
exports["default"] = _default;