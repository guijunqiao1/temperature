//KOA2 
import Config4 from "../indexNode2.js"; // 此处获取到数据库链接配置对象
import dayjs from "dayjs"; // 引入提供format使用环境的组件
let connection2; // 定义数据库连接对象
import Router from "koa-router"; // 引入koa-router

const Router4 = new Router(); // 创建新的 Koa 路由对象

(async () => {
  try {
    // 异步执行Config，用于连接数据库, 后续可对connection数据库链接对象进行数据库语法操作用于对数据库本身进行操作
    connection2 = await Config4();
    console.log("数据库4连接成功");
    console.log("test");
  } catch (error) {
    console.log("数据库4连接失败");
  }
})();

// 表格的呈现-图像的呈现路由
Router4.get("/History", async (ctx) => {
  let { start, end, currentPage, pageSize, d_no } = ctx.query;
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
  if (start === "1" && end === "1") {
    if (page_boolean) {
      const [rows] = await connection2.execute(query + (d_no === "null" ? "" : ` WHERE d_no="${d_no} "`)+DESC_query);
      const formattedRows = toTwoArray(rows);
      ctx.body = JSON.stringify(formattedRows);
    } else {
      const [rows] = await connection2.execute(query + (d_no === "null" ? "" : ` WHERE d_no="${d_no} "`)+DESC_query + `
        LIMIT ${parseInt(pageSize)} OFFSET ${offset}`);
      const formattedRows = toTwoArray(rows);
      ctx.body = JSON.stringify(formattedRows);
    }
  }
  else if (start === "end" && end !== "1") {
    if (page_boolean) {
      const [rows] = await connection2.execute(query + one_query + DESC_query);
      const formattedRows = toTwoArray(rows);
      ctx.body = JSON.stringify(formattedRows);
    } else {
      const [rows] = await connection2.execute(query + one_query + DESC_query + `
        LIMIT ${parseInt(pageSize)} OFFSET ${offset}`);
      ctx.body = toMap(rows);
    }
  } else {
    if (page_boolean) {
      const [rows] = await connection2.execute(query + `
        WHERE c_time BETWEEN "${formattedStart}" AND "${formattedEnd}"` + (d_no === "null" ? "" : ` AND d_no="${d_no}" `) + DESC_query);
      const formattedRows = toTwoArray(rows);
      ctx.body = JSON.stringify(formattedRows);
    } else {
      const [rows] = await connection2.execute(query + `WHERE c_time BETWEEN "${formattedStart}" AND "${formattedEnd}"` + (d_no === "null" ? "" : ` AND d_no="${d_no}" `) + DESC_query + ` LIMIT ${parseInt(pageSize)} OFFSET ${offset}`);
      ctx.body = toMap(rows);
    }
  }
});

// 表格的呈现路由
Router4.get("/History_count", async (ctx) => {
  const { start, end, d_no } = ctx.query;
  try {
    if (start === "1" && end === "1") {
      const [rows] = await connection2.execute(`
        SELECT COUNT(*) as total 
        FROM t_data
      ` + (d_no === "null" ? "" : `WHERE d_no = "${d_no}"`));
      ctx.body = "" + rows[0].total.toString();
    } else if (start === "end" && end !== "1") {
      const formattedEnd = FORMATTIME(end);
      const [rows] = await connection2.execute(`
        SELECT COUNT(*) as total 
        FROM t_data 
        WHERE c_time < "${formattedEnd}"
      ` + (d_no === "null" ? "" : `AND d_no = "${d_no}"`));
      ctx.body = "" + rows[0].total.toString();
    } else {
      const formattedStart = FORMATTIME(start);
      const formattedEnd = FORMATTIME(end);
      const [rows] = await connection2.execute(`
        SELECT COUNT(*) as total  
        FROM t_data 
        WHERE c_time BETWEEN "${formattedStart}" AND "${formattedEnd}"` + (d_no === "null" ? "" : `AND d_no="${d_no}" `));
      ctx.body = "" + rows[0].total.toString();
    }
  } catch (error) {
    console.log("History：" + start);
    console.log("History：" + end);
    console.log("History：" + d_no);
  }
});

