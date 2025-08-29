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
})(); // 机房导航使用
// 不需要分页的路由


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
            return [row.place, row.number];
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
}); // 设备列表使用
// 不需要分页的路由 -- 多设备表格

Router2.get("/DEVICE", function _callee4(ctx) {
  var d_no, query, _ref5, _ref6, results, formattedResults;

  return regeneratorRuntime.async(function _callee4$(_context4) {
    while (1) {
      switch (_context4.prev = _context4.next) {
        case 0:
          _context4.prev = 0;
          d_no = ctx.query.d_no;
          console.log("成功进入当前路由");
          // 处理 undefined 情况
          query = "SELECT * FROM t_device WHERE place = \"".concat(d_no, "\""); // 使用 `await` 进行查询

          _context4.next = 6;
          return regeneratorRuntime.awrap(connection2.execute(query));

        case 6:
          _ref5 = _context4.sent;
          _ref6 = _slicedToArray(_ref5, 1);
          results = _ref6[0];
          // 格式化数据
          console.log("rows:" + results);
          ctx.set("Content-Type", "application/json");
          formattedResults = results.map(function (row) {
            return [row.device_name, row.number, row.ctime, row.place];
          });
          ctx.body = JSON.stringify(formattedResults);
          _context4.next = 20;
          break;

        case 15:
          _context4.prev = 15;
          _context4.t0 = _context4["catch"](0);
          console.error("查询失败:", _context4.t0);
          ctx.status = 500;
          ctx.body = {
            error: "数据库查询失败"
          };

        case 20:
        case "end":
          return _context4.stop();
      }
    }
  }, null, null, [[0, 15]]);
}); //添加时间选择专用获取多机位的数组的路由

Router2.get("/get_array_by_time", function _callee5(ctx) {
  var _ctx$query, start, end, x, formatTime, yuju, formattime, formatstart, formatend, _ref7, _ref8, results, formattedResult;

  return regeneratorRuntime.async(function _callee5$(_context5) {
    while (1) {
      switch (_context5.prev = _context5.next) {
        case 0:
          //参考的是recent路由
          _ctx$query = ctx.query, start = _ctx$query.start, end = _ctx$query.end;
          _context5.prev = 1;
          _context5.next = 4;
          return regeneratorRuntime.awrap(connection2.query("SET SESSION group_concat_max_len = 1000000"));

        case 4:
          x = "'\"', t." + 'field8' + ", '\",', ";

          formatTime = function formatTime(timeStr) {
            return new Date(timeStr).toISOString().slice(0, 19).replace('T', ' ');
          }; //格式化时间方法


          //限制语句
          if (start === '1' && end === '1') {
            //初次
            yuju = '';
          } else if (start !== '1' && end !== '1' && start === end) {
            //向前查询
            //格式化时间值
            formattime = formatTime(start);
            yuju = "WHERE t.c_time < \"".concat(formattime, "\"");
          } else {
            //限制查询
            formatstart = formatTime(start);
            formatend = formatTime(end);
            yuju = "WHERE t.c_time BETWEEN \"".concat(formatstart, "\" AND \"").concat(formatend, "\"");
          }

          _context5.next = 9;
          return regeneratorRuntime.awrap(connection2.query("\n      SELECT \n          t.d_no, \n          GROUP_CONCAT(\n              CONCAT(\n                  '[', ".concat(x, " '\"', t.c_time, '\"', \n                  ']'\n              ) ORDER BY t.c_time\n          ) AS data\n      FROM t_data t\n      ").concat(yuju, "\n      GROUP BY t.d_no;\n    ")));

        case 9:
          _ref7 = _context5.sent;
          _ref8 = _slicedToArray(_ref7, 1);
          results = _ref8[0];
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
          _context5.next = 20;
          break;

        case 17:
          _context5.prev = 17;
          _context5.t0 = _context5["catch"](1);
          console.error("数据库查询失败", _context5.t0);

        case 20:
        case "end":
          return _context5.stop();
      }
    }
  }, null, null, [[1, 17]]);
});
var _default = Router2;
exports["default"] = _default;