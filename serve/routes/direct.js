


//用于接受映射数组获取请求的路由文件
import Router from "express";
const Router_direct = Router();


//在当前需要对Mysql数据库进行操作的文件中提前引入Mysql数据库的配置文件--需要注意的是indexNode文件中的其他引入的组件文件只是对indexNode本身编写的时候进行约束的文件
import Config2 from "../indexNode2.js";//此处获取到数据库链接配置对象
let connection;//定义数据库连接对象
(async ()=>{
  try{
    //异步执行Config，用于连接数据库,后续可对connection数据库链接对象进行数据库语法操作用于对数据库本身进行操作
    connection = await Config2();
    console.log("数据库2连接成功");
  }
  catch(error){
    console.log("数据库2连接失败");
  }
})();


//额外绑定获取所有数据的路由
Router_direct.get("/zhiling",async (req,res)=>{
  const {mode,d_no} = req.query;
  const result = await connection.execute(`
  SELECT c.id,c.f_type,c.mode,c.f_value,c.t_name,c.max,c.min,c.topic,c.header,c.luyou,t.value,c.label_boolean,c.label,t.d_no
  FROM t_direct t,t_direct_config c
  WHERE c.id = t.config_id
  AND ok in ("yes","yes1")
  AND c.mode = "${mode}"
  AND t.d_no = "${(d_no)? d_no:'null'}"
  ORDER BY CASE f_type
      WHEN '1' THEN 1
      WHEN '5' THEN 2
      WHEN '3' THEN 3
      ELSE 4
    END;
  `);
  let rowx = result[0];

  //时间格式化方法
  // const formatTime = (timeStr) => new Date(timeStr).toISOString().slice(0, 19).replace('T', ' ');


  rowx.forEach((item,index)=>{
    if(item.value.split(" ")[1]){//若为时间值
      // item.value = formatTime(item.value);
      // console.log("成功转化时间值" + item.value);
    }  
    else if(Number.isNaN(Number(item.value))){//若为中文值
      // console.log("item.value:"+item.value);
      // console.log(new Date(item.value));
    }
    else{
      // console.log("进入成功");
      item.value = Number(item.value);
    }
  })
  res.send(rowx);
  return;
});

//修改关联boolean的路由
Router_direct.get("/label_boolean",async (req,res)=>{
  console.log("成功进入路由");
  let {content,id} = req.query;
  id = Number(id);
  console.log("TYPE:id"+typeof id);
  const [result0] = await connection.execute(`
  SELECT label
  FROM t_direct_config
  WHERE id = ${id}
  `);
  console.log("result0:");
  console.dir(result0[0]);  
  console.log(result0[0].label+"_label");


  if(content==="开"||content==="关"){
    const [result] = await connection.execute(`
    UPDATE t_direct_config
    SET label_boolean = ${content==="开"?"1":null}
    WHERE label = "${result0[0].label+"_label"}";
  `);
  }
  else{
    const [result] = await connection.execute(`
    UPDATE t_direct_config
    SET label_boolean = ${content==="手动"?"1":null}
    WHERE ok = "yes"; 
  `);
  }

  res.send("ok");
});

//获取控件中机房总类型数量的路由
Router_direct.get("/type_device",async (req,res)=>{
  const result = await connection.execute(`
    SELECT d_no
    FROM t_direct 
    WHERE config_id = 12
    AND d_no != 'null';
  `);
  res.send(result[0]);
  return;
})

//机房历史记录查询路由
Router_direct.get("/operate_history",async(req,res)=>{
  const {d_no} = req.query;
  const [row] = await connection.execute(`
  SELECT *
  FROM operate_history
  WHERE place = '${d_no}'
  `);
  res.send(row);
})


export default Router_direct;




