"use strict";

Object.defineProperty(exports, "__esModule", {
  value: true
});
exports["default"] = void 0;

var _indexNode = _interopRequireDefault(require("../indexNode2.js"));

var _fs = _interopRequireDefault(require("fs"));

var _koaRouter = _interopRequireDefault(require("koa-router"));

var _path = _interopRequireDefault(require("path"));

var _dayjs = _interopRequireDefault(require("dayjs"));

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { "default": obj }; }

function _slicedToArray(arr, i) { return _arrayWithHoles(arr) || _iterableToArrayLimit(arr, i) || _nonIterableRest(); }

function _nonIterableRest() { throw new TypeError("Invalid attempt to destructure non-iterable instance"); }

function _iterableToArrayLimit(arr, i) { if (!(Symbol.iterator in Object(arr) || Object.prototype.toString.call(arr) === "[object Arguments]")) { return; } var _arr = []; var _n = true; var _d = false; var _e = undefined; try { for (var _i = arr[Symbol.iterator](), _s; !(_n = (_s = _i.next()).done); _n = true) { _arr.push(_s.value); if (i && _arr.length === i) break; } } catch (err) { _d = true; _e = err; } finally { try { if (!_n && _i["return"] != null) _i["return"](); } finally { if (_d) throw _e; } } return _arr; }

function _arrayWithHoles(arr) { if (Array.isArray(arr)) return arr; }

var connection;
var Router5 = new _koaRouter["default"]();

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
})();

