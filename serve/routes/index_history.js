

//在当前需要对Mysql数据库进行操作的文件中提前引入Mysql数据库的配置文件--需要注意的是indexNode文件中的其他引入的组件文件只是对indexNode本身编写的时候进行约束的文件
import Config4 from "../indexNode2.js";//此处获取到数据库链接配置对象
import dayjs from "dayjs";//引入提供format使用环境的组件
let connection2;//定义数据库连接对象
import Router from "koa-router";
const Router4= new Router();

(async ()=>{
  try{
    //异步执行Config，用于连接数据库,后续可对connection数据库链接对象进行数据库语法操作用于对数据库本身进行操作
    connection2 = await Config4();
    console.log("数据库4连接成功");
    console.log("test");
  }
  catch(error){
    console.log("数据库4连接失败");
  }
})();

//表格的呈现-图像的呈现路由
Router4.get("/History", async ctx => {
  let { start,end,currentPage,pageSize,d_no } = ctx.query;
  try{ 
    //直接将总的历史记录进行获取--类似data路由内容，但是返回的数组的格式不同
    if(start==="1" && end==="1"){//初始的时候的总数据的请求,进行特定的d_no的分页查询数组的返回
      if(currentPage==="undefined" || pageSize==="undefined"||currentPage===undefined||pageSize===undefined){
        // 执行查询并格式化结果
        const [rows] = await connection2.execute(`
          SELECT d_no, field1, field2, field3,field4, field5, field6,field7,field8, DATE_FORMAT(c_time, '%Y-%m-%dT%H:%i:%s.000Z') AS c_time,type
          FROM t_data 
          ORDER BY c_time DESC
        `, [d_no]);

        // 将数据转换为二维数组格式
        const formattedRows = rows.map(row => [
          row.d_no,
          row.field1.toString(),  // 确保所有字段为字符串类型
          row.field2.toString(),
          row.field3.toString(),
          row.field4.toString(),
          row.field5.toString(),
          row.field6.toString(),
          row.field7.toString(),
          row.field8.toString(),
          dayjs(row.c_time).format('YYYY-MM-DD HH:mm:ss'),  // 已经格式化为ISO 8601标准时间字符串
          row.type
        ]);

        // 直接使用 res.send() 返回数据
        ctx.body = JSON.stringify(formattedRows);
      }
      else{
        console.log("currentPage:"+currentPage);
        console.log("pageSize:"+pageSize);
        //首先将页数整数化
        const offset = (parseInt(currentPage) - 1) * parseInt(pageSize);
        //直接查询
        const [rows] = await connection2.execute(`
          SELECT d_no,field1,field2,field3,field4, field5, field6,field7,field8,c_time,type
          FROM t_data 
          ORDER BY c_time DESC
          LIMIT ${parseInt(pageSize)} OFFSET ${offset}
        `);
        // 将数据转换为二维数组格式
        const formattedRows = rows.map(row => [
          row.d_no,
          row.field1.toString(),  // 确保所有字段为字符串类型
          row.field2.toString(),
          row.field3.toString(),
          row.field4.toString(),
          row.field5.toString(),
          row.field6.toString(),
          row.field7.toString(),
          row.field8.toString(),
          dayjs(row.c_time).format('YYYY-MM-DD HH:mm:ss'),  // 已经格式化为ISO 8601标准时间字符串
          row.type
        ]);

        // 直接使用 res.send() 返回数据
        ctx.body = JSON.stringify(formattedRows);
      }
    }
    else if(start === "end" && end !=="1"){
      console.log("end:"+end);
      console.log("d_no"+d_no);
      if(currentPage==="undefined" || pageSize==="undefined"||currentPage===undefined||pageSize===undefined){
          //首先将时间格式化同时将页数整数化
          const formatTime = (timeStr) => new Date(timeStr).toISOString().slice(0, 19).replace('T', ' ');
          const formattedEnd = formatTime(end);
          //直接查询
          const [rows] = await connection2.execute(`
            SELECT d_no,field1,field2,field3,field4, field5, field6,field7,field8,c_time,type
            FROM t_data 
            WHERE c_time < "${formattedEnd}"
            ORDER BY c_time DESC
          `);
          // 将数据转换为二维数组格式
          const formattedRows = rows.map(row => [
            row.d_no,
            row.field1.toString(),  // 确保所有字段为字符串类型
            row.field2.toString(),
            row.field3.toString(),
            row.field4.toString(),
            row.field5.toString(),
            row.field6.toString(),
            row.field7.toString(),
            row.field8.toString(),
            dayjs(row.c_time).format('YYYY-MM-DD HH:mm:ss'),  // 已经格式化为ISO 8601标准时间字符串
            row.type
          ]);

          // 直接使用 res.send() 返回数据
          ctx.body = JSON.stringify(formattedRows);
      }
      else{
        console.log("currentPage:"+currentPage);
        console.log("pageSize:"+pageSize);
        //首先将时间格式化同时将页数整数化
        const offset = (parseInt(currentPage) - 1) * parseInt(pageSize);
        const formatTime = (timeStr) => new Date(timeStr).toISOString().slice(0, 19).replace('T', ' ');
        const formattedEnd = formatTime(end);
        //直接查询
        const [rows] = await connection2.execute(`
          SELECT d_no,field1,field2,field3,field4, field5, field6,field7,field8,c_time,type
          FROM t_data
          WHERE c_time < "${formattedEnd}"
          ORDER BY c_time DESC
          LIMIT ${parseInt(pageSize)} OFFSET ${offset}
        `);
        res.json(rows.map(row => [row.d_no, row.field1, row.field2, row.field3,row.field4,row.field4,row.field5,row.field6,row.field7,row.field8, dayjs(row.c_time).format('YYYY-MM-DD HH:mm:ss') ,row.type]));
      }
    }
    else{//change1、分页后的事件的执行--内容获取--需要在start到end的基础上结合currentPage分页以及d_no的指定查询
      console.log("start:"+start);
      console.log("end:"+end);
      console.log("d_no"+d_no);
      if(currentPage==="undefined" || pageSize==="undefined"||currentPage===undefined||pageSize===undefined){
          //首先将时间格式化同时将页数整数化
          const formatTime = (timeStr) => new Date(timeStr).toISOString().slice(0, 19).replace('T', ' ');
          const formattedStart = formatTime(start);
          const formattedEnd = formatTime(end);
          //直接查询
          const [rows] = await connection2.execute(`
            SELECT d_no,field1,field2,field3,field4, field5, field6,field7,field8,c_time,type
            FROM t_data 
            WHERE c_time BETWEEN "${formattedStart}" AND "${formattedEnd}"
            ORDER BY c_time DESC
          `);
          // 将数据转换为二维数组格式
          const formattedRows = rows.map(row => [
            row.d_no,
            row.field1.toString(),  // 确保所有字段为字符串类型
            row.field2.toString(),
            row.field3.toString(),
            row.field4.toString(),
            row.field5.toString(),
            row.field6.toString(),
            row.field7.toString(),
            row.field8.toString(),
            dayjs(row.c_time).format('YYYY-MM-DD HH:mm:ss'),  // 已经格式化为ISO 8601标准时间字符串
            row.type
          ]);

          // 直接使用 res.send() 返回数据
          ctx.body = JSON.stringify(formattedRows);
      }
      else{
        console.log("currentPage:"+currentPage);
        console.log("pageSize:"+pageSize);
        //首先将时间格式化同时将页数整数化
        const offset = (parseInt(currentPage) - 1) * parseInt(pageSize);
        const formatTime = (timeStr) => new Date(timeStr).toISOString().slice(0, 19).replace('T', ' ');
        const formattedStart = formatTime(start);
        const formattedEnd = formatTime(end);
        //直接查询
        const [rows] = await connection2.execute(`
          SELECT d_no,field1,field2,field3,field4, field5, field6,field7,field8,c_time,type
          FROM t_data 
          WHERE c_time BETWEEN "${formattedStart}" AND "${formattedEnd}"
          ORDER BY c_time DESC
          LIMIT ${parseInt(pageSize)} OFFSET ${offset}
        `);
        res.json(rows.map(row => [row.d_no, row.field1, row.field2, row.field3,row.field4,row.field4,row.field5,row.field6,row.field7,row.field8, dayjs(row.c_time).format('YYYY-MM-DD HH:mm:ss') ,row.type]));
      }
    }
  }
  catch{
    console.log("History路由中："+start);
    console.log("History路由中："+end);
    console.log("History路由中："+currentPage);
    console.log("History路由中："+pageSize);
    console.log("History路由中："+d_no);
  }

  //模拟只有一组数据返回的情况
  // res.send([["2021","11","22","23","61","2019-01-01 15:40","实时数据"]]);

  //模拟有0组数据返回的情况
  // res.send([]);
});
//表格的呈现路由
Router4.get("/History_count", async ctx => {
  const {start,end,d_no} = ctx.query;
  try{
    //首先判断是否已经激活了ok
    if(start==="1" && end==="1"){//初始状态直接算
      //直接查询
      const [rows] = await connection2.execute(`
        SELECT COUNT(*) as total 
        FROM t_data 
      `);
      // 直接返回数组长度
      ctx.body = ""+rows[0].total.toString()
    }
    else if(start === "end" && end !=="1"){
      console.log("end:"+end);
      console.log("d_no"+d_no);
      //格式化时间值
      const formatTime = (timeStr) => new Date(timeStr).toISOString().slice(0, 19).replace('T', ' ');
      const formattedEnd = formatTime(end);
      //直接查询
      const [rows] = await connection2.execute(`
        SELECT COUNT(*) as total 
        FROM t_data 
        WHERE c_time < "${formattedEnd}"
      `);
      // 直接返回数组长度
      ctx.body = ""+rows[0].total.toString()
    }
    else {//进行分页查询后计算大小
      console.log("start:"+start);
      console.log("end:"+end);
      console.log("d_no"+d_no);
      //格式化时间值
      const formatTime = (timeStr) => new Date(timeStr).toISOString().slice(0, 19).replace('T', ' ');
      const formattedStart = formatTime(start);
      const formattedEnd = formatTime(end);
      //直接查询
      const [rows] = await connection2.execute(`
        SELECT COUNT(*) as total  
        FROM t_data 
        WHERE d_no="${d_no}" 
        AND c_time BETWEEN "${formattedStart}" AND "${formattedEnd}"
      `);
      // 直接返回数组长度
      ctx.body = ""+rows[0].total.toString()
    }
  }
  catch{
    console.log("History："+start);
    console.log("History："+end);
    console.log("History："+d_no);
  }
  //模拟只有一组数据的情况
  // res.send("1");

  //模拟有0组数据返回的情况
  // res.send("0");
});
//告警历史数据
// Router4.get("/History/alarm",asyncctx=>{
//   const {start,end} = ctx.query;
//   const [results] = await connection2.query(`
//     SELECT 
//   `);


