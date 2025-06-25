<template>
  <div class="container">
    <!-- 设备相关内容 -->
    <!-- 设备信息  -->
    <div id="latestData" v-show="Pinia.Device_sign">
      <div class="container22" v-show="Pinia.device_sign">
        <el-dropdown>
          <!-- 当前框只在保底一个的情况下才出现 -->
          <el-button type="primary" v-show="a_length > 1 && date_Array[0][0]">
            传感器设备选择列表<el-icon class="el-icon--right"><arrow-down /></el-icon>
          </el-button>
          <template #dropdown>
            <el-dropdown-menu>
              <div class="device_list" v-for="item in date_Array" :key="item[0]">
                <el-dropdown-item>
                  <div style="border-radius: 5px;" @click="change1(item, $event)">查看传感器设备{{ item[0] }}的最新的一条数据</div>
                </el-dropdown-item>
              </div>
            </el-dropdown-menu>
          </template>
        </el-dropdown>
        <!-- 当检查得到的数组的长度为1的时候进行当前的div的呈现--需要注意的是直接进行渲染的响应式数据所绑定的标签必须使用当前响应式数据存在作为判断条件 -->
        <div class="only" style="border-radius: 5px;" v-if="a_length === 1 && date_Array[0][0]">设备为{{ date_Array[0][0]
        }}的信息</div>
      </div>

      <!-- 最新信息的提示 -->
      <h2 class="newest_device" v-show="Pinia.Device_sign" style="margin-top:70px;">传感器最新记录表格</h2>
      <!-- 下方执行v-if语句用于优先对nowArray的值进行动态的判断之后在进行渲染(防止在控制台报错出现内容还没获取到就报错的问题，
      而之所以会报错是因为ref数据的"开始"渲染发生在"所有异步"处理完成之后) -->
      <table v-if="nowArray && nowArray[1] && nowArray[1].length > 0 && c_length > 0" class="table_device">
        <thead>
          <tr>
            <!-- <th v-show="nowArray[0] && Pinia.device_sign">设备编号</th> -->
            <th>{{ yingshe_array[0].field1 }} ({{ unit_array[0] }})</th>
            <th>{{ yingshe_array[1].field2 }} ({{ unit_array[1] }})</th>
            <th>{{ yingshe_array[2].field3 }} ({{ unit_array[2] }})</th>
            <th>{{ yingshe_array[3].field4 }} ({{ unit_array[3] }})</th>
            <!-- <th>最新告警状态</th> -->
            <th>收集时间</th>
          </tr>
        </thead>
        <tbody>
          <tr>
            <!-- <td v-show="nowArray[0] && Pinia.device_sign">{{ nowArray[0] }}</td> -->
            <td>{{ nowArray[1][nowArray[1].length - 1][0] }}</td>
            <td>{{ nowArray[1][nowArray[1].length - 1][1] }}</td>
            <td>{{ nowArray[1][nowArray[1].length - 1][2] }}</td>
            <td>{{ nowArray[1][nowArray[1].length - 1][3] }}</td>
            <!-- <td>{{ alarm[0].e_msg }}</td> -->
            <td>{{ nowArray[1][nowArray[1].length - 1][4] }}</td>
          </tr>
        </tbody>
      </table>

      <!-- 弹出框设计 -->
      <div id="modal">
        <span class="X" @click="XXX">X</span>
        <div class="modal_child">
        </div>
      </div>
    </div>

    <!-- 图像切换按钮--使用事件委托完成change事件的执行 -->
    <!-- 设备图像 -->
    <div class="change1" @click="change($event)" v-if="a_length > 0 && Pinia.Device_sign">
      <button id="zhexian" class="active">折线图(默认)</button>
      <button id="zhuzhuang">柱状图</button>
    </div>

    <ECharts :option="chartOption" style="width:600px; height: 400px;"
      v-show="a_length > 0 && zhexian_device && Pinia.Device_sign" class="zhexian" />
    <ECharts :option="chartOption1" style="width:600px; height:400px;" class="zhuzhuang"
      v-show="a_length > 0 && !zhexian_device && Pinia.Device_sign" />


    <!-- 行为相关内容 -->

    <h2 v-show="Pinia.action_sign && Pinia.Action_sign">不同场地下的最新资源内容</h2>

    <!-- 行为信息 -->
    <div id="latestData" v-if="Pinia.Action_sign">
      <div class="container222" v-if="Pinia.action_sign">
        <el-dropdown>
          <!-- 当前框只在保底一个的情况下才出现 -->
          <el-button type="primary" v-show="b_length > 1">
            场地<el-icon class="el-icon--right"><arrow-down /></el-icon>
          </el-button>
          <template #dropdown>
            <el-dropdown-menu>
              <div class="device_list1" v-for="item in action_Array" :key="item[0]">
                <el-dropdown-item>
                  <div style="border-radius: 5px;" @click="change2(item, $event)">{{ item[0] }}
                  </div>
                </el-dropdown-item>
              </div>
            </el-dropdown-menu>
          </template>
        </el-dropdown>
        <!-- 当检查得到的数组的长度为1的时候进行当前的div的呈现--需要注意的是直接进行渲染的响应式数据所绑定的标签必须使用当前响应式数据存在作为判断条件 -->
        <div class="only1" style="border-radius: 5px;" v-if="b_length === 1">{{ action_Array[0][0] }}
        </div>
      </div>

      <!-- 最新信息的提示 -->
      <h2 class="newest_action">实时数据表格</h2>

      <!-- 下方执行v-if语句用于优先对nowArray的值进行动态的判断之后在进行渲染(防止在控制台报错出现内容还没获取到就报错的问题，
      而之所以会报错是因为ref数据的"开始"渲染发生在"所有异步"处理完成之后) -->
      <table v-if="nowArray1 && nowArray1[1] && nowArray1[1].length > 0 && d_length > 0" class="table_action">
        <thead>
          <tr>
            <th>场景</th>
            <th>具体资源</th>
            <th>创建时间</th>
            <th>文件类型</th>
          </tr>
        </thead>
        <tbody>
          <tr>
            <td v-if="Pinia.action_sign">{{ nowArray1[0] }}</td>
            <td>{{ nowArray1[1][nowArray1[1].length - 1][0] }} <button v-show="yingshe_action_array[0].type !== '0'"
                class="btn_modal" @click="start_block(nowArray1[1][nowArray1[1].length - 1][0])">查看</button> </td>
            <td>{{ nowArray1[1][nowArray1[1].length - 1][1] }}</td>
            <td>{{ nowArray1[1][nowArray1[1].length - 1][2] }}</td>
          </tr>
        </tbody>
      </table>
    </div>

    <!-- 图像切换按钮--使用事件委托完成change事件的执行 -->
    <div class="change" @click="change0($event)"
      v-if="b_length > 0 && yingshe_action_array && yingshe_action_array[0].is_show === '1' && Pinia.Action_sign">
      <button id="zhexian1" class="active">折线图(默认)</button>
      <button id="zhuzhuang1">柱状图</button>
    </div>
    <ECharts :option="chartOption0" style="width: 600px; height: 400px;" class="zhexian1"
      v-show="b_length > 0 && zhexian_action && Pinia.Action_sign && yingshe_action_array && yingshe_action_array[0].is_show === '1'" />
    <ECharts :option="chartOption11" style="width: 600px; height:400px;" class="zhuzhuang1"
      v-show="b_length > 0 && !zhexian_action && Pinia.Action_sign && yingshe_action_array && yingshe_action_array[0].is_show === '1'" />

  </div>
</template>

