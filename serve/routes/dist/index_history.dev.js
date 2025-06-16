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
  var _ctx$query, start, end, currentPage, pageSize, d_no, query, DESC_query, page_boolean, toTwoArray, OFFSET, FORMATTIME, formattedStart, formattedEnd, one_query, offset, toMap, _ref, _ref2, rows, formattedRows, _ref3, _ref4, _rows, _formattedRows, _ref5, _ref6, _rows2, _formattedRows2, _ref7, _ref8, _rows3, _ref9, _ref10, _rows4, _formattedRows3, _ref11, _ref12, _rows5;

  return regeneratorRuntime.async(function _callee2$(_context2) {
    while (1) {
      switch (_context2.prev = _context2.next) {
        case 0:
          toMap = function _ref16(value) {
            return value.map(function (row) {
              return [row.d_no, row.field1, row.field2, row.field3, row.field4, row.field4, row.field5, row.field6, row.field7, row.field8, (0, _dayjs["default"])(row.c_time).format('YYYY-MM-DD HH:mm:ss'), row.type];
            });
          };

          FORMATTIME = function _ref15(value) {
            var formatTime = function formatTime(timeStr) {
              return new Date(timeStr).toISOString().slice(0, 19).replace('T', ' ');
            };

            return formatTime(value);
          };

          OFFSET = function _ref14(value1, value2) {
            //value1:currentPage,value2:pageSize
            return (parseInt(value1) - 1) * parseInt(value2);
          };

          toTwoArray = function _ref13(value) {
            // 将数据转换为二维数组格式
            var formattedRows = value.map(function (row) {
              return [row.d_no, row.field1.toString(), // 确保所有字段为字符串类型
              row.field2.toString(), row.field3.toString(), row.field4.toString(), row.field5.toString(), row.field6.toString(), row.field7.toString(), row.field8.toString(), (0, _dayjs["default"])(row.c_time).format('YYYY-MM-DD HH:mm:ss'), // 已经格式化为ISO 8601标准时间字符串
              row.type];
            });
            return formattedRows;
          };

          _ctx$query = ctx.query, start = _ctx$query.start, end = _ctx$query.end, currentPage = _ctx$query.currentPage, pageSize = _ctx$query.pageSize, d_no = _ctx$query.d_no; //全局sql

          query = "SELECT d_no,field1,field2,field3,field4, field5, field6,field7,field8,c_time,type FROM t_data "; //降序sql

          DESC_query = "ORDER BY c_time DESC"; //页数有效值判断布尔变量

          page_boolean = currentPage === "undefined" || pageSize === "undefined" || currentPage === undefined || pageSize === undefined; //封装转化为数组的方法

          //全局解构赋值
          formattedStart = FORMATTIME(start !== "end" || start !== "1" ? start : '2025-06-13 15:51:16');
          formattedEnd = FORMATTIME(end !== "1" ? end : '2025-06-13 15:51:16'); //单向限制sql

          one_query = "WHERE c_time < \"".concat(formattedEnd, "\"");

          if (page_boolean) {} else {
            offset = OFFSET(currentPage, pageSize);
          } //封装响应结果格式化的方法


          if (!(start === "1" && end === "1")) {
            _context2.next = 32;
            break;
          }

          if (!page_boolean) {
            _context2.next = 23;
            break;
          }

          _context2.next = 16;
          return regeneratorRuntime.awrap(connection2.execute(query + DESC_query, [d_no]));

        case 16:
          _ref = _context2.sent;
          _ref2 = _slicedToArray(_ref, 1);
          rows = _ref2[0];
          formattedRows = toTwoArray(rows); // 直接使用 res.send() 返回数据

          ctx.body = JSON.stringify(formattedRows);
          _context2.next = 30;
          break;

        case 23:
          _context2.next = 25;
          return regeneratorRuntime.awrap(connection2.execute(query + DESC_query + "\n        LIMIT ".concat(parseInt(pageSize), " OFFSET ").concat(offset)));

        case 25:
          _ref3 = _context2.sent;
          _ref4 = _slicedToArray(_ref3, 1);
          _rows = _ref4[0];
          _formattedRows = toTwoArray(_rows); // 直接使用 res.send() 返回数据

          ctx.body = JSON.stringify(_formattedRows);

        case 30:
          _context2.next = 67;
          break;

        case 32:
          if (!(start === "end" && end !== "1")) {
            _context2.next = 51;
            break;
          }

          if (!page_boolean) {
            _context2.next = 43;
            break;
          }

          _context2.next = 36;
          return regeneratorRuntime.awrap(connection2.execute(query + one_query + DESC_query));

        case 36:
          _ref5 = _context2.sent;
          _ref6 = _slicedToArray(_ref5, 1);
          _rows2 = _ref6[0];
          _formattedRows2 = toTwoArray(_rows2); // 直接使用 res.send() 返回数据

          ctx.body = JSON.stringify(_formattedRows2);
          _context2.next = 49;
          break;

        case 43:
          _context2.next = 45;
          return regeneratorRuntime.awrap(connection2.execute(query + one_query + DESC_query + "\n        LIMIT ".concat(parseInt(pageSize), " OFFSET ").concat(offset, "\n      ")));

        case 45:
          _ref7 = _context2.sent;
          _ref8 = _slicedToArray(_ref7, 1);
          _rows3 = _ref8[0];
          ctx.body = toMap(_rows3);

        case 49:
          _context2.next = 67;
          break;

        case 51:
          if (!page_boolean) {
            _context2.next = 61;
            break;
          }

          _context2.next = 54;
          return regeneratorRuntime.awrap(connection2.execute(query + "\n        WHERE c_time BETWEEN \"".concat(formattedStart, "\" AND \"").concat(formattedEnd, "\"") + DESC_query));

        case 54:
          _ref9 = _context2.sent;
          _ref10 = _slicedToArray(_ref9, 1);
          _rows4 = _ref10[0];
          _formattedRows3 = toTwoArray(_rows4); // 直接使用 res.send() 返回数据

          ctx.body = JSON.stringify(_formattedRows3);
          _context2.next = 67;
          break;

        case 61:
          _context2.next = 63;
          return regeneratorRuntime.awrap(connection2.execute(query + "WHERE c_time BETWEEN \"".concat(formattedStart, "\" AND \"").concat(formattedEnd, "\"") + DESC_query + "LIMIT ".concat(parseInt(pageSize), " OFFSET ").concat(offset, "\n      ")));

        case 63:
          _ref11 = _context2.sent;
          _ref12 = _slicedToArray(_ref11, 1);
          _rows5 = _ref12[0];
          ctx.body = toMap(_rows5);

        case 67:
        case "end":
          return _context2.stop();
      }
    }
  });
}); //表格的呈现路由

