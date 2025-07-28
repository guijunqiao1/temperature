<template>
  <div class="control">
    <div v-if="Pinia.all" class="all">
      <h1>全局指令</h1>
      <!-- 同步时间    -->
      <div v-for="item in control_array">
        <!-- 类型1： -->
        <div class="switch" v-if="item.f_type === '1' && (item.mode === '1' || item.mode === 'null')">
          {{ item.t_name }}：
          <el-switch @change="submit(item)" v-model="item.value" :active-text="xuanran1(item.f_value)"
            :inactive-text="xuanran2(item.f_value)" :active-value="xuanran1(item.f_value)"
            :inactive-value="xuanran2(item.f_value)" :disabled="!Boolean(item.label_boolean)" />
        </div>

        <!-- 类型2： -->
        <div class="input" v-if="item.f_type === '2' && (item.mode === '1' || item.mode === 'null')">
          {{ item.t_name }}：
          <input type="text" v-model="item.value" @focus="handleInputFocus(item)" @blur="handleInputBlur"
            :disabled="!Boolean(item.label_boolean)">
          <button class="input_submit" @click="submit(item)">提交</button>
        </div>

        <!-- 类型3： -->
        <div class="slider-demo-block" v-if="item.f_type === '3' && (item.mode === '1' || item.mode === 'null')">
          {{ item.t_name }}：
          <div class="containerx">
            <text>最小值：{{ item.min }}</text>
            <el-slider v-model="item.value" @change="submit(item)" :min="Number(item.min)" :max="Number(item.max)"
              size="small" :disabled="!Boolean(item.label_boolean)"/>
            <text>最大值：{{ item.max }}</text>
          </div>
        </div>

        <!-- 类型4： -->
        <div class="timepicker" style="margin-top:10px;"
          v-if="item.f_type === '4' && (item.mode === '1' || item.mode === 'null')">
          {{ item.t_name }}：
          <el-time-picker v-model="item.value" @blur="submit(item)" placeholder="时间选择" size="small"
            :disabled="!Boolean(item.label_boolean)" />
        </div>

        <!-- 类型5： -->
        <div class="radio" v-if="item.f_type === '5' && (item.mode === '1' || item.mode === 'null')">
          {{ item.t_name }}：
          <el-radio-group v-model="item.value" @change="submit(item)" :disabled="!Boolean(item.label_boolean)">
            <el-radio :value="xuanran1(item.f_value)" size="large">{{ xuanran1(item.f_value) }}</el-radio>
            <el-radio :value="xuanran2(item.f_value)" size="large">{{ xuanran2(item.f_value) }}</el-radio>
          </el-radio-group>
        </div>
      </div>

    </div>
    <h2>当前场景:{{ Pinia.signzhi }}</h2>
    <div v-if="Pinia.device" class="device">
      <h1>设备指令</h1>
      <!-- 同步时间-->
      <div v-for="item in control_array">
        <!-- 类型1： -->
        <div class="switch" v-if="item.f_type === '1'">
          {{ item.t_name }}：
          <el-switch @change="submit(item)" v-model="item.value" :active-text="xuanran1(item.f_value)"
            :inactive-text="xuanran2(item.f_value)" :active-value="xuanran1(item.f_value)"
            :inactive-value="xuanran2(item.f_value)" :disabled="!Boolean(item.label_boolean)" />
        </div>

        <!-- 类型2： -->
        <div class="input" v-if="item.f_type === '2'">
          {{ item.t_name }}：
          <input type="text" v-model="item.value" @focus="handleInputFocus(item)" @blur="handleInputBlur"
            :disabled="!Boolean(item.label_boolean)">
          <button class="input_submit" @click="submit(item)">提交</button>
        </div>

        <!-- 类型3： -->
        <div class="slider-demo-block" v-if="item.f_type === '3'">
          {{ item.t_name }}：
          <div class="containerx">
            <text>最小值：{{ item.min }}</text>
            <el-slider v-model="item.value" @change="submit(item)" :min="Number(item.min)" :max="Number(item.max)"
              size="small"/>
            <text>最大值：{{ item.max }}</text>
          </div>
        </div>

        <!-- 类型4： -->
        <div class="timepicker" style="margin-top:10px;"
          v-if="item.f_type === '4'">
          {{ item.t_name }}：
          <el-time-picker v-model="item.value" @blur="submit(item)" placeholder="时间选择" size="small"
            :disabled="!Boolean(item.label_boolean)" />
        </div>

        <!-- 类型5： -->
        <div class="radio" v-if="item.f_type === '5'">
          {{ item.t_name }}：
          <el-radio-group v-model="item.value" @change="submit(item)" :disabled="!Boolean(item.label_boolean)">
            <el-radio :value="xuanran1(item.f_value)" size="large">{{ xuanran1(item.f_value) }}</el-radio>
            <el-radio :value="xuanran2(item.f_value)" size="large">{{ xuanran2(item.f_value) }}</el-radio>
          </el-radio-group>
        </div>
      </div>
    </div>

    <h1>设备操作历史记录</h1>

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
          <tr v-for="item in operate_history_array">
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

