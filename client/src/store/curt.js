// src/stores/useUserStore.js
import { defineStore } from 'pinia';
 
// 全局屏蔽器控制台

export const useUserStore = defineStore('user', {
  state: () => ({
    device_sign:true,//控制控件 
    Action_sign:true,//控制行为总内容
    action_sign:true,//控制行为控件
    Device_sign:true//控制设备总内容
  })
});