//设备选项列表相关路由
Router4.get("/data", async (ctx) => {//对data路由进行修改并且接纳上start和end，若接受失败则进行总的数据的返回
  const { start,end } = ctx.query;
  //动态获取到filed字段
  const [result_now] = await connection2.query(`
    SELECT * 
    FROM t_data
  `);
  //动态拼接sql依据字符串
  let sql_string = '';
  for(const item in result_now[0]){
    if(result_now[0][item]!==null&&item.includes("field")){
      const x = `'"', ` + item + `, '",', `;
      sql_string += x;
    }
  }

  //全局sql
  const query = `SELECT d_no, 
        GROUP_CONCAT(
          CONCAT('[', `
          +sql_string+
          `'"', c_time, '"', 
          ']') ORDER BY c_time
        ) AS data
      FROM t_data
      WHERE type = '实时数据'`;
  function FORMATTIME(value){
    const formatTime = (timeStr) => new Date(timeStr).toISOString().slice(0, 19).replace('T', ' ');
    return formatTime(value);
  }
  //按照d_no分组-sql
  const groupbyd_no = `GROUP BY d_no`;
  //扩容sql方法
  async function toBig(){
    await connection2.query("SET SESSION group_concat_max_len = 1000000");
  };
  //全局解构赋值
  const formattedStart = FORMATTIME((start!=="end"||start!=="1")?start:'2025-06-13 15:51:16');
  const formattedEnd = FORMATTIME((end!=="1")?end:'2025-06-13 15:51:16');
  //封装处理查询结果
  function search_result(value){
    const formattedResult = [];
    value.forEach(row => {
      if (!row.data) return;
      const fixedData = `[${row.data}]`;
      const data = JSON.parse(fixedData); // 解析 JSON 数据
      data.forEach(entry => {
        formattedResult.push([row.d_no, entry[0], entry[1], entry[2], entry[3],entry[4],entry[5],entry[6],entry[7],entry[8]]);
      });
    });
    return formattedResult;
  }

  //全局查询结果变量
  let formattedResult;

  toBig();
  if(start==="1"&&end==="1"){//当需要的是总的数据的时候
    const [results] = await connection2.query(query+groupbyd_no);
    // 处理查询结果
    formattedResult = search_result(results);
  }
  else if(start === "end" && end !=="1"){
    const [results] = await connection2.query(query+`
      AND c_time < "${formattedEnd}"
    `+groupbyd_no);
    // 处理查询结果
    formattedResult = search_result(results);
  }
  else{
    const [results] = await connection2.query(query+`
      AND c_time BETWEEN "${formattedStart}" AND "${formattedEnd}"
    `+groupbyd_no);
    // 处理查询结果
    formattedResult = search_result(results);
  }
  ctx.body = formattedResult;


  //模拟只返回一组数据的情况
  // res.send([["2021","11","22","23","61","2019-01-01 15:40","实时数据"]]);

  //模拟返回0组数据的情况
  // res.send([]);
});


// 用于获取单位列的路由--设备数据
Router4.get("/device_unit", async (ctx) => {
  try {
    const query = `
      SELECT unit
      FROM t_field_mapper 
      ORDER BY id ASC
    `;
    const [rows] = await connection2.query(query);
    const unitArray = rows.map((row) => row.unit);
    ctx.body = unitArray;
  } catch (error) {
    console.log("当前发生错误");
  }
});

// 用于获取单位列的路由--行为数据
Router4.get("/action_unit", async (ctx) => {
  const query = `
    SELECT unit 
    FROM t_behavior_field_mapper 
    ORDER BY id ASC
  `;
  const [rows] = await connection2.query(query);
  const unitArray = rows.map((row) => row.unit);
  ctx.body = unitArray;
});

export default Router4;
