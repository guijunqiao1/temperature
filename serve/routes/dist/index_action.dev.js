"use strict";

Object.defineProperty(exports, "__esModule", {
  value: true
});
exports["default"] = void 0;

var _indexNode = _interopRequireDefault(require("../indexNode2.js"));

var _express = _interopRequireDefault(require("express"));

var _dayjs = _interopRequireDefault(require("dayjs"));

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { "default": obj }; }

function _slicedToArray(arr, i) { return _arrayWithHoles(arr) || _iterableToArrayLimit(arr, i) || _nonIterableRest(); }

function _nonIterableRest() { throw new TypeError("Invalid attempt to destructure non-iterable instance"); }

function _iterableToArrayLimit(arr, i) { if (!(Symbol.iterator in Object(arr) || Object.prototype.toString.call(arr) === "[object Arguments]")) { return; } var _arr = []; var _n = true; var _d = false; var _e = undefined; try { for (var _i = arr[Symbol.iterator](), _s; !(_n = (_s = _i.next()).done); _n = true) { _arr.push(_s.value); if (i && _arr.length === i) break; } } catch (err) { _d = true; _e = err; } finally { try { if (!_n && _i["return"] != null) _i["return"](); } finally { if (_d) throw _e; } } return _arr; }

function _arrayWithHoles(arr) { if (Array.isArray(arr)) return arr; }

//此处获取到数据库链接配置对象
var connection; //定义数据库连接对象

//引入提供format使用环境的组件
var Router5 = (0, _express["default"])();

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


