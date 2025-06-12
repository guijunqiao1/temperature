//数据库连接配置文件

import mysql from "mysql2/promise"

// 对mysql这个构造函数中的创建数据库的具体链接的方法进行具体的配置（即内容的重写）
async function Config2(){
  try{
    const connection = await mysql.createConnection({
      host:"127.0.0.1",
      password:"123456",
      database:"project02",
      port:3306,
      user:"root"
    });
    //进行数据连接事件的绑定
    console.log("连接成功");
    //返回连接实例
    return connection;
  }catch(error){
    console.log("数据库2连接失败",error);
    throw error; //抛出错误以便调用方处理
  }
}

//将具体的数据库链接配置(重写后的)函数进行暴露
export default Config2;
