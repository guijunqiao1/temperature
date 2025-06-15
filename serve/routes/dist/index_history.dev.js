"use strict";

Object.defineProperty(exports, "__esModule", {
  value: true
});
exports["default"] = void 0;

var _indexNode = _interopRequireDefault(require("../indexNode2.js"));

var _dayjs = _interopRequireDefault(require("dayjs"));

var _koaRouter = _interopRequireDefault(require("koa-router"));

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { "default": obj }; }

function _slicedToArray(arr, i) { return _arrayWithHoles(arr) || _iterableToArrayLimit(arr, i) || _nonIterableRest(); }

function _nonIterableRest() { throw new TypeError("Invalid attempt to destructure non-iterable instance"); }

function _iterableToArrayLimit(arr, i) { if (!(Symbol.iterator in Object(arr) || Object.prototype.toString.call(arr) === "[object Arguments]")) { return; } var _arr = []; var _n = true; var _d = false; var _e = undefined; try { for (var _i = arr[Symbol.iterator](), _s; !(_n = (_s = _i.next()).done); _n = true) { _arr.push(_s.value); if (i && _arr.length === i) break; } } catch (err) { _d = true; _e = err; } finally { try { if (!_n && _i["return"] != null) _i["return"](); } finally { if (_d) throw _e; } } return _arr; }

function _arrayWithHoles(arr) { if (Array.isArray(arr)) return arr; }

//引入提供format使用环境的组件
var connection2; //定义数据库连接对象

var Router4 = new _koaRouter["default"]();

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
          console.log("数据库4连接成功");
          console.log("test");
          _context.next = 11;
          break;

        case 8:
          _context.prev = 8;
          _context.t0 = _context["catch"](0);
          console.log("数据库4连接失败");

        case 11:
        case "end":
          return _context.stop();
      }
    }
  }, null, null, [[0, 8]]);
})(); //表格的呈现-图像的呈现路由