Router4.get("/History_count", function _callee3(ctx) {
  var _ctx$query2, start, end, d_no, _ref17, _ref18, rows, formatTime, formattedEnd, _ref19, _ref20, _rows6, _formatTime, formattedStart, _formattedEnd, _ref21, _ref22, _rows7;

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
          _ref17 = _context3.sent;
          _ref18 = _slicedToArray(_ref17, 1);
          rows = _ref18[0];
          // 直接返回数组长度
          ctx.body = "" + rows[0].total.toString();
          _context3.next = 34;
          break;

        case 11:
          if (!(start === "end" && end !== "1")) {
            _context3.next = 22;
            break;
          }

          //格式化时间值
          formatTime = function formatTime(timeStr) {
            return new Date(timeStr).toISOString().slice(0, 19).replace('T', ' ');
          };

          formattedEnd = formatTime(end); //直接查询

          _context3.next = 16;
          return regeneratorRuntime.awrap(connection2.execute("\n        SELECT COUNT(*) as total \n        FROM t_data \n        WHERE c_time < \"".concat(formattedEnd, "\"\n      ")));

        case 16:
          _ref19 = _context3.sent;
          _ref20 = _slicedToArray(_ref19, 1);
          _rows6 = _ref20[0];
          // 直接返回数组长度
          ctx.body = "" + _rows6[0].total.toString();
          _context3.next = 34;
          break;

        case 22:
          //进行分页查询后计算大小
          console.log("start:" + start);
          console.log("end:" + end);
          console.log("d_no" + d_no); //格式化时间值

          _formatTime = function _formatTime(timeStr) {
            return new Date(timeStr).toISOString().slice(0, 19).replace('T', ' ');
          };

          formattedStart = _formatTime(start);
          _formattedEnd = _formatTime(end); //直接查询

          _context3.next = 30;
          return regeneratorRuntime.awrap(connection2.execute("\n        SELECT COUNT(*) as total  \n        FROM t_data \n        WHERE d_no=\"".concat(d_no, "\" \n        AND c_time BETWEEN \"").concat(formattedStart, "\" AND \"").concat(_formattedEnd, "\"\n      ")));

        case 30:
          _ref21 = _context3.sent;
          _ref22 = _slicedToArray(_ref21, 1);
          _rows7 = _ref22[0];
          // 直接返回数组长度
          ctx.body = "" + _rows7[0].total.toString();

        case 34:
          _context3.next = 41;
          break;

        case 36:
          _context3.prev = 36;
          _context3.t0 = _context3["catch"](1);
          console.log("History：" + start);
          console.log("History：" + end);
          console.log("History：" + d_no);

        case 41:
        case "end":
          return _context3.stop();
      }
    }
  }, null, null, [[1, 36]]);
}); //告警历史数据
// Router4.get("/History/alarm",asyncctx=>{
//   const {start,end} = ctx.query;
//   const [results] = await connection2.query(`
//     SELECT 
//   `);
// })
//储运箱入库历史数据

