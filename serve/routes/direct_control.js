
// 用于接受映射数组获取请求的路由文件
import Router from "express";
const Router_direct_response = Router();

//在当前需要对Mysql数据库进行操作的文件中提前引入Mysql数据库的配置文件--需要注意的是indexNode文件中的其他引入的组件文件只是对indexNode本身编写的时候进行约束的文件
// import Config from "../indexNode2.js";//此处获取到数据库链接配置对象
import Config from "../indexNode3.js";//此处获取到数据库链接配置对象
let connection;//定义数据库连接对象
//导入mqtt模块--用于指令的正确发送响应 
import { beifen } from "./mqtt_server_get.js";

//定义获取当前时间并且为特定格式的方法
function getFormattedDate() {
  const now = new Date(); 
  const year = now.getFullYear();  
  const month = String(now.getMonth() + 1).padStart(2, '0'); // 月份从0开始，需要加1
  const day = String(now.getDate()).padStart(2, '0');
  const hours = String(now.getHours()).padStart(2, '0');
  const minutes = String(now.getMinutes()).padStart(2, '0');
  const seconds = String(now.getSeconds()).padStart(2, '0');
  return `${year}-${month}-${day} ${hours}:${minutes}:${seconds}`;
} 


(async ()=>{
  try{
    //异步执行Config，用于连接数据库,后续可对connection数据库链接对象进行数据库语法操作用于对数据库本身进行操作
    connection = await Config();
    console.log("数据库连接成功");
    // const result = await connection.execute(`
    //   SELECT c.id,c.f_type,c.mode,c.f_value,c.t_name,c.max,c.min,c.topic,c.header,c.luyou,t.value
    //   FROM t_direct t,t_direct_config c
    //   WHERE c.id = t.config_id
    //   AND ok in ("yes","yes1") 
    //   ORDER BY CASE f_type
    //       WHEN '1' THEN 1
    //       WHEN '5' THEN 2
    //       WHEN '3' THEN 3
    //       ELSE 4
    //     END;
    // `);
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
    //遍历完成全局路由绑定 
    rowx.forEach(async (item,index)=>{
      console.log("item:"+item.luyou);
      //需要注意content控制存入库中的值，tem11为指令值
      Router_direct_response.get("/zhiling/"+item.luyou,async(req,res)=>{
        console.log("成功进入32行阶段");
        let {content,d_no} = req.query;
        //备份内容的封装
        const obj1 = {};
        let tem1;
        let tem11;
        let topic;
 
        //首先判断item中的content字段是否可分
        if(item.f_type!=='2'&&item.f_type!=='3'&&item.f_type!=='4'){ 
          //定义区块变量--用于替代切割后的各个维度的内容
          const C1 = item.f_value.split("|")[0].split(":")[0];//中文第一个维度
          const C2 = item.f_value.split("|")[1].split(":")[0];//中文第二个维度
          const E1 = item.f_value.split("|")[0].split(":")[1];//英文第一个维度
          const E2 = item.f_value.split("|")[1].split(":")[1];//英文第二个维度
 
          //定义指令收尾变量--用于存储切割后的各个维度的内容
          const N1 = item.header.split("|")[0];//结尾第一个维度
          const N2 = item.header.split("|")[1];//结尾第二个维度
          tem1 = content === C1 ? E1 : E2;
          tem11 = content === C1 ? N1 : N2;
          topic =item.topic;
          obj1[tem1] = tem11;
          //中文更新
          content = content === C1 ? C1 : C2 ;
        }else{//输入框情况
          //定义时间格式化方法
          const formatTime = (timeStr) => new Date(timeStr).toISOString().slice(0, 19).replace('T', ' ');
          console.log("成功进入时间判断");
           tem1 = item.f_value.split("|")[0];
           if(content){//当不为单独值查询路由的情况
            if(item.f_type==="4"){//为时间值的情况下将content、tem11进行转化
              content = formatTime(content);
              console.log("时间值格式:"+content);
              tem11 = content.split(" ")[1];
              console.log("time:"+tem11);
             }
             else{
              tem11 = content;
             }
           } 
           else {//查询对应关联t_direct中的值
             const [rowsx] = await connection.execute(`
              SELECT t_direct.value
              FROM t_direct,t_direct_config
              WHERE t_direct_config.id = t_direct.config_id
              AND t_direct_config.id = ${item.id}
              AND d_no = "${d_no==="null"?"null":`${d_no}`}"
              `);
            if(item.f_type==="4"){//为时间值的情况下将
              tem11 = rowsx[0].value.split(" ")[1];
              console.log("time:"+tem11);
             }
             else {
              tem11 = content;
             }
           }
           topic = item.topic;
            if(item.id===12){
              tem11 = 'on'+d_no+'_'+content;
            }
           obj1[tem1] = tem11;
        }
        //指令发送以及是否备份的判断
        if(d_no){
          console.log("即将更新:"+d_no);
          const template = topic;
          console.log("tem:"+template);
          //发送指令，同时完成指令备份
          beifen(d_no,[template,obj1]);//在实际场景像需要将payload包装成value进行直接的传递--后续则直接在publish方法中使用...展开运算符传值即可


          //指令历史的记录
          await connection.execute(`
          INSERT INTO operate_history(place,device,operate,ctime)
          VALUES('${d_no}','${item.t_name}','修改为${content}','${getFormattedDate()}')
          `);

          //首先判断是否存在编号对应的内容
          const [row] = await connection.execute(`
          SELECT config_id
          FROM t_direct,t_direct_config
          WHERE t_direct_config.id = t_direct.config_id
          AND t_direct_config.id = ${item.id}
          AND d_no = "${d_no}"
          `);
          const [rows] = !row[0] ? await connection.execute(`
          INSERT INTO t_direct(config_id,value,d_no)
          VALUE(${item.id},"${content}","${d_no}")
          `) : await connection.execute(`
          UPDATE t_direct
          SET value = "${content}"
          WHERE config_id = ${item.id}
          `);
        }
        // res.send(!d_no ? item : "ok");
        res.send("ok");
        return;
      });
      Router_direct_response.get('/test111',(req,res)=>{
        res.send('ok');
      });
    })
  }
  catch(error){ 
    console.log(error);
    console.log("数据库连接失败");
  }
})();
 
//添加和对应的数据库操作的修改以及指令发送过程中为d_no不为null的情况的topic的修改,考虑为输入框进行提交而不是单纯的sign值的修改导致当前的请求的发送

export default Router_direct_response; 
