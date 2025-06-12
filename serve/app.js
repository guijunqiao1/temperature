// import createError from "http-errors";
// import express from "express";
// import path from "path";
// import cookieParser from "cookie-parser";
// import logger from "morgan";
// import cors from "cors";

// import Router from "./routes/index.js";
// import Router1 from "./routes/index_yingshe.js";
// import Router2 from "./routes/index_device.js";
// import Router3 from "./routes/index_error_msg.js";
// import Router4 from "./routes/index_history.js";
// import Router5 from "./routes/index_action.js";
// import Router_direct from "./routes/direct.js";
// //引入Router_direct_response对象替代下方mqtt的引入，本质下方mqtt的文件为指令配置文件，而真正的指令发送发生在当前对象的文件中
// import Router_direct_control from "./routes/direct_control.js";


// //引入mqtt_server在本身的app.js启动的时候其中的mqtt服务的内容同样会执行起来
// // import client from "./routes/mqtt_server_get.js";//需要该语句本身的含义即为首先是将指定文件引入同时获取到对应的配置好了的对象

// const app = express();


// //在当前import的基础上进行和require()方法引入的path模块的区别的缝合，后者可以直接对__dirname属性进行使用，而前者不然，则需要使用源程序定义的方式进行__dirname的赋值
// import {
//   fileURLToPath
// } from 'url';
// //进行__dirname的获取:
// // 获取当前模块的路径
// const __filename = fileURLToPath(
//   import.meta.url);
// // 获取当前模块的目录
// const __dirname = path.dirname(__filename);

// // view engine setup
// app.set('views', path.join(__dirname, 'views'));
// app.set('view engine', 'ejs');

// //调用跨域共享许可组件
// app.use(cors());

// app.use(logger('dev'));

// app.use(express.json());
// app.use(express.urlencoded({
//   extended: false
// }));
// app.use(cookieParser());
// app.use(express.static(path.join(__dirname, 'public')));

// // 需要注意的是下方的路由对象是需要被app.use的而mqtt_server则引入即可,也就是本身只需要被执行即可,被引入的本质即为被引入且执行--即使本身并没有对这个引入的对象进行利用
// app.use('/', Router); //需要注意的是此处是从'/'作为目录名开始进行查询的--也就是第一个形参为之后Router对应文件中的路由的起始路径
// app.use('/', Router1);
// app.use('/', Router2);
// app.use('/', Router3);
// app.use('/', Router4);
// app.use('/', Router5);
// app.use('/', Router_direct);
// app.use('/',Router_direct_control);


// // catch 404 and forward to error handler
// app.use(function (req, res, next) {
//   next(createError(404));
// });


// // error handler
// app.use(function (err, req, res, next) {
//   // set locals, only providing error in development
//   res.locals.message = err.message;
//   res.locals.error = req.app.get('env') === 'development' ? err : {};
//   // render the error page
//   res.status(err.status || 500);
//   res.render('error');
// });

// export default app;





import Koa from 'koa';
import Router from 'koa-router';
import path from 'path';
import logger from 'koa-morgan';
import cors from '@koa/cors';
import {koaBody} from 'koa-body';
import serve from 'koa-static';
import views from 'koa-views';
import { fileURLToPath } from 'url';

// 导入自定义路由模块
import IndexRouter from './routes/index.js';
import Router1 from './routes/index_yingshe.js';
import Router2 from './routes/index_device.js';
import Router3 from './routes/index_error_msg.js';
import Router4 from './routes/index_history.js';
import Router5 from './routes/index_action.js';
// import Router_direct from './routes/direct.js';  
// import Router_direct_control from './routes/direct_control.js';
import Routerx from './routes/Router_test.js';
import Router_file_txt from './routes/file_txt.js';

// 创建 Koa 应用实例
const app = new Koa();

// 获取 __dirname 和 __filename（ES 模块兼容）
const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

// 配置视图引擎（使用 EJS）
app.use(views(path.join(__dirname, 'views'), {
  extension: 'ejs'
}));

// 启用 CORS
app.use(cors());

// 日志记录中间件
app.use(logger('dev'));

// 解析请求体（替代 express.json 和 express.urlencoded）
app.use(koaBody({
  urlencoded: true,
  json: true
}));

// 提供静态文件服务
app.use(serve(path.join(__dirname, 'public')));

// 创建主路由器
const router = new Router();


// 挂载子路由（假设路由模块已适配 Koa 路由）
router.use(IndexRouter.routes(), IndexRouter.allowedMethods());//需要注意koa的路由的挂载参数中不能有第一个'/'
router.use(Router1.routes(), Router1.allowedMethods());
router.use(Router2.routes(), Router2.allowedMethods());
router.use(Router3.routes(), Router3.allowedMethods());
router.use(Router4.routes(), Router4.allowedMethods());
router.use(Router5.routes(), Router5.allowedMethods());
// router.use(Router_direct.routes(), Router_direct.allowedMethods());
// router.use(Router_direct_control.routes(), Router_direct_control.allowedMethods());
router.use(Routerx.routes(), Routerx.allowedMethods());
router.use(Router_file_txt.routes(), Router_file_txt.allowedMethods());

// 应用主路由器
app.use(router.routes()).use(router.allowedMethods());

// 404 错误处理
app.use(async (ctx, next) => {
  await next();
  if (ctx.status === 404) {
    ctx.status = 404;
    ctx.body = { error: 'Not Found' };
  }
});

// 全局错误处理
app.use(async (ctx, next) => {
  try {
    await next();
  } catch (err) {
    ctx.status = err.status || 500;
    ctx.state.message = err.message;
    ctx.state.error = process.env.NODE_ENV === 'development' ? err : {};
    await ctx.render('error');
  }
});

// 导出 Koa 应用
export default app;

