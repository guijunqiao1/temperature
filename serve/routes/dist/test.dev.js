"use strict";

Object.defineProperty(exports, "__esModule", {
  value: true
});
exports["default"] = void 0;

var _indexNode = _interopRequireDefault(require("../indexNode2.js"));

var _koaRouter = _interopRequireDefault(require("koa-router"));

var _child_process = require("child_process");

var _mqtt_server_get = require("./mqtt_server_get.js");

var _dayjs = _interopRequireDefault(require("dayjs"));

var _ws = _interopRequireDefault(require("ws"));

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { "default": obj }; }

function _slicedToArray(arr, i) { return _arrayWithHoles(arr) || _iterableToArrayLimit(arr, i) || _nonIterableRest(); }

function _nonIterableRest() { throw new TypeError("Invalid attempt to destructure non-iterable instance"); }

function _iterableToArrayLimit(arr, i) { if (!(Symbol.iterator in Object(arr) || Object.prototype.toString.call(arr) === "[object Arguments]")) { return; } var _arr = []; var _n = true; var _d = false; var _e = undefined; try { for (var _i = arr[Symbol.iterator](), _s; !(_n = (_s = _i.next()).done); _n = true) { _arr.push(_s.value); if (i && _arr.length === i) break; } } catch (err) { _d = true; _e = err; } finally { try { if (!_n && _i["return"] != null) _i["return"](); } finally { if (_d) throw _e; } } return _arr; }

function _arrayWithHoles(arr) { if (Array.isArray(arr)) return arr; }

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
})(); //建立最新的websocket链接用于mqtt文件中的变量修改
//全局建立websocket连接，使得告警内容被实时推送到页面的全局


var socket = new _ws["default"]('ws://localhost:8081'); // 连接成功

socket.onopen = function () {
  console.log('后端WebSocket连接成功');
}; // 修改全局test变量


Router.get("/test", function _callee2(ctx) {
  var _ctx$query, d_no, qidong;

  return regeneratorRuntime.async(function _callee2$(_context2) {
    while (1) {
      switch (_context2.prev = _context2.next) {
        case 0:
          _ctx$query = ctx.query, d_no = _ctx$query.d_no, qidong = _ctx$query.qidong; //后台工位修改

          socket.send(JSON.stringify({
            type: 'data',
            gongwei: d_no
          })); //全局测试启动变量赋值

          if (qidong === 'yes') {
            socket.send(JSON.stringify({
              type: 'data',
              test: true
            })); //进行相应的次数变量的递增

            if (d_no === '工位1') {
              socket.send(JSON.stringify({
                type: 'data',
                test_times: 0
              }));
            } else if (d_no === '工位2') {
              socket.send(JSON.stringify({
                type: 'data',
                test_times: 1
              }));
            } else {
              socket.send(JSON.stringify({
                type: 'data',
                test_times: 2
              }));
            }
          } else {
            console.log("这里接收到了test:false");
            socket.send(JSON.stringify({
              type: 'data',
              test: false
            }));
          }

          ctx.body = 'ok';

        case 4:
        case "end":
          return _context2.stop();
      }
    }
  });
}); // 获取到当次的历史数组记录的路由

