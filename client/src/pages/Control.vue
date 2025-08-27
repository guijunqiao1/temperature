<template>
  <div class="control">
    <!-- 顶部导航栏 -->
    <div class="control-header">
      <el-dropdown class="station-dropdown">
        <el-button type="primary" v-show="Pinia.type_len > 1" class="station-btn">
          工位<el-icon class="el-icon--right"><arrow-down /></el-icon>
        </el-button>
        <template #dropdown>
          <el-dropdown-menu>
            <div>
              <div class="device_list" v-for="item in Pinia.type_array" :key="item[0]">
                <el-dropdown-item>
                  <div class="station-item" @click="change_jifang(item[0])">{{ item[0] }}</div>
                </el-dropdown-item>
              </div>
            </div>
          </el-dropdown-menu>
        </template>
      </el-dropdown>
      <div class="current-station" v-if="type_len <= 1">
        当前工位：{{ Pinia.signzhi }}
      </div>
    </div>

    <!-- 全局指令区域 -->
    <div v-if="Pinia.all" class="all">
      <h1 class="section-title">全局指令</h1>
      <!-- 同步时间    -->
      <div class="control-grid">
        <div v-for="item in all_array" :key="item.id" class="control-item">
          <!-- 类型1： -->
          <div class="switch control-card" v-if="item.f_type === '1' && (item.mode === '1' || item.mode === 'null')">
            <label class="control-label">{{ item.t_name }}：</label>
            <el-switch @change="submit(item)" v-model="item.value" :active-text="xuanran1(item.f_value)"
              :inactive-text="xuanran2(item.f_value)" :active-value="xuanran1(item.f_value)"
              :inactive-value="xuanran2(item.f_value)" :disabled="!Boolean(item.label_boolean)" />
          </div>

          <!-- 类型2： -->
          <div class="input control-card" v-if="item.f_type === '2' && (item.mode === '1' || item.mode === 'null')">
            <label class="control-label">{{ item.t_name }}：</label>
            <div class="input-group">
              <input type="text" v-model="item.value" @focus="handleInputFocus(item)" @blur="handleInputBlur"
                :disabled="!Boolean(item.label_boolean)" class="control-input">
              <button class="input_submit" @click="submit(item)">提交</button>
            </div>
          </div>

          <!-- 类型3： -->
          <div class="slider-demo-block control-card" v-if="item.f_type === '3' && (item.mode === '1' || item.mode === 'null')">
            <label class="control-label">{{ item.t_name }}：</label>
            <div class="containerx">
              <span class="range-label">最小值：{{ item.min }}</span>
              <el-slider v-model="item.value" @change="submit(item)" :min="Number(item.min)" :max="Number(item.max)"
                size="small" :disabled="!Boolean(item.label_boolean)" class="control-slider"/>
              <span class="range-label">最大值：{{ item.max }}</span>
            </div>
          </div>

          <!-- 类型4： -->
          <div class="timepicker control-card"
            v-if="item.f_type === '4' && (item.mode === '1' || item.mode === 'null')">
            <label class="control-label">{{ item.t_name }}：</label>
            <el-time-picker v-model="item.value" @blur="submit(item)" placeholder="时间选择" size="small"
              :disabled="!Boolean(item.label_boolean)" class="control-timepicker" />
          </div>

          <!-- 类型5： -->
          <div class="radio control-card" v-if="item.f_type === '5' && (item.mode === '1' || item.mode === 'null')">
            <label class="control-label">{{ item.t_name }}：</label>
            <el-radio-group v-model="item.value" @change="submit(item)" :disabled="!Boolean(item.label_boolean)" class="radio-group">
              <el-radio :value="xuanran1(item.f_value)" size="large">{{ xuanran1(item.f_value) }}</el-radio>
              <el-radio :value="xuanran2(item.f_value)" size="large">{{ xuanran2(item.f_value) }}</el-radio>
            </el-radio-group>
          </div>
        </div>
      </div>
    </div>

    <!-- 当前场景标题 -->
    <h2 class="scene-title">当前场景: {{ Pinia.signzhi }}</h2>

    <!-- 设备指令区域 -->
    <div v-if="Pinia.device" class="device">
      <h1 class="section-title">设备指令</h1>
      <!-- 同步时间-->
      <div class="control-grid">
        <div v-for="item in control_array" :key="item.id" class="control-item">
          <!-- 类型1： -->
          <div class="switch control-card" v-if="item.f_type === '1'">
            <label class="control-label">{{ item.t_name }}：</label>
            <el-switch @change="submit(item)" v-model="item.value" :active-text="xuanran1(item.f_value)"
              :inactive-text="xuanran2(item.f_value)" :active-value="xuanran1(item.f_value)"
              :inactive-value="xuanran2(item.f_value)" />
          </div>

          <!-- 类型2： -->
          <div class="input control-card" v-if="item.f_type === '2'">
            <label class="control-label">{{ item.t_name }}：</label>
            <div class="input-group">
              <input type="text" v-model="item.value" @focus="handleInputFocus(item)" @blur="handleInputBlur"
                :disabled="!Boolean(item.label_boolean)" class="control-input">
              <button class="input_submit" @click="submit(item)">提交</button>
            </div>
          </div>

          <!-- 类型3： -->
          <div class="slider-demo-block control-card" v-if="item.f_type === '3'">
            <label class="control-label">{{ item.t_name }}：</label>
            <div class="containerx">
              <span class="range-label">最小值：{{ item.min }}</span>
              <el-slider v-model="item.value" @change="submit(item)" :min="Number(item.min)" :max="Number(item.max)"
                size="small" class="control-slider"/>
              <span class="range-label">最大值：{{ item.max }}</span>
            </div>
          </div>

          <!-- 类型4： -->
          <div class="timepicker control-card" v-if="item.f_type === '4'">
            <label class="control-label">{{ item.t_name }}：</label>
            <el-time-picker v-model="item.value" @blur="submit(item)" placeholder="时间选择" size="small"
              :disabled="!Boolean(item.label_boolean)" class="control-timepicker" />
          </div>

          <!-- 类型5： -->
          <div class="radio control-card" v-if="item.f_type === '5'">
            <label class="control-label">{{ item.t_name }}：</label>
            <el-radio-group v-model="item.value" @change="submit(item)" :disabled="!Boolean(item.label_boolean)" class="radio-group">
              <el-radio :value="xuanran1(item.f_value)" size="large">{{ xuanran1(item.f_value) }}</el-radio>
              <el-radio :value="xuanran2(item.f_value)" size="large">{{ xuanran2(item.f_value) }}</el-radio>
            </el-radio-group>
          </div>
        </div>
      </div>
    </div>

    <!-- 设备操作历史记录 -->
    <h1 class="section-title history-title">设备操作历史记录</h1>

    <!-- 操作历史  -->
    <div class="control_history">
      <table class="history_table">
        <thead class="history_thead">
          <tr>
            <th>机房</th>
            <th>操作的设备</th>
            <th>操作内容</th>
            <th>操作时间</th>
          </tr>
        </thead>
        <tbody class="history_tbody">
          <tr v-for="item in operate_history_array" :key="item.id">
            <td>{{ item.place }}</td> 
            <td>{{ item.device }}</td> 
            <td>{{ item.operate }}</td> 
            <td>{{ moment(item.ctime).format('YYYY-MM-DD HH:mm:ss') }}</td> 
          </tr>
        </tbody>
      </table>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref, onMounted, nextTick, onUnmounted } from "vue";
