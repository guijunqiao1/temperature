"use strict";

Object.defineProperty(exports, "__esModule", {
  value: true
});
exports["default"] = void 0;

var _indexNode = _interopRequireDefault(require("../indexNode2.js"));

var _express = _interopRequireDefault(require("express"));

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { "default": obj }; }

function _slicedToArray(arr, i) { return _arrayWithHoles(arr) || _iterableToArrayLimit(arr, i) || _nonIterableRest(); }

function _nonIterableRest() { throw new TypeError("Invalid attempt to destructure non-iterable instance"); }

function _iterableToArrayLimit(arr, i) { if (!(Symbol.iterator in Object(arr) || Object.prototype.toString.call(arr) === "[object Arguments]")) { return; } var _arr = []; var _n = true; var _d = false; var _e = undefined; try { for (var _i = arr[Symbol.iterator](), _s; !(_n = (_s = _i.next()).done); _n = true) { _arr.push(_s.value); if (i && _arr.length === i) break; } } catch (err) { _d = true; _e = err; } finally { try { if (!_n && _i["return"] != null) _i["return"](); } finally { if (_d) throw _e; } } return _arr; }

function _arrayWithHoles(arr) { if (Array.isArray(arr)) return arr; }

//此处获取到数据库链接配置对象
var connection1; //定义数据库连接对象

var Router3 = (0, _express["default"])();

(function _callee() {
  return regeneratorRuntime.async(function _callee$(_context) {
    while (1) {
      switch (_context.prev = _context.next) {
        case 0:
          _context.prev = 0;
          _context.next = 3;
          return regeneratorRuntime.awrap((0, _indexNode["default"])());

        case 3:
          connection1 = _context.sent;
          console.log("数据库3连接成功");
          _context.next = 10;
          break;

        case 7:
          _context.prev = 7;
          _context.t0 = _context["catch"](0);
          console.log("数据库3连接失败");

        case 10:
        case "end":
          return _context.stop();
      }
    }
  }, null, null, [[0, 7]]);
})();

Router3.get("/t_error_msg/all", function _callee2(req, res) {
  var _ref, _ref2, rows;

  return regeneratorRuntime.async(function _callee2$(_context2) {
    while (1) {
      switch (_context2.prev = _context2.next) {
        case 0:
          _context2.next = 2;
          return regeneratorRuntime.awrap(connection1.execute("\n    SELECT *\n    FROM t_error_msg\n    "));

        case 2:
          _ref = _context2.sent;
          _ref2 = _slicedToArray(_ref, 1);
          rows = _ref2[0];
          console.log("整体的neirong:");
          console.dir(rows);
          res.send(rows);

        case 8:
        case "end":
          return _context2.stop();
      }
    }
  });
}); // 需要分页的路由

