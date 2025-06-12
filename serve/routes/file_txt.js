
//用于接受映射数组获取请求的路由文件
import Router from "koa-router";
import fs from "fs";
import path_model from "path";
const Router_file_txt = new Router();


//表格的呈现-图像的呈现路由
Router_file_txt.get("/file_txt",async ctx=>{
  const { path } = ctx.query;
  //总路径
  console.log("当前的path的取值为："+path);
  const All_path = path_model.resolve('D:\\','source_find',path);//需要注意的是D:拼接的取值含义为当前的D盘下所对应上的D盘的工作目录
  console.log("当前总路径:"+All_path);
  //读取文本内容并返回
  console.log("查看文件内容:");
  console.dir(fs.readFileSync(All_path).toString("utf8"));
  ctx.body = fs.readFileSync(All_path).toString("utf8"); // 把可读流赋给 ctx.body
})  
export default Router_file_txt;