Router4.get("/History", function _callee2(ctx) {
  var _ctx$query, start, end, currentPage, pageSize, d_no, _ref, _ref2, rows, formattedRows, offset, _ref3, _ref4, _rows, _formattedRows, formatTime, formattedEnd, _ref5, _ref6, _rows2, _formattedRows2, _offset, _formatTime, _formattedEnd, _ref7, _ref8, _rows3, _formatTime2, formattedStart, _formattedEnd2, _ref9, _ref10, _rows4, _formattedRows3, _offset2, _formatTime3, _formattedStart, _formattedEnd3, _ref11, _ref12, _rows5;

  return regeneratorRuntime.async(function _callee2$(_context2) {
    while (1) {
      switch (_context2.prev = _context2.next) {
        case 0:
          _ctx$query = ctx.query, start = _ctx$query.start, end = _ctx$query.end, currentPage = _ctx$query.currentPage, pageSize = _ctx$query.pageSize, d_no = _ctx$query.d_no;
          _context2.prev = 1;

          if (!(start === "1" && end === "1")) {
            _context2.next = 25;
            break;
          }

          if (!(currentPage === "undefined" || pageSize === "undefined" || currentPage === undefined || pageSize === undefined)) {
            _context2.next = 13;
            break;
          }

          _context2.next = 6;
          return regeneratorRuntime.awrap(connection2.execute("\n          SELECT d_no, field1, field2, field3,field4, field5, field6,field7,field8, DATE_FORMAT(c_time, '%Y-%m-%dT%H:%i:%s.000Z') AS c_time,type\n          FROM t_data \n          ORDER BY c_time DESC\n        ", [d_no]));

        case 6:
          _ref = _context2.sent;
          _ref2 = _slicedToArray(_ref, 1);
          rows = _ref2[0];
          // 将数据转换为二维数组格式
          formattedRows = rows.map(function (row) {
            return [row.d_no, row.field1.toString(), // 确保所有字段为字符串类型
            row.field2.toString(), row.field3.toString(), row.field4.toString(), row.field5.toString(), row.field6.toString(), row.field7.toString(), row.field8.toString(), (0, _dayjs["default"])(row.c_time).format('YYYY-MM-DD HH:mm:ss'), // 已经格式化为ISO 8601标准时间字符串
            row.type];
          }); // 直接使用 res.send() 返回数据

          ctx.body = JSON.stringify(formattedRows);
          _context2.next = 23;
          break;

        case 13:
          console.log("currentPage:" + currentPage);
          console.log("pageSize:" + pageSize); //首先将页数整数化

          offset = (parseInt(currentPage) - 1) * parseInt(pageSize); //直接查询

          _context2.next = 18;
          return regeneratorRuntime.awrap(connection2.execute("\n          SELECT d_no,field1,field2,field3,field4, field5, field6,field7,field8,c_time,type\n          FROM t_data \n          ORDER BY c_time DESC\n          LIMIT ".concat(parseInt(pageSize), " OFFSET ").concat(offset, "\n        ")));

        case 18:
          _ref3 = _context2.sent;
          _ref4 = _slicedToArray(_ref3, 1);
          _rows = _ref4[0];
          // 将数据转换为二维数组格式
          _formattedRows = _rows.map(function (row) {
            return [row.d_no, row.field1.toString(), // 确保所有字段为字符串类型
            row.field2.toString(), row.field3.toString(), row.field4.toString(), row.field5.toString(), row.field6.toString(), row.field7.toString(), row.field8.toString(), (0, _dayjs["default"])(row.c_time).format('YYYY-MM-DD HH:mm:ss'), // 已经格式化为ISO 8601标准时间字符串
            row.type];
          }); // 直接使用 res.send() 返回数据

          ctx.body = JSON.stringify(_formattedRows);

        case 23:
          _context2.next = 81;
          break;

        case 25:
          if (!(start === "end" && end !== "1")) {
            _context2.next = 53;
            break;
          }

          console.log("end:" + end);
          console.log("d_no" + d_no);

          if (!(currentPage === "undefined" || pageSize === "undefined" || currentPage === undefined || pageSize === undefined)) {
            _context2.next = 40;
            break;
          }

          //首先将时间格式化同时将页数整数化
          formatTime = function formatTime(timeStr) {
            return new Date(timeStr).toISOString().slice(0, 19).replace('T', ' ');
          };

          formattedEnd = formatTime(end); //直接查询

          _context2.next = 33;
          return regeneratorRuntime.awrap(connection2.execute("\n            SELECT d_no,field1,field2,field3,field4, field5, field6,field7,field8,c_time,type\n            FROM t_data \n            WHERE c_time < \"".concat(formattedEnd, "\"\n            ORDER BY c_time DESC\n          ")));

        case 33:
          _ref5 = _context2.sent;
          _ref6 = _slicedToArray(_ref5, 1);
          _rows2 = _ref6[0];
          // 将数据转换为二维数组格式
          _formattedRows2 = _rows2.map(function (row) {
            return [row.d_no, row.field1.toString(), // 确保所有字段为字符串类型
            row.field2.toString(), row.field3.toString(), row.field4.toString(), row.field5.toString(), row.field6.toString(), row.field7.toString(), row.field8.toString(), (0, _dayjs["default"])(row.c_time).format('YYYY-MM-DD HH:mm:ss'), // 已经格式化为ISO 8601标准时间字符串
            row.type];
          }); // 直接使用 res.send() 返回数据

          ctx.body = JSON.stringify(_formattedRows2);
          _context2.next = 51;
          break;

        case 40:
          console.log("currentPage:" + currentPage);
          console.log("pageSize:" + pageSize); //首先将时间格式化同时将页数整数化

          _offset = (parseInt(currentPage) - 1) * parseInt(pageSize);

          _formatTime = function _formatTime(timeStr) {
            return new Date(timeStr).toISOString().slice(0, 19).replace('T', ' ');
          };

          _formattedEnd = _formatTime(end); //直接查询

          _context2.next = 47;
          return regeneratorRuntime.awrap(connection2.execute("\n          SELECT d_no,field1,field2,field3,field4, field5, field6,field7,field8,c_time,type\n          FROM t_data\n          WHERE c_time < \"".concat(_formattedEnd, "\"\n          ORDER BY c_time DESC\n          LIMIT ").concat(parseInt(pageSize), " OFFSET ").concat(_offset, "\n        ")));

        case 47:
          _ref7 = _context2.sent;
          _ref8 = _slicedToArray(_ref7, 1);
          _rows3 = _ref8[0];
          res.json(_rows3.map(function (row) {
            return [row.d_no, row.field1, row.field2, row.field3, row.field4, row.field4, row.field5, row.field6, row.field7, row.field8, (0, _dayjs["default"])(row.c_time).format('YYYY-MM-DD HH:mm:ss'), row.type];
          }));

        case 51:
          _context2.next = 81;
          break;

        case 53:
          //change1、分页后的事件的执行--内容获取--需要在start到end的基础上结合currentPage分页以及d_no的指定查询
          console.log("start:" + start);
          console.log("end:" + end);
          console.log("d_no" + d_no);

          if (!(currentPage === "undefined" || pageSize === "undefined" || currentPage === undefined || pageSize === undefined)) {
            _context2.next = 69;
            break;
          }

          //首先将时间格式化同时将页数整数化
          _formatTime2 = function _formatTime2(timeStr) {
            return new Date(timeStr).toISOString().slice(0, 19).replace('T', ' ');
          };

          formattedStart = _formatTime2(start);
          _formattedEnd2 = _formatTime2(end); //直接查询

          _context2.next = 62;
          return regeneratorRuntime.awrap(connection2.execute("\n            SELECT d_no,field1,field2,field3,field4, field5, field6,field7,field8,c_time,type\n            FROM t_data \n            WHERE c_time BETWEEN \"".concat(formattedStart, "\" AND \"").concat(_formattedEnd2, "\"\n            ORDER BY c_time DESC\n          ")));

        case 62:
          _ref9 = _context2.sent;
          _ref10 = _slicedToArray(_ref9, 1);
          _rows4 = _ref10[0];
          // 将数据转换为二维数组格式
          _formattedRows3 = _rows4.map(function (row) {
            return [row.d_no, row.field1.toString(), // 确保所有字段为字符串类型
            row.field2.toString(), row.field3.toString(), row.field4.toString(), row.field5.toString(), row.field6.toString(), row.field7.toString(), row.field8.toString(), (0, _dayjs["default"])(row.c_time).format('YYYY-MM-DD HH:mm:ss'), // 已经格式化为ISO 8601标准时间字符串
            row.type];
          }); // 直接使用 res.send() 返回数据

          ctx.body = JSON.stringify(_formattedRows3);
          _context2.next = 81;
          break;

        case 69:
          console.log("currentPage:" + currentPage);
          console.log("pageSize:" + pageSize); //首先将时间格式化同时将页数整数化

          _offset2 = (parseInt(currentPage) - 1) * parseInt(pageSize);

          _formatTime3 = function _formatTime3(timeStr) {
            return new Date(timeStr).toISOString().slice(0, 19).replace('T', ' ');
          };

          _formattedStart = _formatTime3(start);
          _formattedEnd3 = _formatTime3(end); //直接查询

          _context2.next = 77;
          return regeneratorRuntime.awrap(connection2.execute("\n          SELECT d_no,field1,field2,field3,field4, field5, field6,field7,field8,c_time,type\n          FROM t_data \n          WHERE c_time BETWEEN \"".concat(_formattedStart, "\" AND \"").concat(_formattedEnd3, "\"\n          ORDER BY c_time DESC\n          LIMIT ").concat(parseInt(pageSize), " OFFSET ").concat(_offset2, "\n        ")));

        case 77:
          _ref11 = _context2.sent;
          _ref12 = _slicedToArray(_ref11, 1);
          _rows5 = _ref12[0];
          res.json(_rows5.map(function (row) {
            return [row.d_no, row.field1, row.field2, row.field3, row.field4, row.field4, row.field5, row.field6, row.field7, row.field8, (0, _dayjs["default"])(row.c_time).format('YYYY-MM-DD HH:mm:ss'), row.type];
          }));

        case 81:
          _context2.next = 90;
          break;

        case 83:
          _context2.prev = 83;
          _context2.t0 = _context2["catch"](1);
          console.log("History路由中：" + start);
          console.log("History路由中：" + end);
          console.log("History路由中：" + currentPage);
          console.log("History路由中：" + pageSize);
          console.log("History路由中：" + d_no);

        case 90:
        case "end":
          return _context2.stop();
      }
    }
  }, null, null, [[1, 83]]);
}); //表格的呈现路由