import axios from "axios";
import { ArrowDown } from '@element-plus/icons-vue'
import { useUserStore } from "../store/curt";
import moment from "moment";
import { useRouter } from 'vue-router'


const Pinia = useUserStore();
//获取到渲染数组

//全局数组变量
const all_array:any = ref();

//设备数组变量
const control_array: any = ref();

//设备相关变量
let LLL = 0;
let changjing_array = ref();
let change1;
let signzhi = ref(Pinia.signzhi);

const router = useRouter();


//机房设备记录数组
let operate_history_array = ref();

//定时器变量
let x;

// 跟踪当前正在编辑的输入框
const currentFocusedInput: any = ref(null);

//封装定时器内容
function setInter() {
  return setInterval(async () => {
    console.log("定时器正常运转");
    const result = await axios.get(`/api/zhiling?mode=0&d_no=${signzhi.value}`);
    // 更新control_array时保留正在编辑的输入框的值
    if (currentFocusedInput.value) {
      const focusedInputId = currentFocusedInput.value.id;
      const currentValue = currentFocusedInput.value.value;
      control_array.value = result.data.map((item: any) => {
        if (item.id === focusedInputId && currentFocusedInput.value && (currentFocusedInput.value.f_type === '2' || currentFocusedInput.value.f_type === "3" || currentFocusedInput.value.f_type === "4")) {
          return { ...item, value: currentValue };
        }
        return item;
      });
    } else {
      control_array.value = result.data;
    }
    console.log("control_array:");
    console.dir(control_array.value);
  }, 5000);
}

