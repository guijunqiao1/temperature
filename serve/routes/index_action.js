// //用于接受映射数组获取请求的路由文件
// //在当前需要对Mysql数据库进行操作的文件中提前引入Mysql数据库的配置文件--需要注意的是indexNode文件中的其他引入的组件文件只是对indexNode本身编写的时候进行约束的文件
// import Config from "../indexNode2.js";//此处获取到数据库链接配置对象

// let connection;//定义数据库连接对象
// import fs from "fs";
// import Router from "express";
// import path from "path";
// import dayjs from "dayjs";//引入提供format使用环境的组件
// const Router5 = Router();
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
// Router5.get("/action", async (req,res) => {
//   let { start,end,currentPage,pageSize,d_no } = req.query;
//   // 动态获取到字段
//   const [result_now] = await connection.query(`
//     SELECT * 
//     FROM t_behavior_data 
//   `);
//   //动态拼接sql依据字符串
//   let sql_string = '';
//   for(const item in result_now[0]){
//     if(result_now[0][item]!==null&&item.includes("field")){
//       const x = item + `,`;
//       sql_string += x;
//     }
//   }

//   //全局sql
//   const query = `SELECT d_no , ${sql_string } c_time,is_saved,file_type FROM t_behavior_data `;
//   //降序sql
//   const DESC_query = `ORDER BY c_time DESC`;
//   //页数有效值判断布尔变量
//   const page_boolean = (!pageSize || !currentPage || currentPage==="undefined" || pageSize==="undefined"||currentPage===undefined||pageSize===undefined);
//   //封装转化为数组的方法
//   function toTwoArray(value){
//     // 将数据转换为二维数组格式
//     const formattedRows = value.map(row => [
//       row.d_no,
//       row.field1.toString(),  // 确保所有字段为字符串类型
//       row.field2.toString(),  // 确保所有字段为字符串类型
//       dayjs(row.c_time).format('YYYY-MM-DD HH:mm:ss'),  // 已经格式化为ISO 8601标准时间字符串
//       row.is_saved,
//       row.file_type
//     ]);
//     return formattedRows;
//   }
//   //封装获取数据格式的方法
//   function OFFSET(value1,value2){//value1:currentPage,value2:pageSize
//     return (parseInt(value1) - 1) * parseInt(value2);
//   }
//   function FORMATTIME(value){
//     const formatTime = (timeStr) => new Date(timeStr).toISOString().slice(0, 19).replace('T', ' ');
//     return formatTime(value);
//   }
//   //全局解构赋值
//   const formattedStart = FORMATTIME((start!=="end"||start!=="1")?start:'2025-06-13 15:51:16');
//   const formattedEnd = FORMATTIME((end!=="1")?end:'2025-06-13 15:51:16');
//   console.log("formattedStart:"+formattedStart);
//   console.log("formattedEnd:"+formattedEnd);
//   //单向限制sql
//   const one_query = `WHERE c_time < "${formattedEnd}"`+(d_no==="null"?"":` AND d_no = "${d_no}"`);
//   let offset;
//   if(page_boolean){}
//   else{
//     offset = OFFSET(currentPage,pageSize);
//   }
//   //封装响应结果格式化的方法
//   function toMap(value){
//     return value.map(row => [row.d_no, row.field1,row.field2, dayjs(row.c_time).format('YYYY-MM-DD HH:mm:ss') ,row.file_type,row.is_saved])
//   }

