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

// 替换 express 为 koa-router
var connection2; // 数据库连接对象

var Router = new _koaRouter["default"](); // 创建 Koa 路由实例
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
})(); // 设备最新数据


Router.get("/recent", function _callee2(ctx) {
  var _ref, _ref2, result_now, sql_string, item, x, _ref3, _ref4, results, formattedResult;

  return regeneratorRuntime.async(function _callee2$(_context2) {
    while (1) {
      switch (_context2.prev = _context2.next) {
        case 0:
          _context2.prev = 0;
          _context2.next = 3;
          return regeneratorRuntime.awrap(connection2.query("SET SESSION group_concat_max_len = 1000000"));

        case 3:
          _context2.next = 5;
          return regeneratorRuntime.awrap(connection2.query("\n      SELECT * \n      FROM t_data\n    "));

        case 5:
          _ref = _context2.sent;
          _ref2 = _slicedToArray(_ref, 1);
          result_now = _ref2[0];
          sql_string = '';

          for (item in result_now[0]) {
            if (result_now[0][item] !== null && item.includes("field")) {
              x = "'\"', t." + item + ", '\",', ";
              sql_string += x;
            }
          }

          _context2.next = 12;
          return regeneratorRuntime.awrap(connection2.query("\n      SELECT \n          t.d_no, \n          GROUP_CONCAT(\n              CONCAT(\n                  '[', ".concat(sql_string, " '\"', t.c_time, '\"', \n                  ']'\n              ) ORDER BY t.c_time\n          ) AS data\n      FROM t_data t\n      WHERE t.c_time BETWEEN \n          (SELECT MAX(c_time) FROM t_data WHERE d_no = t.d_no) - INTERVAL 5 MINUTE \n          AND (SELECT MAX(c_time) FROM t_data WHERE d_no = t.d_no)\n      GROUP BY t.d_no;\n    ")));

        case 12:
          _ref3 = _context2.sent;
          _ref4 = _slicedToArray(_ref3, 1);
          results = _ref4[0];
          formattedResult = results.map(function (row) {
            try {
              if (!row.data) return [row.d_no, []];
              var fixedData = "[".concat(row.data, "]");
              var data = JSON.parse(fixedData);
              data = data.map(function (entry) {
                return entry;
              });
              return [row.d_no, data];
            } catch (error) {
              console.error("JSON \u89E3\u6790\u5931\u8D25: ".concat(row.data), error);
              return [row.d_no, []];
            }
          });
          ctx.set('Access-Control-Allow-Origin', '*');
          ctx.body = formattedResult;
          _context2.next = 23;
          break;

        case 20:
          _context2.prev = 20;
          _context2.t0 = _context2["catch"](0);
          console.error("数据库查询失败", _context2.t0);

        case 23:
        case "end":
          return _context2.stop();
      }
    }
  }, null, null, [[0, 20]]);
}); // 行为最新数据

Router.get("/recent/action", function _callee3(ctx) {
  var _ref5, _ref6, result_now, sql_string, item, x, _ref7, _ref8, results, formattedResult;

  return regeneratorRuntime.async(function _callee3$(_context3) {
    while (1) {
      switch (_context3.prev = _context3.next) {
        case 0:
          _context3.prev = 0;
          _context3.next = 3;
          return regeneratorRuntime.awrap(connection2.query("SET SESSION group_concat_max_len = 1000000"));

        case 3:
          _context3.next = 5;
          return regeneratorRuntime.awrap(connection2.query("\n      SELECT * \n      FROM t_behavior_data\n    "));

        case 5:
          _ref5 = _context3.sent;
          _ref6 = _slicedToArray(_ref5, 1);
          result_now = _ref6[0];
          sql_string = '';

          for (item in result_now[0]) {
            if (result_now[0][item] !== null && item.includes("field")) {
              x = "'\"', t." + item + ", '\",', ";
              sql_string += x;
            }
          }

          _context3.next = 12;
          return regeneratorRuntime.awrap(connection2.query("\n      WITH latest_time_per_dno AS (\n        SELECT d_no, MAX(c_time) AS max_time \n        FROM t_behavior_data\n        GROUP BY d_no\n      )\n      SELECT \n          t.d_no, \n          GROUP_CONCAT(\n              CONCAT('[', \n              ".concat(sql_string, "\n              '\"', t.c_time, '\",',\n              '\"', t.file_type, '\"',\n              ']') ORDER BY t.c_time\n          ) AS data\n      FROM t_behavior_data t\n      JOIN latest_time_per_dno l\n        ON t.d_no = l.d_no\n        WHERE t.c_time BETWEEN (l.max_time - INTERVAL 5 MINUTE) AND l.max_time\n      GROUP BY t.d_no;\n    ")));

        case 12:
          _ref7 = _context3.sent;
          _ref8 = _slicedToArray(_ref7, 1);
          results = _ref8[0];
          formattedResult = results.map(function (row) {
            try {
              if (!row.data) return [row.d_no, []];
              var fixedData = "[".concat(row.data, "]");
              var data = JSON.parse(fixedData);
              return [row.d_no, data];
            } catch (error) {
              console.error("JSON \u89E3\u6790\u5931\u8D25: ".concat(row.data), error);
              return [row.d_no, []];
            }
          });
          ctx.body = formattedResult;
          _context3.next = 22;
          break;

        case 19:
          _context3.prev = 19;
          _context3.t0 = _context3["catch"](0);
          console.error("数据库查询失败", _context3.t0);

        case 22:
        case "end":
          return _context3.stop();
      }
    }
  }, null, null, [[0, 19]]);
}); // 设备ID最新记录

Router.get("/recent/list_obj", function _callee4(ctx) {
  var _ref9, _ref10, rows;

  return regeneratorRuntime.async(function _callee4$(_context4) {
    while (1) {
      switch (_context4.prev = _context4.next) {
        case 0:
          _context4.next = 2;
          return regeneratorRuntime.awrap(connection2.query("\n    SELECT *\n    FROM t_container\n    ORDER BY ctime DESC\n  "));

        case 2:
          _ref9 = _context4.sent;
          _ref10 = _slicedToArray(_ref9, 1);
          rows = _ref10[0];
          ctx.body = rows[0];

        case 6:
        case "end":
          return _context4.stop();
      }
    }
  });
}); // 最新图片资源记录

Router.get("/recent/img", function _callee5(ctx) {
  var d_no, _ref11, _ref12, rows;

  return regeneratorRuntime.async(function _callee5$(_context5) {
    while (1) {
      switch (_context5.prev = _context5.next) {
        case 0:
          d_no = ctx.query.d_no;
          console.log("d_no:" + d_no);
          _context5.next = 4;
          return regeneratorRuntime.awrap(connection2.execute("\n    SELECT *\n    FROM t_behavior_data\n    WHERE d_no = '".concat(d_no, "'\n    ORDER BY c_time DESC\n    LIMIT 1\n  ")));

        case 4:
          _ref11 = _context5.sent;
          _ref12 = _slicedToArray(_ref11, 1);
          rows = _ref12[0];
          ctx.body = rows[0];

        case 8:
        case "end":
          return _context5.stop();
      }
    }
  });
});
var _default = Router;
exports["default"] = _default;