Router5.get("/action", function _callee2(req, res) {
  var _req$query, start, end, currentPage, pageSize, d_no, _ref, _ref2, result_now, sql_string, item, x, query, DESC_query, page_boolean, toTwoArray, OFFSET, FORMATTIME, formattedStart, formattedEnd, one_query, offset, toMap, _ref3, _ref4, rows, formattedRows, _ref5, _ref6, _rows, _formattedRows, _ref7, _ref8, _rows2, _formattedRows2, _ref9, _ref10, _rows3, _ref11, _ref12, _rows4, _formattedRows3, _ref13, _ref14, _rows5;

  return regeneratorRuntime.async(function _callee2$(_context2) {
    while (1) {
      switch (_context2.prev = _context2.next) {
        case 0:
          toMap = function _ref18(value) {
            return value.map(function (row) {
              return [row.d_no, row.field1, row.field2, (0, _dayjs["default"])(row.c_time).format('YYYY-MM-DD HH:mm:ss'), row.file_type, row.is_saved];
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
              row.field2.toString(), // 确保所有字段为字符串类型
              (0, _dayjs["default"])(row.c_time).format('YYYY-MM-DD HH:mm:ss'), // 已经格式化为ISO 8601标准时间字符串
              row.is_saved, row.file_type];
            });
            return formattedRows;
          };

          _req$query = req.query, start = _req$query.start, end = _req$query.end, currentPage = _req$query.currentPage, pageSize = _req$query.pageSize, d_no = _req$query.d_no; // 动态获取到字段

          _context2.next = 7;
          return regeneratorRuntime.awrap(connection.query("\n    SELECT * \n    FROM t_behavior_data \n  "));

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


          query = "SELECT d_no , ".concat(sql_string, " c_time,is_saved,file_type FROM t_behavior_data "); //降序sql

          DESC_query = "ORDER BY c_time DESC"; //页数有效值判断布尔变量

          page_boolean = !pageSize || !currentPage || currentPage === "undefined" || pageSize === "undefined" || currentPage === undefined || pageSize === undefined; //封装转化为数组的方法

          //全局解构赋值
          formattedStart = FORMATTIME(start !== "end" || start !== "1" ? start : '2025-06-13 15:51:16');
          formattedEnd = FORMATTIME(end !== "1" ? end : '2025-06-13 15:51:16');
          console.log("formattedStart:" + formattedStart);
          console.log("formattedEnd:" + formattedEnd); //单向限制sql

          one_query = "WHERE c_time < \"".concat(formattedEnd, "\"") + (d_no === "null" ? "" : " AND d_no = \"".concat(d_no, "\""));

          if (page_boolean) {} else {
            offset = OFFSET(currentPage, pageSize);
          } //封装响应结果格式化的方法


          if (!(start === "1" && end === "1")) {
            _context2.next = 43;
            break;
          }

          if (!page_boolean) {
            _context2.next = 33;
            break;
          }

          console.log("进入的是第一个"); // 执行查询并格式化结果

          _context2.next = 26;
          return regeneratorRuntime.awrap(connection.execute(query + (d_no === "null" ? "" : " WHERE d_no = \"".concat(d_no, "\" ")) + DESC_query));

        case 26:
          _ref3 = _context2.sent;
          _ref4 = _slicedToArray(_ref3, 1);
          rows = _ref4[0];
          formattedRows = toTwoArray(rows); // 直接使用 res.send() 返回数据

          res.send(JSON.stringify(formattedRows));
          _context2.next = 41;
          break;

        case 33:
          console.log("进入的是第2个"); //直接查询

          _context2.next = 36;
          return regeneratorRuntime.awrap(connection.execute(query + (d_no === "null" ? "" : " WHERE d_no = \"".concat(d_no, "\" ")) + DESC_query + "\n        LIMIT ".concat(parseInt(pageSize), " OFFSET ").concat(offset)));

        case 36:
          _ref5 = _context2.sent;
          _ref6 = _slicedToArray(_ref5, 1);
          _rows = _ref6[0];
          _formattedRows = toTwoArray(_rows); // 直接使用 res.send() 返回数据

          res.send(JSON.stringify(_formattedRows));

        case 41:
          _context2.next = 78;
          break;

        case 43:
          if (!(start === "end" && end !== "1")) {
            _context2.next = 62;
            break;
          }

          if (!page_boolean) {
            _context2.next = 54;
            break;
          }

          _context2.next = 47;
          return regeneratorRuntime.awrap(connection.execute(query + one_query + DESC_query));

        case 47:
          _ref7 = _context2.sent;
          _ref8 = _slicedToArray(_ref7, 1);
          _rows2 = _ref8[0];
          _formattedRows2 = toTwoArray(_rows2); // 直接使用 res.send() 返回数据

          res.send(JSON.stringify(_formattedRows2));
          _context2.next = 60;
          break;

        case 54:
          _context2.next = 56;
          return regeneratorRuntime.awrap(connection.execute(query + one_query + DESC_query + "\n        LIMIT ".concat(parseInt(pageSize), " OFFSET ").concat(offset, "\n      ")));

        case 56:
          _ref9 = _context2.sent;
          _ref10 = _slicedToArray(_ref9, 1);
          _rows3 = _ref10[0];
          res.send(toMap(_rows3));

        case 60:
          _context2.next = 78;
          break;

        case 62:
          if (!page_boolean) {
            _context2.next = 72;
            break;
          }

          _context2.next = 65;
          return regeneratorRuntime.awrap(connection.execute(query + "\n        WHERE c_time BETWEEN \"".concat(formattedStart, "\" AND \"").concat(formattedEnd, "\"") + (d_no === "null" ? "" : " AND d_no = \"".concat(d_no, "\" ")) + DESC_query));

        case 65:
          _ref11 = _context2.sent;
          _ref12 = _slicedToArray(_ref11, 1);
          _rows4 = _ref12[0];
          _formattedRows3 = toTwoArray(_rows4); // 直接使用 res.send() 返回数据

          res.send(JSON.stringify(_formattedRows3));
          _context2.next = 78;
          break;

        case 72:
          _context2.next = 74;
          return regeneratorRuntime.awrap(connection.execute(query + "WHERE c_time BETWEEN \"".concat(formattedStart, "\" AND \"").concat(formattedEnd, "\"") + (d_no === "null" ? "" : " AND d_no = \"".concat(d_no, "\" ")) + DESC_query + " LIMIT ".concat(parseInt(pageSize), " OFFSET ").concat(offset, "\n      ")));

        case 74:
          _ref13 = _context2.sent;
          _ref14 = _slicedToArray(_ref13, 1);
          _rows5 = _ref14[0];
          res.send(toMap(_rows5));

        case 78:
        case "end":
          return _context2.stop();
      }
    }
  });
}); //表格的呈现路由