//   //直接将总的历史记录进行获取--类似data路由内容，但是返回的数组的格式不同
//   if(start==="1" && end==="1"){//初始的时候的总数据的请求,进行特定的d_no的分页查询数组的返回
//     if(page_boolean){
//       console.log("进入的是第一个");
//       // 执行查询并格式化结果
//       const [rows] = await connection.execute(query+(d_no==="null"?"":` WHERE d_no = "${d_no}" `)+DESC_query);
//       const formattedRows = toTwoArray(rows);
//       // 直接使用 res.send() 返回数据
//       res.send(JSON.stringify(formattedRows));
//     }
//     else{
//       console.log("进入的是第2个");
//       //直接查询
//       const [rows] = await connection.execute(query+(d_no==="null"?"":` WHERE d_no = "${d_no}" `)+DESC_query+`
//         LIMIT ${parseInt(pageSize)} OFFSET ${offset}`);
//       const formattedRows = toTwoArray(rows);
//       // 直接使用 res.send() 返回数据
//       res.send(JSON.stringify(formattedRows));
//     }
//   }
//   else if(start === "end" && end !=="1"){
//     if(page_boolean){
//         //直接查询
//         const [rows] = await connection.execute(query+one_query+DESC_query); 
//         const formattedRows = toTwoArray(rows);
//         // 直接使用 res.send() 返回数据
//         res.send(JSON.stringify(formattedRows));
//     }
//     else{
//       //直接查询
//       const [rows] = await connection.execute(query+one_query+DESC_query+`
//         LIMIT ${parseInt(pageSize)} OFFSET ${offset}
//       `);
//       res.send(toMap(rows));
//     }
//   }
//   else{//change1、分页后的事件的执行--内容获取--需要在start到end的基础上结合currentPage分页以及d_no的指定查询
//     if(page_boolean){
//       //首先将时间格式化同时将页数整数化
//       //直接查询
//       const [rows] = await connection.execute(query+`
//         WHERE c_time BETWEEN "${formattedStart}" AND "${formattedEnd}"` +(d_no==="null"?"":` AND d_no = "${d_no}" `)+DESC_query);
//       const formattedRows = toTwoArray(rows);
//       // 直接使用 res.send() 返回数据
//       res.send(JSON.stringify(formattedRows));
//     }
//     else{
//       //直接查询
//       const [rows] = await connection.execute(query+`WHERE c_time BETWEEN "${formattedStart}" AND "${formattedEnd}"`+(d_no==="null"?"":` AND d_no = "${d_no}" `)+DESC_query+` LIMIT ${parseInt(pageSize)} OFFSET ${offset}
//       `);
//       res.send(toMap(rows));
//     }
//   }

//   //模拟只有一组数据返回的情况
//   // res.send([["2021","11","22","23","61","2019-01-01 15:40","实时数据"]]);

//   //模拟有0组数据返回的情况
//   // res.send([]);
// });
// //表格的呈现路由
// Router5.get("/action_count", async (req,res) => {
//   const {start,end,d_no} = req.query;
//   try{
//     //首先判断是否已经激活了ok
//     if(start==="1" && end==="1"){//初始状态直接算
//       //直接查询
//       const [rows] = await connection.execute(`
//         SELECT COUNT(*) as total 
//         FROM t_behavior_data
//       `+(d_no==="null"?"":`WHERE d_no = "${d_no}"`));
//       // 直接返回数组长度
//       res.send(""+rows[0].total.toString());
//     }
//     else if(start === "end" && end !=="1"){
//       //格式化时间值
//       const formatTime = (timeStr) => new Date(timeStr).toISOString().slice(0, 19).replace('T', ' ');
//       const formattedEnd = formatTime(end);
//       //直接查询
//       const [rows] = await connection.execute(`
//         SELECT COUNT(*) as total 
//         FROM t_behavior_data 
//         WHERE c_time < "${formattedEnd}"
      
//       `+(d_no==="null"?"":`AND d_no = "${d_no}"`));
//       // 直接返回数组长度
//       res.send(""+rows[0].total.toString());
//     }
//     else {//进行分页查询后计算大小
//       console.log("start:"+start);
//       console.log("end:"+end);
//       console.log("d_no"+d_no);
//       //格式化时间值
//       const formatTime = (timeStr) => new Date(timeStr).toISOString().slice(0, 19).replace('T', ' ');
//       const formattedStart = formatTime(start);
//       const formattedEnd = formatTime(end);
//       //直接查询
//       const [rows] = await connection.execute(`
//         SELECT COUNT(*) as total  
//         FROM t_behavior_data 
//         WHERE c_time BETWEEN "${formattedStart}" AND "${formattedEnd}"
//       `+(d_no==="null"?"":` AND d_no="${d_no}" `));
//       // 直接返回数组长度
//       res.send(""+rows[0].total.toString());
//     }
//   }
//   catch{
//     console.log("History："+start);
//     console.log("History："+end);
//     console.log("History："+d_no);
//   }
//   //模拟只有一组数据的情况
//   // res.send("1");

//   //模拟有0组数据返回的情况
//   // res.send("0"); 
// });

