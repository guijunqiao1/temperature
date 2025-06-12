
import Koa from 'koa';
import Router from 'koa-router';
import {koaBody} from 'koa-body';
import axios from 'axios';
import Config1 from "../indexNode3.js";

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


export let active = false;

let zhiling_beifen_array = [];

let level = 0;
let now_ID = null;
let tem = 0;

const BASE_URL = 'http://127.0.0.1:9000';

function delay(ms) {
  return new Promise(resolve => setTimeout(resolve, ms));
}

function getFormattedDate() {
  const now = new Date();
  const year = now.getFullYear();
  const month = String(now.getMonth() + 1).padStart(2, '0');
  const day = String(now.getDate()).padStart(2, '0');
  const hours = String(now.getHours()).padStart(2, '0');
  const minutes = String(now.getMinutes()).padStart(2, '0');
  const seconds = String(now.getSeconds()).padStart(2, '0');
  return `${year}-${month}-${day}-${hours}-${minutes}-${seconds}`;
}

function getTongbu() {
  const now = new Date();
  const hours = String(now.getHours()).padStart(2, '0');
  const minutes = String(now.getMinutes()).padStart(2, '0');
  const seconds = String(now.getSeconds()).padStart(2, '0');
  return `${hours}:${minutes}:${seconds}`;
}

// 心跳检测器
setInterval(async () => {
  console.log("心跳正常发送");
  try {
    await axios.post(`${BASE_URL}/heartbeat/send`, { heartTest_client: "start" });
    active = false;
    console.log("成功发送心跳");
  } catch (err) {
    console.log(`发送心跳失败: ${err.message}`);
  }
}, 5000);

// 重发函数
function reconnect_republish() {
  active = true;
  republish();
}

async function republish() {
  console.log("zhiling_beifen_array_length:" + zhiling_beifen_array.length);
  console.log("zhiling_beifen:");
  console.dir(zhiling_beifen_array);
  const length = zhiling_beifen_array.length;
  for (let i = 0; i < length; i++) {
    if (zhiling_beifen_array.length > 0 && zhiling_beifen_array[0].length > 0) {
      await beifen(1, zhiling_beifen_array[0]);
      zhiling_beifen_array.shift();
    }
    await delay(3000);
  }
}

export async function beifen(value1, value2) {
  try {
    await axios.post(`${BASE_URL}/${value2[0]}`, value2[1]);
    await delay(1000);
    await axios.post(`${BASE_URL}/${value2[0]}`, value2[1]);
  } catch (err) {
    console.log(`发送指令失败: ${err.message}`);
  }

  if (active === false) {
    zhiling_beifen_array.push(value2);
    console.log("zhiling_beifen_array.length:" + zhiling_beifen_array.length);
  }
}

// HTTP 服务器端点
router.post('/sensor/data', async (ctx) => {
  const { d_no, string, png, mp4, type } = ctx.request.body;
  console.log("接收到传感器数据", ctx.request.body);
  if (string > 0 && png > 0 && mp4 > 0) {
    const [rows1] = await connection1.execute(`SELECT p_name FROM t_field_mapper`);
    const time_base = getFormattedDate();
    const obj = {};
    rows1.forEach((item, index) => {
      if (index === 0) obj[item.p_name] = png;
      else if (index === 1) obj[item.p_name] = string;
      else if (index === 2) obj[item.p_name] = mp4;
    });
    const finalType = type || "实时数据";
    const finalDNo = d_no || null;
    await connection1.execute(`
      INSERT INTO t_data(d_no,field1,field2,field3,field4,c_time,type)
      VALUES ("${finalDNo}","${obj.TI}","${obj.TO}","${obj.L}","1","${time_base}","${finalType}")
    `);
  }
  ctx.status = 200;
  ctx.body = 'OK';
});