<script lang="ts" setup name="New">
import axios from 'axios';
import moment from 'moment';
import { onUnmounted, onUpdated } from 'vue';
import { onMounted, ref, nextTick } from 'vue';
//导入echart启动函数
import { use } from 'echarts/core';
//导入渲染器
import { CanvasRenderer } from 'echarts/renderers';
import ECharts from "vue-echarts";
//导入柱状图剩余所需要的其它配置项
import { LineChart } from 'echarts/charts';
import { BarChart } from 'echarts/charts';
import { LabelLayout } from 'echarts/features';
import { UniversalTransition } from 'echarts/features';
import { ArrowDown } from '@element-plus/icons-vue'
import {
  TitleComponent,
  TooltipComponent,
  GridComponent,
  LegendComponent,
  ToolboxComponent
} from 'echarts/components'
use([
  CanvasRenderer,
  TitleComponent,
  TooltipComponent,
  GridComponent,
  LegendComponent,
  ToolboxComponent,
  BarChart,
  LineChart,
  LabelLayout,
  UniversalTransition
]);
import { useUserStore } from "../store/curt";
const Pinia = useUserStore();

// 响应式变量定义
let yingshe_array = ref();//设备映射数组
let yingshe_action_array = ref();//行为映射数组
let nowArray = ref();//该数组用于将dataArray中确定的字段进行赋值--发生在change事件中
let nowArray1 = ref();//行为实时数组
let chartOption = ref<any>({});//设备图像--折线
let chartOption1 = ref<any>({});//设备图像--柱状
let chartOption0 = ref<any>({});//行为图像--折线
let chartOption11 = ref<any>({});//行为图像--柱状
let change1 = (value: any, value1) => { };//设备信息change方法
let change2 = (value: any, value1) => { };//行为change方法

let change = (value: any) => { };//切换图像事件--设备信息
let change0 = (value: any) => { };//切换图像事件--设备信息

let date_Array = ref();//设备总类型数组--用于获取到去重数组
let action_Array = ref();//行为总类型数组--用于获取到去重数组
let time_array: any = [];//设备图像和行为图像通用
let tem_array: any = ref([]);//用于临时存储不同时间格式的nowArray
let tem_array1: any = ref([]);//用于临时存储不同时间格式的nowArray1

//定义额外的维度变量用于内容的扩展
// const alarm = ref();
// const ID_array = ref();

//定义长度变量
let a_length = ref();//设备数组长度记录变量
let b_length = ref();//行为数组长度记录变量
let c_length = ref();//记录设备映射变量
let d_length = ref();//记录行为映射变量

//定义临时变量用于存储点击之后的signzhi
let signzhi;
let signzhi1;

//定义检测当前切换图像状态的变量 
let zhexian_device = ref(true);
let zhexian_action = ref(true);

//定义单位数组变量
let unit_array = ref();
let unit_action_array = ref();

//存储渲染块的变量
let xuanran_block_device = ref();

//定义弹出框绑定的事件
async function start_block(value) {
  console.log("成功触发事件");

  // 获取到弹出框对象
  const modal = document.getElementById("modal") as HTMLElement;
  const modal_child = document.querySelector("#modal>.modal_child") as HTMLElement;
  console.dir(modal);
  console.dir(modal_child);
  // 显示弹窗父元素
  modal.style.display = "block";
  // 解析传递的value
  const value_Extension = value.split('.').pop();//补充：pop方法用于返回到最后一项
  if (value_Extension === "png") {
    //添加img标签对象
    const img = document.createElement("img");
    //属性赋值
    img.src = "../../public/" + value;//优先使用绝对路径尝试
    //添加到子元素
    modal_child.appendChild(img);
  }
  else if (value_Extension === "mp4") {
    //生成播放器元素
    const video = document.createElement("video");
    video.src = "../../public/" + value;
    //播放设置添加
    video.autoplay = true;  // 自动播放
    video.muted = true;     // 静音，绕过浏览器限制
    video.loop = true;      // 循环播放
    video.controls = true;  // 显示播放控件

    //添加到子元素
    modal_child.appendChild(video);
  }
  else {
    alert("后缀名解析失败");
  }
}

//为弹出框删除按钮绑定上事件
function XXX() {
  const modal = document.getElementById("modal") as HTMLElement;
  const modal_child = document.querySelector("#modal>.modal_child") as HTMLElement;
  const X = document.querySelector(".X") as HTMLElement;
  X.addEventListener("click", (e) => {
    console.log("成功触发X事件");
    //先清空再隐藏
    modal_child.innerHTML = "";
    modal.style.display = "none";
  })
}

//定义获取分钟间隔的数组的函数--去秒格式
function OneMinute(value1, value2) {//value2为'1'时去秒
  let time: any = [];
  //定义时间戳
  let date1 = new Date(value1[value1.length - 1]);//将最新的时间戳作为标杆
  let date: any;
  time.push(value1[value1.length - 1]);
  for (let i = 1; i < value1.length; i++) {
    date = new Date(value1[value1.length - (i + 1)]);//动态转化
    // 计算日期之间的差值（以毫秒为单位）
    const timeDifference: number = date1.getTime() - date.getTime();
    // 将毫秒差转换为分钟
    const minutesDifference = timeDifference / 1000 / 60;
    // 判断时间差是否大于 1 分钟
    if (minutesDifference >= 1) {
      //替换被减者
      date1 = date;
      time.push(value1[value1.length - (i + 1)]);
      if (time.length === 5) {
        break;
      }
    }
  }
  let time_now: any = [];
  //对此时的time_array数组进行逆序处理用于匹配y_zhi内容的填充
  for (let i = 0; i < time.length; i++) {
    time_now.push(time[time.length - i - 1]);
  }
  if (value2 === "1") {
    console.log("成功进入当前去除的情况");
    // 对时间进行遍历并且将最终的内容进行输出
    time_now.forEach((item, index) => {
      time_now[index] = moment(item).format('YYYY-MM-DD HH:mm');
    })
    console.log("此时的时间值为：" + time_now);
    return time_now;
  }
  return time_now;
}

//定义获取分钟间隔的时候的平均值数组的函数--折线图值的配置函数
function y_zhi(value1, value2) {
  let average: any = value2 === "device" ? [[], [], [], []] : [[], []]; // 用于存储 5 个字段的平均值--设备信息
  const for_length = average.length;
  const object_chart = value2 === "device" ? chartOption : chartOption0;
  // 遍历 4 个字段--设备信息
  for (let j = 0; j < for_length; j++) {
    let avg_values: any = []; // 存储当前字段的平均值
    value1.forEach(target_time => {
      let targetDate = new Date(target_time);
      let startTime = new Date(targetDate.getTime() - 60 * 1000); // 1 分钟前
      // 筛选出在 [startTime, target_time] 之间的数据
      let relevantRecords = nowArray.value[1].filter(record => {
        let recordDate = new Date(record[value2 === "device" ? 4 : 2]);
        return recordDate >= startTime && recordDate <= targetDate;
      });
      if (relevantRecords.length > 0) {
        let sum = 0;
        relevantRecords.forEach(record => {
          sum += parseFloat(record[j]); // 计算当前列的总和
        });
        let avg = sum / relevantRecords.length; // 计算平均值
        avg_values.push(avg);
      } else {
        avg_values.push(null); // 没有数据时填充 null，避免影响图表
      }
    });
    average[j] = avg_values; // 存入对应字段
  }
  // 更新 chart--设备数据
  for (let i = 0; i < for_length; i++) {
    console.log("成功进入阶段4");
    console.log("长度：" + object_chart.value.series.length);
    object_chart.value.series[i].data = average[i];
  }
  console.log("完成所有内容的赋值");
  console.dir(object_chart);
}
//柱状图值的配置函数
function y_zhi0(value1, value2) {
  let sum1: any = value2 === "device" ? [[], [], [], []] : [[], []]; // 用于存储 4 个字段的平均值--设备信息
  const for_length = sum1.length;
  const object_chart = value2 === "device" ? chartOption1 : chartOption11;

  // 遍历 4 个字段--设备信息
  for (let j = 0; j < for_length; j++) {
    let avg_values: any = []; // 存储当前字段的平均值
    value1.forEach(target_time => {
      let targetDate = new Date(target_time);
      let startTime = new Date(targetDate.getTime() - 60 * 1000); // 1 分钟前
      // 筛选出在 [startTime, target_time] 之间的数据
      let relevantRecords = nowArray.value[1].filter(record => {
        let recordDate = new Date(record[value2 == "device" ? 4 : 2]);
        return recordDate >= startTime && recordDate <= targetDate;
      });

      if (relevantRecords.length > 0) {
        let sum = 0;
        relevantRecords.forEach(record => {
          sum += parseFloat(record[j]); // 计算当前列的总和
        });
        let avg = sum; // 计算平均值
        avg_values.push(avg);
      } else {
        avg_values.push(null); // 没有数据时填充 null，避免影响图表
      }
    });
    sum1[j] = avg_values; // 存入对应字段
  }
  // 更新 chart--设备数据
  for (let i = 0; i < for_length; i++) {
    object_chart.value.series[i].data = sum1[i];
  }
}