Router3.get("/t_error_msg/first", function _callee3(req, res) {
  var _req$query, currentPage, pageSize, _req$query2, start, end, d_no, query, _ref3, _ref4, results, _formattedResults, formatTime, formattedEnd, _query, _ref5, _ref6, _results, _formattedResults2, _formatTime, formattedStart, _formattedEnd, _query2, _ref7, _ref8, _results2, _formattedResults3, page, size, offset, _ref9, _ref10, rows, formattedRows, _formatTime2, _formattedEnd2, _ref11, _ref12, _rows, _formattedRows, _formatTime3, _formattedStart, _formattedEnd3, _ref13, _ref14, _rows2, _formattedRows2;

  return regeneratorRuntime.async(function _callee3$(_context3) {
    while (1) {
      switch (_context3.prev = _context3.next) {
        case 0:
          _context3.prev = 0;
          _req$query = req.query, currentPage = _req$query.currentPage, pageSize = _req$query.pageSize;
          _req$query2 = req.query, start = _req$query2.start, end = _req$query2.end, d_no = _req$query2.d_no; // 处理 undefined 情况

          if (!(currentPage === "undefined")) {
            _context3.next = 46;
            break;
          }

          if (!(start === "1" && end === "1")) {
            _context3.next = 16;
            break;
          }

          //全局查询AND d_no = '${d_no}'
          query = "SELECT d_no,e_msg,c_time FROM t_error_msg WHERE d_no = '${d_no}'"; // ✅ 使用 `await` 进行查询

          _context3.next = 8;
          return regeneratorRuntime.awrap(connection1.execute(query));

        case 8:
          _ref3 = _context3.sent;
          _ref4 = _slicedToArray(_ref3, 1);
          results = _ref4[0];
          // 格式化数据
          _formattedResults = results.map(function (row) {
            return [row.d_no, row.e_msg, row.c_time];
          });
          res.setHeader('Content-Type', 'application/json');
          res.send(JSON.stringify(_formattedResults));
          _context3.next = 44;
          break;

        case 16:
          if (!(start === "end" && end !== "1")) {
            _context3.next = 30;
            break;
          }

          //单向查询
          formatTime = function formatTime(timeStr) {
            return new Date(timeStr).toISOString().slice(0, 19).replace('T', ' ');
          };

          formattedEnd = formatTime(end);
          _query = "SELECT d_no,e_msg, c_time FROM t_error_msg WHERE c_time < '".concat(formattedEnd, "' AND d_no = '").concat(d_no, "'"); // ✅ 使用 `await` 进行查询

          _context3.next = 22;
          return regeneratorRuntime.awrap(connection1.execute(_query));

        case 22:
          _ref5 = _context3.sent;
          _ref6 = _slicedToArray(_ref5, 1);
          _results = _ref6[0];
          // 格式化数据
          _formattedResults2 = _results.map(function (row) {
            return [row.d_no, row.e_msg, row.c_time];
          });
          res.setHeader('Content-Type', 'application/json');
          res.send(JSON.stringify(_formattedResults2));
          _context3.next = 44;
          break;

        case 30:
          //区间查询
          // 将时间值进行转化
          _formatTime = function _formatTime(timeStr) {
            return new Date(timeStr).toISOString().slice(0, 19).replace('T', ' ');
          };

          formattedStart = _formatTime(start);
          _formattedEnd = _formatTime(end);
          console.log("桂start:" + start);
          console.log("桂end:" + end);
          _query2 = "SELECT d_no,e_msg, c_time FROM t_error_msg WHERE c_time BETWEEN '".concat(formattedStart, "' AND '").concat(_formattedEnd, "' AND d_no = '").concat(d_no, "'"); // ✅ 使用 `await` 进行查询

          _context3.next = 38;
          return regeneratorRuntime.awrap(connection1.execute(_query2));

        case 38:
          _ref7 = _context3.sent;
          _ref8 = _slicedToArray(_ref7, 1);
          _results2 = _ref8[0];
          // 格式化数据
          _formattedResults3 = _results2.map(function (row) {
            return [row.d_no, row.e_msg, row.c_time];
          });
          res.setHeader('Content-Type', 'application/json');
          res.send(JSON.stringify(_formattedResults3));

        case 44:
          _context3.next = 85;
          break;

        case 46:
          // ✅ 解析分页参数（确保转换为整数）
          page = parseInt(currentPage, 10) || 1;
          size = parseInt(pageSize, 10) || 12;
          offset = (page - 1) * size;
          console.log("page：" + page);
          console.log("page：" + size);
          console.log("page：" + offset);

          if (!(start === "1" && end === "1")) {
            _context3.next = 62;
            break;
          }

          _context3.next = 55;
          return regeneratorRuntime.awrap(connection1.execute("\n            SELECT d_no, e_msg,  c_time\n            FROM t_error_msg \n            WHERE d_no = '".concat(d_no, "'\n            AND d_no = '").concat(d_no, "'\n            LIMIT ").concat(size, " OFFSET ").concat(offset, "\n          ")));

        case 55:
          _ref9 = _context3.sent;
          _ref10 = _slicedToArray(_ref9, 1);
          rows = _ref10[0];
          //大多数时候请使用字符串拼接的方式书写分页代码以及其他相关的代码
          // 将数据转换为二维数组格式
          formattedRows = rows.map(function (row) {
            return [// 确保所有字段为字符串类型
            row.d_no, row.e_msg, row.c_time];
          }); // 直接使用 res.send() 返回数据

          res.send(JSON.stringify(formattedRows));
          _context3.next = 85;
          break;

        case 62:
          if (!(start === "end" && end !== "1")) {
            _context3.next = 74;
            break;
          }

          //单向查询
          _formatTime2 = function _formatTime2(timeStr) {
            return new Date(timeStr).toISOString().slice(0, 19).replace('T', ' ');
          };

          _formattedEnd2 = _formatTime2(end);
          _context3.next = 67;
          return regeneratorRuntime.awrap(connection1.execute("\n            SELECT d_no,e_msg,  c_time\n            FROM t_error_msg \n            WHERE c_time < '".concat(_formattedEnd2, "'\n            AND d_no = '").concat(d_no, "'\n            LIMIT ").concat(size, " OFFSET ").concat(offset, "\n          ")));

        case 67:
          _ref11 = _context3.sent;
          _ref12 = _slicedToArray(_ref11, 1);
          _rows = _ref12[0];
          //大多数时候请使用字符串拼接的方式书写分页代码以及其他相关的代码
          // 将数据转换为二维数组格式
          _formattedRows = _rows.map(function (row) {
            return [row.d_no, row.e_msg, row.c_time];
          }); // 直接使用 res.send() 返回数据

          res.send(JSON.stringify(_formattedRows));
          _context3.next = 85;
          break;

        case 74:
          _formatTime3 = function _formatTime3(timeStr) {
            return new Date(timeStr).toISOString().slice(0, 19).replace('T', ' ');
          };

          _formattedStart = _formatTime3(start);
          _formattedEnd3 = _formatTime3(end);
          _context3.next = 79;
          return regeneratorRuntime.awrap(connection1.execute("\n            SELECT d_no,e_msg,  c_time\n            FROM t_error_msg \n            WHERE c_time BETWEEN '".concat(_formattedStart, "' AND '").concat(_formattedEnd3, "'\n            AND d_no = '").concat(d_no, "'\n            LIMIT ").concat(size, " OFFSET ").concat(offset, "\n          ")));

        case 79:
          _ref13 = _context3.sent;
          _ref14 = _slicedToArray(_ref13, 1);
          _rows2 = _ref14[0];
          //大多数时候请使用字符串拼接的方式书写分页代码以及其他相关的代码
          // 将数据转换为二维数组格式
          _formattedRows2 = _rows2.map(function (row) {
            return [// 确保所有字段为字符串类型
            row.d_no, row.e_msg, row.c_time];
          });
          res.setHeader('Content-Type', 'application/json');
          res.send(JSON.stringify(formattedResults));

        case 85:
          _context3.next = 90;
          break;

        case 87:
          _context3.prev = 87;
          _context3.t0 = _context3["catch"](0);
          console.error("查询失败:", _context3.t0); // res.status(500).json({ error: "数据库查询失败" });

        case 90:
        case "end":
          return _context3.stop();
      }
    }
  }, null, null, [[0, 87]]);
}); //根据对应的信息进行查询的路由
// Router3.get("/t_error_msg/search",async (req,res)=>{
//   const { d_no,e_msg,currentPage,pageSize } = req.query;
//   const { start,end } = req.query;
//   // ✅ 解析分页参数（确保转换为整数）
//   const page = parseInt(currentPage, 10) || 1;
//   const size = parseInt(pageSize, 10) || 12;
//   const offset = (page - 1) * size;
//   if(d_no!=="1"&&e_msg==="1"){//当d_no存在而e_msg不存在的时候
//     let query;
//     if(start==="1"&&end==="1"){
//       query = `SELECT d_no,e_msg, c_time, type FROM t_error_msg WHERE d_no='${d_no}' AND type='${type}' LIMIT ${size} OFFSET ${offset}`;
//     }
//     else if(start==="end"&&end!=="1"){
//       const formatTime = (timeStr) => new Date(timeStr).toISOString().slice(0, 19).replace('T', ' ');
//       const formattedEnd = formatTime(end);
//       query = `SELECT d_no,e_msg, c_time, type FROM t_error_msg WHERE d_no='${d_no}' AND type='${type}' AND c_time<'${formattedEnd}' LIMIT ${size} OFFSET ${offset}`;
//     }
//     else{
//       const formatTime = (timeStr) => new Date(timeStr).toISOString().slice(0, 19).replace('T', ' ');
//       const formattedStart = formatTime(start);
//       const formattedEnd = formatTime(end);
//       query = `SELECT d_no,e_msg, c_time, type FROM t_error_msg WHERE d_no='${d_no}' AND type='${type}' AND c_time BETWEEN '${formattedStart}' AND '${formattedEnd}' LIMIT ${size} OFFSET ${offset}`;
//     }
//     // ✅ 使用 `await` 进行查询
//     const [results] = await connection1.execute(query);
//     if(results.length<1){//当查询为空
// res.send([]);
//       return;
//     }
//     else {
//       // 格式化数据
//       const formattedResults = results.map(row => [
//         row.d_no,
//         row.e_msg,
//         row.c_time
//       ]);
// res.setHeader('Content-Type', 'application/json');
// res.send(JSON.stringify(formattedResults));
//       return;
//     }
//   }
//   else if(d_no==="1"&&e_msg!=="1"){//当d_no不存在而e_msg存在的时候
//     let query;
//     if(start==="1"&&end==="1"){
//        query = `SELECT d_no,e_msg, c_time, type FROM t_error_msg WHERE e_msg='${e_msg}' AND type='${type}' LIMIT ${size} OFFSET ${offset}`;
//     }
//     else if(start==="end"&&end!=="1"){
//       const formatTime = (timeStr) => new Date(timeStr).toISOString().slice(0, 19).replace('T', ' ');
//       const formattedEnd = formatTime(end);
//        query = `SELECT d_no,e_msg, c_time, type FROM t_error_msg WHERE e_msg='${e_msg}' AND type='${type}' AND c_time<'${formattedEnd}' LIMIT ${size} OFFSET ${offset}`;
//     }
//     else{
//       const formatTime = (timeStr) => new Date(timeStr).toISOString().slice(0, 19).replace('T', ' ');
//       const formattedStart = formatTime(start);
//       const formattedEnd = formatTime(end);
//        query = `SELECT d_no,e_msg, c_time, type FROM t_error_msg WHERE e_msg='${e_msg}' AND type='${type}' AND c_time BETWEEN '${formattedStart}' AND '${formattedEnd}' LIMIT ${size} OFFSET ${offset}`;
//     }
//     // ✅ 使用 `await` 进行查询
//     const [results] = await connection1.execute(query);
//     if(results.length<1){//当查询为空
// res.send([]);
//       return;
//     }
//     else {
//       // 格式化数据
//       const formattedResults = results.map(row => [
//         row.d_no,
//         row.e_msg,
//         row.c_time
//       ]);
// res.setHeader('Content-Type', 'application/json');
// res.send(JSON.stringify(formattedResults));
//       return;
//     }
//   }
//   else if(d_no!=="1"&&e_msg!=="1"){//当d_no和e_msg都存在的时候
//     let query;
//     if(start==="1"&&end==="1"){
//        query = `SELECT d_no,e_msg, c_time, type FROM t_error_msg WHERE d_no='${d_no}' AND e_msg='${e_msg}' AND type='${type}' LIMIT ${size} OFFSET ${offset}`;
//     }
//     else if(start==="end"&&end==="1"){
//       const formatTime = (timeStr) => new Date(timeStr).toISOString().slice(0, 19).replace('T', ' ');
//       const formattedEnd = formatTime(end);
//        query = `SELECT d_no, e_msg, c_time, type FROM t_error_msg WHERE d_no='${d_no}' AND e_msg='${e_msg}' AND type='${type}' AND c_time<'${formattedEnd}' LIMIT ${size} OFFSET ${offset}`;
//     }
//     else{
//       const formatTime = (timeStr) => new Date(timeStr).toISOString().slice(0, 19).replace('T', ' ');
//       const formattedStart = formatTime(start);
//       const formattedEnd = formatTime(end);
//        query = `SELECT d_no,e_msg, c_time, type FROM t_error_msg WHERE d_no='${d_no}' AND e_msg='${e_msg}' AND type='${type}' AND c_time BETWEEN '${formattedStart}' AND '${formattedEnd}'  LIMIT ${size} OFFSET ${offset}`;
//     }
//     // ✅ 使用 `await` 进行查询
//     const [results] = await connection1.execute(query);
//     if(results.length<1){
// res.send([]);
//       return;
//     }
//     else {
//       // 格式化数据
//       const formattedResults = results.map(row => [
//         row.d_no,
//         row.e_msg,
//         row.c_time
//       ]);
// res.setHeader('Content-Type', 'application/json');
// res.send(JSON.stringify(formattedResults));
//       return;
//     }
//   }
// })
// //获取数据库信息总数的路由--未激活查询框的状态