// Router5.get("/data/action", async (req,res) => {//对data路由进行修改并且接纳上start和end，若接受失败则进行总的数据的返回
//   const { start,end,d_no } = req.query;
//   //动态获取到filed字段
//   const [result_now] = await connection.query(`
//     SELECT * 
//     FROM t_behavior_data
//   `);
//   //动态拼接sql依据字符串
//   let sql_string = '';
//   for(const item in result_now[0]){
//     if(result_now[0][item]!==null&&item.includes("field")){
//       const x = `'"', ` + item + `, '",', `;
//       sql_string += x;
//     }
//   }
//   let query;

//   if(!d_no){
//     //全局sql
//     query = `SELECT d_no, 
//           GROUP_CONCAT(
//             CONCAT('[', `
//             +sql_string+
//             `'"', c_time, '",', 
//             '"', file_type, '"', 
//             ']') ORDER BY c_time
//           ) AS data
//         FROM t_behavior_data
//         WHERE is_saved = '实时数据'`;
//   }else{
//     //全局sql
//     query = `SELECT d_no, 
//           GROUP_CONCAT(
//             CONCAT('[', `
//             +sql_string+
//             `'"', c_time, '",', 
//             '"', file_type, '"', 
//             ']') ORDER BY c_time
//           ) AS data
//         FROM t_behavior_data
//         WHERE is_saved = '实时数据'
//         AND d_no = "${d_no}"`;
//   }


//   function FORMATTIME(value){
//     const formatTime = (timeStr) => new Date(timeStr).toISOString().slice(0, 19).replace('T', ' ');
//     return formatTime(value);
//   }
//   //按照d_no分组-sql
//   const groupbyd_no = `GROUP BY d_no`;
//   //扩容sql方法
//   async function toBig(){
//     await connection.query("SET SESSION group_concat_max_len = 1000000");
//   };
//   //全局解构赋值
//   const formattedStart = FORMATTIME((start!=="end"||start!=="1")?start:'2025-06-13 15:51:16');
//   const formattedEnd = FORMATTIME((end!=="1")?end:'2025-06-13 15:51:16');
//   //封装处理查询结果
//   function search_result(value){
//     const formattedResult = [];
//     value.forEach(row => {
//       if (!row.data) return;
//       const fixedData = `[${row.data}]`;
//       const data = JSON.parse(fixedData); // 解析 JSON 数据
//       data.forEach(entry => {
//         formattedResult.push([row.d_no, entry[0], entry[1], entry[2],entry[3]]);
//       });
//     });
//     return formattedResult;
//   }

//   //全局查询结果变量
//   let formattedResult;

//   toBig();
//   if(start==="1"&&end==="1"){//当需要的是总的数据的时候
//     const [results] = await connection.query(query+groupbyd_no);
//     // 处理查询结果
//     formattedResult = search_result(results);
//   }
//   else if(start === "end" && end !=="1"){
//     const [results] = await connection.query(query+`
//       AND c_time < "${formattedEnd}"
//     `+groupbyd_no);
//     // 处理查询结果
//     formattedResult = search_result(results);
//   }
//   else{
//     const [results] = await connection.query(query+`
//       AND c_time BETWEEN "${formattedStart}" AND "${formattedEnd}"
//     `+groupbyd_no);
//     // 处理查询结果
//     formattedResult = search_result(results);
//   }

//   res.send(formattedResult);


//   //模拟只返回一组数据的情况
//   // res.send([["2021","11","22","23","61","2019-01-01 15:40","实时数据"]]);

//   //模拟返回0组数据的情况
//   // res.send([]);
// });

// export default Router5;
 

//KOA2
import Config from "../indexNode2.js";
let connection;
import fs from "fs";
import Router from "koa-router";
import path from "path";
import dayjs from "dayjs";
const Router5 = new Router();

(async () => {
  try {
    connection = await Config();
    console.log("数据库5连接成功");
  } catch (error) {
    console.log("数据库5连接失败");
  }
})();