Router4.get("/History/container", function _callee4(ctx) {
  var _ctx$query3, start, end, formatTime, formattedStart, formattedEnd, _ref23, _ref24, results, formattedResults;

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
          _ref23 = _context4.sent;
          _ref24 = _slicedToArray(_ref23, 1);
          results = _ref24[0];
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
  var _ctx$query4, start, end, query, FORMATTIME, groupbyd_no, toBig, formattedStart, formattedEnd, search_result, formattedResult, _ref25, _ref26, results, _ref27, _ref28, _results, _ref29, _ref30, _results2;

  return regeneratorRuntime.async(function _callee5$(_context6) {
    while (1) {
      switch (_context6.prev = _context6.next) {
        case 0:
          search_result = function _ref33(value) {
            var formattedResult = [];
            value.forEach(function (row) {
              if (!row.data) return;
              var fixedData = "[".concat(row.data, "]");
              var data = JSON.parse(fixedData); // 解析 JSON 数据

              data.forEach(function (entry) {
                formattedResult.push([row.d_no, entry[0], entry[1], entry[2], entry[3], entry[4], entry[5], entry[6], entry[7], entry[8]]);
              });
            });
            return formattedResult;
          };

          toBig = function _ref32() {
            return regeneratorRuntime.async(function toBig$(_context5) {
              while (1) {
                switch (_context5.prev = _context5.next) {
                  case 0:
                    _context5.next = 2;
                    return regeneratorRuntime.awrap(connection2.query("SET SESSION group_concat_max_len = 1000000"));

                  case 2:
                  case "end":
                    return _context5.stop();
                }
              }
            });
          };

          FORMATTIME = function _ref31(value) {
            var formatTime = function formatTime(timeStr) {
              return new Date(timeStr).toISOString().slice(0, 19).replace('T', ' ');
            };

            return formatTime(value);
          };

          //对data路由进行修改并且接纳上start和end，若接受失败则进行总的数据的返回
          _ctx$query4 = ctx.query, start = _ctx$query4.start, end = _ctx$query4.end; //全局sql

          query = "SELECT d_no, \n        GROUP_CONCAT(\n          CONCAT('[', \n            '\"', field1, '\"', ',', \n            '\"', field2, '\"', ',', \n            '\"', field3, '\"', ',', \n            '\"', field4, '\"', ',', \n            '\"', field5, '\"', ',', \n            '\"', field6, '\"', ',', \n            '\"', field7, '\"', ',', \n            '\"', field8, '\"', ',', \n            '\"', c_time, '\"', \n          ']') ORDER BY c_time\n        ) AS data\n      FROM t_data\n      WHERE type = '\u5B9E\u65F6\u6570\u636E'";
          //按照d_no分组-sql
          groupbyd_no = "GROUP BY d_no"; //扩容sql方法

          ; //全局解构赋值

          formattedStart = FORMATTIME(start !== "end" || start !== "1" ? start : '2025-06-13 15:51:16');
          formattedEnd = FORMATTIME(end !== "1" ? end : '2025-06-13 15:51:16'); //封装处理查询结果

          toBig();

          if (!(start === "1" && end === "1")) {
            _context6.next = 19;
            break;
          }

          _context6.next = 13;
          return regeneratorRuntime.awrap(connection2.query(query + groupbyd_no));

        case 13:
          _ref25 = _context6.sent;
          _ref26 = _slicedToArray(_ref25, 1);
          results = _ref26[0];
          // 处理查询结果
          formattedResult = search_result(results);
          _context6.next = 34;
          break;

        case 19:
          if (!(start === "end" && end !== "1")) {
            _context6.next = 28;
            break;
          }

          _context6.next = 22;
          return regeneratorRuntime.awrap(connection2.query(query + "\n      AND c_time < \"".concat(formattedEnd, "\"\n    ") + groupbyd_no));

        case 22:
          _ref27 = _context6.sent;
          _ref28 = _slicedToArray(_ref27, 1);
          _results = _ref28[0];
          // 处理查询结果
          formattedResult = search_result(_results);
          _context6.next = 34;
          break;

        case 28:
          _context6.next = 30;
          return regeneratorRuntime.awrap(connection2.query(query + "\n      AND c_time BETWEEN \"".concat(formattedStart, "\" AND \"").concat(formattedEnd, "\"\n    ") + groupbyd_no));

        case 30:
          _ref29 = _context6.sent;
          _ref30 = _slicedToArray(_ref29, 1);
          _results2 = _ref30[0];
          // 处理查询结果
          formattedResult = search_result(_results2);

        case 34:
          ctx.body = formattedResult; //模拟只返回一组数据的情况
          // res.send([["2021","11","22","23","61","2019-01-01 15:40","实时数据"]]);
          //模拟返回0组数据的情况
          // res.send([]);

        case 35:
        case "end":
          return _context6.stop();
      }
    }
  });
}); //用于获取单位列的路由--设备数据