// })
//储运箱入库历史数据
Router4.get("/History/container",async ctx=>{
  const {start,end} = ctx.query;
  const formatTime = (timeStr) => new Date(timeStr).toISOString().slice(0, 19).replace('T', ' ');
  const formattedStart = formatTime(start);
  const formattedEnd = formatTime(end);
  const [results] = await connection2.query(`
    SELECT *
    FROM t_container
    WHERE ctime BETWEEN "${formattedStart}" AND "${formattedEnd}"
    ORDER BY ctime
  `);
  // 格式化数据
  const formattedResults = results.map(row => [
      row.PID,
      row.VID,
      row.ctime
  ]);
  ctx.body = formattedResults;
})


//设备选项列表相关路由
Router4.get("/data", async ctx => {//对data路由进行修改并且接纳上start和end，若接受失败则进行总的数据的返回
  const { start,end } = ctx.query;
  if(start==="1"&&end==="1"){//当需要的是总的数据的时候
    await connection2.query("SET SESSION group_concat_max_len = 1000000");

    const [results] = await connection2.query(`
      SELECT d_no, 
        GROUP_CONCAT(
          CONCAT('[', 
            '"', field1, '"', ',', 
            '"', field2, '"', ',', 
            '"', field3, '"', ',', 
            '"', field4, '"', ',', 
            '"', field5, '"', ',', 
            '"', field6, '"', ',', 
            '"', field7, '"', ',', 
            '"', field8, '"', ',', 
            '"', c_time, '"', 
          ']') ORDER BY c_time
        ) AS data
      FROM t_data
      WHERE type = '实时数据'
      GROUP BY d_no;
    `);
  
    // 处理查询结果
    const formattedResult = [];
    results.forEach(row => {
      if (!row.data) return;
      const fixedData = `[${row.data}]`;
      const data = JSON.parse(fixedData); // 解析 JSON 数据
      data.forEach(entry => {
        formattedResult.push([row.d_no, entry[0], entry[1], entry[2], entry[3], entry[4],entry[5],entry[6],entry[7],entry[8]]);
      });
    });
  
    // 最终返回的格式为 [[设备名, 数据1...], [设备名, 数据2...], ...]
    ctx.body = formattedResult;
  }
  else if(start === "end" && end !=="1"){
    await connection2.query("SET SESSION group_concat_max_len = 1000000");
    const formatTime = (timeStr) => new Date(timeStr).toISOString().slice(0, 19).replace('T', ' ');
    const formattedEnd = formatTime(end);
    const [results] = await connection2.query(`
      SELECT d_no, 
        GROUP_CONCAT(
          CONCAT('[', 
            '"', field1, '"', ',', 
            '"', field2, '"', ',', 
            '"', field3, '"', ',', 
            '"', field4, '"', ',', 
            '"', field5, '"', ',', 
            '"', field6, '"', ',', 
            '"', field7, '"', ',', 
            '"', field8, '"', ',', 
            '"', c_time, '"', 
            '"', type, '"',
          ']') ORDER BY c_time
        ) AS data
      FROM t_data
      WHERE type = '实时数据'
      AND c_time < "${formattedEnd}"
      GROUP BY d_no;
    `);
    // 处理查询结果
    const formattedResult = [];
    results.forEach(row => {
      if (!row.data) return;
      const fixedData = `[${row.data}]`;
      const data = JSON.parse(fixedData); // 解析 JSON 数据
      data.forEach(entry => {
        formattedResult.push([row.d_no, entry[0], entry[1], entry[2], entry[3], entry[4],entry[5],entry[6],entry[7],entry[8]]);
      });
    });
    // 最终返回的格式为 [[设备名, 数据1...], [设备名, 数据2...], ...]
    ctx.body = formattedResult;
  }
  else{
    await connection2.query("SET SESSION group_concat_max_len = 1000000");
    const formatTime = (timeStr) => new Date(timeStr).toISOString().slice(0, 19).replace('T', ' ');
    const formattedStart = formatTime(start);
    const formattedEnd = formatTime(end);
    const [results] = await connection2.query(`
      SELECT d_no,  
        GROUP_CONCAT(
          CONCAT('[', 
            '"', field1, '"', ',', 
            '"', field2, '"', ',', 
            '"', field3, '"', ',', 
            '"', field4, '"', ',', 
            '"', field5, '"', ',', 
            '"', field6, '"', ',', 
            '"', field7, '"', ',', 
            '"', field8, '"', ',', 
            '"', c_time, '"', 
          ']') ORDER BY c_time
        ) AS data
      FROM t_data
      WHERE type = '实时数据'
      AND c_time BETWEEN "${formattedStart}" AND "${formattedEnd}"
      GROUP BY d_no;
    `);
    // 处理查询结果
    const formattedResult = [];
    results.forEach(row => {
      if (!row.data) return;
      const fixedData = `[${row.data}]`;
      const data = JSON.parse(fixedData); // 解析 JSON 数据
      data.forEach(entry => {
        formattedResult.push([row.d_no, entry[0], entry[1], entry[2], entry[3], entry[4],entry[5],entry[6],entry[7],entry[8]]);
      });
    });
    // 最终返回的格式为 [[设备名, 数据1...], [设备名, 数据2...], ...]
    ctx.body = formattedResult; 
  }

  //模拟只返回一组数据的情况
  // res.send([["2021","11","22","23","61","2019-01-01 15:40","实时数据"]]);

  //模拟返回0组数据的情况
  // res.send([]);
});