//立即执行函数
(async () => {
  const result_alarm = await axios.get("/api/alarm");
  // alarm.value = result_alarm.data;
  // const result_ID = await axios.get("/api/recent/list_obj");
  // ID_array.value = result_ID.data;

  const result = await axios.get("/api/yingshe");//设备映射数组
  yingshe_array.value = result.data;



  const result0 = await axios.get("/api/yingshe/action");//行为映射数组
  yingshe_action_array.value = result0.data;

  //渲染块变量赋值
  xuanran_block_device.value = yingshe_array.value[0].is_show;//查看该组内容是否可渲染,一致处理

  const result1 = await axios.get("/api/recent");//设备种类数组
  date_Array.value = result1.data;
  //对初始文本进行编辑
  const text_array: any = document.querySelectorAll(".el-button.el-button--primary.el-tooltip__trigger>span");
  // text_array[0].innerText = `设备编号为${date_Array.value[0][0]}的信息`;//需要注意的是当标签中的Content中包含文本加上标签时，DOM操作获取到后的innerHTML以及innerText分别对应全部内容、文本内容
  const result11 = await axios.get("/api/recent/action");//行为种类数组
  action_Array.value = result11.data;
  nowArray.value = date_Array.value[0];
  tem_array.value = [, []];
  tem_array.value[0] = nowArray.value[0];
  nowArray.value[1].forEach((item, index) => {
    item[4] = moment(item[4]).format('YYYY-MM-DD HH:mm:ss');
    tem_array.value[1].push(item);
  })
  console.log("tem_array:" + tem_array.value);
  nowArray1.value = action_Array.value[0];
  tem_array1.value = [, []];
  tem_array1.value[0] = nowArray1.value[0];
  nowArray1.value[1].forEach((item, index) => {
    item[1] = moment(item[1]).format('YYYY-MM-DD HH:mm:ss');
    tem_array1.value[1].push(item);
  })

  console.log("tem_array1:" + tem_array1.value);
  a_length.value = date_Array.value.length;
  b_length.value = action_Array.value.length;


  //对单位数组进行获取
  const resultt = await axios.get(`/api/device_unit`);
  unit_array.value = resultt.data;
  const resulttt = await axios.get(`/api/action_unit`);
  unit_action_array.value = resulttt.data;
  //对长度变量进行赋值--用于渲染判断
  c_length.value = unit_array.value.length;
  d_length.value = unit_action_array.value.length;


  // 定义图表配置--设备信息--折线图
  chartOption = ref({
    title: {
      text: ""
    },
    tooltip: {
      trigger: 'axis'
    },
    legend: {
      data: []
      //yingshe_array.value[0].field1, yingshe_array.value[1].field2, yingshe_array.value[2].field3
    },
    grid: {
      left: '3%',
      right: '4%',
      bottom: '3%',
      containLabel: true
    },
    xAxis: {
      type: 'category',
      boundaryGap: false,
      data: [],
      axisLabel: {
        fontSize: 10,
        color: '#333',
        fontWeight: '400',
        rotate: 90
      }
    },
    yAxis: {
      type: 'value'
    },
    series: [
      // {
      //   name: yingshe_array.value[0].field1,
      //   type: 'line',
      //   data: [],
      //   smooth: true,

      // },
      // {
      //   name: yingshe_array.value[1].field2,
      //   type: 'line',
      //   data: [],
      //   smooth: true,


      // },
      // {
      //   name: yingshe_array.value[2].field3,
      //   type: 'line',
      //   data: [],
      //   smooth: true,

      // },
    ]
  });
  // 定义图表配置--设备信息--柱状图
  chartOption1 = ref({
    title: {
      text: ""
    },
    tooltip: {
      trigger: 'axis'
    },
    legend: {
      data: []
      // yingshe_array.value[0].field1, yingshe_array.value[1].field2, yingshe_array.value[2].field3
    },
    grid: {
      left: '3%',
      right: '4%',
      bottom: '3%',
      containLabel: true
    },
    xAxis: {
      type: 'category',
      boundaryGap: ['20%', '10%'],  // 左边偏移20%，右边偏移10%
      data: [],
      axisLabel: {//使得横轴文本纵向排列
        fontSize: 10,
        color: '#333',
        fontWeight: '400',
        rotate: 90
      }
    },
    yAxis: {
      type: 'value'
    },
    series: [
      // {
      //   name: yingshe_array.value[0].field1,
      //   type: 'bar',
      //   data: []
      // },
      // {
      //   name: yingshe_array.value[1].field2,
      //   type: 'bar',
      //   data: []
      // },
      // {
      //   name: yingshe_array.value[2].field3,
      //   type: 'bar',
      //   data: []
      // }
    ]
  });
  // 定义图表配置--行为信息--折线图
  chartOption0 = ref({
    title: {
      text: ""
    },
    tooltip: {
      trigger: 'axis'
    },
    legend: {
      data: []
      // yingshe_action_array.value[0].field1, yingshe_action_array.value[1].field2
    },
    grid: {
      left: '3%',
      right: '4%',
      bottom: '3%',
      containLabel: true
    },
    xAxis: {
      type: 'category',
      boundaryGap: false,
      data: [],
      axisLabel: {
        fontSize: 10,
        color: '#333',
        fontWeight: '400',
        rotate: 90
      }
    },
    yAxis: {
      type: 'value'
    },
    series: [
      // {
      //   name: yingshe_action_array.value[0].field1,
      //   type: 'line',
      //   smooth: true,

      //   data: []
      // },
      // {
      //   name: yingshe_action_array.value[1].field2,
      //   type: 'line',
      //   smooth: true,

      //   data: []
      // }
    ]
  });
  // 定义图表配置--行为信息--柱状图
  chartOption11 = ref({
    title: {
      text: ""
    },
    tooltip: {
      trigger: 'axis'
    },
    legend: {
      data: []
      // yingshe_action_array.value[0].field1, yingshe_action_array.value[1].field2 
    },
    grid: {
      left: '3%',
      right: '4%',
      bottom: '3%',
      containLabel: true
    },
    xAxis: {
      type: 'category',
      boundaryGap: ['20%', '10%'],  // 左边偏移20%，右边偏移10%
      data: [],
      axisLabel: {
        fontSize: 10,
        color: '#333',
        fontWeight: '400',
        rotate: 90
      }
    },
    yAxis: {
      type: 'value'
    },
    series: [
      // {
      //   name: yingshe_action_array.value[0].field1,
      //   type: 'bar',
      //   data: []
      // },
      // {
      //   name: yingshe_action_array.value[1].field2,
      //   type: 'bar',
      //   data: []
      // }
    ]
  });



  //需要注意的是初始化体表进行渲染的时候的赋值应该发生在异步处理中，否则报错且不生效
  time_array = [];

  // 设备配置赋值
  yingshe_array.value.forEach((item, index) => {
    // 折线赋值
    console.log("检查当前实际插入的字段值:" + item[`field${index + 1}`]);
    chartOption.value.legend.data.push(item[`field${index + 1}`]);
    chartOption1.value.legend.data.push(item[`field${index + 1}`]);
    chartOption.value.series.push({
      name: item[`field${index + 1}`],
      type: 'line',
      smooth: true,
      data: []
    })
    chartOption1.value.series.push({
      name: item[`field${index + 1}`],
      type: 'bar',
      data: []
    })
  })
  // 行为配置赋值
  yingshe_action_array.value.forEach((item, index) => {
    if (item.is_show === "1") {
      // 折线赋值
      console.log("检查当前实际插入的字段值:" + item[`field${index + 1}`]);
      chartOption0.value.legend.data.push(item[`field${index + 1}`]);
      chartOption11.value.legend.data.push(item[`field${index + 1}`]);
      chartOption0.value.series.push({
        name: item[`field${index + 1}`],
        type: 'line',
        smooth: true,
        data: []
      })
      chartOption11.value.series.push({
        name: item[`field${index + 1}`],
        type: 'bar',
        data: []
      })
      //柱状赋值
    }
  })

  console.log("已经成功的时候!!!!");


  // 折线图、柱状图--设备
  for (let i = 0; i < tem_array.value[1].length; i++) {
    time_array.push(tem_array.value[1][i][4]);
  }
  console.log("guiguiguiguiguiguiguiguiguiguiguiguigui" + time_array);
  chartOption.value.xAxis.data = OneMinute(time_array, "1");
  chartOption1.value.xAxis.data = OneMinute(time_array, "1");
  //为time_array填充上原先时间格式的内容
  time_array = [];
  for (let i = 0; i < tem_array.value[1].length; i++) {
    time_array.push(tem_array.value[1][i][4]);
  }
  console.log("桂桂桂桂桂桂桂桂桂桂桂桂桂桂桂桂桂桂桂：" + time_array);
  y_zhi(OneMinute(time_array, "1"), "device");
  y_zhi0(OneMinute(time_array, "1"), "device");
  // 折线图、柱状图--行为
  time_array = [];
  for (let i = 0; i < tem_array1.value[1].length; i++) {
    time_array.push(tem_array1.value[1][i][2]);
  }
  // console.log("test:" + time_array);
  chartOption0.value.xAxis.data = OneMinute(time_array, "1");
  chartOption11.value.xAxis.data = OneMinute(time_array, "1");
  time_array = [];
  for (let i = 0; i < tem_array1.value[1].length; i++) {
    time_array.push(tem_array1.value[1][i][2]);
  }

  y_zhi(OneMinute(time_array, "0"), "action");
  y_zhi0(OneMinute(time_array, "0"), "action");
})()

