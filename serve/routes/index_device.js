// //进行表格模块的路由文件的设计
// import express from "express";
// //在当前需要对Mysql数据库进行操作的文件中提前引入Mysql数据库的配置文件--需要注意的是indexNode文件中的其他引入的组件文件只是对indexNode本身编写的时候进行约束的文件
// import Config1 from "../indexNode2.js";//此处获取到数据库链接配置对象
// import Config2 from "../indexNode1.js";//此处获取到数据库链接配置对象
// let connection2;//定义数据库连接对象
// let connection1;//定义数据库连接对象
// const Router2 = express();
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
// Router2.get("/t_device/first", async (req, res) => {
//   try {
//       let query;
//       // 处理 undefined 情况
//       query = "SELECT * FROM t_container ORDER BY ctime DESC";
//       // ✅ 使用 `await` 进行查询
//       const [results] = await connection2.execute(query);
//       // 格式化数据
//       const formattedResults = results.map(row => [
//           row.PID,
//           row.VID,
//           row.ctime
//       ]);
//       console.log("rows:"+results);
//       res.setHeader("Content-Type", "application/json");
//       res.send(JSON.stringify(formattedResults));
//   } 
//   catch (error) {
//       console.error("查询失败:", error);
//       res.status(500).json({ error: "数据库查询失败" }); 
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
// Router2.get("/t_device", async (req, res) => {
//   try {
//       let query;
//       // 处理 undefined 情况
//       query = "SELECT * FROM t_device";
//       // ✅ 使用 `await` 进行查询
//       const [results] = await connection1.execute(query);
//       // 格式化数据
//       console.log("rows:"+results);
//       res.setHeader("Content-Type", "application/json");
//       res.send(JSON.stringify(formattedResults));
//   } 
//   catch (error) {
//       console.error("查询失败:", error);
//       res.status(500).json({ error: "数据库查询失败" }); 
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




//进行表格模块的路由文件的设计
//在当前需要对Mysql数据库进行操作的文件中提前引入Mysql数据库的配置文件--需要注意的是indexNode文件中的其他引入的组件文件只是对indexNode本身编写的时候进行约束的文件
import Config1 from "../indexNode2.js";//此处获取到数据库链接配置对象
import Config2 from "../indexNode1.js";//此处获取到数据库链接配置对象
let connection2;//定义数据库连接对象
let connection1;//定义数据库连接对象
import Router from "koa-router";
const Router2 = new Router();


(async ()=>{
  try{
    //异步执行Config，用于连接数据库,后续可对connection数据库链接对象进行数据库语法操作用于对数据库本身进行操作
    connection2 = await Config1();
    connection1 = await Config2();
    console.log("数据库2连接成功");
    console.log("数据库1连接成功");
  }
  catch(error){
    console.log("数据库2连接失败");
    console.log("数据库1连接失败");
  }
})();
// 不需要分页的路由
Router2.get("/t_device/first", async ctx => {
  try {
      let query;
      // 处理 undefined 情况
      query = "SELECT * FROM t_container ORDER BY ctime DESC";
      // ✅ 使用 `await` 进行查询
      const [results] = await connection2.execute(query);
      // 格式化数据
      const formattedResults = results.map(row => [
          row.PID,
          row.VID,
          row.ctime
      ]);
      console.log("rows:"+results);
      ctx.set("Content-Type", "application/json");
      ctx.body = JSON.stringify(formattedResults);
  } 
  catch (error) {
      console.error("查询失败:", error);
  }

  //测试返回一种结果的情况
//   res.send(
//     [
//       [
//         "2021",
//         "异常",
//         "集成装置1",
//         "2025-03-03T09:29:47.000Z"
//       ]
//     ]
//   );
});

// 不需要分页的路由--多设备表格
Router2.get("/t_device", async ctx => {
  try {
      let query;
      // 处理 undefined 情况
      query = "SELECT * FROM t_device";
      // ✅ 使用 `await` 进行查询
      const [results] = await connection1.execute(query);
      // 格式化数据
      console.log("rows:"+results);
      ctx.set("Content-Type", "application/json");
      ctx.body = JSON.stringify(formattedResults);
  } 
  catch (error) {
      console.error("查询失败:", error);
  }

  //测试返回一种结果的情况
//   res.send(
//     [
//       [
//         "2021",
//         "异常",
//         "集成装置1",
//         "2025-03-03T09:29:47.000Z"
//       ]
//     ]
//   );
});


export default Router2;

//记得将查询条件中的一定为实时数据进行修改了,所有的数据都可以
//记得在所有的没有使用try包裹的语句添加上try\catch语句用于对start为undefined的情况进行捕获