//用于获取单位列的路由--设备数据
Router4.get("/device_unit",async (ctx)=>{
  try{
    // 查询数据库，获取 t_behavior_field_mapper 表中的 unit 列
    // 并按照 id 排序
    const query = `
      SELECT unit 
      FROM t_field_mapper 
      ORDER BY id ASC
    `;
    console.log("成功进入当前路由");
    // 执行查询
    const [rows] = await connection2.query(query);
    
    // 将查询结果转换为字符串数组
    // 从每一行对象中提取 unit 值
    const unitArray = rows.map(row => row.unit);
    // 返回字符串数组结果
    ctx.body = unitArray;
  }catch(error){
    console.log("当前发生错误");
  }
})

//用于获取单位列的路由--行为数据
Router4.get("/action_unit",async ctx=>{
  // 查询数据库，获取 t_behavior_field_mapper 表中的 unit 列
  // 并按照 id 排序
  const query = `
    SELECT unit 
    FROM t_behavior_field_mapper 
    ORDER BY id ASC
  `;
  // 执行查询
  const [rows] = await connection2.query(query);
  
  // 将查询结果转换为字符串数组
  // 从每一行对象中提取 unit 值
  const unitArray = rows.map(row => row.unit);
  // 返回字符串数组结果
  ctx.body = unitArray;
})


export default Router4;

//记得将查询条件中的一定为实时数据进行修改了,所有的数据都可以