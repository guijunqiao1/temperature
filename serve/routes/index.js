// import express from "express";
// //在当前需要对Mysql数据库进行操作的文件中提前引入Mysql数据库的配置文件--需要注意的是indexNode文件中的其他引入的组件文件只是对indexNode本身编写的时候进行约束的文件
// import Config from "../indexNode2.js";//此处获取到数据库链接配置对象
// // import Config2 from "../indexNode2.js";

// let connection2;//首先定义一个用于存储连接数据库的实例对象,在下方首次进行数据库的实例赋值之后则可完成值的保存，后续在路由中进行
// //数据库操作的时候直接执行connection.execute()方法即可--因为connection指向保持不变
// // 同时需要注意的是connection就算初始化未被赋值的情况下如果使用的是const关键字进行定义的话则在后续赋值则会被视作为错误，则提前进行全局变量的定义不能使用const关键字
// // let connection2;

// const Router = express();
// //引入数据库链接函数


// //下方语句用于实现数据库1的连接
// (async ()=>{
//   try{
//     //异步执行Config，用于连接数据库,后续可对connection数据库链接对象进行数据库语法操作用于对数据库本身进行操作
//     connection2 = await Config();
//     console.log("数据库连接成功");
//   }
//   catch(error){
//     console.log("数据库连接失败");
//   }
// })();//注意此为立即执行函数的写法，并且通过使用匿名函数的方式，则需要立即执行函数本身自带的第一个()进行包裹，并且在前者中的同时因为需要使用异步对Config方法进行处理
// //故需要进行async的同理包裹


// //设备最新数据
// Router.get("/recent", async (req, res) => {
//   try {
//     await connection2.query("SET SESSION group_concat_max_len = 1000000");
//     // //动态拼接sql
//     // const [result0] = await connection2.query(`
//     // SELECT *
//     // FROM t_data
//     // `);
//     // const [result00] = await connection2.query(`
//     // SELECT 
//     // `);

//     const [results] = await connection2.query(`
//       SELECT 
//           t.d_no, 
//           GROUP_CONCAT(
//               CONCAT(
//                   '[', 
//                       '"', t.field1, '",', 
//                       '"', t.field2, '",', 
//                       '"', t.field3, '",', 
//                       '"', t.field4, '",', 
//                       '"', t.c_time, '"', 
//                   ']'
//               ) ORDER BY t.c_time
//           ) AS data
//       FROM t_data t
//       WHERE t.c_time BETWEEN 
//           (SELECT MAX(c_time) FROM t_data WHERE d_no = t.d_no) - INTERVAL 5 MINUTE 
//           AND (SELECT MAX(c_time) FROM t_data WHERE d_no = t.d_no)
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
//   } catch (err) {
//     console.error("数据库查询失败", err);
//     res.status(500).send("数据库查询失败");
//   }
// });
// //行为最新数据
// Router.get("/recent/action", async (req, res) => {
//   try {
//     await connection2.query("SET SESSION group_concat_max_len = 1000000");
//     const [results] = await connection2.query(`
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
//     res.send(formattedResult);
//   } catch (err) {
//     console.error("数据库查询失败", err);
//     res.status(500).send("数据库查询失败");
//   }
// });
// //设备ID最新记录--映射列表对象路由
// Router.get("/recent/list_obj",async(req,res)=>{
//   const [rows] = await connection2.query(`
//   SELECT *
//   FROM t_container
//   ORDER BY ctime DESC
//   `);
//   res.send(rows[0]);
// })

// export default Router;

// // 实例mysql语句代码：
// // async function executeSQL() {
// //   const connection = await mysql.createConnection({
// //     host: 'localhost',
// //     user: 'root',
// //     password: 'your_password',
// //     database: 'your_database',
// //   });

// //   // 直接运行 SQL
// //   const [result] = await connection.execute(`
// //     INSERT INTO users (name, email, age)
// //     VALUES ('Alice', 'alice@example.com', 25)
// //   `);

// //   console.log('插入结果:', result);
// //   await connection.end();//关闭当前数据库--此处需要注意的是由于数据库的连接实例变量是在当前路由下进行获取的，所以进行关闭的时候也需要再当前路由中执行
// //，这样会导致所有的路由都需要执行一次关闭数据库的操作，而对于上述的实际代码中利用connection的提前赋值的形式进行连接的实例对象的获取，这样就可以在module_exports赋值之前
// //执行一次数据库关闭的操作就能将所有的路由中的请求对应的数据库关闭操作都包含了(异步的原理--也就是在执行路由并且返回响应体内容的时候同时也会执行当前程序中的后续的内容);


// //一般最好不要主动添加上connection.end()方法的执行，一般都是在程序被关闭的时候才断开连接，因为在多次访问路由文件的时候路由前置代码只会执行一次(也就是只会进行一次数据库的连接),并且后续直接访问到路由内容
// //若断开太早则会导致路由中的数据库操作无法被识别操作的数据库对象--除非是在每一个路由中进行一次数据库的连接操作
// // }