Router3.get("/t_error_msg/count", function _callee4(req, res) {
  var _req$query3, start, end, d_no, _ref15, _ref16, rows, formatTime, formattedEnd, _ref17, _ref18, _rows3, _formatTime4, formattedStart, _formattedEnd4, _ref19, _ref20, _rows4;

  return regeneratorRuntime.async(function _callee4$(_context4) {
    while (1) {
      switch (_context4.prev = _context4.next) {
        case 0:
          _req$query3 = req.query, start = _req$query3.start, end = _req$query3.end, d_no = _req$query3.d_no;

          if (!(start === "1" && end === "1")) {
            _context4.next = 10;
            break;
          }

          _context4.next = 4;
          return regeneratorRuntime.awrap(connection1.execute("SELECT * FROM t_error_msg WHERE d_no = '${d_no}'"));

        case 4:
          _ref15 = _context4.sent;
          _ref16 = _slicedToArray(_ref15, 1);
          rows = _ref16[0];
          //将指定的d_no对应的内容总数进行获取
          res.send("" + rows.length);
          _context4.next = 30;
          break;

        case 10:
          if (!(start === "end" && end !== "1")) {
            _context4.next = 21;
            break;
          }

          formatTime = function formatTime(timeStr) {
            return new Date(timeStr).toISOString().slice(0, 19).replace('T', ' ');
          };

          formattedEnd = formatTime(end);
          _context4.next = 15;
          return regeneratorRuntime.awrap(connection1.execute("SELECT * FROM t_error_msg WHERE c_time<'".concat(formattedEnd, "' AND d_no = '").concat(d_no, "'")));

        case 15:
          _ref17 = _context4.sent;
          _ref18 = _slicedToArray(_ref17, 1);
          _rows3 = _ref18[0];
          //将指定的d_no对应的内容总数进行获取
          res.send("" + _rows3.length);
          _context4.next = 30;
          break;

        case 21:
          _formatTime4 = function _formatTime4(timeStr) {
            return new Date(timeStr).toISOString().slice(0, 19).replace('T', ' ');
          };

          formattedStart = _formatTime4(start);
          _formattedEnd4 = _formatTime4(end);
          _context4.next = 26;
          return regeneratorRuntime.awrap(connection1.execute("SELECT * FROM t_error_msg WHERE c_time BETWEEN '".concat(formattedStart, "' AND '").concat(_formattedEnd4, "' AND d_no = '").concat(d_no, "'")));

        case 26:
          _ref19 = _context4.sent;
          _ref20 = _slicedToArray(_ref19, 1);
          _rows4 = _ref20[0];
          //将指定的d_no对应的内容总数进行获取
          res.send("" + _rows4.length);

        case 30:
        case "end":
          return _context4.stop();
      }
    }
  });
}); //获取到告警数据