// 监听输入框焦点状态
function handleInputFocus(item: any) {
  currentFocusedInput.value = item;
}
function handleInputBlur() {
  currentFocusedInput.value = null;
}
//封装渲染方法
function xuanran1(value) {
  return value.split("|")[0].split(":")[0];
}
function xuanran2(value) {
  return value.split("|")[1].split(":")[0];
}

//机房切换以及重置方法
function change_jifang(value){
  Pinia.change(value);

  //重置页面,先跳到一个空路由，再跳回来
  router.replace('/empty').then(() => {
    router.replace('/t_Control');
  })
  console.log("当前机房:"+Pinia.signzhi);
}

(async () => {
  signzhi.value = Pinia.signzhi;
  const result_all = await axios.get(`/api/zhiling?mode=1`);
  const result = await axios.get(`/api/zhiling?mode=0&d_no=${signzhi.value}`);
  control_array.value = result.data;
  all_array.value = result_all.data;
  console.log("control_array:");
  console.dir(control_array.value);
  console.log("all_array:");
  console.dir(all_array.value);

  //立即执行一次定时器内容
  console.log("定时器正常运转");
  const resultx = await axios.get(`/api/zhiling?mode=0&d_no=${signzhi.value}`);
  // 更新control_array时保留正在编辑的输入框的值
  if (currentFocusedInput.value) {
    const focusedInputId = currentFocusedInput.value.id;
    const currentValue = currentFocusedInput.value.value;
    control_array.value = resultx.data.map((item: any) => {
      if (item.id === focusedInputId && currentFocusedInput.value && (currentFocusedInput.value.f_type === '2' || currentFocusedInput.value.f_type === "3" || currentFocusedInput.value.f_type === "4")) {
        return { ...item, value: currentValue };
      }
      return item;
    });
  } else {
    control_array.value = resultx.data;
  }
  console.log("control_array:" + control_array.value);
  //立即创建定时器
  x = setInter();
})()
// 开关(包括时间、开关、单选、输入、滚动)方法
async function submit(value) {
  console.log("成功出发");
  //重置定时器
  clearInterval(x);
  x = setInter();
  if (value.f_type === '2') {
    if (Number(value.value) <= Number(value.max) && Number(value.value) >= Number(value.min)) {
      const result = await axios.get(`/api/zhiling/${value.luyou}?d_no=${value.mode === '1' ? "null" : signzhi.value}&topic=${value.topic}&content=${value.value}`);
      alert(value.t_name + "成功修改为" + value.value);
    }
    else {
      alert("修改失败，请在" + value.min + "到" + value.max + "的范围中取值");
    }
  }
  else {
    // //对自动手动控件特殊处理，后续尽量不要动主题
    // const result = await axios.get(`/api/zhiling/${value.luyou}?d_no=${value.mode === '1' ? "null" : signzhi.value}&topic=${value.topic}&content=${value.value}`);
    // if (value.id === 15) {//空调开关附属内容
    //   const result = await axios.get(`/api/zhiling/kongtiaoM?d_no=${value.mode === '1' ? "null" : signzhi.value}&topic=${value.topic}&content=${control_array.value[4].value}`);
    //   // const result1 = await axios.get(`/api/zhiling/kongtiaoP?d_no=${value.mode === '1' ? "null" : value.d_no}&topic=${value.topic}&content=${control_array.value[7].value}`);
    // }
    const result = await axios.get(`/api/zhiling/${value.luyou}?d_no=${signzhi.value}&topic=${value.topic}&content=${value.value}`);



    // else if (value.id === 13) {//风扇开关附属内容
    //   const result = await axios.get(`/api/zhiling/fengshanV?d_no=${value.mode === '1' ? "null" : value.d_no}&topic=${value.topic}&content=${control_array.value[6].value}`);
    // }
    // else if (value.id === 11) {//灯泡开关附属内容
    //   const result = await axios.get(`/api/zhiling/dengP?d_no=${value.mode === '1' ? "null" : value.d_no}&topic=${value.topic}&content=${control_array.value[5].value}`);
    // }
    // else if (value.id === 0) {//切换模式的附属内容
    //   for (let i = 0; i < control_array.value.length; i++) {
    //     const result = await axios.get(`/api/zhiling/${control_array.value[i].luyou}?d_no=${control_array.value[i].mode === '1' ? "null" : control_array.value[i].d_no}&topic=${control_array.value[i].topic}&content=${control_array.value[i].value}`);
    //   }
    // } 
  }
  //启用子元素或者禁用子元素
  if (value.id === 11 || value.id === 13 || value.id === 15 || value.id === 0) {
    const result = await axios.get(`/api/label_boolean?content=${value.value}&id=${value.id}`);
  }

  //完成表格的重置
  const result = await axios.get(`/api/operate_history?d_no=${signzhi.value}`);
  operate_history_array.value = result.data;
}