const Pinia = useUserStore();
//获取到渲染数组
//全局数组变量
const control_array: any = ref();

//设备相关变量
let LLL = 0;
let changjing_array = ref();
let change1;
let signzhi = ref(Pinia.signzhi);

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
    console.log("control_array:" + control_array.value);
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

(async () => {
  signzhi.value = Pinia.signzhi;
  const result = await axios.get(`/api/zhiling?mode=0&d_no=${signzhi.value}`);
  control_array.value = result.data;
  console.log("control_array:");
  console.dir(control_array.value);


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
  border: 3px solid black;
  position: absolute;
  top: 0;
  width: 100%;
  display: flex;
  justify-content: flex-start;
  align-items: center;
  background-color: skyblue;
  margin-top: 0;
  flex-direction: column;
}

/* 屏蔽x按钮 */
.el-input__suffix {
  display: none !important;
}

/* 控制时间选择器的宽度 */
.timepicker {
  overflow: hidden;
  width: 100px !important;
}

.all {
  width: 100%;
  background-color: gray;
  margin-top: 0;
  margin-left: 0;
  height: 590px;
  border: 3px solid black;
}

.local {
  width: 100%;
  /* display: flex; */
  height: 500px;
}

/* 为输入框进行样式设计  */
.temperature1>input,
.temperature2>input,
.light_min>input,
.light_max>input {
  border: 1px solid black;
  height: 10px;
  /* 去除默认聚焦的效果 */
  outline: none;
}

/* 为输入框被激活的状态进行样式设计 */
.temperature1>input:focus,
.temperature2>input:focus,
.light_min>input:focus,
.light_max>input:focus {}

/* 为输入框文本进行样式设计 */
.temperature1>input::placeholder,
.temperature2>input::placeholder,
.light_min>input::placeholder,
.light_max>input::placeholder {
  /* font-size: inherit; */
  font-size: 14px;
  /* 让 placeholder 字体和输入内容保持一致 */
}



/* 输入框的提交按钮进行样式设计 */
.input_submit {
  width: 50px;
  height: 20px;
  margin-top: 5px;
  margin-left: 50px;
  font-size: 12px;
  text-align: center;
  line-height: 16px;
  background-color: antiquewhite;
  border: 1px solid black;
  border-radius: 3px;
}

.input_submit:hover {
  cursor: pointer;
}

/* 为单独的情况的盒子进行样式设计  */
.only {
  width: 150px;
  height: 30px;
  text-align: center;
  line-height: 30px;
  font-size: 14px;
  margin-left: 5px;
}

/* 为滑块进行样式设计 */
.containerx {
  display: flex;
  margin-left: 20px;
  width: 293px;
  justify-content: space-evenly;
  align-items: center;
}

/* 滑块中的文本标签  */
.containerx>text {
  width: 68px;
  text-align: center;
  line-height: 24px;
}

/* 控制滑块宽度 */
.el-slider.el-slider--small {
  width: 50%;
}

.only1 {
  width:78px;
  height:32px;
  background-color: #409eff;
  text-align: center;
  line-height:32px;
  font-size:14px;
}


/* 为设备历史表格进行样式设计 */
.history_table {
  margin-top: 18px;
  border-top: 5px solid gray;
  width: 100%;
  height: 66px;
  /* 需要注意的是此处不能设置固定的table的高度否则则会导致其中只有一个tr的情况下会占据整个tbody的高度 */
  border-spacing: 0;
  /* 下方设置使得table标签变得其中的th、td标签不会随着内容的变化而发生变化 */
  table-layout: fixed;
}
.history_thead {
  min-height: 0;
  width: 1020px;
  height: 33px;
  background-color: #cecece;
}
.history_tbody {
  min-height: 0;
  width: 1020px;
  height: 33px;
  background-color: rgb(206, 206, 206);
}



table thead>tr,
table tbody>tr {
  width: 1020px;
  height: 32px;
}

table thead>tr>th,
table tbody>tr>td {
  width: 154.1px;
  height: 32px;
  color: black;
  font-size: 14px;
  border: 1px solid #9DA79F;
  font-weight: 800;
  text-align: center;
}


</style>
