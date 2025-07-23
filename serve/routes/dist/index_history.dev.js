"use strict";

Object.defineProperty(exports, "__esModule", {
  value: true
});
exports["default"] = void 0;

var _indexNode = _interopRequireDefault(require("../indexNode2.js"));

var _dayjs = _interopRequireDefault(require("dayjs"));

var _express = _interopRequireWildcard(require("express"));

function _getRequireWildcardCache() { if (typeof WeakMap !== "function") return null; var cache = new WeakMap(); _getRequireWildcardCache = function _getRequireWildcardCache() { return cache; }; return cache; }

function _interopRequireWildcard(obj) { if (obj && obj.__esModule) { return obj; } if (obj === null || _typeof(obj) !== "object" && typeof obj !== "function") { return { "default": obj }; } var cache = _getRequireWildcardCache(); if (cache && cache.has(obj)) { return cache.get(obj); } var newObj = {}; var hasPropertyDescriptor = Object.defineProperty && Object.getOwnPropertyDescriptor; for (var key in obj) { if (Object.prototype.hasOwnProperty.call(obj, key)) { var desc = hasPropertyDescriptor ? Object.getOwnPropertyDescriptor(obj, key) : null; if (desc && (desc.get || desc.set)) { Object.defineProperty(newObj, key, desc); } else { newObj[key] = obj[key]; } } } newObj["default"] = obj; if (cache) { cache.set(obj, newObj); } return newObj; }

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { "default": obj }; }

function _typeof(obj) { if (typeof Symbol === "function" && typeof Symbol.iterator === "symbol") { _typeof = function _typeof(obj) { return typeof obj; }; } else { _typeof = function _typeof(obj) { return obj && typeof Symbol === "function" && obj.constructor === Symbol && obj !== Symbol.prototype ? "symbol" : typeof obj; }; } return _typeof(obj); }

function _slicedToArray(arr, i) { return _arrayWithHoles(arr) || _iterableToArrayLimit(arr, i) || _nonIterableRest(); }

function _nonIterableRest() { throw new TypeError("Invalid attempt to destructure non-iterable instance"); }

function _iterableToArrayLimit(arr, i) { if (!(Symbol.iterator in Object(arr) || Object.prototype.toString.call(arr) === "[object Arguments]")) { return; } var _arr = []; var _n = true; var _d = false; var _e = undefined; try { for (var _i = arr[Symbol.iterator](), _s; !(_n = (_s = _i.next()).done); _n = true) { _arr.push(_s.value); if (i && _arr.length === i) break; } } catch (err) { _d = true; _e = err; } finally { try { if (!_n && _i["return"] != null) _i["return"](); } finally { if (_d) throw _e; } } return _arr; }

function _arrayWithHoles(arr) { if (Array.isArray(arr)) return arr; }

var connection2; //定义数据库连接对象

var Router4 = (0, _express["default"])();

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


