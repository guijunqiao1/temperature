//导入mqtt模块
import mqtt from "mqtt";

//在当前需要对Mysql数据库进行操作的文件中提前引入Mysql数据库的配置文件--需要注意的是indexNode文件中的其他引入的组件文件只是对indexNode本身编写的时候进行约束的文件
import Config1 from "../indexNode3.js";//此处获取到数据库链接配置对象

let connection1;//定义数据库连接对象--project02

(async ()=>{
  try{
    //异步执行Config，用于连接数据库,后续可对connection数据库链接对象进行数据库语法操作用于对数据库本身进行操作
    connection1 = await Config1();
    console.log("数据库3连接成功");
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

export const client = mqtt.connect('mqtt://127.0.0.1',{
  clientId:"client_control",//唯一标识符
}); 

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
//同步时间格式的方法
function getTongbu() {
  const now = new Date();
  const hours = String(now.getHours()).padStart(2, '0');
  const minutes = String(now.getMinutes()).padStart(2, '0');
  const seconds = String(now.getSeconds()).padStart(2, '0');
  return `${hours}:${minutes}:${seconds}`;
}

 
// 心跳检测器
// 制作一个定时器用于定期向设备层订阅的主题中发送消息，并且设备层在接受到消息之后则响应相同的消息到应用层，用于检测设备层和应用层是不是直接的连接
setInterval(()=>{
  console.log("心跳正常发送");
  // 单设备
  active = false;
  client.publish(`direct`,JSON.stringify({heartTest_client:"start"}),{qos:1});//多设备情况下考虑的文本内容得添加上设备的具体编号
  //多设备
  //首先对整个beifen数组进行缓存，并且根据其中的首元素的个数进行对应的主题的发送
  // active_array.forEach((item,index)=>{
  //   //在当前的item(某个不同的设备)中完成心跳的发送的操作并且将此时对应上的active标记
  //   client.publish(`direct:${item[0]}`,JSON.stringify({heartTest_client:"start"}),{qos:1});//多设备情况下考虑的文本内容得添加上设备的具体编号
  //   item[1] = false;
  //   console.log("成功发送消息到主题direct:"+item[0]);
  // })
},5000);//每5s进行一次心跳的检测



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


//控制台客户端对象连接设置
client.on('connect', () => {
  console.log("接收方连接成功");
  //当客户端连接成功之后订阅对应的主题
  //用于检测传感器数据的主题
  client.subscribe('sensor/data',{qos:1},(err)=>{
    if(err){
      console.log("sensor/data主题订阅失败");
    }
    else{
      console.log("sensor/data主题订阅成功")
    }
  });
  //用于检测告警信息发送过来的主题
  client.subscribe('sensor/alarm',{qos:1}, (err) => {
    if (!err) {
      console.log('成功订阅 sensor/alarm');
    } else {
      console.log('失败订阅 sensor/alarm');
    }
  });
  //主动订阅保存状态下的传感器数据主题
  client.subscribe('miss_data',{qos:1},(err)=>{
    if(err){
      console.log("miss_data主题订阅失败");
    }
    else{
      console.log("miss_data主题订阅成功")
    }
  });
  //主动订阅心跳主题
  client.subscribe('heartbeat',{qos:1},(err)=>{
    if(err){
      console.log("订阅sensor/heartTest_device主题失败");
    }
    else{
      console.log("订阅sensor/heartTest_device主题成功");
    }
  });
  //主动订阅自动模式下修改控件的监听主题
  // client.subscribe('veiw',{qos:1},(err)=>{
  //   if(err){
  //     console.log("订阅view主题失败");
  //   } 
  //   else{
  //     console.log("订阅view主题成功");
  //   }
  // });
  //主动订阅入库主题
  client.subscribe('direct1',{qos:1},(err)=>{
    if(err){
      console.log("订阅direct1主题失败");
    }
    else{
      console.log("订阅direct1主题成功");
    }
  });
  client.subscribe('alarm',{qos:1},(err)=>{
    if(err){
      console.log("订阅alarm主题失败");
    }
    else{
      console.log("订阅alarm主题成功");
    }
  });
  client.subscribe('alarm1',{qos:1},(err)=>{
    if(err){
      console.log("订阅alarm1主题失败");
    }
    else{
      console.log("订阅alarm1主题成功");
    }
  });
  client.subscribe('chonglian',{qos:1},(err)=>{
    if(err){
      console.log("订阅chonglian主题失败");
    }
    else{
      console.log("订阅chonglian主题成功");
    }
  });
});

client.on('disconnect', () => {
  console.log("断开连接");
});

//监听控制台客户端对象收到的消息--接收方完成即可
client.on('message', async (topic, message) => {
  //告警
  if(topic === "sensor/data"){
    console.log("成功接收到消息");
    //需要注意使用await使得promise对象的值被解析进而允许使用[x]= 的方式完成数组顺序赋值
    const [rows1] = await connection1.execute(`
      SELECT p_name 
      FROM t_field_mapper
      `);//为{ p_name:TI,p_name:TO,p_name:L}的结构

    // 首先获取到指标变量的内容 
    console.log("接收到传感器数据");
    console.log(JSON.parse(message));
    let { d_no,waibuwendu,neibuwendu,guangzhao,type} = JSON.parse(message);
    //首先判断值是否合法后进行插入
    if(waibuwendu>0&&neibuwendu>0&&guangzhao>0){
      //基础时间值获取
      const time_base = getFormattedDate();
      //数据库中映射字段的使用
      const obj = {};
      rows1.forEach((item,index)=>{
        if(index===0){
          obj[item.p_name] = neibuwendu;//由于为对象的最新属性进行初始化故无法直接使用.运算符进行属性的索引赋值而应该使用的是[]进行属性名的直接获取
        }
        else if(index===1){
          obj[item.p_name] = waibuwendu;
        }
        else if(index===2){
          obj[item.p_name] = guangzhao;
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
      INSERT INTO t_data(d_no,field1,field2,field3,field4,c_time,type)
      VALUES ("${d_no}","${obj.T}","${obj.S}","${obj.L}","1","${time_base}","${type}")
      `);
    }
  }
  //重发数据
  else if(topic === "miss_data"){
    console.log("接收到了");
    let { d_no,neibuwendu,waibuwendu,guangzhao,type,hour,minute,second} = JSON.parse(message);
    if(neibuwendu>0&&waibuwendu>0&&guangzhao>0){
      const [rows1] = await connection1.execute(`
      SELECT p_name
      FROM t_field_mapper
      `);//为{ p_name:S1,p_name:S2,p_name:I}的结构
      // 首先获取到指标变量的内容
      console.log("接收到传感器数据");
      console.log(JSON.parse(message));
      //基础时间值获取
      const time_base = getFormattedDate();
      //数据库中映射字段的使用
      const obj = {}; 
      rows1.forEach((item,index)=>{
        if(index===0){
          obj[item.p_name] = neibuwendu;//由于为对象的最新属性进行初始化故无法直接使用.运算符进行属性的索引赋值而应该使用的是[]进行属性名的直接获取
        }
        else if(index===1){
          obj[item.p_name] = waibuwendu;
        }
        else if(index===2){
          obj[item.p_name] = guangzhao;
        }
      })
      // //将传感器数据存入到t_data中
      if(!type){
        type="保存数据";
      }
      if(!d_no){
        d_no = null;
      }
      const time = `${time_base.split("-")[0]}-${time_base.split("-")[1]}-${time_base.split("-")[2]} ${hour}:${minute}:${second}`;
      const [rows] = await connection1.execute(`
      INSERT INTO t_data(d_no,field1,field2,field3,field4,c_time,type)
      VALUES ("${d_no}","${obj.TI}","${obj.TO}","${obj.L}","1","${time}","${type}")
      `);
    }
  } 
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
  // else if(topic==="veiw"){
  //   //解构赋值获取参数--需要设计参数名和路由名称一致完成遍历的条件设计
  //   let obj = { fengshan,fengshanV,kongtiao,kongtiaoP,kongtiaoM,deng } = JSON.parse(message);
  //   for (let key in obj) {
  //     //首先将中文值进行转化
  //     if(Number.isNaN(Number(obj.key))){//若为中文值
  //       if(obj.key==="start"||obj.key==="stop"){
  //         obj.key = obj.key==="start"?"开":"关";
  //       }
  //       else if(obj.key==="hot"||obj.key==="cold"){
  //         obj.key = obj.key==="hot"?"制热":"制冷";
  //       }
  //     }
  //     const [rows] = await connection1.execute(`
  //     UPDATE t_direct
  //     SET value = '${obj.key}'
  //     WHERE config_id IN (
  //         SELECT id
  //         FROM t_direct_config
  //         WHERE luyou = ${key}
  //     );
  //     `);
  //   }
  // }
  else if (topic==="alarm"){
    const { Vstatus } = JSON.parse(message);
    const [rows] = await connection1.execute(`
      UPDATE t_error_msg
      SET e_msg = "${Vstatus==="1"?"空调故障": (Vstatus==="2"?"风扇故障": Vstatus==="3"?"危险气体浓度超标":Vstatus==="4"? "湿度超标":"储运箱断电时间过长")}", c_time = "${getFormattedDate()}"
      WHERE id = ${Number(Vstatus)};
    `);
    const [rows0] = await connection1.execute(`
      UPDATE t_error_msg
      SET VStatus = "1"; 
    `);
    //添加错误历史记录 
    const [rows1] = await connection1.execute(`
    INSERT INTO t_error_history(e_msg,c_time)
    VALUES ("${Vstatus==="1"?"空调故障": (Vstatus==="2"?"风扇故障": Vstatus==="3"?"危险气体浓度超标":Vstatus==="4"? "湿度超标":"储运箱断电时间过长")}","${getFormattedDate()}")
    `); 
  }
  else if(topic==="alarm1"){
    console.log("alarm1成功触发");
    const {OK} = JSON.parse(message);
      const [rows] = await connection1.execute(`
      UPDATE t_error_msg
      SET e_msg = "未发生告警", c_time = "${getFormattedDate()}" 
      WHERE id = ${Number(OK)};
    `); 
    //判断是否都恢复正常
    const [rows1] = await connection1.execute(`
      SELECT e_msg
      FROM t_error_msg 
    `);
    console.dir("rows1:"+rows1); 
    //遍历判断e_msg值
    let sum = 0;
    for(let i=0 ;i<5;i++){
      if(rows1[i].e_msg==="未发生告警"){
        sum++;
      }
      else{
        break;
      }
    }
    if(sum===5){
      const [rows2] = await connection1.execute(`
      UPDATE t_error_msg
      SET VStatus = "0";
    `);
    }
  }
  else if(topic === "chonglian"){
    // 同步系统时间到设备层 now_time NowTime:...
    console.log("当前接收到重连消息");
    setTimeout(()=>{
      beifen(0,["chonglian1",{time:`${getTongbu()}`}]);//发布当前时间信息到同步时间相关的主题中
    },10000);
  } 
  //接收到储物箱存储的消息
  else if(topic === "direct1"){
    const {PID,VID} = JSON.parse(message);
    const [rows] = await connection1.execute(`
    INSERT INTO t_container(VID,ctime,PID)
    VALUES ("${VID}","${getFormattedDate()}","${PID}")
    `);
  } 
});



// //模拟发送传感器数据的客户端
// setInterval(async()=>{
//   const min = 10;
//   const max = 30
//   const randomDecimal1 = Math.random() * (max - min) + min;
//   const randomDecimal2 = Math.random() * (max - min) + min;
//   const randomDecimal3 = Math.random()>0.5? 1:0 ;
//   client.publish("sensor/data",JSON.stringify({yanwu1:randomDecimal1.toFixed(2),yanwu2:randomDecimal2.toFixed(2),warning_flag:randomDecimal3}),{qos:1});
// },2000);
