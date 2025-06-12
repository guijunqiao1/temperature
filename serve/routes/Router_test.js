//测试
import Router_gui from "koa-router";
const Routerx = new Router_gui();



Routerx.get("/gui_test",(ctx,next)=>{
  console.log("成功进入当前路由");
  ctx.body = "响应成功";
})

export default Routerx;