

// //在当前需要对Mysql数据库进行操作的文件中提前引入Mysql数据库的配置文件--需要注意的是indexNode文件中的其他引入的组件文件只是对indexNode本身编写的时候进行约束的文件
// import Config from "../indexNode2.js";//此处获取到数据库链接配置对象
// // import Config2 from "../indexNode2.js";

// let connection2;//首先定义一个用于存储连接数据库的实例对象,在下方首次进行数据库的实例赋值之后则可完成值的保存，后续在路由中进行
// //数据库操作的时候直接执行connection.execute()方法即可--因为connection指向保持不变
// // 同时需要注意的是connection就算初始化未被赋值的情况下如果使用的是const关键字进行定义的话则在后续赋值则会被视作为错误，则提前进行全局变量的定义不能使用const关键字
// // let connection2;

// import Router1 from "express";
// const Router = Router1();
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
// Router.get("/recent", async (req,res) => {
//   try {
//     await connection2.query("SET SESSION group_concat_max_len = 1000000");

//     //获取实时表字段
//     const [result_now] = await connection2.query(`
//       SELECT * 
//       FROM t_data
//     `);
//     //动态拼接sql依据字符串
//     let sql_string = '';
//     for(const item in result_now[0]){
//       if(result_now[0][item]!==null&&item.includes("field")){
//         const x = `'"', t.` + item + `, '",', `;
//         sql_string += x;
//       }
//     }

//     const [results] = await connection2.query(`
//       SELECT 
//           t.d_no, 
//           GROUP_CONCAT(
//               CONCAT(
//                   '[', `+sql_string+`'"', t.c_time, '"', 
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
//     res.setHeader('Access-Control-Allow-Origin', '*'); // 允许所有来源
//     res.send(formattedResult);
//   } catch (err) {
//     console.error("数据库查询失败", err);
//   }
// });
// //行为最新数据
// Router.get("/recent/action", async (req,res) => {
//   try {
//     await connection2.query("SET SESSION group_concat_max_len = 1000000");
//     //获取实时表字段
//     const [result_now] = await connection2.query(`
//       SELECT * 
//       FROM t_behavior_data
//     `);
//     //动态拼接sql依据字符串
//     let sql_string = '';
//     for(const item in result_now[0]){
//       if(result_now[0][item]!==null&&item.includes("field")){
//         const x = `'"', t.` + item + `, '",', `;
//         sql_string += x;
//       }
//     }

//     const [results] = await connection2.query(`
//       WITH latest_time_per_dno AS (
//         SELECT d_no, MAX(c_time) AS max_time 
//         FROM t_behavior_data
//         GROUP BY d_no
//       )
//       SELECT 
//           t.d_no, 
//           GROUP_CONCAT(
//               CONCAT('[', 
//               `+sql_string+`
//               '"', t.c_time, '",',
//               '"', t.file_type, '"',
//               ']') ORDER BY t.c_time
//           ) AS data
//       FROM t_behavior_data t
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
//         // data = data.map(entry => {
//         //   return entry;
//         // });
    
//         return [row.d_no, data];
//       } catch (error) {
//         console.error(`JSON 解析失败: ${row.data}`, error);
//         return [row.d_no, []];
//       }
//     });
//     res.send(formattedResult);
//   } catch (err) {
//     console.error("数据库查询失败", err);
//   }
// });
// //设备ID最新记录--映射列表对象路由
// Router.get("/recent/list_obj",async (req,res)=>{
//   const [rows] = await connection2.query(`
//   SELECT *
//   FROM t_container
//   ORDER BY ctime DESC
//   `);
//   res.send(rows[0]);
// })

// //最新图片资源记录路由
// Router.get("/recent/img",async (req,res)=>{
//   const {d_no} = req.query;
//   const [rows] = await connection2.execute(`
//     SELECT *
//     FROM t_behavior_data
//     WHERE d_no = '${d_no}'
//     ORDER BY c_time DESC
//     LIMIT 1
//     `);
//   //封装查询结果
//   res.send(rows[0]);
// })


// export default Router;


//KOA2
import Config from "../indexNode2.js"; // 获取数据库链接配置对象
import Router1 from "koa-router"; // 替换 express 为 koa-router

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

// 设备最新数据
Router.get("/recent", async (ctx) => {
  try {
    await connection2.query("SET SESSION group_concat_max_len = 1000000");

    const [result_now] = await connection2.query(`
      SELECT * 
      FROM t_data
    `);

    let sql_string = '';
    for (const item in result_now[0]) {
      if (result_now[0][item] !== null && item.includes("field")) {
        const x = `'"', t.` + item + `, '",', `;
        sql_string += x;
      }
    }

    const [results] = await connection2.query(`
      SELECT 
          t.d_no, 
          GROUP_CONCAT(
              CONCAT(
                  '[', ${sql_string} '"', t.c_time, '"', 
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
        data = data.map(entry => entry);
        return [row.d_no, data];
      } catch (error) {
        console.error(`JSON 解析失败: ${row.data}`, error);
        return [row.d_no, []];
      }
    });

    ctx.set('Access-Control-Allow-Origin', '*');
    ctx.body = formattedResult;
  } catch (err) {
    console.error("数据库查询失败", err);
  }
});

// 行为最新数据
Router.get("/recent/action", async (ctx) => {
  try {
    await connection2.query("SET SESSION group_concat_max_len = 1000000");

    const [result_now] = await connection2.query(`
      SELECT * 
      FROM t_behavior_data
    `);

    let sql_string = '';
    for (const item in result_now[0]) {
      if (result_now[0][item] !== null && item.includes("field")) {
        const x = `'"', t.` + item + `, '",', `;
        sql_string += x;
      }
    }

    const [results] = await connection2.query(`
      WITH latest_time_per_dno AS (
        SELECT d_no, MAX(c_time) AS max_time 
        FROM t_behavior_data
        GROUP BY d_no
      )
      SELECT 
          t.d_no, 
          GROUP_CONCAT(
              CONCAT('[', 
              ${sql_string}
              '"', t.c_time, '",',
              '"', t.file_type, '"',
              ']') ORDER BY t.c_time
          ) AS data
      FROM t_behavior_data t
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
        return [row.d_no, data];
      } catch (error) {
        console.error(`JSON 解析失败: ${row.data}`, error);
        return [row.d_no, []];
      }
    });

    ctx.body = formattedResult;
  } catch (err) {
    console.error("数据库查询失败", err);
  }
}); 

// 设备ID最新记录
Router.get("/recent/list_obj", async (ctx) => {
  const [rows] = await connection2.query(`
    SELECT *
    FROM t_container
    ORDER BY ctime DESC
  `);
  ctx.body = rows[0];
});

// 最新图片资源记录
Router.get("/recent/img", async (ctx) => {
  const { d_no } = ctx.query;
  const [rows] = await connection2.execute(`
    SELECT *
    FROM t_behavior_data
    WHERE d_no = '${d_no}'
    ORDER BY c_time DESC
    LIMIT 1
  `);
  ctx.body = rows[0];
});

export default Router;