onMounted(async () => {
  //完成内容赋值
  const result = await axios.get(`/api/operate_history?d_no=${signzhi.value}`);
  operate_history_array.value = result.data;



})
</script>

<style scoped>
.control {
  border: none;
  position: absolute;
  top: 0;
  width: 100%;
  display: flex;
  justify-content: flex-start;
  align-items: center;
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  margin-top: 0;
  flex-direction: column;
  min-height: 100vh;
  padding: 20px;
  box-sizing: border-box;
}

/* 顶部导航栏样式 */
.control-header {
  width: 100%;
  display: flex;
  justify-content: flex-start;
  align-items: center;
  margin-bottom: 30px;
  gap: 20px;
}

.station-dropdown {
  margin-right: 20px;
}

.station-btn {
  background: linear-gradient(45deg, #409eff, #67c23a);
  border: none;
  border-radius: 25px;
  padding: 12px 24px;
  font-weight: 600;
  box-shadow: 0 4px 15px rgba(64, 158, 255, 0.3);
  transition: all 0.3s ease;
}

.station-btn:hover {
  transform: translateY(-2px);
  box-shadow: 0 6px 20px rgba(64, 158, 255, 0.4);
}

.station-item {
  padding: 8px 16px;
  border-radius: 8px;
  transition: all 0.3s ease;
  cursor: pointer;
}

.station-item:hover {
  background: linear-gradient(45deg, #409eff, #67c23a);
  color: white;
}

.current-station {
  width: auto;
  height: auto;
  text-align: center;
  line-height: 1.5;
  font-size: 16px;
  padding: 12px 24px;
  background: linear-gradient(45deg, #409eff, #67c23a);
  color: white;
  border-radius: 25px;
  font-weight: 600;
  box-shadow: 0 4px 15px rgba(64, 158, 255, 0.3);
}

/* 屏蔽x按钮 */
.el-input__suffix {
  display: none !important;
}

/* Element Plus 组件样式增强 */
.el-switch {
  --el-switch-on-color: linear-gradient(45deg, #409eff, #67c23a);
  --el-switch-off-color: #dcdfe6;
}

.el-switch .el-switch__core {
  border-radius: 20px;
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
}

.el-radio {
  --el-radio-checked-color: #409eff;
  --el-radio-checked-text-color: #409eff;
}

.el-radio .el-radio__input.is-checked .el-radio__inner {
  border-color: #409eff;
  background: #409eff;
}

.el-slider {
  --el-slider-main-bg-color: #409eff;
  --el-slider-runway-bg-color: #e4e7ed;
}

.el-time-picker {
  --el-border-color: #409eff;
}

/* 控制时间选择器的宽度 */
.timepicker {
  overflow: hidden;
  width: 100% !important;
}

.all {
  width: 100%;
  background: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);
  margin-top: 0;
  margin-left: 0;
  min-height: 590px;
  border: none;
  border-radius: 20px;
  padding: 30px;
  box-shadow: 0 10px 30px rgba(0, 0, 0, 0.2);
  margin-bottom: 30px;
}

.local {
  width: 100%;
  height: 500px;
}

/* 控制网格布局 */
.control-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
  gap: 20px;
  margin-top: 20px;
}

.control-item {
  width: 100%;
}

.control-card {
  background: rgba(255, 255, 255, 0.95);
  border-radius: 15px;
  padding: 20px;
  box-shadow: 0 8px 25px rgba(0, 0, 0, 0.1);
  transition: all 0.3s ease;
  border: 1px solid rgba(255, 255, 255, 0.2);
}

.control-card:hover {
  transform: translateY(-5px);
  box-shadow: 0 15px 35px rgba(0, 0, 0, 0.15);
}

.control-label {
  display: block;
  font-weight: 600;
  color: #333;
  margin-bottom: 15px;
  font-size: 16px;
}

.input-group {
  display: flex;
  align-items: center;
  gap: 15px;
}

.control-input {
  flex: 1;
  border: 2px solid #e1e5e9;
  height: 40px;
  border-radius: 8px;
  padding: 0 15px;
  font-size: 14px;
  transition: all 0.3s ease;
  background: white;
}

.control-input:focus {
  border-color: #409eff;
  box-shadow: 0 0 0 3px rgba(64, 158, 255, 0.1);
  outline: none;
}

.control-input:disabled {
  background: #f5f7fa;
  color: #c0c4cc;
}

.control-slider {
  flex: 1;
}

.control-timepicker {
  width: 100% !important;
}

.radio-group {
  display: flex;
  gap: 20px;
}

/* 为输入框进行样式设计  */
.temperature1>input,
.temperature2>input,
.light_min>input,
.light_max>input {
  border: 2px solid #e1e5e9;
  height: 40px;
  border-radius: 8px;
  padding: 0 15px;
  font-size: 14px;
  transition: all 0.3s ease;
  background: white;
}

/* 为输入框被激活的状态进行样式设计 */
.temperature1>input:focus,
.temperature2>input:focus,
.light_min>input:focus,
.light_max>input:focus {
  border-color: #409eff;
  box-shadow: 0 0 0 3px rgba(64, 158, 255, 0.1);
}

/* 为输入框文本进行样式设计 */
.temperature1>input::placeholder,
.temperature2>input::placeholder,
.light_min>input::placeholder,
.light_max>input::placeholder {
  font-size: 14px;
  color: #c0c4cc;
}

/* 输入框的提交按钮进行样式设计 */
.input_submit {
  width: 80px;
  height: 40px;
  margin-top: 0;
  margin-left: 0;
  font-size: 14px;
  text-align: center;
  line-height: 1;
  background: linear-gradient(45deg, #409eff, #67c23a);
  color: white;
  border: none;
  border-radius: 8px;
  cursor: pointer;
  transition: all 0.3s ease;
  font-weight: 600;
}

.input_submit:hover {
  transform: translateY(-2px);
  box-shadow: 0 4px 15px rgba(64, 158, 255, 0.4);
}

.input_submit:active {
  transform: translateY(0);
}

/* 为单独的情况的盒子进行样式设计  */
.only {
  width: auto;
  height: auto;
  text-align: center;
  line-height: 1.5;
  font-size: 16px;
  padding: 12px 24px;
  background: linear-gradient(45deg, #409eff, #67c23a);
  color: white;
  border-radius: 25px;
  font-weight: 600;
  box-shadow: 0 4px 15px rgba(64, 158, 255, 0.3);
}

/* 为滑块进行样式设计 */
.containerx {
  display: flex;
  margin-left: 0;
  width: 100%;
  justify-content: space-between;
  align-items: center;
  gap: 15px;
}

/* 滑块中的文本标签  */
.containerx>text,
.range-label {
  width: auto;
  text-align: center;
  line-height: 1.5;
  font-size: 14px;
  color: #666;
  font-weight: 500;
  min-width: 60px;
}

/* 控制滑块宽度 */
.el-slider.el-slider--small {
  width: 100%;
  flex: 1;
}

.only1 {
  width: 78px;
  height: 32px;
  background: linear-gradient(45deg, #409eff, #67c23a);
  text-align: center;
  line-height: 32px;
  font-size: 14px;
  border-radius: 16px;
  color: white;
  font-weight: 600;
}

/* 场景标题 */
.scene-title {
  color: white;
  text-align: center;
  margin: 30px 0;
  font-size: 24px;
  font-weight: 600;
  text-shadow: 0 2px 4px rgba(0, 0, 0, 0.3);
}

/* 区域标题 */
.section-title {
  color: white;
  text-align: center;
  margin-bottom: 30px;
  font-size: 28px;
  font-weight: 700;
  text-shadow: 0 2px 4px rgba(0, 0, 0, 0.3);
}

.history-title {
  margin-top: 40px;
}

/* 设备区域 */
.device {
  width: 100%;
  background: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%);
  min-height: 500px;
  border: none;
  border-radius: 20px;
  padding: 30px;
  box-shadow: 0 10px 30px rgba(0, 0, 0, 0.2);
  margin-bottom: 30px;
}

/* 为设备历史表格进行样式设计 */
.history_table {
  margin-top: 18px;
  border-top: none;
  width: 100%;
  height: auto;
  border-spacing: 0;
  table-layout: fixed;
  background: white;
  border-radius: 15px;
  overflow: hidden;
  box-shadow: 0 8px 25px rgba(0, 0, 0, 0.1);
  border: 1px solid rgba(255, 255, 255, 0.2);
}

.history_thead {
  min-height: 0;
  width: 100%;
  height: 50px;
  background: linear-gradient(45deg, #667eea, #764ba2);
}

.history_tbody {
  min-height: 0;
  width: 100%;
  background: white;
}

table thead>tr,
table tbody>tr {
  width: 100%;
  height: 50px;
  transition: all 0.3s ease;
}

table tbody>tr:hover {
  background: #f8f9fa;
  transform: scale(1.01);
}

table thead>tr>th,
table tbody>tr>td {
  width: 25%;
  height: 50px;
  color: #333;
  font-size: 14px;
  border: 1px solid #e1e5e9;
  font-weight: 600;
  text-align: center;
  padding: 10px;
}

table thead>tr>th {
  color: white;
  font-weight: 700;
  font-size: 16px;
}

/* 响应式设计 */
@media (max-width: 768px) {
  .control {
    padding: 15px;
  }
  
  .control-header {
    flex-direction: column;
    align-items: stretch;
    gap: 15px;
  }
  
  .station-btn,
  .current-station {
    width: 100%;
    text-align: center;
  }
  
  .control-grid {
    grid-template-columns: 1fr;
    gap: 15px;
  }
  
  .control-card {
    padding: 15px;
  }
  
  .containerx {
    flex-direction: column;
    gap: 10px;
  }
  
  .input-group {
    flex-direction: column;
    align-items: stretch;
  }
  
  .radio-group {
    flex-direction: column;
    gap: 10px;
  }
  
  .history_table {
    font-size: 12px;
  }
  
  table thead>tr>th,
  table tbody>tr>td {
    padding: 8px 5px;
    font-size: 12px;
  }
}

@media (max-width: 480px) {
  .control {
    padding: 10px;
  }
  
  .all,
  .device {
    padding: 20px;
  }
  
  .section-title {
    font-size: 24px;
  }
  
  .scene-title {
    font-size: 20px;
  }
}

/* 增强的动画效果 */
@keyframes fadeInUp {
  from {
    opacity: 0;
    transform: translateY(30px);
  }
  to {
    opacity: 1;
    transform: translateY(0);
  }
}

.control-card {
  animation: fadeInUp 0.6s ease-out;
}

/* 悬停效果增强 */
.control-card:hover {
  transform: translateY(-5px) scale(1.02);
  box-shadow: 0 20px 40px rgba(0, 0, 0, 0.2);
}

/* 渐变文字效果 */
.section-title,
.scene-title {
  background: linear-gradient(45deg, #ffffff, #f0f8ff);
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
  background-clip: text;
  text-shadow: none;
}

/* 卡片内容悬停效果 */
.control-label:hover {
  color: #409eff;
  transform: translateX(5px);
  transition: all 0.3s ease;
}

/* 输入框聚焦动画 */
.control-input:focus,
.temperature1>input:focus,
.temperature2>input:focus,
.light_min>input:focus,
.light_max>input:focus {
  transform: scale(1.02);
  transition: all 0.3s ease;
}

/* 滚动条美化 */
.control::-webkit-scrollbar {
  width: 8px;
}

.control::-webkit-scrollbar-track {
  background: rgba(255, 255, 255, 0.1);
  border-radius: 4px;
}

.control::-webkit-scrollbar-thumb {
  background: linear-gradient(45deg, #409eff, #67c23a);
  border-radius: 4px;
}

.control::-webkit-scrollbar-thumb:hover {
  background: linear-gradient(45deg, #67c23a, #409eff);
}

/* 加载状态 */
.control-card.loading {
  position: relative;
  overflow: hidden;
}

.control-card.loading::before {
  content: '';
  position: absolute;
  top: 0;
  left: -100%;
  width: 100%;
  height: 100%;
  background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.4), transparent);
  animation: loading 1.5s infinite;
}

@keyframes loading {
  0% {
    left: -100%;
  }
  100% {
    left: 100%;
  }
}
</style>
