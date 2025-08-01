import express from 'express';
import path from 'path';
import logger from 'morgan';
import cors from 'cors';
import { fileURLToPath } from 'url'; 
// import "./routes/websocket_test.js";
// import "./routes/jiankong.js";


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

const app = express();

// 获取 __dirname 和 __filename（ES 模块兼容）
const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);


// 配置视图引擎（使用 EJS）
app.set('views', path.join(__dirname, 'views'));
app.set('view engine', 'ejs');


// 启用 CORS
app.use(cors());

// 日志记录中间件
app.use(logger('dev'));


app.use(express.json());
app.use(express.urlencoded({ extended: true }));

// 提供静态文件服务
app.use(express.static(path.join(__dirname, 'public')));
 

// 挂载子路由（假设路由模块已适配 Koa 路由）
app.use('/', Router_direct);
app.use('/', Router4);
app.use('/', Router5);
app.use('/', Router3);
app.use('/', Router2);
app.use('/', Router1);
app.use('/', IndexRouter);
app.use('/', Router_direct_control);
app.use("/",Router_http);
// 应用和YOLO服务端的沟通http路由
// app.use('/', Router_http);

// Express 的 req, res 对象
app.use((err, req, res, next) => {
  res.locals.message = err.message;
  res.status(err.status || 500);
  res.render('error');
});



export default app;

