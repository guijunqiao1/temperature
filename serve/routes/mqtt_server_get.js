//导入mqtt模块
import mqtt from "mqtt";

//在当前需要对Mysql数据库进行操作的文件中提前引入Mysql数据库的配置文件--需要注意的是indexNode文件中的其他引入的组件文件只是对indexNode本身编写的时候进行约束的文件
import Config1 from "../indexNode2.js";//此处获取到数据库链接配置对象
import axios from "axios";
import WebSocket from "ws";

//定义全局测试启动变量以及工位启动变量、测试次数变量
export let test;
export let gongwei;
export let test_times = [];
let connection1;//定义数据库连接对象--project02
(async ()=>{
  try{
    //异步执行Config，用于连接数据库,后续可对connection数据库链接对象进行数据库语法操作用于对数据库本身进行操作
    connection1 = await Config1();
    console.log("数据库333333连接成功");
    const [rows] = await connection1.execute(`
      SELECT times 
      FROM t_data
      WHERE d_no = "工位1"
      ORDER BY times DESC
      LIMIT 1;
    `);
    console.log("成功了一次");
    test_times.push(rows[0]['times']);
    const [rows1] = await connection1.execute(`
      SELECT times 
      FROM t_data
      WHERE d_no = "工位2"
      ORDER BY times DESC
      LIMIT 1;
    `);
    test_times.push(rows1[0]['times']);
    const [rows2] = await connection1.execute(`
      SELECT times 
      FROM t_data
      WHERE d_no = "工位3"
      ORDER BY times DESC
      LIMIT 1;
    `);
    test_times.push(rows2[0]['times']);
    console.log("此时完成了test_times的赋值~~~~~~~~:"+test_times);
  }
  catch(error){ 
    console.log("数据库3连接失败");
  }
})();

//动态获取到多设备的总数，完成设备列表的填充
// const [rows1] = await connection1.execute(`
// SELECT d_no 
// FROM t_device
// WHERE device_name = "电动自行车"
// `);

//定义当前心跳是否正常的标志变量
// export let active_array = [[2021,false]];
export let active = false;
// for(let i=0;i<rows1[0].length;i++){
//   active_array.push([Number(rows1[0][i]),false]);
// }


//定义指令备份数组
// let zhiling_beifen_array = [];
// for(let i=0;i<rows1[0].length;i++){
//   zhiling_beifen_array.push([Number(rows1[0][i]),[]]);
// }
let zhiling_beifen_array = [];

//定义全局阶段性变量
let level = 0;
//定义准确的ID标识变量
let now_ID = null;


//定义临时变量用于控制每次入库的次数进行准确的监听
let tem = 0;


//设备存储
//指令备份数组的元素格式为：
// 设备编号,【主题，数据({payload,qos})，该设备所属的指令的类别】


// 方式：传感器直接支持MQTT 
// 控制台客户端对象         192.168.218.141'

export const client = mqtt.connect('mqtt://192.168.1.100',{
  clientId:"client_control",//唯一标识符
});  


//暴露错误队列，用于配合前端检测路由的指令发送
export const error_quene = [[],[],[]];