Router5.get("/action_count", function _callee3(req, res) {
  var _req$query2, start, end, d_no, _ref19, _ref20, rows, formatTime, formattedEnd, _ref21, _ref22, _rows6, _formatTime, formattedStart, _formattedEnd, _ref23, _ref24, _rows7;

  return regeneratorRuntime.async(function _callee3$(_context3) {
    while (1) {
      switch (_context3.prev = _context3.next) {
        case 0:
          _req$query2 = req.query, start = _req$query2.start, end = _req$query2.end, d_no = _req$query2.d_no;
          _context3.prev = 1;

          if (!(start === "1" && end === "1")) {
            _context3.next = 11;
            break;
          }

          _context3.next = 5;
          return regeneratorRuntime.awrap(connection.execute("\n        SELECT COUNT(*) as total \n        FROM t_behavior_data\n      " + (d_no === "null" ? "" : "WHERE d_no = \"".concat(d_no, "\""))));

        case 5:
          _ref19 = _context3.sent;
          _ref20 = _slicedToArray(_ref19, 1);
          rows = _ref20[0];
          // 直接返回数组长度
          res.send("" + rows[0].total.toString());
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
          return regeneratorRuntime.awrap(connection.execute("\n        SELECT COUNT(*) as total \n        FROM t_behavior_data \n        WHERE c_time < \"".concat(formattedEnd, "\"\n      \n      ") + (d_no === "null" ? "" : "AND d_no = \"".concat(d_no, "\""))));

        case 16:
          _ref21 = _context3.sent;
          _ref22 = _slicedToArray(_ref21, 1);
          _rows6 = _ref22[0];
          // 直接返回数组长度
          res.send("" + _rows6[0].total.toString());
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
          return regeneratorRuntime.awrap(connection.execute("\n        SELECT COUNT(*) as total  \n        FROM t_behavior_data \n        WHERE c_time BETWEEN \"".concat(formattedStart, "\" AND \"").concat(_formattedEnd, "\"\n      ") + (d_no === "null" ? "" : " AND d_no=\"".concat(d_no, "\" "))));

        case 30:
          _ref23 = _context3.sent;
          _ref24 = _slicedToArray(_ref23, 1);
          _rows7 = _ref24[0];
          // 直接返回数组长度
          res.send("" + _rows7[0].total.toString());

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
});
Router5.get("/data/action", function _callee4(req, res) {
  var _req$query3, start, end, d_no, _ref25, _ref26, result_now, sql_string, item, x, query, FORMATTIME, groupbyd_no, toBig, formattedStart, formattedEnd, search_result, formattedResult, _ref27, _ref28, results, _ref29, _ref30, _results, _ref31, _ref32, _results2;

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
                formattedResult.push([row.d_no, entry[0], entry[1], entry[2], entry[3]]);
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
                    return regeneratorRuntime.awrap(connection.query("SET SESSION group_concat_max_len = 1000000"));

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
          _req$query3 = req.query, start = _req$query3.start, end = _req$query3.end, d_no = _req$query3.d_no; //动态获取到filed字段

          _context5.next = 6;
          return regeneratorRuntime.awrap(connection.query("\n    SELECT * \n    FROM t_behavior_data\n  "));

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
          }

          if (!d_no) {
            //全局sql
            query = "SELECT d_no, \n          GROUP_CONCAT(\n            CONCAT('[', " + sql_string + "'\"', c_time, '\",', \n            '\"', file_type, '\"', \n            ']') ORDER BY c_time\n          ) AS data\n        FROM t_behavior_data\n        WHERE is_saved = '\u5B9E\u65F6\u6570\u636E'";
          } else {
            //全局sql
            query = "SELECT d_no, \n          GROUP_CONCAT(\n            CONCAT('[', " + sql_string + "'\"', c_time, '\",', \n            '\"', file_type, '\"', \n            ']') ORDER BY c_time\n          ) AS data\n        FROM t_behavior_data\n        WHERE is_saved = '\u5B9E\u65F6\u6570\u636E'\n        AND d_no = \"".concat(d_no, "\"");
          }

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
          return regeneratorRuntime.awrap(connection.query(query + groupbyd_no));

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
          return regeneratorRuntime.awrap(connection.query(query + "\n      AND c_time < \"".concat(formattedEnd, "\"\n    ") + groupbyd_no));

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
          return regeneratorRuntime.awrap(connection.query(query + "\n      AND c_time BETWEEN \"".concat(formattedStart, "\" AND \"").concat(formattedEnd, "\"\n    ") + groupbyd_no));

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
});
var _default = Router5;
exports["default"] = _default;