Router.get("/test_history", function _callee3(ctx) {
  var _ctx$query2, start, end, currentPage, pageSize, d_no, times, _ref, _ref2, result_now, sql_string, item, x, query, DESC_query, page_boolean, toTwoArray, OFFSET, FORMATTIME, formattedStart, formattedEnd, one_query, offset, toMap, _ref3, _ref4, rows, formattedRows, _ref5, _ref6, _rows, _formattedRows, _ref7, _ref8, _rows2, _formattedRows2, _ref9, _ref10, _rows3, _ref11, _ref12, _rows4, _formattedRows3, _ref13, _ref14, _rows5;

  return regeneratorRuntime.async(function _callee3$(_context3) {
    while (1) {
      switch (_context3.prev = _context3.next) {
        case 0:
          toMap = function _ref18(value) {
            return value.map(function (row) {
              return [row.d_no, row.field1, row.field2, row.field3, row.field4, row.field5, row.field6, row.field7, row.field8, (0, _dayjs["default"])(row.c_time).format('YYYY-MM-DD HH:mm:ss')];
            });
          };

          FORMATTIME = function _ref17(value) {
            var formatTime = function formatTime(timeStr) {
              return new Date(timeStr).toISOString().slice(0, 19).replace('T', ' ');
            };

            return formatTime(value);
          };

          OFFSET = function _ref16(value1, value2) {
            // value1:currentPage,value2:pageSize
            return (parseInt(value1) - 1) * parseInt(value2);
          };

          toTwoArray = function _ref15(value) {
            console.log("当前的row:");
            console.dir(value); // 将数据转换为二维数组格式 

            var formattedRows = value.map(function (row) {
              return [row.d_no, row.field1.toString(), row.field2.toString(), row.field3.toString(), row.field4.toString(), row.field5.toString(), row.field6.toString(), row.field7.toString(), row.field8.toString(), (0, _dayjs["default"])(row.c_time).format('YYYY-MM-DD HH:mm:ss') // 已经格式化为ISO 8601标准时间字符串
              ];
            });
            return formattedRows;
          };

          _ctx$query2 = ctx.query, start = _ctx$query2.start, end = _ctx$query2.end, currentPage = _ctx$query2.currentPage, pageSize = _ctx$query2.pageSize, d_no = _ctx$query2.d_no, times = _ctx$query2.times;
          _context3.next = 7;
          return regeneratorRuntime.awrap(connection2.query("\n    SELECT * \n    FROM t_data\n  "));

        case 7:
          _ref = _context3.sent;
          _ref2 = _slicedToArray(_ref, 1);
          result_now = _ref2[0];
          // 动态拼接sql依据字符串
          sql_string = '';

          for (item in result_now[0]) {
            if (result_now[0][item] !== null && item.includes("field")) {
              x = item + ",";
              sql_string += x;
            }
          } // 全局sql


          query = "SELECT d_no,".concat(sql_string, " c_time FROM t_data "); // 降序sql

          DESC_query = "ORDER BY c_time DESC"; // 页数有效值判断布尔变量 

          page_boolean = currentPage === "undefined" || pageSize === "undefined" || currentPage === undefined || pageSize === undefined; // 封装转化为数组的方法

          // 全局解构赋值
          formattedStart = FORMATTIME(start !== "end" && start !== "1" ? start : '2025-06-13 15:51:16');
          formattedEnd = FORMATTIME(end !== "1" ? end : '2025-06-13 15:51:16'); // 单向限制sql

          one_query = "WHERE c_time < \"".concat(formattedEnd, "\"") + (d_no === "null" ? "" : " AND d_no = \"".concat(d_no, "\""));

          if (page_boolean) {} else {
            offset = OFFSET(currentPage, pageSize);
          } // 封装响应结果格式化的方法


          if (!(start === "1" && end === "1")) {
            _context3.next = 39;
            break;
          }

          if (!page_boolean) {
            _context3.next = 30;
            break;
          }

          _context3.next = 23;
          return regeneratorRuntime.awrap(connection2.execute(query + (d_no === "null" ? "" : " WHERE d_no=\"".concat(d_no, " \"")) + " AND times=\"".concat(times, "\" ") + DESC_query));

        case 23:
          _ref3 = _context3.sent;
          _ref4 = _slicedToArray(_ref3, 1);
          rows = _ref4[0];
          formattedRows = toTwoArray(rows);
          ctx.body = JSON.stringify(formattedRows);
          _context3.next = 37;
          break;

        case 30:
          _context3.next = 32;
          return regeneratorRuntime.awrap(connection2.execute(query + (d_no === "null" ? "" : " WHERE d_no=\"".concat(d_no, " \"")) + " AND times=\"".concat(times, "\" ") + DESC_query + "\n        LIMIT ".concat(parseInt(pageSize), " OFFSET ").concat(offset)));

        case 32:
          _ref5 = _context3.sent;
          _ref6 = _slicedToArray(_ref5, 1);
          _rows = _ref6[0];
          _formattedRows = toTwoArray(_rows);
          ctx.body = JSON.stringify(_formattedRows);

        case 37:
          _context3.next = 74;
          break;

        case 39:
          if (!(start === "end" && end !== "1")) {
            _context3.next = 58;
            break;
          }

          if (!page_boolean) {
            _context3.next = 50;
            break;
          }

          _context3.next = 43;
          return regeneratorRuntime.awrap(connection2.execute(query + one_query + " AND times=\"".concat(times, "\" ") + DESC_query));

        case 43:
          _ref7 = _context3.sent;
          _ref8 = _slicedToArray(_ref7, 1);
          _rows2 = _ref8[0];
          _formattedRows2 = toTwoArray(_rows2);
          ctx.body = JSON.stringify(_formattedRows2);
          _context3.next = 56;
          break;

        case 50:
          _context3.next = 52;
          return regeneratorRuntime.awrap(connection2.execute(query + one_query + " AND times=\"".concat(times, "\" ") + DESC_query + "\n        LIMIT ".concat(parseInt(pageSize), " OFFSET ").concat(offset)));

        case 52:
          _ref9 = _context3.sent;
          _ref10 = _slicedToArray(_ref9, 1);
          _rows3 = _ref10[0];
          ctx.body = toMap(_rows3);

        case 56:
          _context3.next = 74;
          break;

        case 58:
          if (!page_boolean) {
            _context3.next = 68;
            break;
          }

          _context3.next = 61;
          return regeneratorRuntime.awrap(connection2.execute(query + "\n        WHERE c_time BETWEEN \"".concat(formattedStart, "\" AND \"").concat(formattedEnd, "\"") + (d_no === "null" ? "" : " AND d_no=\"".concat(d_no, "\" ")) + " AND times=\"".concat(times, "\" ") + DESC_query));

        case 61:
          _ref11 = _context3.sent;
          _ref12 = _slicedToArray(_ref11, 1);
          _rows4 = _ref12[0];
          _formattedRows3 = toTwoArray(_rows4);
          ctx.body = JSON.stringify(_formattedRows3);
          _context3.next = 74;
          break;

        case 68:
          _context3.next = 70;
          return regeneratorRuntime.awrap(connection2.execute(query + "WHERE c_time BETWEEN \"".concat(formattedStart, "\" AND \"").concat(formattedEnd, "\"") + (d_no === "null" ? "" : " AND d_no=\"".concat(d_no, "\" ")) + " AND times=\"".concat(times, "\" ") + DESC_query + " LIMIT ".concat(parseInt(pageSize), " OFFSET ").concat(offset)));

        case 70:
          _ref13 = _context3.sent;
          _ref14 = _slicedToArray(_ref13, 1);
          _rows5 = _ref14[0];
          ctx.body = toMap(_rows5);

        case 74:
        case "end":
          return _context3.stop();
      }
    }
  });
});
Router.get("/times", function _callee4(ctx) {
  var id, result_array, j, _j, _j2;

  return regeneratorRuntime.async(function _callee4$(_context4) {
    while (1) {
      switch (_context4.prev = _context4.next) {
        case 0:
          id = ctx.query.id; // 动态获取到相应长度的数组的方法

          console.log("111111");
          result_array = [];

          if (id === 1 || id == '1') {
            for (j = 0; j <= _mqtt_server_get.test_times[0]; j++) {
              result_array.push(j);
            }

            ctx.body = result_array;
          } else if (id === 2 || id === '2') {
            for (_j = 0; _j <= _mqtt_server_get.test_times[1]; _j++) {
              result_array.push(_j);
            }

            ctx.body = result_array;
          } else {
            for (_j2 = 0; _j2 <= _mqtt_server_get.test_times[2]; _j2++) {
              result_array.push(_j2);
            }

            ctx.body = result_array;
          }

        case 4:
        case "end":
          return _context4.stop();
      }
    }
  });
});
Router.get("/Test_array_get", function _callee5(ctx) {
  return regeneratorRuntime.async(function _callee5$(_context5) {
    while (1) {
      switch (_context5.prev = _context5.next) {
        case 0:
          ctx.body = _mqtt_server_get.test_times;

        case 1:
        case "end":
          return _context5.stop();
      }
    }
  });
}); //唤起计算器的路由

Router.get("/open-calculator", function _callee6(ctx) {
  return regeneratorRuntime.async(function _callee6$(_context6) {
    while (1) {
      switch (_context6.prev = _context6.next) {
        case 0:
          return _context6.abrupt("return", new Promise(function (resolve, reject) {
            // Windows 系统下的计算器命令
            (0, _child_process.exec)('calc', function (error, stdout, stderr) {
              if (error) {
                console.error("\u6267\u884C\u51FA\u9519: ".concat(error));
                ctx.body = {
                  success: false,
                  error: error.message
                };
              } else {
                ctx.body = {
                  success: true
                };
              }

              resolve();
            });
          }));

        case 1:
        case "end":
          return _context6.stop();
      }
    }
  });
});
var _default = Router;
exports["default"] = _default;