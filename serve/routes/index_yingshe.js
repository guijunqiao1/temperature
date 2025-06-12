// //用于接受映射数组获取请求的路由文件
// import express from "express";
// //在当前需要对Mysql数据库进行操作的文件中提前引入Mysql数据库的配置文件--需要注意的是indexNode文件中的其他引入的组件文件只是对indexNode本身编写的时候进行约束的文件
// import Config1 from "../indexNode2.js";//此处获取到数据库链接配置对象
// let connection2;//定义数据库连接对象
// const Router1 = express();
// (async ()=>{
//   try{
//     //异步执行Config，用于连接数据库,后续可对connection数据库链接对象进行数据库语法操作用于对数据库本身进行操作
//     connection2 = await Config1();
//     console.log("数据库1连接成功");
//   }
//   catch(error){
//     console.log("数据库1连接失败"); 
//   }
// })();

// Router1.get("/yingshe", async (req, res) => {
//   console.log("123");
//   let dbResult = await connection2.execute(`
//     SELECT db_name, f_name FROM t_field_mapper;
//   `);
//   dbResult = dbResult[0];

//   const objectArray = dbResult.map(row => {
//     return { [row.db_name]: row.f_name };
//   });

//   console.log("yinghse" + objectArray);
//   res.send(objectArray);
// });
// //行为映射表
// Router1.get("/yingshe/action",async(req,res)=>{
//   console.log("123");
//   let dbResult = await connection2.execute(`
//     SELECT db_name, f_name FROM t_behavior_field_mapper;
//   `);
//   dbResult = dbResult[0];

//   const objectArray = dbResult.map(row => {
//     return { [row.db_name]: row.f_name };
//   });

//   console.log("yingshe/action" + objectArray);
//   res.send(objectArray);
// });

// Router1.get("/guijunqiao",async(req,res)=>{
//   let [rows] = await connection2.execute(`
//     SELECT p_name FROM t_field_mapper;
//   `);
//   res.send(rows);
// })

// export default Router1;



//在当前需要对Mysql数据库进行操作的文件中提前引入Mysql数据库的配置文件--需要注意的是indexNode文件中的其他引入的组件文件只是对indexNode本身编写的时候进行约束的文件
import Config1 from "../indexNode2.js";//此处获取到数据库链接配置对象
let connection2;//定义数据库连接对象
import Router from "koa-router";
const Router1 = new Router();
(async ()=>{
  try{
    //异步执行Config，用于连接数据库,后续可对connection数据库链接对象进行数据库语法操作用于对数据库本身进行操作
    connection2 = await Config1();
    console.log("数据库1连接成功");
  }
  catch(error){
    console.log("数据库1连接失败"); 
  }
})();

Router1.get("/yingshe", async  ctx => {
  console.log("123");
  let dbResult = await connection2.execute(`
    SELECT db_name, f_name FROM t_field_mapper;
  `);
  dbResult = dbResult[0];

  const objectArray = dbResult.map(row => {
    return { [row.db_name]: row.f_name };
  });

  console.log("yinghse" + objectArray);
  ctx.body = objectArray;
});
//行为映射表
Router1.get("/yingshe/action",async ctx=>{
  console.log("123");
  let dbResult = await connection2.execute(`
    SELECT db_name, f_name FROM t_behavior_field_mapper;
  `);
  dbResult = dbResult[0];

  const objectArray = dbResult.map(row => {
    return { [row.db_name]: row.f_name };
  });

  console.log("yingshe/action" + objectArray);
  ctx.body = objectArray;
});

Router1.get("/guijunqiao",async ctx=>{
  let [rows] = await connection2.execute(`
    SELECT p_name FROM t_field_mapper;
  `);
  ctx.body = rows;
})

export default Router1;
