

//KOA2
import Config from "../indexNode2.js"; // 获取数据库链接配置对象
import Router1 from "koa-router"; // 替换 express 为 koa-router
import dayjs from "dayjs"; // 引入提供format使用环境的组件

let connection2; // 数据库连接对象
const SENSOR = new Router1(); // 创建 Koa 路由实例

// 数据库连接（立即执行异步函数）
(async () => {
  try {
    connection2 = await Config();
    console.log("数据库连接成功");
  } catch (error) {
    console.log("数据库连接失败");
  }
})();

SENSOR.get("/sensor_get",async (ctx)=>{
  const { d_no } = ctx.query;
  //动态获取数量
  const [rows] = await connection2.execute(`
  SELECT *
  FROM sensor_set
  WHERE place = '${d_no}'
  `);

  console.log("rows:");
  
  console.log(rows);

  //拼接响应结果
  const result = [];
  let i=1;

  while(1){
    if(rows[0]['sensor'+i]) i++;
    else break;
  }
  
  for(let j=1;j<i;j++){
    //获取到字段信息中的name、cable
    const name = rows[0]['sensor'+j].split(":")[1];
    const cable = rows[0]['sensor'+j].split(":")[0];
    result.push({ name:name,cable:cable,id:j });
  }
  ctx.body = result;  
});

SENSOR.get("/sensor_change",async (ctx)=>{
  const { name,cable,d_no,id } = ctx.query;
  //定义综合内容变量
  const all = cable + ":" + name + '传感器';
  const [rows] = await connection2.execute(`
    UPDATE sensor_set
    SET sensor${id} = "${all}"
    WHERE place = "${d_no}"
    `);
  ctx.body = 'ok';
})

export default SENSOR;