Router4.get("/History_count", function _callee3(ctx) {
  var _ctx$query2, start, end, d_no, _ref13, _ref14, rows, formatTime, formattedEnd, _ref15, _ref16, _rows6, _formatTime4, formattedStart, _formattedEnd4, _ref17, _ref18, _rows7;

  return regeneratorRuntime.async(function _callee3$(_context3) {
    while (1) {
      switch (_context3.prev = _context3.next) {
        case 0:
          _ctx$query2 = ctx.query, start = _ctx$query2.start, end = _ctx$query2.end, d_no = _ctx$query2.d_no;
          _context3.prev = 1;

          if (!(start === "1" && end === "1")) {
            _context3.next = 11;
            break;
          }

          _context3.next = 5;
          return regeneratorRuntime.awrap(connection2.execute("\n        SELECT COUNT(*) as total \n        FROM t_data \n      "));

        case 5:
          _ref13 = _context3.sent;
          _ref14 = _slicedToArray(_ref13, 1);
          rows = _ref14[0];
          // 直接返回数组长度
          ctx.body = "" + rows[0].total.toString();
          _context3.next = 36;
          break;

        case 11:
          if (!(start === "end" && end !== "1")) {
            _context3.next = 24;
            break;
          }

          console.log("end:" + end);
          console.log("d_no" + d_no); //格式化时间值

          formatTime = function formatTime(timeStr) {
            return new Date(timeStr).toISOString().slice(0, 19).replace('T', ' ');
          };

          formattedEnd = formatTime(end); //直接查询

          _context3.next = 18;
          return regeneratorRuntime.awrap(connection2.execute("\n        SELECT COUNT(*) as total \n        FROM t_data \n        WHERE c_time < \"".concat(formattedEnd, "\"\n      ")));

        case 18:
          _ref15 = _context3.sent;
          _ref16 = _slicedToArray(_ref15, 1);
          _rows6 = _ref16[0];
          // 直接返回数组长度
          ctx.body = "" + _rows6[0].total.toString();
          _context3.next = 36;
          break;

        case 24:
          //进行分页查询后计算大小
          console.log("start:" + start);
          console.log("end:" + end);
          console.log("d_no" + d_no); //格式化时间值

          _formatTime4 = function _formatTime4(timeStr) {
            return new Date(timeStr).toISOString().slice(0, 19).replace('T', ' ');
          };

          formattedStart = _formatTime4(start);
          _formattedEnd4 = _formatTime4(end); //直接查询

          _context3.next = 32;
          return regeneratorRuntime.awrap(connection2.execute("\n        SELECT COUNT(*) as total  \n        FROM t_data \n        WHERE d_no=\"".concat(d_no, "\" \n        AND c_time BETWEEN \"").concat(formattedStart, "\" AND \"").concat(_formattedEnd4, "\"\n      ")));

        case 32:
          _ref17 = _context3.sent;
          _ref18 = _slicedToArray(_ref17, 1);
          _rows7 = _ref18[0];
          // 直接返回数组长度
          ctx.body = "" + _rows7[0].total.toString();

        case 36:
          _context3.next = 43;
          break;

        case 38:
          _context3.prev = 38;
          _context3.t0 = _context3["catch"](1);
          console.log("History：" + start);
          console.log("History：" + end);
          console.log("History：" + d_no);

        case 43:
        case "end":
          return _context3.stop();
      }
    }
  }, null, null, [[1, 38]]);
}); //告警历史数据
// Router4.get("/History/alarm",asyncctx=>{
//   const {start,end} = ctx.query;
//   const [results] = await connection2.query(`
//     SELECT 
//   `);
// })
//储运箱入库历史数据

