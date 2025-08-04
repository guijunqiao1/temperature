// KOA2
import Router from "koa-router";
const Router_direct_response = new Router();

import Config from "../indexNode2.js";
let connection;

import { beifen } from "./mqtt_server_get.js";

// 获取格式化时间字符串
function getFormattedDate() {
  const now = new Date(); 
  const year = now.getFullYear();  
  const month = String(now.getMonth() + 1).padStart(2, '0');
  const day = String(now.getDate()).padStart(2, '0');
  const hours = String(now.getHours()).padStart(2, '0');
  const minutes = String(now.getMinutes()).padStart(2, '0');
  const seconds = String(now.getSeconds()).padStart(2, '0');
  return `${year}-${month}-${day} ${hours}:${minutes}:${seconds}`;
}

export async function t_direct_control() {
  try {
    connection = await Config();
    console.log("数据库连接成功");
    const result = await connection.execute(`
      SELECT c.id,c.f_type,c.mode,c.f_value,c.t_name,c.max,c.min,c.topic,c.header,c.luyou
      FROM t_direct_config c
      WHERE ok in ("yes","yes1") 
      ORDER BY CASE f_type
          WHEN '1' THEN 1
          ELSE 2
        END;
    `);
    const rowx = result[0];
    console.log("成功进入外层");
    console.dir(rowx);
    rowx.forEach((item, index) => {
      console.log("item:" + item.luyou);
      Router_direct_response.get("/zhiling/" + item.luyou, async (ctx) => {
        let { content, d_no } = ctx.query;
        console.log("当前总neriong:");
        console.dir(item);
        console.log("content:" + content);
        const obj1 = {};
        let tem1;
        let tem11;
        let topic;
        if (item.f_type !== '2' && item.f_type !== '3' && item.f_type !== '4') {
          const C1 = item.f_value.split("|")[0].split(":")[0];
          const C2 = item.f_value.split("|")[1].split(":")[0];
          const E1 = item.f_value.split("|")[0].split(":")[1];
          const E2 = item.f_value.split("|")[1].split(":")[1];
          const N1 = item.header.split("|")[0];
          const N2 = item.header.split("|")[1];
          tem1 = content === C1 ? E1 : E2;
          tem11 = content === C1 ? N1 : N2;
          topic = item.topic;
          if (item.id === 12) {
            tem11 = 'on' + d_no.split("机房")[1] + '_' + (content === "开" ? '4' : '0');
          }
          obj1[tem1] = tem11;
          content = content === C1 ? C1 : C2;
        } else {
          const formatTime = (timeStr) => new Date(timeStr).toISOString().slice(0, 19).replace('T', ' ');
          console.log("成功进入时间判断");
          tem1 = item.f_value.split("|")[0];
          if (content) {
            if (item.f_type === "4") {
              content = formatTime(content);
              console.log("时间值格式:" + content);
              tem11 = content.split(" ")[1];
              console.log("time:" + tem11);
            } else {
              tem11 = content;
            }
          } else {
            const [rowsx] = await connection.execute(`
              SELECT t_direct.value
              FROM t_direct,t_direct_config
              WHERE t_direct_config.id = t_direct.config_id
              AND t_direct_config.id = ${item.id}
              AND d_no = "${d_no === "null" ? "null" : `${d_no}`}"
            `);
            if (item.f_type === "4") {
              tem11 = rowsx[0].value.split(" ")[1];
              console.log("time:" + tem11);
            } else {
              tem11 = content;
            }
          }
          topic = item.topic;
          console.log("item.id:" + item.id);
          if (item.id === 12) {
            tem11 = 'on' + d_no + '_' + content;
          }
          obj1[tem1] = tem11;
        }
        if (d_no) {
          console.log("即将更新:" + d_no);
          const template = topic;
          console.log("tem:" + template);
          beifen(d_no, [template, obj1]);
          console.log("注册的一次路由");
          await connection.execute(`
            INSERT INTO operate_history(place,device,operate,ctime)
            VALUES('${d_no}','${item.t_name}','修改为${content}','${getFormattedDate()}')
          `);
          const [row] = await connection.execute(`
            SELECT config_id
            FROM t_direct,t_direct_config
            WHERE t_direct_config.id = t_direct.config_id
            AND t_direct_config.id = ${item.id}
            AND d_no = "${d_no}"
          `);
          if (!row[0]) {
            await connection.execute(`
              INSERT INTO t_direct(config_id,value,d_no)
              VALUE(${item.id},"${content}","${d_no}")
            `);
          } else {
            await connection.execute(`
              UPDATE t_direct
              SET value = "${content}"
              WHERE config_id = ${item.id}
            `);
          }
        }
        ctx.body = "ok";
      });
      Router_direct_response.get('/test111', (ctx) => {
        ctx.body = 'ok';
      });
    });
    return Router_direct_response;
  } catch (error) {
    console.log(error);
    console.log("数据库连接失败");
  }
};