//定义延时函数
function delay(ms) {
  return new Promise(resolve => setTimeout(resolve, ms));
}
//定义获取当前时间并且为特定格式的方法
function getFormattedDate() {
  const now = new Date(); 
  const year = now.getFullYear();  
  const month = String(now.getMonth() + 1).padStart(2, '0'); // 月份从0开始，需要加1
  const day = String(now.getDate()).padStart(2, '0');
  const hours = String(now.getHours()).padStart(2, '0');
  const minutes = String(now.getMinutes()).padStart(2, '0');
  const seconds = String(now.getSeconds()).padStart(2, '0');
  return `${year}-${month}-${day}-${hours}-${minutes}-${seconds}`;
}
//定义获取当前时间并且为特定格式的方法
function getFormattedDate1() {
  const now = new Date(); 
  const year = now.getFullYear();  
  const month = String(now.getMonth() + 1).padStart(2, '0'); // 月份从0开始，需要加1
  const day = String(now.getDate()).padStart(2, '0');
  const hours = String(now.getHours()).padStart(2, '0');
  const minutes = String(now.getMinutes()).padStart(2, '0');
  const seconds = String(now.getSeconds()).padStart(2, '0');
  return `${year}-${month}-${day} ${hours}:${minutes}:${seconds}`;
}

 
// 心跳检测器
// 制作一个定时器用于定期向设备层订阅的主题中发送消息，并且设备层在接受到消息之后则响应相同的消息到应用层，用于检测设备层和应用层是不是直接的连接
// setInterval(()=>{
//   console.log("心跳正常发送");
//   // 单设备
//   active = false;
//   client.publish(`direct`,JSON.stringify({heartTest_client:"start"}),{qos:1});//多设备情况下考虑的文本内容得添加上设备的具体编号
//   //多设备
//   //首先对整个beifen数组进行缓存，并且根据其中的首元素的个数进行对应的主题的发送
//   // active_array.forEach((item,index)=>{
//   //   //在当前的item(某个不同的设备)中完成心跳的发送的操作并且将此时对应上的active标记
//   //   client.publish(`direct:${item[0]}`,JSON.stringify({heartTest_client:"start"}),{qos:1});//多设备情况下考虑的文本内容得添加上设备的具体编号
//   //   item[1] = false;
//   //   console.log("成功发送消息到主题direct:"+item[0]);
//   // })
// },5000);//每5s进行一次心跳的检测



//定义重发函数--针对重连的重发函数，封装
function reconnect_republish(value){//参数对应上了实际的响应的设备编号
  // 多设备
  // active_array.forEach((item,index)=>{
  //   if(item[0]===value){
  //     item[1] = true;//当接收到心跳重连的信息的时候进行备份数组的内容的重发布，并且后续在主动进行指令的配置的时候进行active的直接判断并且执行一次是否为active为false的情况并且将对应的指令的信息存入到beifen_array中
  //   }
  // });
  // 单设备
  active = true;
  //主动调用一次重发
  republish();
};

//定义重发函数--广义
async function republish(){
  // 多设备
  // const length = zhiling_beifen_array.length;
  // for(let i=0;i<length;i++){
  //   for(let j=0;zhiling_beifen_array[i][1].length;j++){
  //     if(zhiling_beifen_array.length>0&&zhiling_beifen_array[0].length>0&&zhiling_beifen_array[0][1].length>0){
  //         beifen(zhiling_beifen_array[i][0],zhiling_beifen_array[i][1][j]);//参数1为设备编号，参数2为指令本身内容
  //         zhiling_beifen_array.shift();
  //     }
  //     else{}
  //     await delay(3000);//单位为ms
  //   }
  // }
  // 单设备
  //首先检查长度
  console.log("zhiling_beifen_array_length:"+zhiling_beifen_array.length);
  console.log("zhiling_beifen:");
  console.dir(zhiling_beifen_array);
  const length = zhiling_beifen_array.length;
  console.log("length:"+length);
  for(let i=0;i<length;i++){
    // client.publish(...zhiling_beifen_array[i],{qos:1});
    // client.publish(...zhiling_beifen_array[i],{qos:1});
    console.log(zhiling_beifen_array[0]); 
    if(zhiling_beifen_array.length>0&&zhiling_beifen_array[0].length>0){
      beifen(1,zhiling_beifen_array[0]);
      zhiling_beifen_array.shift();
    }
    else{
      
    }
    await delay(3000);//单位为ms
  }
}

//定义备份函数--value2中的topic必须带上d_no的信息
export async function beifen(value1,value2){//一号位参数用于确定发送的指令类对应的编号、二号位参数用于传递给具体的报文信息
  //首先进行指令发送 
  client.publish(value2[0],JSON.stringify(value2[1]),{qos:1});
  await delay(1000);//单位为ms 
  client.publish(value2[0],JSON.stringify(value2[1]),{qos:1});

  // 多设备指令备份
  // active_array.forEach((item,index)=>{
  //   if(item[0]===value1&&item[1]===false){
  //   // 备份数组的内容填充
  //   zhiling_beifen_array[index][1].push(value2);//其中value2的格式为：[topic,JSON.stringify({origin:"bujindianji",content})]
  //   }
  // })
  // 单设备指令备份
  if(active===false){
    zhiling_beifen_array.push(value2);
    console.log("zhiling_beifen_array.length:"+zhiling_beifen_array.length);
  }
} 