Router4.get("/History/container", function _callee4(ctx) {
  var _ctx$query3, start, end, formatTime, formattedStart, formattedEnd, _ref19, _ref20, results, formattedResults;

  return regeneratorRuntime.async(function _callee4$(_context4) {
    while (1) {
      switch (_context4.prev = _context4.next) {
        case 0:
          _ctx$query3 = ctx.query, start = _ctx$query3.start, end = _ctx$query3.end;

          formatTime = function formatTime(timeStr) {
            return new Date(timeStr).toISOString().slice(0, 19).replace('T', ' ');
          };

          formattedStart = formatTime(start);
          formattedEnd = formatTime(end);
          _context4.next = 6;
          return regeneratorRuntime.awrap(connection2.query("\n    SELECT *\n    FROM t_container\n    WHERE ctime BETWEEN \"".concat(formattedStart, "\" AND \"").concat(formattedEnd, "\"\n    ORDER BY ctime\n  ")));

        case 6:
          _ref19 = _context4.sent;
          _ref20 = _slicedToArray(_ref19, 1);
          results = _ref20[0];
          // 格式化数据
          formattedResults = results.map(function (row) {
            return [row.PID, row.VID, row.ctime];
          });
          ctx.body = formattedResults;

        case 11:
        case "end":
          return _context4.stop();
      }
    }
  });
}); //设备选项列表相关路由

