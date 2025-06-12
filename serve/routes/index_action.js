// //用于接受映射数组获取请求的路由文件
// import express from "express";
// //在当前需要对Mysql数据库进行操作的文件中提前引入Mysql数据库的配置文件--需要注意的是indexNode文件中的其他引入的组件文件只是对indexNode本身编写的时候进行约束的文件
// import Config from "../indexNode2.js";//此处获取到数据库链接配置对象

// let connection;//定义数据库连接对象
// const Router5 = express();
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
// Router5.get("/action",async(req,res)=>{
//   const { person,start_time,book_id,currentPage,pageSize } = req.query;
//   try{
//     const offset = (parseInt(currentPage) - 1) * parseInt(pageSize);
//     let query = `
//       SELECT *
//       FROM t_behavior_data
//       `;
//     if(!person&&!start_time&&!book_id){
//       query+=`
//       ORDER BY c_time
//       LIMIT ${parseInt(pageSize)} OFFSET ${offset}
//       `;
//       const [rows] = await connection.execute(query);
//       res.send(rows);
//       return;
//     }
//     else {//该分支下的！+变量为true的情况需要忽略当前维度
//       //格式化时间方法
//       const formatTime = (timeStr) => {
//         // 检查timeStr是否为"undefined"字符串或无效值
//         if (!timeStr || timeStr === "undefined") {
//           return null;
//         }
//         return new Date(timeStr).toISOString().slice(0, 19).replace('T', ' ');
//       };
      
//       // 检查参数是否为"undefined"字符串
//       const isPerson = person && person !== "undefined";
//       const isBookId = book_id && book_id !== "undefined";
//       const isStartTime = start_time && start_time !== "undefined";
      
//       // 格式化开始时间，只有在有效时才格式化
//       const formattedStartTime = isStartTime ? formatTime(start_time) : null;
      
//       query += `
//       WHERE field2 ${!isPerson ? '!= "此为非法值"' : '= "' + person + '"'}
//       AND d_no ${!isBookId ? '!= "此为非法值"' : '= "' + book_id + '"'}
//       AND c_time ${!isStartTime ? '!= "2005-03-03 17:29:47"' : '> "' + formattedStartTime + '"'}
//       ORDER BY c_time
//       LIMIT ${parseInt(pageSize)} OFFSET ${offset}
//       `;
//       const [rows] = await connection.execute(query);
//       res.send(rows);
//       return;
//     }
//   }
//   catch(error){
//     console.log(error);
//   }


//   //模拟只有一组数据的情况 
//   // res.send([["2021","11","22","23","61","2019-01-01 15:40","实时数据"]]);

//   //模拟有0组数据返回的情况
//   // res.send([]);
// })  
// //表格的呈现路由
// Router5.get("/action_count",async(req,res)=>{
//   const { person,start_time,book_id,all } = req.query;
//   try{
//     let query = `
//       SELECT *
//       FROM t_behavior_data
//       `;
//     if(!person&&!start_time&&!book_id){  
//       const [rows] = await connection.execute(query);
//       res.send(!all? ""+rows.length:rows);
//       return;
//     }
//     else {//该分支下的！+变量为true的情况需要忽略当前维度
//       //格式化时间方法
//       const formatTime = (timeStr) => {
//         // 检查timeStr是否为"undefined"字符串或无效值
//         if (!timeStr || timeStr === "undefined") {
//           return null;
//         }
//         return new Date(timeStr).toISOString().slice(0, 19).replace('T', ' ');
//       };
      
//       // 检查参数是否为"undefined"字符串
//       const isPerson = person && person !== "undefined";
//       const isBookId = book_id && book_id !== "undefined";
//       const isStartTime = start_time && start_time !== "undefined";
      
//       // 格式化开始时间，只有在有效时才格式化
//       const formattedStartTime = isStartTime ? formatTime(start_time) : null;
      
//       query += `
//         WHERE field2 ${!isPerson ? '!= "此为非法值"' : '= "' + person + '"'}
//         AND d_no ${!isBookId ? '!= "此为非法值"' : '= "' + book_id + '"'}
//         AND c_time ${!isStartTime ? '!= "2005-03-03 17:29:47"' : '> "' + formattedStartTime + '"'}
//         ORDER BY c_time
//       `;
//       const [rows] = await connection.execute(query);
//       res.send(!all? ""+rows.length:rows);
//       return;
//     }
//   }
//   catch(error){
//     console.log(error);
//   }