Router4.get("/History", function _callee2(req, res) {
  var _req$query, start, end, currentPage, pageSize, d_no, _ref, _ref2, result_now, sql_string, item, x, query, DESC_query, page_boolean, toTwoArray, OFFSET, FORMATTIME, formattedStart, formattedEnd, one_query, offset, toMap, _ref3, _ref4, rows, formattedRows, _ref5, _ref6, _rows, _formattedRows, _ref7, _ref8, _rows2, _formattedRows2, _ref9, _ref10, _rows3, _ref11, _ref12, _rows4, _formattedRows3, _ref13, _ref14, _rows5;

  return regeneratorRuntime.async(function _callee2$(_context2) {
    while (1) {
      switch (_context2.prev = _context2.next) {
        case 0:
          toMap = function _ref18(value) {
            return value.map(function (row) {
              return [row.d_no, row.field1, row.field2, row.field3, row.field4, row.field5, (0, _dayjs["default"])(row.c_time).format('YYYY-MM-DD HH:mm:ss'), row.type];
            });
          };

          FORMATTIME = function _ref17(value) {
            var formatTime = function formatTime(timeStr) {
              return new Date(timeStr).toISOString().slice(0, 19).replace('T', ' ');
            };

            return formatTime(value);
          };

          OFFSET = function _ref16(value1, value2) {
            //value1:currentPage,value2:pageSize
            return (parseInt(value1) - 1) * parseInt(value2);
          };

          toTwoArray = function _ref15(value) {
            // 将数据转换为二维数组格式
            var formattedRows = value.map(function (row) {
              return [row.d_no, row.field1.toString(), // 确保所有字段为字符串类型
              row.field2.toString(), row.field3.toString(), row.field4.toString(), row.field5.toString(), (0, _dayjs["default"])(row.c_time).format('YYYY-MM-DD HH:mm:ss'), // 已经格式化为ISO 8601标准时间字符串
              row.type];
            });
            return formattedRows;
          };

          _req$query = req.query, start = _req$query.start, end = _req$query.end, currentPage = _req$query.currentPage, pageSize = _req$query.pageSize, d_no = _req$query.d_no; // 动态获取到字段

          _context2.next = 7;
          return regeneratorRuntime.awrap(connection2.query("\n    SELECT * \n    FROM t_data \n  "));

        case 7:
          _ref = _context2.sent;
          _ref2 = _slicedToArray(_ref, 1);
          result_now = _ref2[0];
          //动态拼接sql依据字符串
          sql_string = '';

          for (item in result_now[0]) {
            if (result_now[0][item] !== null && item.includes("field")) {
              x = item + ",";
              sql_string += x;
            }
          } //全局sql


          query = "SELECT d_no,".concat(sql_string, "c_time,type FROM t_data "); //降序sql

          DESC_query = "ORDER BY c_time DESC"; //页数有效值判断布尔变量

          page_boolean = currentPage === "undefined" || pageSize === "undefined" || currentPage === undefined || pageSize === undefined; //封装转化为数组的方法

          //全局解构赋值
          formattedStart = FORMATTIME(start !== "end" || start !== "1" ? start : '2025-06-13 15:51:16');
          formattedEnd = FORMATTIME(end !== "1" ? end : '2025-06-13 15:51:16'); //单向限制sql

          one_query = "WHERE c_time < \"".concat(formattedEnd, "\"") + (d_no === "null" ? "" : " AND d_no = \"".concat(d_no, "\""));

          if (page_boolean) {} else {
            offset = OFFSET(currentPage, pageSize);
          } //封装响应结果格式化的方法


          if (!(start === "1" && end === "1")) {
            _context2.next = 40;
            break;
          }

          if (!page_boolean) {
            _context2.next = 30;
            break;
          }

          _context2.next = 23;
          return regeneratorRuntime.awrap(connection2.execute(query + (d_no === "null" ? "" : " WHERE d_no=\"".concat(d_no, " \"")) + DESC_query));

        case 23:
          _ref3 = _context2.sent;
          _ref4 = _slicedToArray(_ref3, 1);
          rows = _ref4[0];
          formattedRows = toTwoArray(rows); // 直接使用 res.send() 返回数据

          res.send(JSON.stringify(formattedRows));
          _context2.next = 38;
          break;

        case 30:
          console.log("当前总输出结果：" + query + (d_no === "null" ? "" : " WHERE d_no=\"".concat(d_no, " \"")) + DESC_query + "\n        LIMIT ".concat(parseInt(pageSize), " OFFSET ").concat(offset)); //直接查询

          _context2.next = 33;
          return regeneratorRuntime.awrap(connection2.execute(query + (d_no === "null" ? "" : " WHERE d_no=\"".concat(d_no, " \"")) + DESC_query + "\n        LIMIT ".concat(parseInt(pageSize), " OFFSET ").concat(offset)));

        case 33:
          _ref5 = _context2.sent;
          _ref6 = _slicedToArray(_ref5, 1);
          _rows = _ref6[0];
          _formattedRows = toTwoArray(_rows); // 直接使用 res.send() 返回数据

          res.send(JSON.stringify(_formattedRows));

        case 38:
          _context2.next = 75;
          break;

        case 40:
          if (!(start === "end" && end !== "1")) {
            _context2.next = 59;
            break;
          }

          if (!page_boolean) {
            _context2.next = 51;
            break;
          }

          _context2.next = 44;
          return regeneratorRuntime.awrap(connection2.execute(query + one_query + DESC_query));

        case 44:
          _ref7 = _context2.sent;
          _ref8 = _slicedToArray(_ref7, 1);
          _rows2 = _ref8[0];
          _formattedRows2 = toTwoArray(_rows2); // 直接使用 res.send() 返回数据

          res.send(JSON.stringify(_formattedRows2));
          _context2.next = 57;
          break;

        case 51:
          _context2.next = 53;
          return regeneratorRuntime.awrap(connection2.execute(query + one_query + DESC_query + "\n        LIMIT ".concat(parseInt(pageSize), " OFFSET ").concat(offset, "\n      ")));

        case 53:
          _ref9 = _context2.sent;
          _ref10 = _slicedToArray(_ref9, 1);
          _rows3 = _ref10[0];
          res.send(toMap(_rows3));

        case 57:
          _context2.next = 75;
          break;

        case 59:
          if (!page_boolean) {
            _context2.next = 69;
            break;
          }

          _context2.next = 62;
          return regeneratorRuntime.awrap(connection2.execute(query + "\n        WHERE c_time BETWEEN \"".concat(formattedStart, "\" AND \"").concat(formattedEnd, "\"") + (d_no === "null" ? "" : " AND d_no=\"".concat(d_no, " \"")) + DESC_query));

        case 62:
          _ref11 = _context2.sent;
          _ref12 = _slicedToArray(_ref11, 1);
          _rows4 = _ref12[0];
          _formattedRows3 = toTwoArray(_rows4); // 直接使用 res.send() 返回数据

          res.send(JSON.stringify(_formattedRows3));
          _context2.next = 75;
          break;

        case 69:
          _context2.next = 71;
          return regeneratorRuntime.awrap(connection2.execute(query + "WHERE c_time BETWEEN \"".concat(formattedStart, "\" AND \"").concat(formattedEnd, "\"") + (d_no === "null" ? "" : " AND d_no=\"".concat(d_no, " \"")) + DESC_query + " LIMIT ".concat(parseInt(pageSize), " OFFSET ").concat(offset, "\n      ")));

        case 71:
          _ref13 = _context2.sent;
          _ref14 = _slicedToArray(_ref13, 1);
          _rows5 = _ref14[0];
          res.send(toMap(_rows5));

        case 75:
        case "end":
          return _context2.stop();
      }
    }
  });
}); //表格的呈现路由