Router4.get("/data", function _callee5(ctx) {
  var _ctx$query4, start, end, _ref21, _ref22, results, formattedResult, formatTime, formattedEnd, _ref23, _ref24, _results, _formattedResult, _formatTime5, formattedStart, _formattedEnd5, _ref25, _ref26, _results2, _formattedResult2;

  return regeneratorRuntime.async(function _callee5$(_context5) {
    while (1) {
      switch (_context5.prev = _context5.next) {
        case 0:
          //对data路由进行修改并且接纳上start和end，若接受失败则进行总的数据的返回
          _ctx$query4 = ctx.query, start = _ctx$query4.start, end = _ctx$query4.end;

          if (!(start === "1" && end === "1")) {
            _context5.next = 14;
            break;
          }

          _context5.next = 4;
          return regeneratorRuntime.awrap(connection2.query("SET SESSION group_concat_max_len = 1000000"));

        case 4:
          _context5.next = 6;
          return regeneratorRuntime.awrap(connection2.query("\n      SELECT d_no, \n        GROUP_CONCAT(\n          CONCAT('[', \n            '\"', field1, '\"', ',', \n            '\"', field2, '\"', ',', \n            '\"', field3, '\"', ',', \n            '\"', field4, '\"', ',', \n            '\"', field5, '\"', ',', \n            '\"', field6, '\"', ',', \n            '\"', field7, '\"', ',', \n            '\"', field8, '\"', ',', \n            '\"', c_time, '\"', \n          ']') ORDER BY c_time\n        ) AS data\n      FROM t_data\n      WHERE type = '\u5B9E\u65F6\u6570\u636E'\n      GROUP BY d_no;\n    "));

        case 6:
          _ref21 = _context5.sent;
          _ref22 = _slicedToArray(_ref21, 1);
          results = _ref22[0];
          // 处理查询结果
          formattedResult = [];
          results.forEach(function (row) {
            if (!row.data) return;
            var fixedData = "[".concat(row.data, "]");
            var data = JSON.parse(fixedData); // 解析 JSON 数据

            data.forEach(function (entry) {
              formattedResult.push([row.d_no, entry[0], entry[1], entry[2], entry[3], entry[4], entry[5], entry[6], entry[7], entry[8]]);
            });
          }); // 最终返回的格式为 [[设备名, 数据1...], [设备名, 数据2...], ...]

          ctx.body = formattedResult;
          _context5.next = 42;
          break;

        case 14:
          if (!(start === "end" && end !== "1")) {
            _context5.next = 29;
            break;
          }

          _context5.next = 17;
          return regeneratorRuntime.awrap(connection2.query("SET SESSION group_concat_max_len = 1000000"));

        case 17:
          formatTime = function formatTime(timeStr) {
            return new Date(timeStr).toISOString().slice(0, 19).replace('T', ' ');
          };

          formattedEnd = formatTime(end);
          _context5.next = 21;
          return regeneratorRuntime.awrap(connection2.query("\n      SELECT d_no, \n        GROUP_CONCAT(\n          CONCAT('[', \n            '\"', field1, '\"', ',', \n            '\"', field2, '\"', ',', \n            '\"', field3, '\"', ',', \n            '\"', field4, '\"', ',', \n            '\"', field5, '\"', ',', \n            '\"', field6, '\"', ',', \n            '\"', field7, '\"', ',', \n            '\"', field8, '\"', ',', \n            '\"', c_time, '\"', \n            '\"', type, '\"',\n          ']') ORDER BY c_time\n        ) AS data\n      FROM t_data\n      WHERE type = '\u5B9E\u65F6\u6570\u636E'\n      AND c_time < \"".concat(formattedEnd, "\"\n      GROUP BY d_no;\n    ")));

        case 21:
          _ref23 = _context5.sent;
          _ref24 = _slicedToArray(_ref23, 1);
          _results = _ref24[0];
          // 处理查询结果
          _formattedResult = [];

          _results.forEach(function (row) {
            if (!row.data) return;
            var fixedData = "[".concat(row.data, "]");
            var data = JSON.parse(fixedData); // 解析 JSON 数据

            data.forEach(function (entry) {
              _formattedResult.push([row.d_no, entry[0], entry[1], entry[2], entry[3], entry[4], entry[5], entry[6], entry[7], entry[8]]);
            });
          }); // 最终返回的格式为 [[设备名, 数据1...], [设备名, 数据2...], ...]


          ctx.body = _formattedResult;
          _context5.next = 42;
          break;

        case 29:
          _context5.next = 31;
          return regeneratorRuntime.awrap(connection2.query("SET SESSION group_concat_max_len = 1000000"));

        case 31:
          _formatTime5 = function _formatTime5(timeStr) {
            return new Date(timeStr).toISOString().slice(0, 19).replace('T', ' ');
          };

          formattedStart = _formatTime5(start);
          _formattedEnd5 = _formatTime5(end);
          _context5.next = 36;
          return regeneratorRuntime.awrap(connection2.query("\n      SELECT d_no,  \n        GROUP_CONCAT(\n          CONCAT('[', \n            '\"', field1, '\"', ',', \n            '\"', field2, '\"', ',', \n            '\"', field3, '\"', ',', \n            '\"', field4, '\"', ',', \n            '\"', field5, '\"', ',', \n            '\"', field6, '\"', ',', \n            '\"', field7, '\"', ',', \n            '\"', field8, '\"', ',', \n            '\"', c_time, '\"', \n          ']') ORDER BY c_time\n        ) AS data\n      FROM t_data\n      WHERE type = '\u5B9E\u65F6\u6570\u636E'\n      AND c_time BETWEEN \"".concat(formattedStart, "\" AND \"").concat(_formattedEnd5, "\"\n      GROUP BY d_no;\n    ")));

        case 36:
          _ref25 = _context5.sent;
          _ref26 = _slicedToArray(_ref25, 1);
          _results2 = _ref26[0];
          // 处理查询结果
          _formattedResult2 = [];

          _results2.forEach(function (row) {
            if (!row.data) return;
            var fixedData = "[".concat(row.data, "]");
            var data = JSON.parse(fixedData); // 解析 JSON 数据

            data.forEach(function (entry) {
              _formattedResult2.push([row.d_no, entry[0], entry[1], entry[2], entry[3], entry[4], entry[5], entry[6], entry[7], entry[8]]);
            });
          }); // 最终返回的格式为 [[设备名, 数据1...], [设备名, 数据2...], ...]


          ctx.body = _formattedResult2;

        case 42:
        case "end":
          return _context5.stop();
      }
    }
  });
}); //用于获取单位列的路由--设备数据

