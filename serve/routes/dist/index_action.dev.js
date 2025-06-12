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

//此处获取到数据库链接配置对象
var connection; //定义数据库连接对象

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
})(); //表格的呈现-图像的呈现路由


Router5.get("/action", function _callee2(ctx) {
  var _ctx$query, person, start_time, book_id, currentPage, pageSize, offset, query, _ref, _ref2, rows, formatTime, isPerson, isBookId, isStartTime, formattedStartTime, _ref3, _ref4, _rows;

  return regeneratorRuntime.async(function _callee2$(_context2) {
    while (1) {
      switch (_context2.prev = _context2.next) {
        case 0:
          _ctx$query = ctx.query, person = _ctx$query.person, start_time = _ctx$query.start_time, book_id = _ctx$query.book_id, currentPage = _ctx$query.currentPage, pageSize = _ctx$query.pageSize;
          _context2.prev = 1;
          offset = (parseInt(currentPage) - 1) * parseInt(pageSize);
          query = "\n      SELECT *\n      FROM t_behavior_data\n      ";

          if (!(!person && !start_time && !book_id)) {
            _context2.next = 15;
            break;
          }

          query += "\n      ORDER BY c_time\n      LIMIT ".concat(parseInt(pageSize), " OFFSET ").concat(offset, "\n      ");
          _context2.next = 8;
          return regeneratorRuntime.awrap(connection.execute(query));

        case 8:
          _ref = _context2.sent;
          _ref2 = _slicedToArray(_ref, 1);
          rows = _ref2[0];
          ctx.body = rows;
          return _context2.abrupt("return");

        case 15:
          //该分支下的！+变量为true的情况需要忽略当前维度
          //格式化时间方法
          formatTime = function formatTime(timeStr) {
            // 检查timeStr是否为"undefined"字符串或无效值
            if (!timeStr || timeStr === "undefined") {
              return null;
            }

            return new Date(timeStr).toISOString().slice(0, 19).replace('T', ' ');
          }; // 检查参数是否为"undefined"字符串


          isPerson = person && person !== "undefined";
          isBookId = book_id && book_id !== "undefined";
          isStartTime = start_time && start_time !== "undefined"; // 格式化开始时间，只有在有效时才格式化

          formattedStartTime = isStartTime ? formatTime(start_time) : null;
          query += "\n      WHERE field2 ".concat(!isPerson ? '!= "此为非法值"' : '= "' + person + '"', "\n      AND d_no ").concat(!isBookId ? '!= "此为非法值"' : '= "' + book_id + '"', "\n      AND c_time ").concat(!isStartTime ? '!= "2005-03-03 17:29:47"' : '> "' + formattedStartTime + '"', "\n      ORDER BY c_time\n      LIMIT ").concat(parseInt(pageSize), " OFFSET ").concat(offset, "\n      ");
          _context2.next = 23;
          return regeneratorRuntime.awrap(connection.execute(query));

        case 23:
          _ref3 = _context2.sent;
          _ref4 = _slicedToArray(_ref3, 1);
          _rows = _ref4[0];
          ctx.body = _rows;
          return _context2.abrupt("return");

        case 28:
          _context2.next = 33;
          break;

        case 30:
          _context2.prev = 30;
          _context2.t0 = _context2["catch"](1);
          console.log(_context2.t0);

        case 33:
        case "end":
          return _context2.stop();
      }
    }
  }, null, null, [[1, 30]]);
}); //表格的呈现路由

Router5.get("/action_count", function _callee3(ctx) {
  var _ctx$query2, person, start_time, book_id, all, query, _ref5, _ref6, rows, formatTime, isPerson, isBookId, isStartTime, formattedStartTime, _ref7, _ref8, _rows2;

  return regeneratorRuntime.async(function _callee3$(_context3) {
    while (1) {
      switch (_context3.prev = _context3.next) {
        case 0:
          _ctx$query2 = ctx.query, person = _ctx$query2.person, start_time = _ctx$query2.start_time, book_id = _ctx$query2.book_id, all = _ctx$query2.all;
          _context3.prev = 1;
          query = "\n      SELECT *\n      FROM t_behavior_data\n      ";

          if (!(!person && !start_time && !book_id)) {
            _context3.next = 13;
            break;
          }

          _context3.next = 6;
          return regeneratorRuntime.awrap(connection.execute(query));

        case 6:
          _ref5 = _context3.sent;
          _ref6 = _slicedToArray(_ref5, 1);
          rows = _ref6[0];
          ctx.body = !all ? "" + rows.length : rows;
          return _context3.abrupt("return");

        case 13:
          //该分支下的！+变量为true的情况需要忽略当前维度
          //格式化时间方法
          formatTime = function formatTime(timeStr) {
            // 检查timeStr是否为"undefined"字符串或无效值
            if (!timeStr || timeStr === "undefined") {
              return null;
            }

            return new Date(timeStr).toISOString().slice(0, 19).replace('T', ' ');
          }; // 检查参数是否为"undefined"字符串


          isPerson = person && person !== "undefined";
          isBookId = book_id && book_id !== "undefined";
          isStartTime = start_time && start_time !== "undefined"; // 格式化开始时间，只有在有效时才格式化

          formattedStartTime = isStartTime ? formatTime(start_time) : null;
          query += "\n        WHERE field2 ".concat(!isPerson ? '!= "此为非法值"' : '= "' + person + '"', "\n        AND d_no ").concat(!isBookId ? '!= "此为非法值"' : '= "' + book_id + '"', "\n        AND c_time ").concat(!isStartTime ? '!= "2005-03-03 17:29:47"' : '> "' + formattedStartTime + '"', "\n        ORDER BY c_time\n      ");
          _context3.next = 21;
          return regeneratorRuntime.awrap(connection.execute(query));

        case 21:
          _ref7 = _context3.sent;
          _ref8 = _slicedToArray(_ref7, 1);
          _rows2 = _ref8[0];
          ctx.body = !all ? "" + _rows2.length : _rows2;
          return _context3.abrupt("return");

        case 26:
          _context3.next = 31;
          break;

        case 28:
          _context3.prev = 28;
          _context3.t0 = _context3["catch"](1);
          console.log(_context3.t0);

        case 31:
        case "end":
          return _context3.stop();
      }
    }
  }, null, null, [[1, 28]]);
});
var _default = Router5;
exports["default"] = _default;