// // executeSQL();

// //补充：
// //[]为数组解构的赋值方式、而{}为对象解构的赋值方式:
// //作为数组也能进行解构赋值的原因在于本质上是遵循着顺序进行赋值的arr=[1,2,3],[a,b,c]=arr,同时可以进行[,,a,b,c]=[1,2,3,4,5]的赋值方式进行灵活的间隔赋值
// //则上述的[result]的数组解构的赋值方式则是仅将返回值数组中的第一个元素进行获取了



// //接下来的任务：
// //在了解了mysql数据库的基本语法之后进行对应的内容的操作，同时对分页进行深刻的理解(包括前端的表格的分页实现、后端的数据库的分页的实现)，同时需要在所有后端设计完毕之后进行前端的表格实际渲染的添加，
// //并且后续对服务的具体端口以及另一个页面(数据库的利用)的制作进行完善


// // 检查是否已存在相同的 `id`（防止重复）
// // const [rows] = await connection.execute('SELECT * FROM t_device_msg WHERE id = ?', [id]);
// // if (rows.length > 0) {
// //   return res.status(400).send('数据已存在');
// // }

// // // 插入新数据
// // const sql = `
// //   INSERT INTO t_device_msg (id, device_name, c_time, remark, number)
// //   VALUES (?, ?, ?, ?, ?)
// // `;
// // await connection.execute(sql, [id, device_name, c_time, remark, number]);

// // // 响应成功
// // res.send('ADD_OK');


// //使用require()进行引入的内容使用module.exports进行暴露，
// //而使用Import进行引入的内容本身需要使用export default 进行暴露

// //需要注意的是进行axios响应结果接收的情况下不可设置响应状态码




//在当前需要对Mysql数据库进行操作的文件中提前引入Mysql数据库的配置文件--需要注意的是indexNode文件中的其他引入的组件文件只是对indexNode本身编写的时候进行约束的文件
import Config from "../indexNode2.js";//此处获取到数据库链接配置对象
// import Config2 from "../indexNode2.js";

let connection2;//首先定义一个用于存储连接数据库的实例对象,在下方首次进行数据库的实例赋值之后则可完成值的保存，后续在路由中进行
//数据库操作的时候直接执行connection.execute()方法即可--因为connection指向保持不变
// 同时需要注意的是connection就算初始化未被赋值的情况下如果使用的是const关键字进行定义的话则在后续赋值则会被视作为错误，则提前进行全局变量的定义不能使用const关键字
// let connection2;

import Router1 from "koa-router";
const Router = new Router1();
//引入数据库链接函数


//下方语句用于实现数据库1的连接
(async ()=>{
  try{
    //异步执行Config，用于连接数据库,后续可对connection数据库链接对象进行数据库语法操作用于对数据库本身进行操作
    connection2 = await Config();
    console.log("数据库连接成功");
  }
  catch(error){
    console.log("数据库连接失败");
  }
})();//注意此为立即执行函数的写法，并且通过使用匿名函数的方式，则需要立即执行函数本身自带的第一个()进行包裹，并且在前者中的同时因为需要使用异步对Config方法进行处理
//故需要进行async的同理包裹


//设备最新数据
Router.get("/recent", async (ctx) => {
  try {
    await connection2.query("SET SESSION group_concat_max_len = 1000000");
    // //动态拼接sql
    // const [result0] = await connection2.query(`
    // SELECT *
    // FROM t_data
    // `);
    // const [result00] = await connection2.query(`
    // SELECT 
    // `);

    const [results] = await connection2.query(`
      SELECT 
          t.d_no, 
          GROUP_CONCAT(
              CONCAT(
                  '[', 
                      '"', t.field1, '",', 
                      '"', t.field2, '",', 
                      '"', t.field3, '",', 
                      '"', t.field4, '",', 
                      '"', t.c_time, '"', 
                  ']'
              ) ORDER BY t.c_time
          ) AS data
      FROM t_data t
      WHERE t.c_time BETWEEN 
          (SELECT MAX(c_time) FROM t_data WHERE d_no = t.d_no) - INTERVAL 5 MINUTE 
          AND (SELECT MAX(c_time) FROM t_data WHERE d_no = t.d_no)
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
  } catch (err) {
    console.error("数据库查询失败", err);
  }
});
//行为最新数据
Router.get("/recent/action", async  ctx => {
  try {
    await connection2.query("SET SESSION group_concat_max_len = 1000000");
    const [results] = await connection2.query(`
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
    ctx.body =formattedResult;
  } catch (err) {
    console.error("数据库查询失败", err);
  }
});
//设备ID最新记录--映射列表对象路由
Router.get("/recent/list_obj",async ctx=>{
  const [rows] = await connection2.query(`
  SELECT *
  FROM t_container
  ORDER BY ctime DESC
  `);
  ctx.body = rows[0];
})

export default Router;