Router4.get("/device_unit", function _callee6(ctx) {
  var query, _ref27, _ref28, rows, unitArray;

  return regeneratorRuntime.async(function _callee6$(_context6) {
    while (1) {
      switch (_context6.prev = _context6.next) {
        case 0:
          _context6.prev = 0;
          // 查询数据库，获取 t_behavior_field_mapper 表中的 unit 列
          // 并按照 id 排序
          query = "\n      SELECT unit \n      FROM t_field_mapper \n      ORDER BY id ASC\n    ";
          console.log("成功进入当前路由"); // 执行查询

          _context6.next = 5;
          return regeneratorRuntime.awrap(connection2.query(query));

        case 5:
          _ref27 = _context6.sent;
          _ref28 = _slicedToArray(_ref27, 1);
          rows = _ref28[0];
          // 将查询结果转换为字符串数组
          // 从每一行对象中提取 unit 值
          unitArray = rows.map(function (row) {
            return row.unit;
          }); // 返回字符串数组结果

          ctx.body = unitArray;
          _context6.next = 15;
          break;

        case 12:
          _context6.prev = 12;
          _context6.t0 = _context6["catch"](0);
          console.log("当前发生错误");

        case 15:
        case "end":
          return _context6.stop();
      }
    }
  }, null, null, [[0, 12]]);
}); //用于获取单位列的路由--行为数据

Router4.get("/action_unit", function _callee7(ctx) {
  var query, _ref29, _ref30, rows, unitArray;

  return regeneratorRuntime.async(function _callee7$(_context7) {
    while (1) {
      switch (_context7.prev = _context7.next) {
        case 0:
          // 查询数据库，获取 t_behavior_field_mapper 表中的 unit 列
          // 并按照 id 排序
          query = "\n    SELECT unit \n    FROM t_behavior_field_mapper \n    ORDER BY id ASC\n  "; // 执行查询

          _context7.next = 3;
          return regeneratorRuntime.awrap(connection2.query(query));

        case 3:
          _ref29 = _context7.sent;
          _ref30 = _slicedToArray(_ref29, 1);
          rows = _ref30[0];
          // 将查询结果转换为字符串数组
          // 从每一行对象中提取 unit 值
          unitArray = rows.map(function (row) {
            return row.unit;
          }); // 返回字符串数组结果

          ctx.body = unitArray;

        case 8:
        case "end":
          return _context7.stop();
      }
    }
  });
});
var _default = Router4; //记得将查询条件中的一定为实时数据进行修改了,所有的数据都可以

exports["default"] = _default;