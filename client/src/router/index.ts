//1、引入createRouter
import { createRouter, createWebHistory } from "vue-router";
//引入一个一个可能要呈现的组件
import Device from "../pages/t_device.vue";
import Error_message from "../pages/t_error_msg.vue";
import Home from "../pages/Home.vue";
import History from "../pages/History.vue";
import New from "../pages/Now.vue";
import Mqtt from "../pages/Control.vue";
import ex from "../pages/experience.vue";
import container from "../pages/t_container.vue";
import test from '../pages/test.vue';
import DEVICE from "../pages/DEVICE.vue";

//2、创建路由器
const router = createRouter({
  history: createWebHistory(),   //路由器的工作模式（稍后讲解）
  routes: [ //一个一个的路由规则
    {
      path: "/t_device",
      component: Device
    },
    {
      path: "/t_error_msg",
      component: Error_message
    },
    {
      path: "/",
      component: Device
    },
    {
      path: "/New",
      component: New
    },
    {
      path: "/History",
      component: History
    },
    {
      path: "/t_Control",
      component: Mqtt
    },
    {
      path: "/test",
      component: test
    },
    {
      path: "/DEVICE",
      component: DEVICE
    }
  ]
});

//将路由器对象进行暴露
export default router;