Router5.get("/action", async (ctx) => {
  let { start, end, currentPage, pageSize, d_no } = ctx.query;
  const [result_now] = await connection.query(`
    SELECT * 
    FROM t_behavior_data
  `);
  let sql_string = '';
  for (const item in result_now[0]) {
    if (result_now[0][item] !== null && item.includes("field")) {
      const x = item + `,`;
      sql_string += x;
    }
  }
  const query = `SELECT d_no , ${sql_string} c_time,is_saved,file_type FROM t_behavior_data `;
  const DESC_query = `ORDER BY c_time DESC`;
  const page_boolean = (!pageSize || !currentPage || currentPage === "undefined" || pageSize === "undefined" || currentPage === undefined || pageSize === undefined);

  function toTwoArray(value) {
    const formattedRows = value.map(row => [
      row.d_no,
      row.field1.toString(),
      row.field2.toString(),
      dayjs(row.c_time).format('YYYY-MM-DD HH:mm:ss'),
      row.is_saved,
      row.file_type,
    ]);
    return formattedRows;
  }

  function OFFSET(value1, value2) {
    return (parseInt(value1) - 1) * parseInt(value2);
  }

  function FORMATTIME(value) {
    const formatTime = (timeStr) => new Date(timeStr).toISOString().slice(0, 19).replace('T', ' ');
    return formatTime(value);
  }

  const formattedStart = FORMATTIME((start !== "end" || start !== "1") ? start : '2025-06-13 15:51:16');
  const formattedEnd = FORMATTIME((end !== "1") ? end : '2025-06-13 15:51:16');

  const one_query = `WHERE c_time < "${formattedEnd}"` + (d_no === "null" ? "" : ` AND d_no = "${d_no}"`);
  let offset;
  if (!page_boolean) {
    offset = OFFSET(currentPage, pageSize);
  }

  function toMap(value) {
    return value.map(row => [row.d_no, row.field1, row.field2, dayjs(row.c_time).format('YYYY-MM-DD HH:mm:ss'), row.file_type, row.is_saved]);
  }

  if (start === "1" && end === "1") {
    if (page_boolean) {
      const [rows] = await connection.execute(query + (d_no === "null" ? "" : ` WHERE d_no = "${d_no}" `) + DESC_query);
      const formattedRows = toTwoArray(rows);
      ctx.body = JSON.stringify(formattedRows);
    } else {
      const [rows] = await connection.execute(query + (d_no === "null" ? "" : ` WHERE d_no = "${d_no}" `) + DESC_query + `
        LIMIT ${parseInt(pageSize)} OFFSET ${offset}`);
      const formattedRows = toTwoArray(rows);
      ctx.body = JSON.stringify(formattedRows);
    }
  } else if (start === "end" && end !== "1") {
    if (page_boolean) {
      const [rows] = await connection.execute(query + one_query + DESC_query);
      const formattedRows = toTwoArray(rows);
      ctx.body = JSON.stringify(formattedRows);
    } else {
      const [rows] = await connection.execute(query + one_query + DESC_query + `
        LIMIT ${parseInt(pageSize)} OFFSET ${offset}
      `);
      ctx.body = toMap(rows);
    }
  } else {
    if (page_boolean) {
      const [rows] = await connection.execute(query + `
        WHERE c_time BETWEEN "${formattedStart}" AND "${formattedEnd}"` + (d_no === "null" ? "" : ` AND d_no = "${d_no}" `) + DESC_query);
      const formattedRows = toTwoArray(rows);
      ctx.body = JSON.stringify(formattedRows);
    } else {
      const [rows] = await connection.execute(query + `WHERE c_time BETWEEN "${formattedStart}" AND "${formattedEnd}"` + (d_no === "null" ? "" : ` AND d_no = "${d_no}" `) + DESC_query + ` LIMIT ${parseInt(pageSize)} OFFSET ${offset}`);
      ctx.body = toMap(rows);
    }
  }
});