Router4.get("/History_count", function _callee3(req, res) {
  var _req$query2, start, end, d_no, _ref19, _ref20, rows, formatTime, formattedEnd, _ref21, _ref22, _rows6, _formatTime, formattedStart, _formattedEnd, _ref23, _ref24, _rows7;

  return regeneratorRuntime.async(function _callee3$(_context3) {
    while (1) {
      switch (_context3.prev = _context3.next) {
        case 0:
          _req$query2 = req.query, start = _req$query2.start, end = _req$query2.end, d_no = _req$query2.d_no;
          _context3.prev = 1;
          console.log("判断布尔结构是否存在问题");
          console.log("start:" + _typeof(start));
          console.log("start:" + start);
          console.log("end:" + _typeof(end));
          console.log("end:" + end);
          console.log("当前的d_no的值" + _typeof(d_no));
          console.log("当前的d_no的值" + d_no); //首先判断是否已经激活了ok

          if (!(start === "1" && end === "1")) {
            _context3.next = 22;
            break;
          }

          //初始状态直接算
          console.log("判断的diyijiedian");
          console.log("虚拟拼接的sql：");
          console.log("SELECT COUNT(*) as total FROM t_data" + (d_no === "null" ? "" : "WHERE d_no = \"".concat(d_no, "\""))); //直接查询

          _context3.next = 15;
          return regeneratorRuntime.awrap(connection2.execute("\n        SELECT COUNT(*) as total \n        FROM t_data\n      " + (d_no === "null" ? "" : "WHERE d_no = \"".concat(d_no, "\""))));

        case 15:
          _ref19 = _context3.sent;
          _ref20 = _slicedToArray(_ref19, 1);
          rows = _ref20[0];
          // 直接返回数组长度
          console.log("观察返回的结构");
          res.send("" + rows[0].total.toString());
          _context3.next = 45;
          break;

        case 22:
          if (!(start === "end" && end !== "1")) {
            _context3.next = 33;
            break;
          }

          //格式化时间值
          formatTime = function formatTime(timeStr) {
            return new Date(timeStr).toISOString().slice(0, 19).replace('T', ' ');
          };

          formattedEnd = formatTime(end); //直接查询

          _context3.next = 27;
          return regeneratorRuntime.awrap(connection2.execute("\n        SELECT COUNT(*) as total \n        FROM t_data \n        WHERE c_time < \"".concat(formattedEnd, "\"\n      ") + (d_no === "null" ? "" : "AND d_no = \"".concat(d_no, "\""))));

        case 27:
          _ref21 = _context3.sent;
          _ref22 = _slicedToArray(_ref21, 1);
          _rows6 = _ref22[0];
          // 直接返回数组长度
          res.send("" + _rows6[0].total.toString());
          _context3.next = 45;
          break;

        case 33:
          //进行分页查询后计算大小
          console.log("start:" + start);
          console.log("end:" + end);
          console.log("d_no" + d_no); //格式化时间值

          _formatTime = function _formatTime(timeStr) {
            return new Date(timeStr).toISOString().slice(0, 19).replace('T', ' ');
          };

          formattedStart = _formatTime(start);
          _formattedEnd = _formatTime(end); //直接查询

          _context3.next = 41;
          return regeneratorRuntime.awrap(connection2.execute("\n        SELECT COUNT(*) as total  \n        FROM t_data \n        WHERE c_time BETWEEN \"".concat(formattedStart, "\" AND \"").concat(_formattedEnd, "\"") + (d_no === "null" ? "" : "AND d_no=\"".concat(d_no, "\" "))));

        case 41:
          _ref23 = _context3.sent;
          _ref24 = _slicedToArray(_ref23, 1);
          _rows7 = _ref24[0];
          // 直接返回数组长度
          res.send("" + _rows7[0].total.toString());

        case 45:
          _context3.next = 52;
          break;

        case 47:
          _context3.prev = 47;
          _context3.t0 = _context3["catch"](1);
          console.log("History：" + start);
          console.log("History：" + end);
          console.log("History：" + d_no);

        case 52:
        case "end":
          return _context3.stop();
      }
    }
  }, null, null, [[1, 47]]);
}); //告警历史数据
// Router4.get("/History/alarm",async (req,res)=>{
//   const {start,end} = req.query;
//   const [results] = await connection2.query(`
//     SELECT 
//   `);
// })
// //储运箱入库历史数据
// Router4.get("/History/container",async (req,res)=>{
//   const {start,end} = req.query;
//   const formatTime = (timeStr) => new Date(timeStr).toISOString().slice(0, 19).replace('T', ' ');
//   const formattedStart = formatTime(start);
//   const formattedEnd = formatTime(end);
//   const [results] = await connection2.query(`
//     SELECT *
//     FROM t_container
//     WHERE ctime BETWEEN "${formattedStart}" AND "${formattedEnd}"
//     ORDER BY ctime
//   `);
//   // 格式化数据
//   const formattedResults = results.map(row => [
//       row.PID,
//       row.VID,
//       row.ctime
//   ]);
// res.send(formattedResults);
// })
//设备选项列表相关路由