//主题订阅数组(硬转软)
const topic_array = ['sensorData','state'];

//控制台客户端对象连接设置
client.on('connect', () => {
  console.log("接收方连接成功");
  //当客户端连接成功之后订阅对应的主题
  //用于检测传感器数据的主题
  topic_array.forEach((item,index)=>{
    client.subscribe(item,{qos:1},(err)=>{
      if(err){
        console.log(item+"主题订阅失败");
      }else{
        console.log(item+"主题订阅成功");
      }
    })
  })
});

client.on('disconnect', () => {
  console.log("断开连接");  
});

//创建websocket服务器用于实时的告警内容的填充
const wss = new WebSocket.Server({ port: 8081 });
console.log('WebSocket 服务器启动，端口：8081');  

// 存储所有WebSocket客户端
const clients = [];

// WebSocket连接处理
wss.on('connection', (ws, req) => {
  console.log('新客户端连接');
  clients.push(ws);
  
  // 发送欢迎消息
  ws.send(JSON.stringify({
    type: 'welcome',
    message: '告警系统连接成功'
  }));

  // 监听客户端发送的消息
  ws.on('message', (message) => {
    // 这里的 message 是客户端发送的数据
    console.log('接收到客户端消息:', message);
    // 你可以在这里对消息进行处理，比如解析 JSON 或其他逻辑
    const data = JSON.parse(message);
    console.log("message:"+message);
    console.log("data:"+data);
    if(data['gongwei']){
      gongwei = data['gongwei'];
    }else if(data['test']||data['test']===false){
      test = data['test'];
    }else if(data['test_times']||data['test_times']===0){
      console.log("应当完成自增");
      if(data['test_times']===0) test_times[0]++;
      else if(data['test_times']===1) test_times[1]++;
      else if(data['test_times']===2) test_times[2]++;
    }else {
      console.log("没有v匹配上/");
    }
  });

  // 监听客户端断开
  ws.on('close', () => {
    console.log('客户端断开连接');
    const index = clients.indexOf(ws);
    if (index > -1) {
      clients.splice(index, 1);
    }
  });
}); 


// 向所有客户端发送消息的函数
function sendToAllClients(data) {    
  console.log("11111111111111111111111111111111");
  clients.forEach(client => {
  console.log("222222222222222222222222222222");
    if (client.readyState === WebSocket.OPEN) { 
      try {
        console.log("查看一次总data:");
        console.dir(data);
        client.send(data);
      } catch (error) { 
        console.error('发送消息失败:', error);
      }
    }
  });
} 