router.post('/miss_data', async (ctx) => {
  const { d_no, png, string, mp4, type, hour, minute, second } = ctx.request.body;
  console.log("接收到保存数据", ctx.request.body);
  if (png > 0 && png > 0 && mp4 > 0) {
    const [rows1] = await connection1.execute(`SELECT p_name FROM t_field_mapper`);
    const time_base = getFormattedDate();
    const obj = {};
    rows1.forEach((item, index) => {
      if (index === 0) obj[item.p_name] = png;
      else if (index === 1) obj[item.p_name] = string;
      else if (index === 2) obj[item.p_name] = mp4;
    });
    const finalType = type || "保存数据";
    const finalDNo = d_no || null;
    const time = `${time_base.split("-")[0]}-${time_base.split("-")[1]}-${time_base.split("-")[2]} ${hour}:${minute}:${second}`;
    await connection1.execute(`
      INSERT INTO t_data(d_no,field1,field2,field3,field4,c_time,type)
      VALUES ("${finalDNo}","${obj.TI}","${obj.TO}","${obj.L}","1","${time}","${finalType}")
    `);
  }
  ctx.status = 200;
  ctx.body = 'OK';
});

router.post('/heartbeat', async (ctx) => {
  console.log("收到设备心跳");
  reconnect_republish();
  ctx.status = 200;
  ctx.body = 'OK';
});


// 暂时闭嘴报错
// router.post("/heartbeat/send",async(ctx)=>{
//   console.log("成功接收");
//   ctx.body = '当前成功响应';
// })



router.post('/alarm', async (ctx) => {
  const { Vstatus } = ctx.request.body;
  const msg = Vstatus === "1" ? "空调故障" :
              Vstatus === "2" ? "风扇故障" :
              Vstatus === "3" ? "危险气体浓度超标" :
              Vstatus === "4" ? "湿度超标" : "储运箱断电时间过长";
  await connection1.execute(`
    UPDATE t_error_msg
    SET e_msg = "${msg}", c_time = "${getFormattedDate()}"
    WHERE id = ${Number(Vstatus)};
  `);
  await connection1.execute(`UPDATE t_error_msg SET VStatus = "1";`);
  await connection1.execute(`
    INSERT INTO t_error_history(e_msg,c_time)
    VALUES ("${msg}","${getFormattedDate()}")
  `);
  ctx.status = 200;
  ctx.body = 'OK';
});

router.post('/alarm1', async (ctx) => {
  console.log("alarm1成功触发");
  const { OK } = ctx.request.body;
  await connection1.execute(`
    UPDATE t_error_msg
    SET e_msg = "未发生告警", c_time = "${getFormattedDate()}"
    WHERE id = ${Number(OK)};
  `);
  const [rows1] = await connection1.execute(`SELECT e_msg FROM t_error_msg`);
  let sum = 0;
  for (let i = 0; i < 5; i++) {
    if (rows1[i].e_msg === "未发生告警") sum++;
    else break;
  }
  if (sum === 5) {
    await connection1.execute(`UPDATE t_error_msg SET VStatus = "0";`);
  }
  ctx.status = 200;
  ctx.body = 'OK';
});

router.post('/chonglian', async (ctx) => {
  console.log("接收到重连消息");
  setTimeout(async () => {
    await beifen(0, ["chonglian1", { time: getTongbu() }]);
  }, 10000);
  ctx.status = 200;
  ctx.body = 'OK';
});

router.post('/direct1', async (ctx) => {
  const { PID, VID } = ctx.request.body;
  await connection1.execute(`
    INSERT INTO t_container(VID,ctime,PID)
    VALUES ("${VID}","${getFormattedDate()}","${PID}")
  `);
  ctx.status = 200;
  ctx.body = 'OK';
});

// 模拟 MQTT 订阅的轮询
// async function startPolling() {
//   const endpoints = ['sensor/data', 'miss_data', 'heartbeat', 'alarm', 'alarm1', 'chonglian', 'direct1'];
//   while (true) {
//     for (const endpoint of endpoints) { 
//       try {
//         await axios.get(`${BASE_URL}/${endpoint}/poll`);
//       } catch (err) {
//         console.log(`轮询 ${endpoint} 失败: ${err.message}`);
//       }
//     }
//     await delay(5000);
//   }
// }

export default router;

// startPolling();