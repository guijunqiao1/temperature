// KOA2
import Router from "koa-router";
const Router_direct_response = new Router();

import Config from "../indexNode2.js";
let connection;

import { beifen } from "./mqtt_server_get.js";

import { error_quene } from "./mqtt_server_get.js";

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
        if (item.f_type !== '2' && item.f_type !== '3' && item.f_type !== '4') {//开关或单选框的情况
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
            tem11 = 'on' + d_no.split("工位")[1] + '_' + (content === "开" ? '4' : '0');
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
          if (item.id === 12) { //  "开:deng": "on工位1_2"
            console.log("最终进入的是此处");
            console.log("最终进入的是此处");
            console.log("最终进入的是此处");
            console.log("最终进入的是此处");
            tem1 = item.f_value.split("|")[0].split(":")[1];
            //临时content转化
            content = content === '开'?4:0;
            tem11 = 'on' + d_no.split("工位")[1] + '_' + content;
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
          //指令更新完毕后进行全局变量的阈值的赋值
          if(item.f_type==='2'){//针对阈值情况进行单独全局变量的修改
            console.log("检查后发现的内容为,item:");
            console.dir(item);
            console.log("检查后发现的内容为,obj1:");
            console.dir(obj1);
            beifen(d_no, ['change_yuzhi', obj1]);
          }
        }
        ctx.body = "ok";
      });
      //测试路由
      Router_direct_response.get('/test111', (ctx) => {
        ctx.body = 'ok';
      });
      //检测情况下的操作设备接口
      Router_direct_response.get('/operate_device',(ctx) => {
        const { d_no } = ctx.query;

        console.log("-----------------------------------------------");
        //定义纯净数组
        const pure_array = [];

        //定义纯净数组的检查方法
        function pure_panduan(value){
          //定义标记变量
          let sign = false;
          pure_array.forEach((item,index)=>{
            if(item.type===value.type) sign = true;
          })
          return sign;
        }
        //浅拷贝只读数组
        //模拟情况
        let qian_array = [...error_quene];
        console.log("查看当前数组："); 
        console.dir(qian_array);
        //定义错误队列的相同维度下优先取得后续维度情况下的how的取值的处理去重方法
        function qu_quene(value){
          for(let i=qian_array[value].length-1;i>=0;i--){
            console.log("进入一次遍历");
            if(qian_array[value][i].type==='温度'&&!pure_panduan(qian_array[value][i])){
              pure_array.push(qian_array[value][i]);
            }
            else if(qian_array[value][i].type==='湿度'&&!pure_panduan(qian_array[value][i])){
              pure_array.push(qian_array[value][i]);
            }
            else if(qian_array[value][i].type==='光照'&&!pure_panduan(qian_array[value][i])){
              pure_array.push(qian_array[value][i]);
            }
            if(pure_array.length===3){
              break;
            }
          }
        }
        //定义主题变量
        const topic = 'send';
        //定义工位标准偏移索引变量
        let d_no_index;
        if(d_no==='工位1'){
          d_no_index = 0;
        }else if(d_no==='工位2'){
          d_no_index = 1;
        }else if(d_no==='工位3'){
          d_no_index = 2;
        }
        console.log("当前成功进入指令自动push接口");
        //遍历前进行error_quene的去重
        qu_quene(d_no_index);
        console.log("去重后的只读数组:");
        console.dir(pure_array);
        pure_array.forEach((item,index)=>{
          if(item.type==='温度') {
            const obj1 = {  };
            const obj2 = {  };
            if(item.how==='偏大'){
              //发送指定指令
              beifen(d_no, [topic , obj1]);
            }else{
              beifen(d_no, [topic , obj2]);
            }
          }
          else if(item.type==='湿度') {
            const obj1 = {  };
            const obj2 = {  };
            if(item.how==='偏大'){
              //发送指定指令
              beifen(d_no, [topic , obj1]);
            }else{
              beifen(d_no, [topic , obj2]);
            }
          }
          else if(item.type==='光照') { 
            const obj1 = { "deng":`on${d_no_index+1}_0` };
            const obj2 = { "deng":`on${d_no_index+1}_4` };
            if(item.how==='偏大'){
              //发送指定指令
              beifen(d_no, [topic , obj1]);
            }else{
              beifen(d_no, [topic , obj2]);
            }
          }
        })
        //静止之后进行总数组的清空
        for(let i=0;i<qian_array[d_no_index].length;i++){
          qian_array[d_no_index].shift();
          error_quene[d_no_index].shift();
        }
        ctx.body = 'ok';
      })
    });
    return Router_direct_response;
  } catch (error) {
    console.log(error);
    console.log("数据库连接失败");
  }
};