Router3.get("/alarm", function _callee5(req, res) {
  var level1, _ref21, _ref22, rows_level1, query1, _ref23, _ref24, rows;

  return regeneratorRuntime.async(function _callee5$(_context5) {
    while (1) {
      switch (_context5.prev = _context5.next) {
        case 0:
          level1 = "\n  SELECT VStatus\n  FROM t_error_msg\n  ";
          _context5.next = 3;
          return regeneratorRuntime.awrap(connection1.execute(level1));

        case 3:
          _ref21 = _context5.sent;
          _ref22 = _slicedToArray(_ref21, 1);
          rows_level1 = _ref22[0];
          console.log("row_level1:");
          console.dir(rows_level1);

          if (!(rows_level1[0].VStatus !== '0')) {
            _context5.next = 19;
            break;
          }

          query1 = "\n    SELECT *\n    FROM t_error_msg\n    WHERE e_msg != \"\u672A\u53D1\u751F\u544A\u8B66\"\n    ORDER BY c_time DESC\n    ";
          _context5.next = 12;
          return regeneratorRuntime.awrap(connection1.execute(query1));

        case 12:
          _ref23 = _context5.sent;
          _ref24 = _slicedToArray(_ref23, 1);
          rows = _ref24[0];
          res.send(rows);
          return _context5.abrupt("return");

        case 19:
          res.send([{
            e_msg: "所以设备均正常工作"
          }]);
          return _context5.abrupt("return");

        case 21:
        case "end":
          return _context5.stop();
      }
    }
  });
});
var _default = Router3; //记得将查询条件中的一定为实时数据进行修改了,所有的数据都可以

exports["default"] = _default;