Router5.get("/action_count", async (ctx) => {
  const { start, end, d_no } = ctx.query;
  try {
    if (start === "1" && end === "1") {
      const [rows] = await connection.execute(`
        SELECT COUNT(*) as total 
        FROM t_behavior_data
      ` + (d_no === "null" ? "" : `WHERE d_no = "${d_no}"`));
      ctx.body = "" + rows[0].total.toString();
    } else if (start === "end" && end !== "1") {
      const formatTime = (timeStr) => new Date(timeStr).toISOString().slice(0, 19).replace('T', ' ');
      const formattedEnd = formatTime(end);
      const [rows] = await connection.execute(`
        SELECT COUNT(*) as total 
        FROM t_behavior_data 
        WHERE c_time < "${formattedEnd}"
      ` + (d_no === "null" ? "" : `AND d_no = "${d_no}"`));
      ctx.body = "" + rows[0].total.toString();
    } else {
      const formatTime = (timeStr) => new Date(timeStr).toISOString().slice(0, 19).replace('T', ' ');
      const formattedStart = formatTime(start);
      const formattedEnd = formatTime(end);
      const [rows] = await connection.execute(`
        SELECT COUNT(*) as total  
        FROM t_behavior_data 
        WHERE c_time BETWEEN "${formattedStart}" AND "${formattedEnd}"
      ` + (d_no === "null" ? "" : ` AND d_no="${d_no}" `));
      ctx.body = "" + rows[0].total.toString();
    }
  } catch {
    console.log("History：" + start);
    console.log("History：" + end);
    console.log("History：" + d_no);
  }
});

Router5.get("/data/action", async (ctx) => {
  const { start, end, currentPage, pageSize, d_no } = ctx.query;
  const page_boolean = (!pageSize || !currentPage || currentPage === "undefined" || pageSize === "undefined" || currentPage === undefined || pageSize === undefined);

  // 首先不分页获取所有符合条件的数据
  const [result_now] = await connection.query(`
    SELECT * 
    FROM t_behavior_data
    LIMIT 1
  `);
  
  let sql_string = '';
  for (const item in result_now[0]) {
    if (result_now[0][item] !== null && item.includes("field")) {
      const x = `'"', ` + item + `, '",', `;
      sql_string += x;
    }
  }
  
  let query;
  if (!d_no) {
    query = `SELECT d_no, 
      GROUP_CONCAT(
        CONCAT('[', `
      + sql_string +
      `'"', c_time, '",', 
        '"', file_type, '",',
        '"', confidence, '"',
        ']') ORDER BY c_time
      ) AS data
      FROM t_behavior_data
      WHERE is_saved = '实时数据'`;
  } else {
    query = `SELECT d_no, 
      GROUP_CONCAT(
        CONCAT('[', `
      + sql_string +
      `'"', c_time, '",', 
        '"', file_type, '",',
        '"', confidence, '"',
        ']') ORDER BY c_time
      ) AS data
      FROM t_behavior_data
      WHERE is_saved = '实时数据'
      AND d_no = "${d_no}"`;
  }

  function FORMATTIME(value) {
    const formatTime = (timeStr) => new Date(timeStr).toISOString().slice(0, 19).replace('T', ' ');
    return formatTime(value);
  }

  const groupbyd_no = `GROUP BY d_no`;

  await connection.query("SET SESSION group_concat_max_len = 1000000");

  const formattedStart = FORMATTIME((start !== "end" && start !== "1") ? start : '2025-06-13 15:51:16');
  const formattedEnd = FORMATTIME((end !== "1") ? end : '2025-06-13 15:51:16');

  function search_result(value) {
    const formattedResult = [];
    value.forEach(row => {
      if (!row.data) return;
      const fixedData = `[${row.data}]`;
      const data = JSON.parse(fixedData);
      data.forEach(entry => {
        formattedResult.push([row.d_no, entry[0], entry[1], entry[2], entry[3], entry[4]]);
      });
    });
    return formattedResult;
  }

  let formattedResult;
  let finalResult;

  // 根据条件构建查询
  if (start === "1" && end === "1") {
    const [results] = await connection.query(query + groupbyd_no);
    formattedResult = search_result(results);
  } else if (start === "end" && end !== "1") {
    const [results] = await connection.query(query + `
      AND c_time < "${formattedEnd}"
    ` + groupbyd_no);
    formattedResult = search_result(results);
  } else {
    const [results] = await connection.query(query + `
      AND c_time BETWEEN "${formattedStart}" AND "${formattedEnd}"
    ` + groupbyd_no);
    formattedResult = search_result(results);
  }

  // 在展开后的数据上应用分页
  if (!page_boolean) {
    const startIndex = (parseInt(currentPage) - 1) * parseInt(pageSize);
    const endIndex = startIndex + parseInt(pageSize);
    finalResult = formattedResult.slice(startIndex, endIndex);
  } else {
    finalResult = formattedResult;
  }

  ctx.body = finalResult;
});


export default Router5;
