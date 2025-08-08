



//KOA2
import Koa from 'koa';
import path from 'path';
import cors from '@koa/cors';
import logger from 'koa-morgan';
import serve from 'koa-static';
import bodyParser from 'koa-bodyparser';
import views from 'koa-views';
import { fileURLToPath } from 'url';
import Router from '@koa/router';

// 导入子路由（假设这些模块都使用 koa-router 创建）
import { t_direct_control } from "./routes/direct_control.js";
import IndexRouter from './routes/index.js';
import Test from "./routes/test.js";
import Router1 from './routes/index_yingshe.js';
import Router2 from './routes/index_device.js';
import Router3 from './routes/index_error_msg.js';
import Router4 from './routes/index_history.js';
import Router5 from './routes/index_action.js';
import Router_direct from './routes/direct.js';
// import Router_direct_control from './routes/direct_control.js';
import Router_http from "./routes/http_server_get.js";


const app = new Koa();


async function startServer() {
  try {
    const router = new Router();
    const Router_direct_control = await t_direct_control();

    const __filename = fileURLToPath(import.meta.url);
    const __dirname = path.dirname(__filename);

    // 设置视图引擎（EJS）
    app.use(views(path.join(__dirname, 'views'), {
      extension: 'ejs'
    }));

    // 启用 CORS
    app.use(cors());

    // 日志中间件
    app.use(logger('dev'));

    // 请求体解析（替代 express.json() 与 express.urlencoded()）
    app.use(bodyParser());

    // 提供静态文件服务
    app.use(serve(path.join(__dirname, 'public')));

    // 挂载所有子路由
    router.use( Router_direct.routes(), Router_direct.allowedMethods());
    router.use( Router4.routes(), Router4.allowedMethods());
    router.use( Router5.routes(), Router5.allowedMethods());
    router.use( Router3.routes(), Router3.allowedMethods());
    router.use( Router2.routes(), Router2.allowedMethods());
    router.use( Router1.routes(), Router1.allowedMethods());
    router.use( Test.routes(), Test.allowedMethods());
    router.use( IndexRouter.routes(), IndexRouter.allowedMethods());
    router.use( Router_direct_control.routes(), Router_direct_control.allowedMethods());
    router.use( Router_http.routes(), Router_http.allowedMethods());

    // 应用路由
    app.use(router.routes()).use(router.allowedMethods());

    // 错误处理（等效于 Express 的错误中间件）
    app.on('error', (err, ctx) => {
      ctx.status = err.status || 500;
      ctx.body = 'Internal Server Error';
    }); 
  } catch (error) {
    console.error('服务器启动失败:', error);
  }
}

startServer();


export default app;