//监听控制台客户端对象收到的消息--接收方完成即可
client.on('message',async (topic, message)=>{
  //初始化温度、湿度、光照阈值的变量
  let tem_Y1 = 0;
  let tem_Y2 = 100;
  let shi_Y1 = 0;
  let shi_Y2 = 100;
  let light_Y1 = 15;
  let light_Y2 = 100;


  //阈值越界方法定义
  function temperature_panduan(value){
    if(value>=tem_Y1&&value<=tem_Y2) return false;
    else {
      if(value<tem_Y1){
        return 1;
      }else{
        return 2;
      }
    };
  }
  function smoke_panduan(value){
    if(value>=shi_Y1&&value<=shi_Y2) return false;
    else {
      if(value<shi_Y1){
        return 1;
      }else{
        return 2;
      }
    };
  }
  function shuiwei_panduan(value){
    if(value>=light_Y1&&value<=light_Y2) return false;
    else {
      if(value<light_Y1){
        return 1;
      }else{
        return 2;
      }
    };
  }
  console.log("成功接收到消息");
  //告警
  if(topic === "sensorData"){
    console.log("成功接收到消息");
    //需要注意使用await使得promise对象的值被解析进而允许使用[x]= 的方式完成数组顺序赋值
    const [rows1] = await connection1.execute(`
      SELECT p_name
      FROM t_field_mapper
      `);//为{ p_name:TI,p_name:TO,p_name:L}的结构
    // 首先获取到指标变量的内容
    console.log("接收到传感器数据");
    console.log(JSON.parse(message));
    let { d_no,temperature1,temperature2,temperature3,humility1,humility2,humility3,light1,light2,light3,I1,I2,I3,V1,V2,V3,type } = JSON.parse(message);

    //定义对象名称映射变量
    const reflect = { };
    reflect['temperature1'] = sensorTolittle(temperature1);
    reflect['temperature2'] = sensorTolittle(temperature2);
    reflect['temperature3'] = sensorTolittle(temperature3);
    reflect['humility1'] = sensorTolittle(humility1);
    reflect['humility2'] = sensorTolittle(humility2);
    reflect['humility3'] = sensorTolittle(humility3);
    reflect['light1'] = light1;
    reflect['light2'] = light2;
    reflect['light3'] = light3;
    reflect['I1'] = I1;
    reflect['I2'] = I2;
    reflect['I3'] = I3;
    reflect['V1'] = V1;
    reflect['V2'] = V2;
    reflect['V3'] = V3;

    //封装电维度的公式
    function toV(V){
      return Number(V).toFixed(2);
    }
    function toI(I){
      return Number(I).toFixed(2);
    }
    function getP(I,V){
      return I * V;
    }
    function getQ(I){
      return I * 1;
    }
    function getW(P){
      return P * 1;
    }

    //减少小数点的方法
    function sensorTolittle(value){
      return value.toFixed(1);
    }



    //公共块封装
    async function gong_right(value){
      //基础时间值获取
      const time_base = getFormattedDate1();
      //数据库中映射字段的使用
      const obj = {};
      rows1.forEach((item,index)=>{
        if(index===0){
          obj[item.p_name] = reflect['temperature'+value];//由于为对象的最新属性进行初始化故无法直接使用.运算符进行属性的索引赋值而应该使用的是[]进行属性名的直接获取
        }
        else if(index===1){
          obj[item.p_name] = reflect['humility'+value];
        }
        else if(index===2){
          obj[item.p_name] = reflect['light'+value];
        }
        else if(index===3){
          obj[item.p_name] = toV(reflect['V'+value]);
        }
        else if(index===4){
          obj[item.p_name] = toI(reflect['I'+value]);
        }
        else if(index===5){
          obj[item.p_name] = getP(toV(reflect['V'+value]),toI(reflect['I'+value]));
        }
        else if(index===6){
          obj[item.p_name] = getQ(toI(reflect['I'+value]));
        }
        else if(index===7){
          obj[item.p_name] = getW(getP(toV(reflect['V'+value]),toI(reflect['I'+value])));
        }
      })
      // 将传感器数据存入到t_data中
      if(!type){
        type="实时数据";
      }
      // 当d_no不存在时：
      if(!d_no){
        d_no = null;
      }
      // const time = `${time_base.split("-")[0]}-${time_base.split("-")[1]}-${time_base.split("-")[2]} ${hour}:${minute}:${second}`;
      const [rows] = await connection1.execute(`
      INSERT INTO t_data(d_no,field1,field2,field3,field4,field5,field6,field7,field8,c_time,type,times)
      VALUES ("工位${value}","${obj.T}","${obj.S}","${obj.L}","${obj.U}","${obj.I}","${obj.P}","${obj.Q}","${obj.W}","${time_base}","${type}","${test_times[value-1]}")
      `);
      //插入成功则发送动态数据
      // 发送消息
      sendToAllClients(JSON.stringify({
        type: 'data',
        data: ['工位'+value,obj.T,obj.S,obj.L,obj.U,obj.I,obj.P,obj.Q,obj.W,time_base,type,test_times[value-1]],
      }));
    }
    async function gong_tem(value,value1){
      if(value1===1){//过小的情况
        //向错误处理队列中添加上温度偏小的告警
        error_quene[0].push({type:'温度',how:'偏小'});
        await connection1.execute(`
          INSERT INTO t_error_msg(d_no,e_msg,c_time,type)
          VALUES("工位${value}",'温度越界',"${getFormattedDate1()}",'偏小');
          `);
          console.log("--------------------------");
        // 发送消息
        sendToAllClients(JSON.stringify({
            type: 'welcome',
            message: `工位${value}的温度越界`,
        }));
      }else{
        error_quene[0].push({type:'温度',how:'偏大'});
        await connection1.execute(`
          INSERT INTO t_error_msg(d_no,e_msg,c_time,type)
          VALUES("工位${value}",'温度越界',"${getFormattedDate1()}",'偏大');
          `);
          console.log("--------------------------");
        // 发送消息
        sendToAllClients(JSON.stringify({
            type: 'welcome',
            message: `工位${value}的温度越界`,
        }));
      }
    }
    async function gong_smo(value,value1){
      if(value1===1){
        error_quene[1].push({type:'湿度',how:'偏小'});
        await connection1.execute(`
          INSERT INTO t_error_msg(d_no,e_msg,c_time,type)
          VALUES("工位${value}",'湿度越界',"${getFormattedDate1()}",'偏小');
          `);
        // 发送消息
        sendToAllClients(JSON.stringify({
            type: 'welcome',
            message: `工位${value}的湿度越界`,
        }));
      }
      else{
        error_quene[1].push({type:'湿度',how:'偏大'});
        await connection1.execute(`
          INSERT INTO t_error_msg(d_no,e_msg,c_time,type)
          VALUES("工位${value}",'湿度越界',"${getFormattedDate1()}",'偏大');
          `);
        // 发送消息
        sendToAllClients(JSON.stringify({
            type: 'welcome',
            message: `工位${value}的湿度越界`,
        }));
      }

    }
    async function gong_wat(value,value1){
      if(value1===1){
        error_quene[2].push({type:'光照',how:'偏小'});
        await connection1.execute(`
          INSERT INTO t_error_msg(d_no,e_msg,c_time,type)
          VALUES("工位${value}",'光照越界',"${getFormattedDate1()}",'偏小');
          `);
        // 发送消息
        sendToAllClients(JSON.stringify({
            type: 'welcome',
            message: `工位${value}的光照越界`,
        }));
      }else{
        error_quene[2].push({type:'光照',how:'偏大'});
        await connection1.execute(`
          INSERT INTO t_error_msg(d_no,e_msg,c_time,type)
          VALUES("工位${value}",'光照越界',"${getFormattedDate1()}",'偏大');
          `);
        // 发送消息
        sendToAllClients(JSON.stringify({
            type: 'welcome',
            message: `工位${value}的光照越界`,
        }));
      }
    }

    console.log("条件就差一点点:");
    console.log("gongwei:"+gongwei);
    console.log("test:"+test);
    //首先判断值是否合法后进行插入
    if(test&&gongwei==='工位1'){
      console.log("进入啦啦啦啦");
      //当处于test的过程的情况下
      if(!temperature_panduan(temperature1)&&!smoke_panduan(humility1)&&!shuiwei_panduan(light1)){ 
        gong_right(1);
      }else{
        //插入告警表，最后发送错误消息到前端监听的路由中
        if(temperature_panduan(temperature1)){//温度出错
          gong_tem(1,temperature_panduan(temperature1));
        }
        if(smoke_panduan(humility1)){//烟雾出错
          gong_smo(1,smoke_panduan(humility1));
        }
        if(shuiwei_panduan(light1)){//水位出错
          gong_wat(1,shuiwei_panduan(light1));
        }
      }
    }
    if(test&&gongwei==='工位2'){
      if(!temperature_panduan(temperature2)&&!smoke_panduan(humility2)&&!shuiwei_panduan(light2)){
        gong_right(2);
      }else{
        //插入告警表，最后发送错误消息到前端监听的路由中
        if(temperature_panduan(temperature2)){//温度出错
          gong_tem(2,temperature_panduan(temperature2));
        }
        if(smoke_panduan(humility2)){//烟雾出错
          gong_smo(2,smoke_panduan(humility2));
        }
        if(shuiwei_panduan(light2)){//水位出错
          gong_wat(2,shuiwei_panduan(light2));
        }
      }
    }
    if(test&&gongwei==='工位3'){
      if(!temperature_panduan(temperature3)&&!smoke_panduan(humility3)&&!shuiwei_panduan(light3)){
        gong_right(3);
      }else{
        //插入告警表，最后发送错误消息到前端监听的路由中
        if(temperature_panduan(temperature3)){//温度出错
          gong_tem(3,temperature_panduan(temperature3));
        }
        if(smoke_panduan(humility3)){//烟雾出错
          gong_smo(3,smoke_panduan(humility3));
        }
        if(shuiwei_panduan(light3)){//水位出错
          gong_wat(3,shuiwei_panduan(light3));
        }
      }
    }
  }
  //重发数据
  // else if(topic === "miss_data"){
  //   console.log("接收到了");
  //   let { d_no,neibuwendu,waibuwendu,guangzhao,type,hour,minute,second} = JSON.parse(message);
  //   if(neibuwendu>0&&waibuwendu>0&&guangzhao>0){
  //     const [rows1] = await connection1.execute(`
  //     SELECT p_name
  //     FROM t_field_mapper
  //     `);//为{ p_name:S1,p_name:S2,p_name:I}的结构
  //     // 首先获取到指标变量的内容
  //     console.log("接收到传感器数据");
  //     console.log(JSON.parse(message));
  //     //基础时间值获取
  //     const time_base = getFormattedDate();
  //     //数据库中映射字段的使用
  //     const obj = {}; 
  //     rows1.forEach((item,index)=>{
  //       if(index===0){
  //         obj[item.p_name] = neibuwendu;//由于为对象的最新属性进行初始化故无法直接使用.运算符进行属性的索引赋值而应该使用的是[]进行属性名的直接获取
  //       }
  //       else if(index===1){
  //         obj[item.p_name] = waibuwendu;
  //       }
  //       else if(index===2){
  //         obj[item.p_name] = guangzhao;
  //       }
  //     })
  //     // //将传感器数据存入到t_data中
  //     if(!type){
  //       type="保存数据";
  //     }
  //     if(!d_no){
  //       d_no = null;
  //     }
  //     const time = `${time_base.split("-")[0]}-${time_base.split("-")[1]}-${time_base.split("-")[2]} ${hour}:${minute}:${second}`;
  //     const [rows] = await connection1.execute(`
  //     INSERT INTO t_data(d_no,field1,field2,field3,field4,c_time,type)
  //     VALUES ("${d_no}","${obj.TI}","${obj.TO}","${obj.L}","1","${time}","${type}")
  //     `);
  //   }
  // } 
  else if(topic==="heartbeat"){//当发送的心跳消息得到响应的时候的主题消息的内容的执行 --心跳信息中应当存在设备编号的信息
    console.log("收到底层心跳");
    // 单设备
    // reconnect_republish();//完成对应设备的心跳置true
    // 多设备
    //获取到d_no信息
    const {d_no} = JSON.parse(message);
    reconnect_republish(d_no);//完成对应设备的心跳置true
  }
  // 接收到底层的自动模式下的修改控件状态的指令的情况
  else if(topic==="state"){
    console.log("chenggo进入cichu");
    //解构赋值获取参数--需要设计参数名和路由名称一致完成遍历的条件设计
    let { current } = JSON.parse(message);
    // for (let key in obj) {
    //   //首先将中文值进行转化
    //   if(Number.isNaN(Number(obj.key))){//若为中文值
    //     if(obj.key==="start"||obj.key==="stop"){
    //       obj.key = obj.key==="start"?"开":"关";
    //     }
    //     else if(obj.key==="hot"||obj.key==="cold"){
    //       obj.key = obj.key==="hot"?"制热":"制冷";
    //     }
    //   }
    //   const [rows] = await connection1.execute(`
    //   UPDATE t_direct
    //   SET value = '${obj.key}'
    //   WHERE config_id IN (
    //       SELECT id
    //       FROM t_direct_config
    //       WHERE luyou = ${key}
    //   );
    //   `);
    // }
    console.log("current:"+current);
    const [rows] = await connection1.execute(`
    UPDATE t_direct
    SET value = '${(current.split('_')[1])==='0'?'关':'开'}'
    WHERE d_no = '工位${current.split("n")[1][0]}';
    `);


    //设备修改记录添加
    const [rows1] = await connection1.execute(`
    INSERT INTO operate_history(place,operate,ctime,device)
    VALUES ('工位${current.split("n")[1][0]}','修改为${(current.split('_')[1])==='0'?'关':'开'}','${getFormattedDate1()}','电磁阀开关')
    `);

  }
  // else if (topic==="alarm"){
  //   const { Vstatus } = JSON.parse(message);
  //   const [rows] = await connection1.execute(`
  //     UPDATE t_error_msg
  //     SET e_msg = "${Vstatus==="1"?"空调故障": (Vstatus==="2"?"风扇故障": Vstatus==="3"?"危险气体浓度超标":Vstatus==="4"? "湿度超标":"储运箱断电时间过长")}", c_time = "${getFormattedDate()}"
  //     WHERE id = ${Number(Vstatus)};
  //   `);
  //   const [rows0] = await connection1.execute(`
  //     UPDATE t_error_msg
  //     SET VStatus = "1"; 
  //   `);
  //   //添加错误历史记录 
  //   const [rows1] = await connection1.execute(`
  //   INSERT INTO t_error_history(e_msg,c_time)
  //   VALUES ("${Vstatus==="1"?"空调故障": (Vstatus==="2"?"风扇故障": Vstatus==="3"?"危险气体浓度超标":Vstatus==="4"? "湿度超标":"储运箱断电时间过长")}","${getFormattedDate()}")
  //   `); 
  // }
  // else if(topic==="alarm1"){
  //   console.log("alarm1成功触发");
  //   const {OK} = JSON.parse(message);
  //     const [rows] = await connection1.execute(`
  //     UPDATE t_error_msg
  //     SET e_msg = "未发生告警", c_time = "${getFormattedDate()}" 
  //     WHERE id = ${Number(OK)};
  //   `); 
  //   //判断是否都恢复正常
  //   const [rows1] = await connection1.execute(`
  //     SELECT e_msg
  //     FROM t_error_msg 
  //   `);
  //   console.dir("rows1:"+rows1); 
  //   //遍历判断e_msg值
  //   let sum = 0;
  //   for(let i=0 ;i<5;i++){
  //     if(rows1[i].e_msg==="未发生告警"){
  //       sum++;
  //     }
  //     else{
  //       break;
  //     }
  //   }
  //   if(sum===5){
  //     const [rows2] = await connection1.execute(`
  //     UPDATE t_error_msg
  //     SET VStatus = "0";
  //   `);
  //   }
  // }
  // else if(topic === "chonglian"){
  //   // 同步系统时间到设备层 now_time NowTime:...
  //   console.log("当前接收到重连消息");
  //   setTimeout(()=>{
  //     beifen(0,["chonglian1",{time:`${getTongbu()}`}]);//发布当前时间信息到同步时间相关的主题中
  //   },10000);
  // } 
  // //接收到储物箱存储的消息
  // else if(topic === "direct1"){
  //   const {PID,VID} = JSON.parse(message);
  //   const [rows] = await connection1.execute(`
  //   INSERT INTO t_container(VID,ctime,PID)
  //   VALUES ("${VID}","${getFormattedDate()}","${PID}")
  //   `);
  // } 
});



//模拟发送传感器数据的客户端
// setInterval(async()=>{
//   client.publish("sensorData",JSON.stringify({ temperature1:1,temperature2:2,temperature3:3,humility1:1,humility2:2,humility3:3,light1:1,light2:2,light3:3,I:1,V:2,type:"实时数据"}),{qos:1});
// },1000);