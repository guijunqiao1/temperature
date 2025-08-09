

//KOA2
import Config from "../indexNode2.js"; // 获取数据库链接配置对象
import Router1 from "koa-router"; // 替换 express 为 koa-router
import { exec } from 'child_process';
import { test_times,gongwei,test } from "./mqtt_server_get.js";
import dayjs from "dayjs"; // 引入提供format使用环境的组件
import WebSocket from "ws";

let connection2; // 数据库连接对象
const Router = new Router1(); // 创建 Koa 路由实例

// 数据库连接（立即执行异步函数）
(async () => {
  try {
    connection2 = await Config();
    console.log("数据库连接成功");
  } catch (error) {
    console.log("数据库连接失败");
  }
})();

//建立最新的websocket链接用于mqtt文件中的变量修改
//全局建立websocket连接，使得告警内容被实时推送到页面的全局
const socket = new WebSocket('ws://localhost:8081');
// 连接成功
socket.onopen = function() {
    console.log('后端WebSocket连接成功');
}; 

// 修改全局test变量
Router.get("/test", async (ctx) => {
  let { d_no,qidong } = ctx.query;
  //后台工位修改
  socket.send(JSON.stringify({
    type: 'data',
    gongwei: d_no
  }));
  //全局测试启动变量赋值
  if(qidong==='yes'){
    socket.send(JSON.stringify({
      type: 'data',
      test: true
    }));
  }
  else{
    console.log("这里接收到了test:false");
    socket.send(JSON.stringify({
      type: 'data',
      test: false
    }));
    //进行相应的次数变量的递增
    if(d_no==='工位1') {
      socket.send(JSON.stringify({
        type: 'data',
        test_times: 0
      }));
    }
    else if(d_no==='工位2') {
      socket.send(JSON.stringify({
        type: 'data',
        test_times: 1
      }));
    }
    else {
      socket.send(JSON.stringify({
        type: 'data',
        test_times: 2
      }));
    }
  }
  ctx.body = 'ok';
});

// 获取到当次的历史数组记录的路由
Router.get("/test_history", async (ctx) => {
  let { start, end, currentPage, pageSize, d_no,times } = ctx.query;
  const [result_now] = await connection2.query(`
    SELECT * 
    FROM t_data
  `);
  // 动态拼接sql依据字符串
  let sql_string = '';
  for (const item in result_now[0]) {
    if (result_now[0][item] !== null && item.includes("field")) {
      const x = item + `,`;
      sql_string += x;
    }
  }
  // 全局sql
  const query = `SELECT d_no,${sql_string} c_time FROM t_data `;
  // 降序sql
  const DESC_query = `ORDER BY c_time DESC`;
  // 页数有效值判断布尔变量 
  const page_boolean = currentPage === "undefined" || pageSize === "undefined" || currentPage === undefined || pageSize === undefined;
  
  // 封装转化为数组的方法
  function toTwoArray(value) {
    console.log("当前的row:");
    console.dir(value);
    // 将数据转换为二维数组格式 
    const formattedRows = value.map((row) => [
      row.d_no,
      row.field1.toString(),
      row.field2.toString(),
      row.field3.toString(),
      row.field4.toString(),
      row.field5.toString(),
      row.field6.toString(),
      row.field7.toString(),
      row.field8.toString(),
      dayjs(row.c_time).format('YYYY-MM-DD HH:mm:ss'), // 已经格式化为ISO 8601标准时间字符串
    ]);
    return formattedRows;
  }
  
  // 封装获取数据格式的方法
  function OFFSET(value1, value2) { // value1:currentPage,value2:pageSize
    return (parseInt(value1) - 1) * parseInt(value2);
  }
  
  function FORMATTIME(value) {
    const formatTime = (timeStr) => new Date(timeStr).toISOString().slice(0, 19).replace('T', ' ');
    return formatTime(value);
  }

  // 全局解构赋值
  const formattedStart = FORMATTIME((start !== "end" && start !== "1") ? start : '2025-06-13 15:51:16');
  const formattedEnd = FORMATTIME((end !== "1") ? end : '2025-06-13 15:51:16');

  // 单向限制sql
  const one_query = `WHERE c_time < "${formattedEnd}"` + (d_no === "null" ? "" : ` AND d_no = "${d_no}"`);
  
  let offset;
  if (page_boolean) { } else {
    offset = OFFSET(currentPage, pageSize);
  }

  // 封装响应结果格式化的方法
  function toMap(value) {
    return value.map((row) => [
      row.d_no,
      row.field1,
      row.field2,
      row.field3,
      row.field4,
      row.field5,
      row.field6,
      row.field7,
      row.field8,
      dayjs(row.c_time).format('YYYY-MM-DD HH:mm:ss'),
    ]);
  }

  // 直接将总的历史记录进行获取
  if (page_boolean) {
    const [rows] = await connection2.execute(query + (d_no === "null" ? "" : ` WHERE d_no="${d_no} "`)+` AND times="${times}" `+DESC_query);
    const formattedRows = toTwoArray(rows);
    ctx.body = JSON.stringify(formattedRows);
  } else {
    const [rows] = await connection2.execute(query + (d_no === "null" ? "" : ` WHERE d_no="${d_no} "`)+` AND times="${times}" `+DESC_query + `
      LIMIT ${parseInt(pageSize)} OFFSET ${offset}`);
    const formattedRows = toTwoArray(rows);
    ctx.body = JSON.stringify(formattedRows);
  }
  // else if (start === "end" && end !== "1") {
  //   if (page_boolean) {
  //     const [rows] = await connection2.execute(query + one_query + DESC_query);
  //     const formattedRows = toTwoArray(rows);
  //     ctx.body = JSON.stringify(formattedRows);
  //   } else {
  //     const [rows] = await connection2.execute(query + one_query + DESC_query + `
  //       LIMIT ${parseInt(pageSize)} OFFSET ${offset}`);
  //     ctx.body = toMap(rows);
  //   }
  // } else {
  //   if (page_boolean) {
  //     const [rows] = await connection2.execute(query + `
  //       WHERE c_time BETWEEN "${formattedStart}" AND "${formattedEnd}"` + (d_no === "null" ? "" : ` AND d_no="${d_no}" `) + DESC_query);
  //     const formattedRows = toTwoArray(rows);
  //     ctx.body = JSON.stringify(formattedRows);
  //   } else {
  //     const [rows] = await connection2.execute(query + `WHERE c_time BETWEEN "${formattedStart}" AND "${formattedEnd}"` + (d_no === "null" ? "" : ` AND d_no="${d_no}" `) + DESC_query + ` LIMIT ${parseInt(pageSize)} OFFSET ${offset}`);
  //     ctx.body = toMap(rows);
  //   }
  // }


});

Router.get("/times",async (ctx)=>{
  const { id } = ctx.query;
  console.log("111111");
  if(id===1||id=='1'){
    ctx.body = test_times[0];
  }
  else if(id===2||id==='2'){
    ctx.body = test_times[1];
  }else{
    ctx.body = test_times[2];
  }
});

Router.get("/Test_array_get",async (ctx)=>{
  ctx.body = test_times;
})

//唤起计算器的路由
Router.get("/open-calculator",async(ctx)=>{
  return new Promise((resolve, reject) => {
    // Windows 系统下的计算器命令
    exec('calc', (error, stdout, stderr) => {
      if (error) {
        console.error(`执行出错: ${error}`);
        ctx.body = { success: false, error: error.message };
      } else {
        ctx.body = { success: true };
      }
      resolve();
    });
  });
})
 


export default Router;
