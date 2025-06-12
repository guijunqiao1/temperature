
// //用于接受映射数组获取请求的路由文件
// import express from "express";
// //在当前需要对Mysql数据库进行操作的文件中提前引入Mysql数据库的配置文件--需要注意的是indexNode文件中的其他引入的组件文件只是对indexNode本身编写的时候进行约束的文件
// import Config from "../indexNode1.js";//此处获取到数据库链接配置对象
// let connection;//定义数据库连接对象
// const Router_alarm = express();
// (async ()=>{
//   try{
//     //异步执行Config，用于连接数据库,后续可对connection数据库链接对象进行数据库语法操作用于对数据库本身进行操作
//     connection = await Config();
//     console.log("数据库5连接成功");
//   }
//   catch(error){
//     console.log("数据库5连接失败");
//   }
// })();

// //表格的呈现-图像的呈现路由
// Router_alarm.get("/alarm",async(req,res)=>{
//   try{
//     await connection.query("SET SESSION group_concat_max_len = 1000000");
//     const [results] = await connection.query(`
//       WITH latest_time_per_dno AS (
//           SELECT d_no, MAX(c_time) AS max_time 
//           FROM t_data 
//           GROUP BY d_no
//       )
//       SELECT 
//           t.d_no, 
//           GROUP_CONCAT(
//               CONCAT('[', 
//                      '"', t.field1, '"', ',', 
//                      '"', t.field2, '"', ',', 
//                      '"', t.field3, '"', ',', 
//                      '"', t.field4, '"', ',', 
//                      '"', t.c_time, '"', 
//               ']') ORDER BY t.c_time
//           ) AS data
//       FROM t_data t
//       JOIN latest_time_per_dno l 
//         ON t.d_no = l.d_no
//         WHERE t.c_time BETWEEN (l.max_time - INTERVAL 5 MINUTE) AND l.max_time
//       GROUP BY t.d_no;
//     `);

//     const formattedResult = results.map(row => {
//       try {
//         if (!row.data) return [row.d_no, []];
    
//         const fixedData = `[${row.data}]`;
//         let data = JSON.parse(fixedData);
    
//         // 遍历 data 数组，修改 c_time 格式（去掉秒数）
//         data = data.map(entry => {
//           return entry;
//         });
    
//         return [row.d_no, data];
//       } catch (error) {
//         console.error(`JSON 解析失败: ${row.data}`, error);
//         return [row.d_no, []];
//       }
//     });
//     //允许所有的来源
//     res.setHeader("Access-Control-Allow-Origin", "*");
//     res.send(formattedResult);
//   }
//   catch(error){
//     console.log(error);
//   }
// })  
// export default Router_alarm;



//用于接受映射数组获取请求的路由文件
import Router from "koa-router";
const Router_alarm = new Router();

//在当前需要对Mysql数据库进行操作的文件中提前引入Mysql数据库的配置文件--需要注意的是indexNode文件中的其他引入的组件文件只是对indexNode本身编写的时候进行约束的文件
import Config from "../indexNode1.js";//此处获取到数据库链接配置对象
let connection;//定义数据库连接对象
(async ()=>{
  try{
    //异步执行Config，用于连接数据库,后续可对connection数据库链接对象进行数据库语法操作用于对数据库本身进行操作
    connection = await Config();
    console.log("数据库5连接成功");
  }
  catch(error){
    console.log("数据库5连接失败");
  }
})();

//表格的呈现-图像的呈现路由
Router_alarm.get("/alarm",async ctx=>{
  try{
    await connection.query("SET SESSION group_concat_max_len = 1000000");
    const [results] = await connection.query(`
      WITH latest_time_per_dno AS (
          SELECT d_no, MAX(c_time) AS max_time 
          FROM t_data 
          GROUP BY d_no
      )
      SELECT 
          t.d_no, 
          GROUP_CONCAT(
              CONCAT('[', 
                     '"', t.field1, '"', ',', 
                     '"', t.field2, '"', ',', 
                     '"', t.field3, '"', ',', 
                     '"', t.field4, '"', ',', 
                     '"', t.c_time, '"', 
              ']') ORDER BY t.c_time
          ) AS data
      FROM t_data t
      JOIN latest_time_per_dno l 
        ON t.d_no = l.d_no
        WHERE t.c_time BETWEEN (l.max_time - INTERVAL 5 MINUTE) AND l.max_time
      GROUP BY t.d_no;
    `);

    const formattedResult = results.map(row => {
      try {
        if (!row.data) return [row.d_no, []];
    
        const fixedData = `[${row.data}]`;
        let data = JSON.parse(fixedData);
    
        // 遍历 data 数组，修改 c_time 格式（去掉秒数）
        data = data.map(entry => {
          return entry;
        });
    
        return [row.d_no, data];
      } catch (error) {
        console.error(`JSON 解析失败: ${row.data}`, error);
        return [row.d_no, []];
      }
    });
    //允许所有的来源
    ctx.set("Access-Control-Allow-Origin", "*");
    ctx.body = formattedResult;
  }
  catch(error){
    console.log(error);
  }
})  
export default Router_alarm;