//定义定时器类全局id变量--控制设备信息
let x: any = 0;
//定义定时器类全局id变量--控制行为信息
let y: any = 0;

// 挂载时加载数据
onMounted(async () => {
  // 设备选择按钮--设备逻辑
  change1 = async (value, value1) => {
    //点击了设备按钮之后对样式进行修改
    //对所有内容进行统一的设计
    if (a_length.value > 1) {
      const option_array: any = document.querySelectorAll(".device_list");
      option_array.forEach(item => {
        item.children[0].style.color = "black";
        item.children[0].style.backgroundColor = "white";
      })
      value1.target.parentNode.style.color = "#409eff";
      value1.target.parentNode.style.backgroundColor = "rgb(235.9, 245.3, 255)";
    }
    else { }
    signzhi = value[0];
    clearInterval(x);
    const jiezhi_object = zhexian_device.value ? chartOption : chartOption1;
    // 定义代码块--重渲染操作
    function re_xuanran() {
      jiezhi_object.value.series.forEach((item, index) => {
        item = [];
      })
      nowArray.value = value;
      tem_array.value = [, []];
      tem_array.value[0] = nowArray.value[0];
      nowArray.value[1].forEach((item, index) => {
        item[4] = moment(item[4]).format('YYYY-MM-DD HH:mm:ss');
        tem_array.value[1].push(item);
      })
      // console.log("tem_array:" + tem_array.value);
      // chartOption.value.title.text = `传感器设备${nowArray.value[0]}的最近5分钟的数据`;
      jiezhi_object.value.title.text = `传感器设备的最近5分钟的数据`;
      time_array = [];
      for (let i = 0; i < tem_array.value[1].length; i++) {
        time_array.push(tem_array.value[1][i][4]);
      }
      console.log("guiguiguiguiguiguiguiguiguiguiguiguigui" + time_array);
      jiezhi_object.value.xAxis.data = OneMinute(time_array, "1");//赋值
      time_array = [];
      for (let i = 0; i < tem_array.value[1].length; i++) {
        time_array.push(tem_array.value[1][i][4]);
      }

      if (jiezhi_object === chartOption) {//折线情况
        y_zhi(OneMinute(time_array, "1"), "device");
      }
      else {
        y_zhi0(OneMinute(time_array, "1"), "device");
      }
    }
    re_xuanran();
    x = setInterval(async () => {
      // const result_alarm = await axios.get("/api/alarm");
      // alarm.value = result_alarm.data;
      // const result_ID = await axios.get("/api/recent/list_obj");
      // ID_array.value = result_ID.data;
      const result1 = await axios.get("/api/recent");
      date_Array.value = result1.data;
      a_length.value = date_Array.value.length;
      //判断设备选择对象并且赋值
      for (let i = 0; i < date_Array.value.length; i++) {
        if (value[0] === date_Array.value[i][0]) {
          nowArray.value = date_Array.value[i];
        }
      }
      tem_array.value = [, []];
      tem_array.value[0] = nowArray.value[0];
      nowArray.value[1].forEach((item, index) => {
        item[4] = moment(item[4]).format('YYYY-MM-DD HH:mm:ss');
        tem_array.value[1].push(item);
      })
      re_xuanran();
    }, 2000);


    //对初始文本进行编辑
    const text_array: any = document.querySelectorAll(".el-button.el-button--primary.el-tooltip__trigger>span");
    text_array[0].innerText = `设备编号为${value[0]}的信息`;//需要注意的是当标签中的Content中包含文本加上标签时，DOM操作获取到后的innerHTML以及innerText分别对应全部内容、文本内容
  }
  // 设备选择
  change2 = async (value, value1) => {
    //点击了设备按钮之后对样式进行修改
    //对所有内容进行统一的设计
    // if (b_length.value > 1) {
    //   const option_array: any = document.querySelectorAll(".device_list");
    //   option_array.forEach(item => {
    //     item.children[0].style.color = "black";
    //     item.children[0].style.backgroundColor = "white";
    //   })
    //   value1.target.parentNode.style.color = "#409eff";
    //   value1.target.parentNode.style.backgroundColor = "rgb(235.9, 245.3, 255)";
    // }
    // else { }
    signzhi1 = value[0];
    clearInterval(y);
    const jiezhi_object = zhexian_device.value ? chartOption0 : chartOption11;
    // 定义代码块--重渲染操作
    function re_xuanran() {
      jiezhi_object.value.series.forEach((item, index) => {
        item = [];
      })
      nowArray1.value = value;
      tem_array1.value = [, []];
      tem_array1.value[0] = nowArray1.value[0];
      nowArray1.value[1].forEach((item, index) => {
        item[1] = moment(item[1]).format('YYYY-MM-DD HH:mm:ss');
        tem_array1.value[1].push(item);
      })
      // console.log("tem_array:" + tem_array.value);
      // chartOption.value.title.text = `传感器设备${nowArray.value[0]}的最近5分钟的数据`;
      jiezhi_object.value.title.text = `传感器设备的最近5分钟的数据`;
      time_array = [];
      for (let i = 0; i < tem_array1.value[1].length; i++) {
        time_array.push(tem_array1.value[1][i][2]);
      }
      console.log("guiguiguiguiguiguiguiguiguiguiguiguigui" + time_array);
      jiezhi_object.value.xAxis.data = OneMinute(time_array, "1");//赋值
      time_array = [];
      for (let i = 0; i < tem_array1.value[1].length; i++) {
        time_array.push(tem_array1.value[1][i][2]);
      }

      if (jiezhi_object === chartOption0) {// 折线情况
        y_zhi(OneMinute(time_array, "1"), "action");
      }
      else {
        y_zhi0(OneMinute(time_array, "1"), "action");
      }
    }
    re_xuanran();
    y = setInterval(async () => {
      // const result_alarm = await axios.get("/api/alarm");
      // alarm.value = result_alarm.data;
      // const result_ID = await axios.get("/api/recent/list_obj");
      // ID_array.value = result_ID.data;
      const result1 = await axios.get("/api/recent/action");
      action_Array.value = result1.data;
      b_length.value = action_Array.value.length;
      //判断设备选择对象并且赋值
      for (let i = 0; i < action_Array.value.length; i++) {
        if (value[0] === action_Array.value[i][0]) {
          nowArray1.value = action_Array.value[i];
        }
      }
      tem_array1.value = [, []];
      tem_array1.value[0] = nowArray1.value[0];
      nowArray1.value[1].forEach((item, index) => {
        item[1] = moment(item[1]).format('YYYY-MM-DD HH:mm:ss');
        tem_array1.value[1].push(item);
      })
      re_xuanran();
    }, 2000);

    //对初始文本进行编辑
    // const text_array: any = document.querySelectorAll(".el-button.el-button--primary.el-tooltip__trigger>span");
    // text_array[0].innerText = `设备编号为${value[0]}的信息`;//需要注意的是当标签中的Content中包含文本加上标签时，DOM操作获取到后的innerHTML以及innerText分别对应全部内容、文本内容
  }

  x = setInterval(async () => {
    const result_alarm = await axios.get("/api/alarm");
    // alarm.value = result_alarm.data;
    // const result_ID = await axios.get("/api/recent/list_obj");
    // ID_array.value = result_ID.data;
    const result1 = await axios.get("/api/recent");
    date_Array.value = result1.data;
    a_length.value = date_Array.value.length;
    nowArray.value = date_Array.value[0];
    tem_array.value = [, []];
    tem_array.value[0] = nowArray.value[0];
    nowArray.value[1].forEach((item, index) => {
      item[4] = moment(item[4]).format('YYYY-MM-DD HH:mm:ss');
      tem_array.value[1].push(item);
    })
    //渲染折线图
    chartOption.value.series.forEach((item, index) => {
      item = [];
    })
    time_array = [];
    // chartOption.value.title.text = `传感器设备${nowArray.value[0]}的最近5分钟的数据`;
    chartOption.value.title.text = `传感器设备的最近5分钟的数据`;
    for (let i = 0; i < tem_array.value[1].length; i++) {
      console.log("tem_array.value[1]:" + tem_array.value[1]);
      console.log("tem_array.value[1][i][4]:" + tem_array.value[1][i][4]);
      time_array.push(tem_array.value[1][i][4]);
      console.log("time:" + time_array);
    }
    console.log("guiguiguiguiguiguiguiguiguiguiguiguigui" + time_array);

    chartOption.value.xAxis.data = OneMinute(time_array, "1");
    time_array = [];
    for (let i = 0; i < tem_array.value[1].length; i++) {
      time_array.push(tem_array.value[1][i][4]);
    }
    console.log("桂桂桂桂桂桂桂桂桂桂桂桂桂桂桂桂桂桂桂桂：" + time_array);

    y_zhi(OneMinute(time_array, "0"), "device");
  }, 2000);

  y = setInterval(async () => {
    const result1 = await axios.get("/api/recent/action");
    action_Array.value = result1.data;
    b_length.value = action_Array.value.length;
    nowArray1.value = action_Array.value[0];
    tem_array1.value = [, []];
    tem_array1.value[0] = nowArray1.value[0];
    nowArray1.value[1].forEach((item, index) => {
      item[1] = moment(item[1]).format('YYYY-MM-DD HH:mm:ss');
      tem_array1.value[1].push(item);
    })
    //渲染折线图
    chartOption.value.series.forEach((item, index) => {
      item = [];
    })
    time_array = [];
    // chartOption0.value.title.text = `传感器设备${nowArray1.value[0]}的最近5分钟的数据`;
    chartOption0.value.title.text = `传感器设备的最近5分钟的数据`;
    for (let i = 0; i < tem_array1.value[1].length; i++) {
      console.log("tem_array1.value[1]:" + tem_array1.value[1]);
      console.log("tem_array1.value[1][i][4]:" + tem_array1.value[1][i][4]);
      time_array.push(tem_array1.value[1][i][2]);
      console.log("time:" + time_array);
    }
    console.log("guiguiguiguiguiguiguiguiguiguiguiguigui" + time_array);

    chartOption0.value.xAxis.data = OneMinute(time_array, "1");
    time_array = [];
    for (let i = 0; i < tem_array1.value[1].length; i++) {
      time_array.push(tem_array1.value[1][i][2]);
    }
    console.log("桂桂桂桂桂桂桂桂桂桂桂桂桂桂桂桂桂桂桂桂：" + time_array);

    y_zhi(OneMinute(time_array, "1"), "action");
  }, 2000);

  // 设备信息图像切换按钮
  change = async (value) => {
    const zhexian_btn = document.querySelector("#zhexian") as HTMLElement;
    const zhuzhuang_btn = document.querySelector("#zhuzhuang") as HTMLElement;
    clearInterval(x);
    if (value.target === zhexian_btn) {
      zhexian_device.value = true;
      //为选中元素进行样式修改
      zhexian_btn.classList.add("active");
      zhuzhuang_btn.classList.remove("active");
      //优先执行一次定时器内容
      const result1 = await axios.get("/api/recent");
      date_Array.value = result1.data;
      a_length.value = date_Array.value.length;
      nowArray.value = [];
      date_Array.value.forEach((item, index) => {
        if (item[0] === signzhi) {
          nowArray.value = item;
        }
      })
      if (nowArray.value.length < 1) {//当原先的内容被删除的时候
        nowArray.value = date_Array.value[0];
      }
      tem_array.value = [, []];
      tem_array.value[0] = nowArray.value[0];
      nowArray.value[1].forEach((item, index) => {
        item[4] = moment(item[4]).format('YYYY-MM-DD HH:mm:ss');
        tem_array.value[1].push(item);
      })
      console.log("tem_array:" + tem_array.value);
      console.log("设备zhuzhuang===none");
      //渲染折线图
      chartOption.value.series.forEach((item, index) => {
        item = [];
      })
      time_array = [];
      // chartOption.value.title.text = `传感器设备${nowArray.value[0]}的最近5分钟的数据`;
      // chartOption.value.title.text = `传感器设备的最近5分钟的数据`;
      for (let i = 0; i < tem_array.value[1].length; i++) {
        console.log("tem_array.value[1]:" + tem_array.value[1]);
        console.log("tem_array.value[1][i][4]:" + tem_array.value[1][i][4]);
        time_array.push(tem_array.value[1][i][4]);
        console.log("time:" + time_array);
      }
      console.log("guiguiguiguiguiguiguiguiguiguiguiguigui" + time_array);
      chartOption.value.xAxis.data = OneMinute(time_array, "1");
      time_array = [];
      for (let i = 0; i < tem_array.value[1].length; i++) {
        console.log("tem_array.value[1]:" + tem_array.value[1]);
        console.log("tem_array.value[1][i][4]:" + tem_array.value[1][i][4]);
        time_array.push(tem_array.value[1][i][4]);
        console.log("time:" + time_array);
      }
      console.log("桂桂桂桂桂桂桂桂桂桂桂桂桂桂桂桂桂桂桂桂：" + time_array);
      y_zhi(OneMinute(time_array, "0"), "device");
      x = setInterval(async () => {
        const result_alarm = await axios.get("/api/alarm");
        // alarm.value = result_alarm.data;
        // const result_ID = await axios.get("/api/recent/list_obj");
        // ID_array.value = result_ID.data;
        const result1 = await axios.get("/api/recent");
        date_Array.value = result1.data;
        a_length.value = date_Array.value.length;
        nowArray.value = [];
        date_Array.value.forEach((item, index) => {
          if (item[0] === signzhi) {
            nowArray.value = item;
          }
        })
        if (nowArray.value.length < 1) {//当原先的内容被删除的时候
          nowArray.value = date_Array.value[0];
        }
        tem_array.value = [, []];
        tem_array.value[0] = nowArray.value[0];
        nowArray.value[1].forEach((item, index) => {
          item[4] = moment(item[4]).format('YYYY-MM-DD HH:mm:ss');
          tem_array.value[1].push(item);
        })
        console.log("tem_array:" + tem_array.value);
        console.log("设备zhuzhuang===none");
        //渲染折线图
        chartOption.value.series.forEach((item, index) => {
          item = [];
        })
        time_array = [];
        // chartOption.value.title.text = `传感器设备${nowArray.value[0]}的最近5分钟的数据`;
        chartOption.value.title.text = `传感器设备的最近5分钟的数据`;
        for (let i = 0; i < tem_array.value[1].length; i++) {
          console.log("tem_array.value[1]:" + tem_array.value[1]);
          console.log("tem_array.value[1][i][4]:" + tem_array.value[1][i][4]);
          time_array.push(tem_array.value[1][i][4]);
          console.log("time:" + time_array);
        }
        console.log("guiguiguiguiguiguiguiguiguiguiguiguigui" + time_array);
        chartOption.value.xAxis.data = OneMinute(time_array, "1");
        time_array = [];
        for (let i = 0; i < tem_array.value[1].length; i++) {
          time_array.push(tem_array.value[1][i][4]);
        }
        console.log("桂桂桂桂桂桂桂桂桂桂桂桂桂桂桂桂桂桂桂桂：" + time_array);
        y_zhi(OneMinute(time_array, "0"), "device");
      }, 2000)
    }
    else if (value.target === zhuzhuang_btn) {
      zhexian_device.value = false;
      //为选中元素进行样式修改
      zhuzhuang_btn.classList.add("active");
      zhexian_btn.classList.remove("active");

      //优先执行一次定时器内容
      const result1 = await axios.get("/api/recent");
      date_Array.value = result1.data;
      a_length.value = date_Array.value.length;
      nowArray.value = [];
      date_Array.value.forEach((item, index) => {
        if (item[0] === signzhi) {
          nowArray.value = item;
        }
      })
      if (nowArray.value.length < 1) {
        nowArray.value = date_Array.value[0];
      }
      tem_array.value = [, []];
      tem_array.value[0] = nowArray.value[0];
      nowArray.value[1].forEach((item, index) => {
        item[4] = moment(item[4]).format('YYYY-MM-DD HH:mm:ss');
        tem_array.value[1].push(item);
      })
      console.log("tem_array:" + tem_array.value);

      console.log("设备zhexian===none");
      // 渲染柱状图
      chartOption1.value.series[0].data = [];
      chartOption1.value.series[1].data = [];
      chartOption1.value.series[2].data = [];
      // chartOption1.value.series[3].data = [];
      time_array = [];
      // chartOption1.value.title.text = `传感器设备${nowArray.value[0]}的最近5分钟的数据`;
      chartOption1.value.title.text = `传感器设备的最近5分钟的数据`;
      for (let i = 0; i < tem_array.value[1].length; i++) {
        console.log("tem_array.value[1]:" + tem_array.value[1]);
        console.log("tem_array.value[1][i][4]:" + tem_array.value[1][i][4]);
        time_array.push(tem_array.value[1][i][4]);
      }
      console.log("guiguiguiguiguiguiguiguiguiguiguiguigui" + time_array);

      chartOption1.value.xAxis.data = OneMinute(time_array, "1");
      time_array = [];
      for (let i = 0; i < tem_array.value[1].length; i++) {
        time_array.push(tem_array.value[1][i][4]);
      }
      console.log("桂桂桂桂桂桂桂桂桂桂桂桂桂桂桂桂桂桂桂桂：" + time_array);

      y_zhi0(OneMinute(time_array, "0"), "device");

      x = setInterval(async () => {
        const result_alarm = await axios.get("/api/alarm");
        // alarm.value = result_alarm.data;
        // const result_ID = await axios.get("/api/recent/list_obj");
        // ID_array.value = result_ID.data;
        const result1 = await axios.get("/api/recent");
        date_Array.value = result1.data;
        a_length.value = date_Array.value.length;
        nowArray.value = [];
        date_Array.value.forEach((item, index) => {
          if (item[0] === signzhi) {
            nowArray.value = item;
          }
        })
        if (nowArray.value.length < 1) {
          nowArray.value = date_Array.value[0];
        }
        tem_array.value = [, []];
        tem_array.value[0] = nowArray.value[0];
        nowArray.value[1].forEach((item, index) => {
          item[4] = moment(item[4]).format('YYYY-MM-DD HH:mm:ss');
          tem_array.value[1].push(item);
        })
        console.log("tem_array:" + tem_array.value);

        console.log("设备zhexian===none");
        // 渲染柱状图
        chartOption1.value.series[0].data = [];
        chartOption1.value.series[1].data = [];
        chartOption1.value.series[2].data = [];
        // chartOption1.value.series[3].data = [];
        time_array = [];
        // chartOption1.value.title.text = `传感器设备${nowArray.value[0]}的最近5分钟的数据`;
        chartOption1.value.title.text = `传感器设备的最近5分钟的数据`;
        for (let i = 0; i < tem_array.value[1].length; i++) {
          console.log("tem_array.value[1]:" + tem_array.value[1]);
          console.log("tem_array.value[1][i][4]:" + tem_array.value[1][i][4]);
          time_array.push(tem_array.value[1][i][4]);
        }
        console.log("guiguiguiguiguiguiguiguiguiguiguiguigui" + time_array);

        chartOption1.value.xAxis.data = OneMinute(time_array, "1");
        time_array = [];
        for (let i = 0; i < tem_array.value[1].length; i++) {
          time_array.push(tem_array.value[1][i][4]);
        }
        console.log("桂桂桂桂桂桂桂桂桂桂桂桂桂桂桂桂桂桂桂桂：" + time_array);

        y_zhi0(OneMinute(time_array, "0"), "device");
      }, 2000)
    }
  }
  // 行为信息图像切换按钮
  change0 = async (value) => {
    const zhexian_btn = document.querySelector("#zhexian1") as HTMLElement;
    const zhuzhuang_btn = document.querySelector("#zhuzhuang1") as HTMLElement;
    clearInterval(y);
    if (value.target === zhexian_btn) {
      zhexian_action.value = true;
      //为选中元素进行样式修改
      zhexian_btn.classList.add("active");
      zhuzhuang_btn.classList.remove("active");

      //优先执行一次定时器内容
      const result1 = await axios.get("/api/recent/action");
      action_Array.value = result1.data;
      b_length.value = action_Array.value.length;
      nowArray1.value = [];
      action_Array.value.forEach((item, index) => {
        if (item[0] === signzhi1) {
          nowArray1.value = item;
        }
      })
      if (nowArray1.value.length < 1) {
        nowArray1.value = action_Array.value[0];
      }
      tem_array1.value = [, []];
      tem_array1.value[0] = nowArray1.value[0];
      nowArray1.value[1].forEach((item, index) => {
        item[1] = moment(item[1]).format('YYYY-MM-DD HH:mm:ss');
        tem_array1.value[1].push(item);
      })
      console.log("tem_array1:" + tem_array1.value);

      // 对dom元素进行判断若存在则渲染对应的图像
      console.log("行为zhuzhuang===none");
      chartOption0.value.series[0].data = [];
      chartOption0.value.series[1].data = [];
      // chartOption0.value.series[2].data = [];
      // chartOption0.value.series[3].data = [];
      time_array = [];
      // chartOption0.value.title.text = `传感器设备${nowArray1.value[0]}的最近5分钟的数据`;
      chartOption0.value.title.text = `传感器设备的最近5分钟的数据`;
      for (let i = 0; i < tem_array1.value[1].length; i++) {
        console.log("tem_array.value[1]:" + tem_array1.value[1]);
        console.log("tem_array.value[1][i][4]:" + tem_array1.value[1][i][4]);
        time_array.push(tem_array1.value[1][i][2]);
        console.log("time:" + time_array);
      }
      console.log("guiguiguiguiguiguiguiguiguiguiguiguigui" + time_array);


      chartOption0.value.xAxis.data = OneMinute(time_array, "1");
      time_array = [];
      for (let i = 0; i < tem_array1.value[1].length; i++) {
        time_array.push(tem_array1.value[1][i][2]);
      }
      console.log("桂桂桂桂桂桂桂桂桂桂桂桂桂桂桂桂桂桂桂桂：" + time_array);

      y_zhi(OneMinute(time_array, "0"), "action");

      //折线图清空
      y = setInterval(async () => {
        const result1 = await axios.get("/api/recent/action");
        action_Array.value = result1.data;
        b_length.value = action_Array.value.length;
        nowArray1.value = [];
        action_Array.value.forEach((item, index) => {
          if (item[0] === signzhi1) {
            nowArray1.value = item;
          }
        })
        if (nowArray1.value.length < 1) {
          nowArray1.value = action_Array.value[0];
        }
        tem_array1.value = [, []];
        tem_array1.value[0] = nowArray1.value[0];
        nowArray1.value[1].forEach((item, index) => {
          item[1] = moment(item[1]).format('YYYY-MM-DD HH:mm:ss');
          tem_array1.value[1].push(item);
        })
        console.log("tem_array1:" + tem_array1.value);

        // 对dom元素进行判断若存在则渲染对应的图像
        console.log("行为zhuzhuang===none");
        chartOption0.value.series[0].data = [];
        chartOption0.value.series[1].data = [];
        // chartOption0.value.series[2].data = [];
        // chartOption0.value.series[3].data = [];
        time_array = [];
        // chartOption0.value.title.text = `传感器设备${nowArray1.value[0]}的最近5分钟的数据`;
        chartOption0.value.title.text = `传感器设备的最近5分钟的数据`;
        for (let i = 0; i < tem_array1.value[1].length; i++) {
          console.log("tem_array.value[1]:" + tem_array1.value[1]);
          console.log("tem_array.value[1][i][4]:" + tem_array1.value[1][i][4]);
          time_array.push(tem_array1.value[1][i][2]);
          console.log("time:" + time_array);
        }
        console.log("guiguiguiguiguiguiguiguiguiguiguiguigui" + time_array);


        chartOption0.value.xAxis.data = OneMinute(time_array, "1");
        time_array = [];
        for (let i = 0; i < tem_array1.value[1].length; i++) {
          time_array.push(tem_array1.value[1][i][2]);
        }
        console.log("桂桂桂桂桂桂桂桂桂桂桂桂桂桂桂桂桂桂桂桂：" + time_array);

        y_zhi(OneMinute(time_array, "0"), "action");
      }, 2000);
    }
    else if (value.target === zhuzhuang_btn) {
      zhexian_action.value = false;
      //为选中元素进行样式修改
      zhuzhuang_btn.classList.add("active");
      zhexian_btn.classList.remove("active");

      //优先执行一次定时器内容
      const result1 = await axios.get("/api/recent/action");
      action_Array.value = result1.data;
      b_length.value = action_Array.value.length;
      nowArray1.value = [];
      action_Array.value.forEach((item, index) => {
        if (item[0] === signzhi1) {
          nowArray1.value = item;
        }
      })
      if (nowArray1.value.length < 1) {
        nowArray1.value = action_Array.value[0];
      }
      tem_array1.value = [, []];
      tem_array1.value[0] = nowArray1.value[0];
      nowArray1.value[1].forEach((item, index) => {
        item[1] = moment(item[1]).format('YYYY-MM-DD HH:mm:ss');
        tem_array1.value[1].push(item);
      })
      console.log("tem_array1:" + tem_array1.value);
      // 对dom元素进行判断若存在则渲染对应的图像
      console.log("行为zhexian===none");
      // 渲染柱状图
      chartOption11.value.series[0].data = [];
      chartOption11.value.series[1].data = [];
      // ;
      // chartOption11.value.series[3].data = [];
      time_array = [];
      // chartOption11.value.title.text = `传感器设备${nowArray1.value[0]}的最近5分钟的数据`;
      chartOption11.value.title.text = `传感器设备的最近5分钟的数据`;
      for (let i = 0; i < tem_array1.value[1].length; i++) {
        console.log("tem_array.value[1]:" + tem_array1.value[1]);
        console.log("tem_array.value[1][i][4]:" + tem_array1.value[1][i][4]);
        time_array.push(tem_array1.value[1][i][2]);
        console.log("time:" + time_array);
      }
      console.log("guiguiguiguiguiguiguiguiguiguiguiguigui" + time_array);


      chartOption11.value.xAxis.data = OneMinute(time_array, "1");
      time_array = [];
      for (let i = 0; i < tem_array1.value[1].length; i++) {
        time_array.push(tem_array1.value[1][i][2]);
      }
      console.log("桂桂桂桂桂桂桂桂桂桂桂桂桂桂桂桂桂桂桂桂：" + time_array);

      y_zhi(OneMinute(time_array, "0"), "action");

      y = setInterval(async () => {
        const result1 = await axios.get("/api/recent/action");
        action_Array.value = result1.data;
        b_length.value = action_Array.value.length;
        nowArray1.value = [];
        action_Array.value.forEach((item, index) => {
          if (item[0] === signzhi1) {
            nowArray1.value = item;
          }
        })
        if (nowArray1.value.length < 1) {
          nowArray1.value = action_Array.value[0];
        }
        tem_array1.value = [, []];
        tem_array1.value[0] = nowArray1.value[0];
        nowArray1.value[1].forEach((item, index) => {
          item[1] = moment(item[1]).format('YYYY-MM-DD HH:mm:ss');
          tem_array1.value[1].push(item);
        })
        console.log("tem_array1:" + tem_array1.value);
        // 对dom元素进行判断若存在则渲染对应的图像
        console.log("行为zhexian===none");
        // 渲染柱状图
        chartOption11.value.series[0].data = [];
        chartOption11.value.series[1].data = [];
        ;
        // chartOption11.value.series[3].data = [];
        time_array = [];
        // chartOption11.value.title.text = `传感器设备${nowArray1.value[0]}的最近5分钟的数据`;
        chartOption11.value.title.text = `传感器设备的最近5分钟的数据`;
        for (let i = 0; i < tem_array1.value[1].length; i++) {
          console.log("tem_array.value[1]:" + tem_array1.value[1]);
          console.log("tem_array.value[1][i][4]:" + tem_array1.value[1][i][4]);
          time_array.push(tem_array1.value[1][i][2]);
          console.log("time:" + time_array);
        }
        console.log("guiguiguiguiguiguiguiguiguiguiguiguigui" + time_array);


        chartOption11.value.xAxis.data = OneMinute(time_array, "1");
        time_array = [];
        for (let i = 0; i < tem_array1.value[1].length; i++) {
          time_array.push(tem_array1.value[1][i][2]);
        }
        console.log("桂桂桂桂桂桂桂桂桂桂桂桂桂桂桂桂桂桂桂桂：" + time_array);

        y_zhi0(OneMinute(time_array, "0"), "action");
      }, 2000);
    }
  }

});

