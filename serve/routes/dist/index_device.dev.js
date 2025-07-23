"use strict";

Object.defineProperty(exports, "__esModule", {
  value: true
});
exports["default"] = void 0;

var _express = _interopRequireDefault(require("express"));

var _indexNode = _interopRequireDefault(require("../indexNode2.js"));

var _indexNode2 = _interopRequireDefault(require("../indexNode1.js"));

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { "default": obj }; }

function _slicedToArray(arr, i) { return _arrayWithHoles(arr) || _iterableToArrayLimit(arr, i) || _nonIterableRest(); }

function _nonIterableRest() { throw new TypeError("Invalid attempt to destructure non-iterable instance"); }

function _iterableToArrayLimit(arr, i) { if (!(Symbol.iterator in Object(arr) || Object.prototype.toString.call(arr) === "[object Arguments]")) { return; } var _arr = []; var _n = true; var _d = false; var _e = undefined; try { for (var _i = arr[Symbol.iterator](), _s; !(_n = (_s = _i.next()).done); _n = true) { _arr.push(_s.value); if (i && _arr.length === i) break; } } catch (err) { _d = true; _e = err; } finally { try { if (!_n && _i["return"] != null) _i["return"](); } finally { if (_d) throw _e; } } return _arr; }

function _arrayWithHoles(arr) { if (Array.isArray(arr)) return arr; }

//此处获取到数据库链接配置对象
var connection2; //定义数据库连接对象

var connection1; //定义数据库连接对象

var Router2 = (0, _express["default"])();

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
})(); // 不需要分页的路由


Router2.get("/t_device/first", function _callee2(req, res) {
  var query, _ref, _ref2, results, _formattedResults;

  return regeneratorRuntime.async(function _callee2$(_context2) {
    while (1) {
      switch (_context2.prev = _context2.next) {
        case 0:
          _context2.prev = 0;
          // 处理 undefined 情况
          query = "SELECT * FROM t_container ORDER BY ctime DESC"; // ✅ 使用 `await` 进行查询

          _context2.next = 4;
          return regeneratorRuntime.awrap(connection2.execute(query));

        case 4:
          _ref = _context2.sent;
          _ref2 = _slicedToArray(_ref, 1);
          results = _ref2[0];
          // 格式化数据
          _formattedResults = results.map(function (row) {
            return [row.PID, row.VID, row.ctime];
          });
          console.log("rows:" + results);
          res.setHeader("Content-Type", "application/json");
          res.send(JSON.stringify(_formattedResults));
          _context2.next = 17;
          break;

        case 13:
          _context2.prev = 13;
          _context2.t0 = _context2["catch"](0);
          console.error("查询失败:", _context2.t0);
          res.status(500).json({
            error: "数据库查询失败"
          });

        case 17:
        case "end":
          return _context2.stop();
      }
    }
  }, null, null, [[0, 13]]);
}); // 不需要分页的路由--多设备表格

Router2.get("/t_device", function _callee3(req, res) {
  var query, _ref3, _ref4, results;

  return regeneratorRuntime.async(function _callee3$(_context3) {
    while (1) {
      switch (_context3.prev = _context3.next) {
        case 0:
          _context3.prev = 0;
          // 处理 undefined 情况
          query = "SELECT * FROM t_device"; // ✅ 使用 `await` 进行查询

          _context3.next = 4;
          return regeneratorRuntime.awrap(connection1.execute(query));

        case 4:
          _ref3 = _context3.sent;
          _ref4 = _slicedToArray(_ref3, 1);
          results = _ref4[0];
          // 格式化数据
          console.log("rows:" + results);
          res.setHeader("Content-Type", "application/json");
          res.send(JSON.stringify(formattedResults));
          _context3.next = 16;
          break;

        case 12:
          _context3.prev = 12;
          _context3.t0 = _context3["catch"](0);
          console.error("查询失败:", _context3.t0);
          res.status(500).json({
            error: "数据库查询失败"
          });

        case 16:
        case "end":
          return _context3.stop();
      }
    }
  }, null, null, [[0, 12]]);
});
var _default = Router2; //记得将查询条件中的一定为实时数据进行修改了,所有的数据都可以
//记得在所有的没有使用try包裹的语句添加上try\catch语句用于对start为undefined的情况进行捕获
// //进行表格模块的路由文件的设计
// //在当前需要对Mysql数据库进行操作的文件中提前引入Mysql数据库的配置文件--需要注意的是indexNode文件中的其他引入的组件文件只是对indexNode本身编写的时候进行约束的文件
// import Config1 from "../indexNode2.js";//此处获取到数据库链接配置对象
// import Config2 from "../indexNode1.js";//此处获取到数据库链接配置对象
// let connection2;//定义数据库连接对象
// let connection1;//定义数据库连接对象
// import Router from "koa-router";
// const Router2 = new Router();
// (async ()=>{
//   try{
//     //异步执行Config，用于连接数据库,后续可对connection数据库链接对象进行数据库语法操作用于对数据库本身进行操作
//     connection2 = await Config1();
//     connection1 = await Config2();
//     console.log("数据库2连接成功");
//     console.log("数据库1连接成功");
//   }
//   catch(error){
//     console.log("数据库2连接失败");
//     console.log("数据库1连接失败");
//   }
// })();
// // 不需要分页的路由
// Router2.get("/t_device/first", async ctx => {
//   try {
//       let query;
//       // 处理 undefined 情况
//       query = "SELECT * FROM t_device ORDER BY ctime DESC";
//       // ✅ 使用 `await` 进行查询
//       const [results] = await connection2.execute(query);
//       // 格式化数据
//       const formattedResults = results.map(row => [
//           row.PID,
//           row.VID,
//           row.ctime
//       ]);
//       console.log("rows:"+results);
//       ctx.set("Content-Type", "application/json");
//       ctx.body = JSON.stringify(formattedResults);
//   } 
//   catch (error) {
//       console.error("查询失败:", error);
//   }
//   //测试返回一种结果的情况
// //   res.send(
// //     [
// //       [
// //         "2021",
// //         "异常",
// //         "集成装置1",
// //         "2025-03-03T09:29:47.000Z"
// //       ]
// //     ]
// //   );
// });
// // 不需要分页的路由--多设备表格
// Router2.get("/t_device", async ctx => {
//   try {
//       let query;
//       // 处理 undefined 情况
//       query = "SELECT * FROM t_device";
//       // ✅ 使用 `await` 进行查询
//       const [results] = await connection1.execute(query);
//       // 格式化数据
//       console.log("rows:"+results);
//       ctx.set("Content-Type", "application/json");
//       ctx.body = JSON.stringify(formattedResults);
//   } 
//   catch (error) {
//       console.error("查询失败:", error);
//   }
//   //测试返回一种结果的情况
// //   res.send(
// //     [
// //       [
// //         "2021",
// //         "异常",
// //         "集成装置1",
// //         "2025-03-03T09:29:47.000Z"
// //       ]
// //     ]
// //   );
// });
// export default Router2;
// //记得将查询条件中的一定为实时数据进行修改了,所有的数据都可以
// //记得在所有的没有使用try包裹的语句添加上try\catch语句用于对start为undefined的情况进行捕获

exports["default"] = _default;