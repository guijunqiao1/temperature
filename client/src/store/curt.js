// src/stores/useUserStore.js
import { defineStore } from 'pinia';
 
// 全局屏蔽器控制台

export const useUserStore = defineStore('user', {
  state: () => ({
    device_sign:true,//控制控件 
    Action_sign:true,//控制行为总内容
    action_sign:true,//控制行为控件
    Device_sign:true,//控制设备总内容
    all:false,
    device:true,
    signzhi:null,
    type_array:null,
    type_len:null,
    test_array:[],//当此的测试的总数组记录
    test_type_len:null,//测试总次数
    times:null,//次数变量
  }),
  actions:{
    change(value) {
      this.signzhi = value;
    },
    change_jifang(value) {
      this.type_array = value;
      this.type_len = value.length;
    },
    change_times(value) {
      this.times = value;
    },
    change_Test_array(value) {
      this.test_array = value;
      this.test_type_len = value.length;
    }
  }
});