let cc = 0;//设备渲染
let ccc = 0;//行为渲染
onUpdated(() => {//使用updated钩子解决onMounted无法动态挂载完随响应式数据变化而变化的dom,并且此处仅要求执行一次,否则定时器一直运行导致当前的一号为的内容同样一直运行
  // if (cc === 0) {
  //   if (a_length.value > 1) {//当显示的不是only的时候
  //     const option_array: any = document.querySelectorAll(".device_list");
  //     console.log("guijunqiao")
  //     option_array[0].children[0].style.color = "#409eff";
  //     option_array[0].children[0].style.backgroundColor = "rgb(235.9, 245.3, 255)";
  //     cc++;
  //   }
  // }
  // else { }


  // if (ccc === 0) {
  //   if (b_length.value > 1) {//当显示的不是only的时候
  //     const option_array: any = document.querySelectorAll(".device_list1");
  //     console.log("guijunqiao1")
  //     option_array[0].children[0].style.color = "#409eff";
  //     option_array[0].children[0].style.backgroundColor = "rgb(235.9, 245.3, 255)";
  //     ccc++;
  //   }
  // }
  // else { }
})
// 上述代码需要注意的是：这个语句（setup语法糖的部分中包含了onMounted()和onUpdated()的情况）中，在多次的标签元素的动态修改的时候
//(由外部互动产生的标签元素),在onUpdated这个钩子会因每次的标签元素发生动态的改变而多次执行而setup()本身的内容(例如let i=0)和onMOounted仅执行一次,并且需要注意的是每次onUpdated执行的位置发生在原先的位置的地方进行叠加

