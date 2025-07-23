

//在当前需要对Mysql数据库进行操作的文件中提前引入Mysql数据库的配置文件--需要注意的是indexNode文件中的其他引入的组件文件只是对indexNode本身编写的时候进行约束的文件
import Config1 from "../indexNode2.js";//此处获取到数据库链接配置对象
let connection2;//定义数据库连接对象
import Router from "express";
const Router1 = Router();
(async ()=>{
  try{
    //异步执行Config，用于连接数据库,后续可对connection数据库链接对象进行数据库语法操作用于对数据库本身进行操作
    connection2 = await Config1();
    console.log("数据库1连接成功");
  }
  catch(error){
    console.log("数据库1连接失败"); 
  }
})();

Router1.get("/yingshe", async (req,res) => {
  console.log("123");
  let dbResult = await connection2.execute(`
    SELECT db_name, f_name  FROM t_field_mapper;
  `);
  dbResult = dbResult[0];
  const objectArray = dbResult.map(row => {
    return { [row.db_name]: row.f_name };
  });
  console.log("yingshe");
  console.dir(objectArray);
  res.send(objectArray);
});
//行为映射表
Router1.get("/yingshe/action",async (req,res)=>{
  console.log("123");
  let dbResult = await connection2.execute(`
    SELECT db_name, f_name ,type,is_show FROM t_behavior_field_mapper;
  `);
  dbResult = dbResult[0];
  const objectArray = dbResult.map(row => {
    return { [row.db_name]: row.f_name,type:row.type,is_show:row.is_show };
  });
  console.log("yingshe/action" + objectArray);
  res.send(objectArray);
});


export default Router1;
