
//进行图像信息提供的路由文件
//在当前需要对Mysql数据库进行操作的文件中提前引入Mysql数据库的配置文件--需要注意的是indexNode文件中的其他引入的组件文件只是对indexNode本身编写的时候进行约束的文件
import Config3 from "../indexNode2.js";//此处获取到数据库链接配置对象
let connection1;//定义数据库连接对象
import Router from "koa-router";
const Router3 = new Router();
(async ()=>{
  try{
    //异步执行Config，用于连接数据库,后续可对connection数据库链接对象进行数据库语法操作用于对数据库本身进行操作
    connection1 = await Config3();
    console.log("数据库3连接成功");
  }
  catch(error){
    console.log("数据库3连接失败");
    
  }
})();

// 需要分页的路由
Router3.get("/t_error_msg/first", async ctx => {
  try {
      let { currentPage, pageSize } = ctx.query;
      let { start,end } = ctx.query;
      // 处理 undefined 情况
      if (currentPage === "undefined") {
        if(start === "1"&&end==="1"){//全局查询
          const query = "SELECT e_msg,c_time FROM t_error_history";
          // ✅ 使用 `await` 进行查询
          const [results] = await connection1.execute(query);
          // 格式化数据
          const formattedResults = results.map(row => [
              row.e_msg,
              row.c_time
          ]);
          ctx.set("Content-Type", "application/json");
          ctx.body = JSON.stringify(formattedResults);
        }
        else if(start === "end"&&end!=="1"){//单向查询
          const formatTime = (timeStr) => new Date(timeStr).toISOString().slice(0, 19).replace('T', ' ');
          const formattedEnd = formatTime(end);

          const query = `SELECT e_msg, c_time FROM t_error_history WHERE c_time < '${formattedEnd}'`;
          // ✅ 使用 `await` 进行查询
          const [results] = await connection1.execute(query);
          // 格式化数据
          const formattedResults = results.map(row => [
              row.e_msg,
              row.c_time
          ]);
          ctx.set("Content-Type", "application/json");
          ctx.body = JSON.stringify(formattedResults);
        } 
        else{//区间查询
          // 将时间值进行转化
          const formatTime = (timeStr) => new Date(timeStr).toISOString().slice(0, 19).replace('T', ' ');
          const formattedStart = formatTime(start);
          const formattedEnd = formatTime(end);
          console.log("桂start:"+start);
          console.log("桂end:"+end);
          
          const query = `SELECT e_msg, c_time FROM t_error_history WHERE c_time BETWEEN '${formattedStart}' AND '${formattedEnd}'`;
          // ✅ 使用 `await` 进行查询
          const [results] = await connection1.execute(query);
          // 格式化数据
          const formattedResults = results.map(row => [
              row.e_msg,
              row.c_time
          ]);
          ctx.set("Content-Type", "application/json");
          ctx.body = JSON.stringify(formattedResults);
        }
      } 
      else {
        // ✅ 解析分页参数（确保转换为整数）
        const page = parseInt(currentPage, 10) || 1;
        const size = parseInt(pageSize, 10) || 12;
        const offset = (page - 1) * size;
        console.log("page：" + page);
        console.log("page：" + size);
        console.log("page：" + offset);

        if(start==="1"&&end==="1"){//全局查询
          const [rows] = await connection1.execute(`
            SELECT e_msg,  c_time
            FROM t_error_history 
            LIMIT ${size} OFFSET ${offset}
          `);
          //大多数时候请使用字符串拼接的方式书写分页代码以及其他相关的代码
    
          // 将数据转换为二维数组格式
          const formattedRows = rows.map(row => [
            
              // 确保所有字段为字符串类型
            row.e_msg,
            row.c_time,
          ]);
          // 直接使用 res.send() 返回数据
          ctx.body = JSON.stringify(formattedRows);
        }
        else if(start==="end"&&end!=="1"){//单向查询
          const formatTime = (timeStr) => new Date(timeStr).toISOString().slice(0, 19).replace('T', ' ');
          const formattedEnd = formatTime(end);
          const [rows] = await connection1.execute(`
            SELECT e_msg,  c_time
            FROM t_error_history 
            WHERE c_time < '${formattedEnd}'
            LIMIT ${size} OFFSET ${offset}
          `);
          //大多数时候请使用字符串拼接的方式书写分页代码以及其他相关的代码
    
          // 将数据转换为二维数组格式
          const formattedRows = rows.map(row => [
            row.e_msg,
            row.c_time,
          ]);
          // 直接使用 res.send() 返回数据
          ctx.body = JSON.stringify(formattedRows);
        }
        else {
          const formatTime = (timeStr) => new Date(timeStr).toISOString().slice(0, 19).replace('T', ' ');
          const formattedStart = formatTime(start);
          const formattedEnd = formatTime(end);
          const [rows] = await connection1.execute(`
            SELECT e_msg,  c_time
            FROM t_error_history 
            WHERE c_time BETWEEN '${formattedStart}' AND '${formattedEnd}'
            LIMIT ${size} OFFSET ${offset}
          `);
          //大多数时候请使用字符串拼接的方式书写分页代码以及其他相关的代码
    
          // 将数据转换为二维数组格式
          const formattedRows = rows.map(row => [
              // 确保所有字段为字符串类型
            row.e_msg,
            row.c_time,
          ]);
          ctx.set("Content-Type", "application/json");
          // 直接使用 res.send() 返回数据
          ctx.body = JSON.stringify(formattedRows);
        }
      }
  } 
  catch (error) {
      console.error("查询失败:", error);
      res.status(500).json({ error: "数据库查询失败" });
  }
});
// //根据对应的信息进行查询的路由
Router3.get("/t_error_msg/search",async ctx=>{
  const { d_no,e_msg,currentPage,pageSize } = ctx.query;
  const { start,end } = ctx.query;
  // ✅ 解析分页参数（确保转换为整数）
  const page = parseInt(currentPage, 10) || 1;
  const size = parseInt(pageSize, 10) || 12;
  const offset = (page - 1) * size;
  if(d_no!=="1"&&e_msg==="1"){//当d_no存在而e_msg不存在的时候
    let query;
    if(start==="1"&&end==="1"){
      query = `SELECT e_msg, c_time, type FROM t_error_history WHERE d_no='${d_no}' AND type='${type}' LIMIT ${size} OFFSET ${offset}`;
    }
    else if(start==="end"&&end!=="1"){
      const formatTime = (timeStr) => new Date(timeStr).toISOString().slice(0, 19).replace('T', ' ');
      const formattedEnd = formatTime(end);
      query = `SELECT e_msg, c_time, type FROM t_error_history WHERE d_no='${d_no}' AND type='${type}' AND c_time<'${formattedEnd}' LIMIT ${size} OFFSET ${offset}`;
    }
    else{
      const formatTime = (timeStr) => new Date(timeStr).toISOString().slice(0, 19).replace('T', ' ');
      const formattedStart = formatTime(start);
      const formattedEnd = formatTime(end);
      query = `SELECT e_msg, c_time, type FROM t_error_history WHERE d_no='${d_no}' AND type='${type}' AND c_time BETWEEN '${formattedStart}' AND '${formattedEnd}' LIMIT ${size} OFFSET ${offset}`;
    }
    // ✅ 使用 `await` 进行查询
    const [results] = await connection1.execute(query);
    if(results.length<1){//当查询为空
      
      ctx.body = [];
      return;
    }
    else {
      // 格式化数据
      const formattedResults = results.map(row => [
        
        
        row.e_msg,
        row.c_time
      ]);
      ctx.set("Content-Type", "application/json");
      ctx.body = JSON.stringify(formattedResults);
      return;
    }
  }
  else if(d_no==="1"&&e_msg!=="1"){//当d_no不存在而e_msg存在的时候
    let query;
    if(start==="1"&&end==="1"){
       query = `SELECT e_msg, c_time, type FROM t_error_history WHERE e_msg='${e_msg}' AND type='${type}' LIMIT ${size} OFFSET ${offset}`;
    }
    else if(start==="end"&&end!=="1"){
      const formatTime = (timeStr) => new Date(timeStr).toISOString().slice(0, 19).replace('T', ' ');
      const formattedEnd = formatTime(end);
       query = `SELECT e_msg, c_time, type FROM t_error_history WHERE e_msg='${e_msg}' AND type='${type}' AND c_time<'${formattedEnd}' LIMIT ${size} OFFSET ${offset}`;
    }
    else{
      const formatTime = (timeStr) => new Date(timeStr).toISOString().slice(0, 19).replace('T', ' ');
      const formattedStart = formatTime(start);
      const formattedEnd = formatTime(end);
       query = `SELECT e_msg, c_time, type FROM t_error_history WHERE e_msg='${e_msg}' AND type='${type}' AND c_time BETWEEN '${formattedStart}' AND '${formattedEnd}' LIMIT ${size} OFFSET ${offset}`;
    }
    // ✅ 使用 `await` 进行查询
    const [results] = await connection1.execute(query);
    if(results.length<1){//当查询为空
      ctx.body = [];
      return;
    }
    else {
      // 格式化数据
      const formattedResults = results.map(row => [
        
        
        row.e_msg,
        row.c_time
      ]);
      ctx.set("Content-Type", "application/json");
      ctx.body = JSON.stringify(formattedResults)
      return;
    }
  }
  else if(d_no!=="1"&&e_msg!=="1"){//当d_no和e_msg都存在的时候
    let query;
    if(start==="1"&&end==="1"){
       query = `SELECT e_msg, c_time, type FROM t_error_history WHERE d_no='${d_no}' AND e_msg='${e_msg}' AND type='${type}' LIMIT ${size} OFFSET ${offset}`;

    }
    else if(start==="end"&&end==="1"){
      const formatTime = (timeStr) => new Date(timeStr).toISOString().slice(0, 19).replace('T', ' ');
      const formattedEnd = formatTime(end);
       query = `SELECT e_msg, c_time, type FROM t_error_history WHERE d_no='${d_no}' AND e_msg='${e_msg}' AND type='${type}' AND c_time<'${formattedEnd}' LIMIT ${size} OFFSET ${offset}`;
    }
    else{
      const formatTime = (timeStr) => new Date(timeStr).toISOString().slice(0, 19).replace('T', ' ');
      const formattedStart = formatTime(start);
      const formattedEnd = formatTime(end);
       query = `SELECT e_msg, c_time, type FROM t_error_history WHERE d_no='${d_no}' AND e_msg='${e_msg}' AND type='${type}' AND c_time BETWEEN '${formattedStart}' AND '${formattedEnd}'  LIMIT ${size} OFFSET ${offset}`;
    }
    // ✅ 使用 `await` 进行查询
    const [results] = await connection1.execute(query);
    if(results.length<1){
      ctx.body = [];
      return;
    }
    else {
      // 格式化数据
      const formattedResults = results.map(row => [
        
        
        row.e_msg,
        row.c_time
      ]);
      ctx.set("Content-Type", "application/json");
      ctx.body = JSON.stringify(formattedResults)
      return;
    }

  }
})
// //获取数据库信息总数的路由--未激活查询框的状态
Router3.get("/t_error_msg/count",async ctx=>{
  const { start,end } = ctx.query;
  if(start==="1"&&end==="1"){
    const [rows] = await connection1.execute("SELECT * FROM t_error_history");//将指定的d_no对应的内容总数进行获取
    ctx.body = ""+rows.length;
  }
  else if(start==="end"&&end!=="1"){
    const formatTime = (timeStr) => new Date(timeStr).toISOString().slice(0, 19).replace('T', ' ');
    const formattedEnd = formatTime(end);
    const [rows] = await connection1.execute(`SELECT * FROM t_error_history WHERE c_time<'${formattedEnd}'`);//将指定的d_no对应的内容总数进行获取
    ctx.body = ""+rows.length;
  }
  else{
    const formatTime = (timeStr) => new Date(timeStr).toISOString().slice(0, 19).replace('T', ' ');
    const formattedStart = formatTime(start);
    const formattedEnd = formatTime(end);
    const [rows] = await connection1.execute(`SELECT * FROM t_error_history WHERE c_time BETWEEN '${formattedStart}' AND '${formattedEnd}'`);//将指定的d_no对应的内容总数进行获取
    ctx.body = ""+rows.length;
  }
})


//获取到告警数据
Router3.get("/alarm",async ctx=>{
  let level1= `
  SELECT VStatus
  FROM t_error_msg
  `;
  const [rows_level1] = await connection1.execute(level1);
  console.log("row_level1:");
  console.dir(rows_level1);
  if(rows_level1[0].VStatus!=='0'){
    let query1 = `
    SELECT *
    FROM t_error_msg
    WHERE e_msg != "未发生告警"
    ORDER BY c_time DESC
    `; 
    const [rows] = await connection1.execute(query1);
    ctx.body = rows;
    return;
  }else {
    ctx.body = [{e_msg:"所以设备均正常工作"}];
    return;
  }
})



export default Router3;


//记得将查询条件中的一定为实时数据进行修改了,所有的数据都可以