//并且发生在屏幕停留在当前页面的情况下才执行上述函数
onUnmounted(() => {
  clearInterval(x);
  clearInterval(y);
});

</script>

<style scoped>
h2 {
  font-size: 2.5em;
}

.example-showcase .el-dropdown+.el-dropdown {
  margin-left: 15px;
}

.example-showcase .el-dropdown-link {
  cursor: pointer;
  color: var(--el-color-primary);
  display: flex;
  align-items: center;
}

.container {
  width: 100%;
  border: 2px solid gray;
  position: relative;
  top: 20px;
}

.c_time1,
.c_time2 {
  font-size: 20px;
}

#latestData {
  display: flex;
  width: 1200px;
  height: 100px;
  flex-wrap: wrap;
}

.container.fit-view {
  border: 0px;
  position: absolute;
  top: 0;
}

.device_list {
  height: 26.33px;
}

.echarts {
  margin-top: 150px;
  width: 900px !important;
  justify-self: center;
}

.echarts>div {
  transform: scale(1.5);
}

.one {
  display: none;
}

/* 用于作为设备列表参考的盒子 */
.container22,
.container222 {
  width: 100%;
  position: relative;
}

.container22>.el-dropdown:nth-child(1),
.container222>.el-dropdown:nth-child(1) {
  position: absolute;
  left: 470px;
}

