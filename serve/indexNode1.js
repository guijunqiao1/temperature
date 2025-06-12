//Node.js入口文件

//针对当前后端的文件的功能进行解释:
// 主要作用是完成路由针对不同的板块进行直接的跳转;同时完成mysql数据库的连接的操作

//引入mysql数据库中的表格的内容设计的模版检查文件,并且直接获取到模版对象，便于直接对该模版对象使用create方法进行直接的表格的内容的
//创建但是由于此处是根据用户进行动态的数据库内容的修改则不需要在连接上数据的时候立即添加内容,只是做个示例
import mysql from "mysql2/promise";
//创建mysql构造函数并且获取

async function Config1(){
  try{
    const connection = await mysql.createConnection({
      host:"127.0.0.1",
      password:"123456",
      database:"project01",
      new_port:3306,
      user:"root"
    });
    //进行数据连接事件的绑定
    console.log("连接成功");
    //返回连接实例
    return connection;
  }catch(error){
    console.log("数据库1连接失败",error);
    throw error; //抛出错误以便调用方处理
  }
}
//需要注意的是此处是通过转化为数据库实例对象的创建进而完成了数据库的连接--所谓转化为实例对象也就是此时的mysql变量中的内容为project01数据库对象了

//暴露数据库连接模版函数提供给其他数据库操作的文件中进行函数调用
export default Config1;

// //设置一段时间后自动关闭mysql服务的定时器函数
// setTimeout(()=>{
//   mysql.disconnect();
// },3000);

// --下面完成路由服务的开启的Nodejs的代码设置：