Router4.get("/data", function _callee4(req, res) {
  var _req$query3, start, end, _ref25, _ref26, result_now, sql_string, item, x, query, FORMATTIME, groupbyd_no, toBig, formattedStart, formattedEnd, search_result, formattedResult, _ref27, _ref28, results, _ref29, _ref30, _results, _ref31, _ref32, _results2;

  return regeneratorRuntime.async(function _callee4$(_context5) {
    while (1) {
      switch (_context5.prev = _context5.next) {
        case 0:
          search_result = function _ref35(value) {
            var formattedResult = [];
            value.forEach(function (row) {
              if (!row.data) return;
              var fixedData = "[".concat(row.data, "]");
              var data = JSON.parse(fixedData); // 解析 JSON 数据

              data.forEach(function (entry) {
                formattedResult.push([row.d_no, entry[0], entry[1], entry[2], entry[3], entry[4]]);
              });
            });
            return formattedResult;
          };

          toBig = function _ref34() {
            return regeneratorRuntime.async(function toBig$(_context4) {
              while (1) {
                switch (_context4.prev = _context4.next) {
                  case 0:
                    _context4.next = 2;
                    return regeneratorRuntime.awrap(connection2.query("SET SESSION group_concat_max_len = 1000000"));

                  case 2:
                  case "end":
                    return _context4.stop();
                }
              }
            });
          };

          FORMATTIME = function _ref33(value) {
            var formatTime = function formatTime(timeStr) {
              return new Date(timeStr).toISOString().slice(0, 19).replace('T', ' ');
            };

            return formatTime(value);
          };

          //对data路由进行修改并且接纳上start和end，若接受失败则进行总的数据的返回
          _req$query3 = req.query, start = _req$query3.start, end = _req$query3.end; //动态获取到filed字段

          _context5.next = 6;
          return regeneratorRuntime.awrap(connection2.query("\n    SELECT * \n    FROM t_data\n  "));

        case 6:
          _ref25 = _context5.sent;
          _ref26 = _slicedToArray(_ref25, 1);
          result_now = _ref26[0];
          //动态拼接sql依据字符串
          sql_string = '';

          for (item in result_now[0]) {
            if (result_now[0][item] !== null && item.includes("field")) {
              x = "'\"', " + item + ", '\",', ";
              sql_string += x;
            }
          } //全局sql


          query = "SELECT d_no, \n        GROUP_CONCAT(\n          CONCAT('[', " + sql_string + "'\"', c_time, '\"', \n          ']') ORDER BY c_time\n        ) AS data\n      FROM t_data\n      WHERE type = '\u5B9E\u65F6\u6570\u636E'";
          //按照d_no分组-sql
          groupbyd_no = "GROUP BY d_no"; //扩容sql方法

          ; //全局解构赋值

          formattedStart = FORMATTIME(start !== "end" || start !== "1" ? start : '2025-06-13 15:51:16');
          formattedEnd = FORMATTIME(end !== "1" ? end : '2025-06-13 15:51:16'); //封装处理查询结果

          toBig();

          if (!(start === "1" && end === "1")) {
            _context5.next = 26;
            break;
          }

          _context5.next = 20;
          return regeneratorRuntime.awrap(connection2.query(query + groupbyd_no));

        case 20:
          _ref27 = _context5.sent;
          _ref28 = _slicedToArray(_ref27, 1);
          results = _ref28[0];
          // 处理查询结果
          formattedResult = search_result(results);
          _context5.next = 41;
          break;

        case 26:
          if (!(start === "end" && end !== "1")) {
            _context5.next = 35;
            break;
          }

          _context5.next = 29;
          return regeneratorRuntime.awrap(connection2.query(query + "\n      AND c_time < \"".concat(formattedEnd, "\"\n    ") + groupbyd_no));

        case 29:
          _ref29 = _context5.sent;
          _ref30 = _slicedToArray(_ref29, 1);
          _results = _ref30[0];
          // 处理查询结果
          formattedResult = search_result(_results);
          _context5.next = 41;
          break;

        case 35:
          _context5.next = 37;
          return regeneratorRuntime.awrap(connection2.query(query + "\n      AND c_time BETWEEN \"".concat(formattedStart, "\" AND \"").concat(formattedEnd, "\"\n    ") + groupbyd_no));

        case 37:
          _ref31 = _context5.sent;
          _ref32 = _slicedToArray(_ref31, 1);
          _results2 = _ref32[0];
          // 处理查询结果
          formattedResult = search_result(_results2);

        case 41:
          res.send(formattedResult); //模拟只返回一组数据的情况
          // res.send([["2021","11","22","23","61","2019-01-01 15:40","实时数据"]]);
          //模拟返回0组数据的情况
          // res.send([]);

        case 42:
        case "end":
          return _context5.stop();
      }
    }
  });
}); //用于获取单位列的路由--设备数据