.container22>.el-dropdown:nth-child(2),
.container222>.el-dropdown:nth-child(2) {
  position: absolute;
  left: 470px;
}



/* 对最新数据表格进行渲染 */
/* 对表格进行样式设计 */
table {
  margin-top: 50px;
  border-top: 5px solid gray;
  width: 100%;
  height: 66px;
  /* 需要注意的是此处不能设置固定的table的高度否则则会导致其中只有一个tr的情况下会占据整个tbody的高度 */
  border-spacing: 0;
  /* 下方设置使得table标签变得其中的th、td标签不会随着内容的变化而发生变化 */
  table-layout: fixed;
}

table>thead,
table>tbody {
  min-height: 0;
  width: 1090px;
  height: 33px;
  background-color: #cecece;
}

table thead>tr,
table tbody>tr {
  width: 1090px;
  height: 32px;
}

table thead>tr>th,
table tbody>tr>td {
  width: 180px;
  height: 32px;
  color: black;
  font-size: 14px;
  border: 1px solid #9DA79F;
  font-weight: 800;
  text-align: center;
}

/* 为唯一的选择的盒子进行样式设计 */
.only,
.only1 {
  width: 176.33px;
  height: 32px;
  font-size: 14px;
  text-align: center;
  line-height: 32px;
  position: absolute;
  left: 480px;
  font-weight: 500;
  background-color: #409eff;
}