//   // 模拟只有一组数据的情况
//   // res.send("1");

//   //模拟有0组数据返回的情况
//   // res.send("0");
// })

// export default Router5;



//用于接受映射数组获取请求的路由文件
//在当前需要对Mysql数据库进行操作的文件中提前引入Mysql数据库的配置文件--需要注意的是indexNode文件中的其他引入的组件文件只是对indexNode本身编写的时候进行约束的文件
import Config from "../indexNode2.js";//此处获取到数据库链接配置对象

let connection;//定义数据库连接对象
import Router from "koa-router";
const Router5 = new Router();
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
Router5.get("/action",async ctx=>{
  const { person,start_time,book_id,currentPage,pageSize } = ctx.query;
  try{
    const offset = (parseInt(currentPage) - 1) * parseInt(pageSize);
    let query = `
      SELECT *
      FROM t_behavior_data
      `;
    if(!person&&!start_time&&!book_id){
      query+=`
      ORDER BY c_time
      LIMIT ${parseInt(pageSize)} OFFSET ${offset}
      `;
      const [rows] = await connection.execute(query);
      ctx.body = rows;
      return;
    }
    else {//该分支下的！+变量为true的情况需要忽略当前维度
      //格式化时间方法
      const formatTime = (timeStr) => {
        // 检查timeStr是否为"undefined"字符串或无效值
        if (!timeStr || timeStr === "undefined") {
          return null;
        }
        return new Date(timeStr).toISOString().slice(0, 19).replace('T', ' ');
      };
      
      // 检查参数是否为"undefined"字符串
      const isPerson = person && person !== "undefined";
      const isBookId = book_id && book_id !== "undefined";
      const isStartTime = start_time && start_time !== "undefined";
      
      // 格式化开始时间，只有在有效时才格式化
      const formattedStartTime = isStartTime ? formatTime(start_time) : null;
      
      query += `
      WHERE field2 ${!isPerson ? '!= "此为非法值"' : '= "' + person + '"'}
      AND d_no ${!isBookId ? '!= "此为非法值"' : '= "' + book_id + '"'}
      AND c_time ${!isStartTime ? '!= "2005-03-03 17:29:47"' : '> "' + formattedStartTime + '"'}
      ORDER BY c_time
      LIMIT ${parseInt(pageSize)} OFFSET ${offset}
      `;
      const [rows] = await connection.execute(query);
      ctx.body = rows;
      return;
    }
  }
  catch(error){
    console.log(error);
  }


  //模拟只有一组数据的情况 
  // res.send([["2021","11","22","23","61","2019-01-01 15:40","实时数据"]]);

  //模拟有0组数据返回的情况
  // res.send([]);
})  
//表格的呈现路由
Router5.get("/action_count",async ctx=>{
  const { person,start_time,book_id,all } = ctx.query;
  try{
    let query = `
      SELECT *
      FROM t_behavior_data
      `;
    if(!person&&!start_time&&!book_id){  
      const [rows] = await connection.execute(query);
      ctx.body = !all? ""+rows.length:rows;
      return;
    }
    else {//该分支下的！+变量为true的情况需要忽略当前维度
      //格式化时间方法
      const formatTime = (timeStr) => {
        // 检查timeStr是否为"undefined"字符串或无效值
        if (!timeStr || timeStr === "undefined") {
          return null;
        }
        return new Date(timeStr).toISOString().slice(0, 19).replace('T', ' ');
      };
      
      // 检查参数是否为"undefined"字符串
      const isPerson = person && person !== "undefined";
      const isBookId = book_id && book_id !== "undefined";
      const isStartTime = start_time && start_time !== "undefined";
      
      // 格式化开始时间，只有在有效时才格式化
      const formattedStartTime = isStartTime ? formatTime(start_time) : null;
      
      query += `
        WHERE field2 ${!isPerson ? '!= "此为非法值"' : '= "' + person + '"'}
        AND d_no ${!isBookId ? '!= "此为非法值"' : '= "' + book_id + '"'}
        AND c_time ${!isStartTime ? '!= "2005-03-03 17:29:47"' : '> "' + formattedStartTime + '"'}
        ORDER BY c_time
      `;
      const [rows] = await connection.execute(query);
      ctx.body = !all? ""+rows.length:rows;
      return;
    }
  }
  catch(error){
    console.log(error);
  }


  // 模拟只有一组数据的情况
  // res.send("1");

  //模拟有0组数据返回的情况
  // res.send("0");
})

export default Router5;
