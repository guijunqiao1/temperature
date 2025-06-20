
import Koa from 'koa';
import Router from 'koa-router';
import {koaBody} from 'koa-body';
import Config1 from "../indexNode2.js";

const app = new Koa();
const router = new Router();

app.use(koaBody({
  urlencoded: true,
  json: true
}));

let connection1;

(async () => {
  try {
    connection1 = await Config1();
    console.log("数据库3连接成功");
  } catch (error) {
    console.log("数据库3连接失败");
  }
})();

// HTTP 服务器端点
router.post('/sensor/data', async (ctx) => {
  const { d_no, png, mp4, type } = ctx.request.body;
  console.log("接收到传感器数据", ctx.request.body);
  if ( png > 0 && mp4 > 0) {
    const [rows1] = await connection1.execute(`SELECT p_name FROM t_behavior_field_mapper`);
    const time_base = getFormattedDate();
    const obj = {};
    rows1.forEach((item, index) => {
      if (index === 0) obj[item.p_name] = png;
      else if (index === 1) obj[item.p_name] = mp4;
    });
    const finalType = type || "实时数据";
    const finalDNo = d_no || null;
    await connection1.execute(`
      INSERT INTO t_behavior_data(d_no,field1,field2,c_time,type)
      VALUES ("${finalDNo}","${obj.P}","${obj.V}","${time_base}","${finalType}")
    `);
  }
  ctx.status = 200;
  ctx.body = 'OK';
});

router.post('/miss_data', async (ctx) => {
  const { d_no, png, mp4, type } = ctx.request.body;
  console.log("接收到保存数据", ctx.request.body);
  if ( png > 0 && mp4 > 0) {
    const [rows1] = await connection1.execute(`SELECT p_name FROM t_behavior_field_mapper`);
    const time_base = getFormattedDate();
    const obj = {};
    rows1.forEach((item, index) => {
      if (index === 0) obj[item.p_name] = png;
      else if (index === 1) obj[item.p_name] = mp4;
    });
    const finalType = type || "保存数据";
    const finalDNo = d_no || null;
    await connection1.execute(`
      INSERT INTO t_behavior_data(d_no,field1,field2,c_time,type)
      VALUES ("${finalDNo}","${obj.P}","${obj.V}","${time_base}","${finalType}")
    `);
  }
  ctx.status = 200;
  ctx.body = 'OK';
});


export default router;