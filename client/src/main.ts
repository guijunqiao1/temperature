// 引入 Element UI组件库，用于vue文件快速搭建样式标签
import ElementPlus from 'element-plus'
// 引入 Element UI 的样式
import 'element-plus/dist/index.css';
import { createPinia } from 'pinia';
import { createApp } from 'vue'
import App from './App.vue'
//引入路由器
import router from "./router/index.ts";

//获取到app(Vue的实例对象)
const app = createApp(App);
const pinia = createPinia();

// 使用 Element UI
app.use(ElementPlus);
// 使用路由器
app.use(router);
//使用pinia全局管理
app.use(pinia); // 必须在任何 store 使用之前调用


//将app枝组件对象挂载到index.html文件中的id为app的标签中
app.mount("#app");

//本质上main.ts文件为项目的各个部分的结合配置的文件(比如：路由器的全局中间件函数的使用、组件库的使用、组件标签的直接挂载到指定位置的配置文件--比如：App.vue文件被直接挂载到index.html文件的指定位置上)