Router4.get("/device_unit", function _callee5(req, res) {
  var query, _ref36, _ref37, rows, unitArray;

  return regeneratorRuntime.async(function _callee5$(_context6) {
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
          _ref36 = _context6.sent;
          _ref37 = _slicedToArray(_ref36, 1);
          rows = _ref37[0];
          // 将查询结果转换为字符串数组
          // 从每一行对象中提取 unit 值
          unitArray = rows.map(function (row) {
            return row.unit;
          }); // 返回字符串数组结果

          res.send(unitArray);
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

Router4.get("/action_unit", function _callee6(req, res) {
  var query, _ref38, _ref39, rows, unitArray;

  return regeneratorRuntime.async(function _callee6$(_context7) {
    while (1) {
      switch (_context7.prev = _context7.next) {
        case 0:
          // 查询数据库，获取 t_behavior_field_mapper 表中的 unit 列
          // 并按照 id 排序
          query = "\n    SELECT unit \n    FROM t_behavior_field_mapper \n    ORDER BY id ASC\n  "; // 执行查询

          _context7.next = 3;
          return regeneratorRuntime.awrap(connection2.query(query));

        case 3:
          _ref38 = _context7.sent;
          _ref39 = _slicedToArray(_ref38, 1);
          rows = _ref39[0];
          // 将查询结果转换为字符串数组
          // 从每一行对象中提取 unit 值
          unitArray = rows.map(function (row) {
            return row.unit;
          }); // 返回字符串数组结果

          res.send(unitArray);

        case 8:
        case "end":
          return _context7.stop();
      }
    }
  });
});
var _default = Router4; //记得将查询条件中的一定为实时数据进行修改了,所有的数据都可以

exports["default"] = _default;