.only:hover,
.only1:hover {
  cursor: pointer;
}

/* 为最新消息h2标签进行样式设计 */
h2.newest_device,
h2.newest_action {
  width: 100%;
  position: relative;
  top: 50px;
  background-color: #9da79f;
  margin: 0;
  text-align: center;
}

/* 为选中元素进行样式设计 */
.active {
  background-color: aqua !important;
}

/* 为容器标签设计左边框 */
.container.fit-view {
  border-left: 36px solid gray;
}

/* 设计切换图像按钮盒子的样式 */
.change,
.change1 {
  display: block;
  position: relative;
  top: 105px;
  left: 15px;
  /* width: 280px;
  height: 32px; */
}

.change1 {
  margin-top: 300px;
}

/* 单独设计切换图像按钮盒子 */
#zhexian,
#zhexian1 {
  width: 100px;
  height: 28px;
  background-color: gray;
  border: 0.667px solid black;
  font-size: 14px;
}

#zhexian:hover,
#zhexian1:hover {
  cursor: pointer;
  box-shadow: 1px 1px 1px 1px gray;
}

#zhuzhuang,
#zhuzhuang1 {
  margin-left: 30px;
  width: 100px;
  height: 28px;
  border: 0.667px solid black;
  background-color: gray;
  font-size: 14px;
}

#zhuzhuang:hover,
#zhuzhuang1:hover {
  cursor: pointer;
  box-shadow: 1px 1px 1px 1px gray;
}

/* 为屏蔽器进行样式设计  */
.h2_checkbox {
  width: 100% !important;
  height: 19px !important;
  background-color: gray;
  display: flex;
  justify-content: center;
}

.select_checkbox {
  width: 100% !important;
  height: 19px !important;
  background-color: gray;
  display: flex;
  justify-content: center;

}

.table_checkbox {
  width: 1104px !important;
  height: 19px !important;
  display: flex;
  justify-content: center;
  background-color: gray;

}

.change_checkbox {
  width: 100%;
  height: 19px !important;
  display: flex;
  justify-content: center;
  background-color: gray;

}

.image_checkbox {
  width: 100%;
  height: 19px !important;
  display: flex;
  justify-content: center;
  background-color: gray;
}

/* 使得表格宽度铺满整个页面 */
/* .table_device,
.table_action {
  width:100px !important;
} */

/* 为屏蔽器添加上悬浮样式 */
input[type="checkbox"]:hover {
  cursor: pointer;
}

.newest_device {
  width: 100% !important;
}

/* modal样式设计 */
#modal {
  position: fixed;
  top: 160px;
  left: 50%;
  transform: translate(-50%, -50%);
  z-index: 1000;
  display: none;
}

.modal_child {
  height: 200px;
  background-color: white;
  padding: 20px;
  border-radius: 5px;
  box-shadow: 0 2px 12px 0 rgba(0, 0, 0, 0.1);
  min-width: 300px;
  max-width: 80%;
  overflow: auto;
  overflow: hidden;
}

/* 为弹窗按钮添加样式 */
.btn_modal:hover {
  cursor: pointer;
}

/* 为弹窗X按钮进行样式设计 */
.X {
  color: red;
  position: relative;
  top: 18px;
  left: 325px;
}

.X:hover {
  cursor: pointer;
}
</style>

<!-- 
对于vue而言的样式设计当设计样式无法生效的时候针对位移属性position，首先可以观察检查栏目是否有其他组件对当前的标签进行提前的样式提前设计，
则此时在style中设置的样式可能会由于优先级的不足导致无法生效，但除了提高优先级的方式之外还可以通过使用反向赋值的方式向反方向赋负值达到相同的效果 -->
