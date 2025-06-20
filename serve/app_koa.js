
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
import Router_direct from './routes/direct.js';  
import Router_direct_control from './routes/direct_control.js';
// 导入和YOLOV5的沟通模块 
import Router_http from "./routes/http_server_get.js";

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
router.use(IndexRouter.routes(), IndexRouter.allowedMethods());
router.use(Router1.routes(), Router1.allowedMethods());
router.use(Router2.routes(), Router2.allowedMethods());
router.use(Router3.routes(), Router3.allowedMethods());
router.use(Router4.routes(), Router4.allowedMethods());
router.use(Router5.routes(), Router5.allowedMethods());
router.use( Router_direct.routes(), Router_direct.allowedMethods());
router.use( Router_direct_control.routes(), Router_direct_control.allowedMethods());
// 应用和YOLO服务端的沟通http路由
router.use( Router_http.routes(), Router_http.allowedMethods());


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