Router4.get("/device_unit", function _callee6(ctx) {
  var query, _ref34, _ref35, rows, unitArray;

  return regeneratorRuntime.async(function _callee6$(_context7) {
    while (1) {
      switch (_context7.prev = _context7.next) {
        case 0:
          _context7.prev = 0;
          // 查询数据库，获取 t_behavior_field_mapper 表中的 unit 列
          // 并按照 id 排序
          query = "\n      SELECT unit \n      FROM t_field_mapper \n      ORDER BY id ASC\n    ";
          console.log("成功进入当前路由"); // 执行查询

          _context7.next = 5;
          return regeneratorRuntime.awrap(connection2.query(query));

        case 5:
          _ref34 = _context7.sent;
          _ref35 = _slicedToArray(_ref34, 1);
          rows = _ref35[0];
          // 将查询结果转换为字符串数组
          // 从每一行对象中提取 unit 值
          unitArray = rows.map(function (row) {
            return row.unit;
          }); // 返回字符串数组结果

          ctx.body = unitArray;
          _context7.next = 15;
          break;

        case 12:
          _context7.prev = 12;
          _context7.t0 = _context7["catch"](0);
          console.log("当前发生错误");

        case 15:
        case "end":
          return _context7.stop();
      }
    }
  }, null, null, [[0, 12]]);
}); //用于获取单位列的路由--行为数据

Router4.get("/action_unit", function _callee7(ctx) {
  var query, _ref36, _ref37, rows, unitArray;

  return regeneratorRuntime.async(function _callee7$(_context8) {
    while (1) {
      switch (_context8.prev = _context8.next) {
        case 0:
          // 查询数据库，获取 t_behavior_field_mapper 表中的 unit 列
          // 并按照 id 排序
          query = "\n    SELECT unit \n    FROM t_behavior_field_mapper \n    ORDER BY id ASC\n  "; // 执行查询

          _context8.next = 3;
          return regeneratorRuntime.awrap(connection2.query(query));

        case 3:
          _ref36 = _context8.sent;
          _ref37 = _slicedToArray(_ref36, 1);
          rows = _ref37[0];
          // 将查询结果转换为字符串数组
          // 从每一行对象中提取 unit 值
          unitArray = rows.map(function (row) {
            return row.unit;
          }); // 返回字符串数组结果

          ctx.body = unitArray;

        case 8:
        case "end":
          return _context8.stop();
      }
    }
  });
});
var _default = Router4; //记得将查询条件中的一定为实时数据进行修改了,所有的数据都可以

exports["default"] = _default;