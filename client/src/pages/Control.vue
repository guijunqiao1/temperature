<template>
  <div class="control">
    <div class="all">
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
              size="small" :disabled="!Boolean(item.label_boolean)" />
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
  </div>
</template>

<script setup lang="ts">
import { ref, onMounted, nextTick, onUnmounted } from "vue";
import axios from "axios";
// import { ArrowDown } from '@element-plus/icons-vue'
import { useUserStore } from "../store/curt";
const Pinia = useUserStore();
//获取到渲染数组
//全局数组变量
const control_array: any = ref();

//定时器变量
let x;

// 跟踪当前正在编辑的输入框
const currentFocusedInput: any = ref(null);

//封装定时器内容
function setInter() {
  return setInterval(async () => {
    console.log("定时器正常运转");
    const result = await axios.get("/api/zhiling?mode=1");
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
  const result = await axios.get("/api/zhiling?mode=1");
  control_array.value = result.data;
  console.log("control_array:" + control_array.value);


  //立即创建定时器
  x = setInter();
})()
// 开关(包括时间、开关、单选、输入、滚动)方法
async function submit(value) {
  //重置定时器
  clearInterval(x);
  x = setInter();

  if (value.f_type === '2') {
    if (Number(value.value) <= Number(value.max) && Number(value.value) >= Number(value.min)) {
      const result = await axios.get(`/api/zhiling/${value.luyou}?d_no=${value.mode === '1' ? "null" : value.d_no}&topic=${value.topic}&content=${value.value}`);
      alert(value.t_name + "成功修改为" + value.value);
    }
    else {
      alert("修改失败，请在" + value.min + "到" + value.max + "的范围中取值");
    }
  }
  else {
    //对自动手动控件特殊处理，后续尽量不要动主题
    const result = await axios.get(`/api/zhiling/${value.luyou}?d_no=${value.mode === '1' ? "null" : value.d_no}&topic=${value.topic}&content=${value.value}`);
    if (value.id === 15) {//空调开关附属内容
      const result = await axios.get(`/api/zhiling/kongtiaoM?d_no=${value.mode === '1' ? "null" : value.d_no}&topic=${value.topic}&content=${control_array.value[4].value}`);
      // const result1 = await axios.get(`/api/zhiling/kongtiaoP?d_no=${value.mode === '1' ? "null" : value.d_no}&topic=${value.topic}&content=${control_array.value[7].value}`);
    }



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
}

onMounted(async () => {
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
</style>