Router5.get("/action", function _callee2(ctx) {
  var _ctx$query, start, end, currentPage, pageSize, d_no, _ref, _ref2, result_now, sql_string, item, x, query, DESC_query, page_boolean, toTwoArray, OFFSET, FORMATTIME, formattedStart, formattedEnd, one_query, offset, toMap, _ref3, _ref4, rows, formattedRows, _ref5, _ref6, _rows, _formattedRows, _ref7, _ref8, _rows2, _formattedRows2, _ref9, _ref10, _rows3, _ref11, _ref12, _rows4, _formattedRows3, _ref13, _ref14, _rows5;

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
            return (parseInt(value1) - 1) * parseInt(value2);
          };

          toTwoArray = function _ref15(value) {
            var formattedRows = value.map(function (row) {
              return [row.d_no, row.field1.toString(), row.field2.toString(), (0, _dayjs["default"])(row.c_time).format('YYYY-MM-DD HH:mm:ss'), row.is_saved, row.file_type];
            });
            return formattedRows;
          };

          _ctx$query = ctx.query, start = _ctx$query.start, end = _ctx$query.end, currentPage = _ctx$query.currentPage, pageSize = _ctx$query.pageSize, d_no = _ctx$query.d_no;
          _context2.next = 7;
          return regeneratorRuntime.awrap(connection.query("\n    SELECT * \n    FROM t_behavior_data\n  "));

        case 7:
          _ref = _context2.sent;
          _ref2 = _slicedToArray(_ref, 1);
          result_now = _ref2[0];
          sql_string = '';

          for (item in result_now[0]) {
            if (result_now[0][item] !== null && item.includes("field")) {
              x = item + ",";
              sql_string += x;
            }
          }

          query = "SELECT d_no , ".concat(sql_string, " c_time,is_saved,file_type FROM t_behavior_data ");
          DESC_query = "ORDER BY c_time DESC";
          page_boolean = !pageSize || !currentPage || currentPage === "undefined" || pageSize === "undefined" || currentPage === undefined || pageSize === undefined;
          formattedStart = FORMATTIME(start !== "end" || start !== "1" ? start : '2025-06-13 15:51:16');
          formattedEnd = FORMATTIME(end !== "1" ? end : '2025-06-13 15:51:16');
          one_query = "WHERE c_time < \"".concat(formattedEnd, "\"") + (d_no === "null" ? "" : " AND d_no = \"".concat(d_no, "\""));

          if (!page_boolean) {
            offset = OFFSET(currentPage, pageSize);
          }

          if (!(start === "1" && end === "1")) {
            _context2.next = 39;
            break;
          }

          if (!page_boolean) {
            _context2.next = 30;
            break;
          }

          _context2.next = 23;
          return regeneratorRuntime.awrap(connection.execute(query + (d_no === "null" ? "" : " WHERE d_no = \"".concat(d_no, "\" ")) + DESC_query));

        case 23:
          _ref3 = _context2.sent;
          _ref4 = _slicedToArray(_ref3, 1);
          rows = _ref4[0];
          formattedRows = toTwoArray(rows);
          ctx.body = JSON.stringify(formattedRows);
          _context2.next = 37;
          break;

        case 30:
          _context2.next = 32;
          return regeneratorRuntime.awrap(connection.execute(query + (d_no === "null" ? "" : " WHERE d_no = \"".concat(d_no, "\" ")) + DESC_query + "\n        LIMIT ".concat(parseInt(pageSize), " OFFSET ").concat(offset)));

        case 32:
          _ref5 = _context2.sent;
          _ref6 = _slicedToArray(_ref5, 1);
          _rows = _ref6[0];
          _formattedRows = toTwoArray(_rows);
          ctx.body = JSON.stringify(_formattedRows);

        case 37:
          _context2.next = 74;
          break;

        case 39:
          if (!(start === "end" && end !== "1")) {
            _context2.next = 58;
            break;
          }

          if (!page_boolean) {
            _context2.next = 50;
            break;
          }

          _context2.next = 43;
          return regeneratorRuntime.awrap(connection.execute(query + one_query + DESC_query));

        case 43:
          _ref7 = _context2.sent;
          _ref8 = _slicedToArray(_ref7, 1);
          _rows2 = _ref8[0];
          _formattedRows2 = toTwoArray(_rows2);
          ctx.body = JSON.stringify(_formattedRows2);
          _context2.next = 56;
          break;

        case 50:
          _context2.next = 52;
          return regeneratorRuntime.awrap(connection.execute(query + one_query + DESC_query + "\n        LIMIT ".concat(parseInt(pageSize), " OFFSET ").concat(offset, "\n      ")));

        case 52:
          _ref9 = _context2.sent;
          _ref10 = _slicedToArray(_ref9, 1);
          _rows3 = _ref10[0];
          ctx.body = toMap(_rows3);

        case 56:
          _context2.next = 74;
          break;

        case 58:
          if (!page_boolean) {
            _context2.next = 68;
            break;
          }

          _context2.next = 61;
          return regeneratorRuntime.awrap(connection.execute(query + "\n        WHERE c_time BETWEEN \"".concat(formattedStart, "\" AND \"").concat(formattedEnd, "\"") + (d_no === "null" ? "" : " AND d_no = \"".concat(d_no, "\" ")) + DESC_query));

        case 61:
          _ref11 = _context2.sent;
          _ref12 = _slicedToArray(_ref11, 1);
          _rows4 = _ref12[0];
          _formattedRows3 = toTwoArray(_rows4);
          ctx.body = JSON.stringify(_formattedRows3);
          _context2.next = 74;
          break;

        case 68:
          _context2.next = 70;
          return regeneratorRuntime.awrap(connection.execute(query + "WHERE c_time BETWEEN \"".concat(formattedStart, "\" AND \"").concat(formattedEnd, "\"") + (d_no === "null" ? "" : " AND d_no = \"".concat(d_no, "\" ")) + DESC_query + " LIMIT ".concat(parseInt(pageSize), " OFFSET ").concat(offset)));

        case 70:
          _ref13 = _context2.sent;
          _ref14 = _slicedToArray(_ref13, 1);
          _rows5 = _ref14[0];
          ctx.body = toMap(_rows5);

        case 74:
        case "end":
          return _context2.stop();
      }
    }
  });
});
Router5.get("/action_count", function _callee3(ctx) {
  var _ctx$query2, start, end, d_no, _ref19, _ref20, rows, formatTime, formattedEnd, _ref21, _ref22, _rows6, _formatTime, formattedStart, _formattedEnd, _ref23, _ref24, _rows7;

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
          return regeneratorRuntime.awrap(connection.execute("\n        SELECT COUNT(*) as total \n        FROM t_behavior_data\n      " + (d_no === "null" ? "" : "WHERE d_no = \"".concat(d_no, "\""))));

        case 5:
          _ref19 = _context3.sent;
          _ref20 = _slicedToArray(_ref19, 1);
          rows = _ref20[0];
          ctx.body = "" + rows[0].total.toString();
          _context3.next = 31;
          break;

        case 11:
          if (!(start === "end" && end !== "1")) {
            _context3.next = 22;
            break;
          }

          formatTime = function formatTime(timeStr) {
            return new Date(timeStr).toISOString().slice(0, 19).replace('T', ' ');
          };

          formattedEnd = formatTime(end);
          _context3.next = 16;
          return regeneratorRuntime.awrap(connection.execute("\n        SELECT COUNT(*) as total \n        FROM t_behavior_data \n        WHERE c_time < \"".concat(formattedEnd, "\"\n      ") + (d_no === "null" ? "" : "AND d_no = \"".concat(d_no, "\""))));

        case 16:
          _ref21 = _context3.sent;
          _ref22 = _slicedToArray(_ref21, 1);
          _rows6 = _ref22[0];
          ctx.body = "" + _rows6[0].total.toString();
          _context3.next = 31;
          break;

        case 22:
          _formatTime = function _formatTime(timeStr) {
            return new Date(timeStr).toISOString().slice(0, 19).replace('T', ' ');
          };

          formattedStart = _formatTime(start);
          _formattedEnd = _formatTime(end);
          _context3.next = 27;
          return regeneratorRuntime.awrap(connection.execute("\n        SELECT COUNT(*) as total  \n        FROM t_behavior_data \n        WHERE c_time BETWEEN \"".concat(formattedStart, "\" AND \"").concat(_formattedEnd, "\"\n      ") + (d_no === "null" ? "" : " AND d_no=\"".concat(d_no, "\" "))));

        case 27:
          _ref23 = _context3.sent;
          _ref24 = _slicedToArray(_ref23, 1);
          _rows7 = _ref24[0];
          ctx.body = "" + _rows7[0].total.toString();

        case 31:
          _context3.next = 38;
          break;

        case 33:
          _context3.prev = 33;
          _context3.t0 = _context3["catch"](1);
          console.log("History：" + start);
          console.log("History：" + end);
          console.log("History：" + d_no);

        case 38:
        case "end":
          return _context3.stop();
      }
    }
  }, null, null, [[1, 33]]);
});
Router5.get("/data/action", function _callee4(ctx) {
  var _ctx$query3, start, end, d_no, _ref25, _ref26, result_now, sql_string, item, x, query, FORMATTIME, groupbyd_no, toBig, formattedStart, formattedEnd, search_result, formattedResult, _ref27, _ref28, results, _ref29, _ref30, _results, _ref31, _ref32, _results2;

  return regeneratorRuntime.async(function _callee4$(_context5) {
    while (1) {
      switch (_context5.prev = _context5.next) {
        case 0:
          search_result = function _ref35(value) {
            var formattedResult = [];
            value.forEach(function (row) {
              if (!row.data) return;
              var fixedData = "[".concat(row.data, "]");
              var data = JSON.parse(fixedData);
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

          _ctx$query3 = ctx.query, start = _ctx$query3.start, end = _ctx$query3.end, d_no = _ctx$query3.d_no;
          _context5.next = 6;
          return regeneratorRuntime.awrap(connection.query("\n    SELECT * \n    FROM t_behavior_data\n  "));

        case 6:
          _ref25 = _context5.sent;
          _ref26 = _slicedToArray(_ref25, 1);
          result_now = _ref26[0];
          sql_string = '';

          for (item in result_now[0]) {
            if (result_now[0][item] !== null && item.includes("field")) {
              x = "'\"', " + item + ", '\",', ";
              sql_string += x;
            }
          }

          if (!d_no) {
            query = "SELECT d_no, \n      GROUP_CONCAT(\n        CONCAT('[', " + sql_string + "'\"', c_time, '\",', \n        '\"', file_type, '\",',\n        '\"', confidence, '\"',\n        ']') ORDER BY c_time\n      ) AS data\n      FROM t_behavior_data\n      WHERE is_saved = '\u5B9E\u65F6\u6570\u636E'";
          } else {
            query = "SELECT d_no, \n      GROUP_CONCAT(\n        CONCAT('[', " + sql_string + "'\"', c_time, '\",', \n        '\"', file_type, '\",',\n        '\"', confidence, '\"',\n        ']') ORDER BY c_time\n      ) AS data\n      FROM t_behavior_data\n      WHERE is_saved = '\u5B9E\u65F6\u6570\u636E'\n      AND d_no = \"".concat(d_no, "\"");
          }

          groupbyd_no = "GROUP BY d_no";
          ;
          formattedStart = FORMATTIME(start !== "end" || start !== "1" ? start : '2025-06-13 15:51:16');
          formattedEnd = FORMATTIME(end !== "1" ? end : '2025-06-13 15:51:16');
          _context5.next = 18;
          return regeneratorRuntime.awrap(toBig());

        case 18:
          if (!(start === "1" && end === "1")) {
            _context5.next = 27;
            break;
          }

          _context5.next = 21;
          return regeneratorRuntime.awrap(connection.query(query + groupbyd_no));

        case 21:
          _ref27 = _context5.sent;
          _ref28 = _slicedToArray(_ref27, 1);
          results = _ref28[0];
          formattedResult = search_result(results);
          _context5.next = 42;
          break;

        case 27:
          if (!(start === "end" && end !== "1")) {
            _context5.next = 36;
            break;
          }

          _context5.next = 30;
          return regeneratorRuntime.awrap(connection.query(query + "\n      AND c_time < \"".concat(formattedEnd, "\"\n    ") + groupbyd_no));

        case 30:
          _ref29 = _context5.sent;
          _ref30 = _slicedToArray(_ref29, 1);
          _results = _ref30[0];
          formattedResult = search_result(_results);
          _context5.next = 42;
          break;

        case 36:
          _context5.next = 38;
          return regeneratorRuntime.awrap(connection.query(query + "\n      AND c_time BETWEEN \"".concat(formattedStart, "\" AND \"").concat(formattedEnd, "\"\n    ") + groupbyd_no));

        case 38:
          _ref31 = _context5.sent;
          _ref32 = _slicedToArray(_ref31, 1);
          _results2 = _ref32[0];
          formattedResult = search_result(_results2);

        case 42:
          ctx.body = formattedResult;

        case 43:
        case "end":
          return _context5.stop();
      }
    }
  });
});
var _default = Router5;
exports["default"] = _default;