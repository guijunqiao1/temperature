<template>
  <div class="container">
    <!-- 设备相关内容 -->
    <el-dropdown>
      <el-button type="primary" v-show="Pinia.type_len > 1">
        机房<el-icon class="el-icon--right"><arrow-down /></el-icon>
      </el-button>
      <template #dropdown>
        <el-dropdown-menu>
          <div>
            <div class="device_list" v-for="item in Pinia.type_array" :key="item[0]">
              <el-dropdown-item>
                <div style="border-radius: 5px;" @click="change_jifang(item[0])">{{ item[0] }}</div>
              </el-dropdown-item>
            </div> 
          </div>
        </el-dropdown-menu>
      </template>
    </el-dropdown>
    <div class="only" style="border-radius: 5px;background-color: #409eff;" v-if="type_len <= 1">
      当前机房：{{ Pinia.signzhi }}</div>  


    <!-- 设备信息  --> 
    <div id="latestData" v-show="Pinia.Device_sign">
      <!-- 弹出框设计 -->   
      <div id="modal">
        <span class="X" @click="XXX">X</span>
        <div class="modal_child">
        </div>
      </div>
    </div>

    <!-- 目标值设定 -->
    <div class="target_set">
      <input type="text">目标温度
      <input type="text">目标湿度
      <button  @click="submit">提交目标值</button>
    </div>


    <!-- 开始测试 -->
    <button class="start_test" @click="test(1)">开始测试</button>
    <button class="end_test" @click="test(0)">停止测试</button>

    <button class="print" @click="print">打印</button>

    <ECharts ref="chartRef" :option="chartOption" style="width:600px; height: 400px;" class="zhexian" />
  </div>
</template>

<script lang="ts" setup name="New">
import axios from 'axios';
import moment from 'moment';
import { onUnmounted, onUpdated } from 'vue';
import { onMounted, ref, nextTick } from 'vue';
import { useRouter } from 'vue-router';
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
import * as echarts from 'echarts/core';


// 在组件中添加一个 ref 引用
const chartRef = ref(null);
const Pinia = useUserStore();

// 响应式变量定义
let yingshe_array = ref();//设备映射数组
let chartOption = ref<any>({});//设备图像--折线

let time_array: any = [];//设备图像和行为图像通用

const router = useRouter();

//定义检测当前切换图像状态的变量 
let zhexian_device = ref(true);

//测试启动标记变量
let test_qidong=0;

//定义定时器类全局id变量--控制设备信息
let x: any = 0;

//定义存储图像数据的数组注意和time_array进行区分
const nowArray = ref([]);

//目标温湿度变量
const target_wen = ref();
const target_shi = ref();

//温湿度总量变量
let sum_wen = 0;
let sum_shi = 0;
let sum_hao = 0;


// 计时秒变量
let jishi_second = 0;



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
  let average: any = [[],[],[],[],[],[],[],[]] ; // 用于存储 5 个字段的平均值--设备信息
  const for_length = average.length;
  const object_chart = chartOption;
  // 遍历 8 个字段--设备信息
  for (let j = 0; j < for_length; j++) {
    let avg_values: any = []; // 存储当前字段的平均值
    value1.forEach(target_time => {
      let targetDate = new Date(target_time);
      let startTime = new Date(targetDate.getTime() - 60 * 1000); // 1 分钟前
      // 筛选出在 [startTime, target_time] 之间的数据
      let relevantRecords = nowArray.value[1].filter(record => {
        let recordDate = new Date(record[8]);
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
        console.log("判断条件不合理");
        avg_values.push(null); // 没有数据时填充 null，避免影响图表
      }
    });
    average[j] = avg_values; // 存入对应字段
  }
  // 更新 chart--设备数据
  for (let i = 0; i < for_length; i++) {
    console.log("成功进入到v内容中");
    if(object_chart.value.series[i]!==undefined){
      object_chart.value.series[i].data = average[i];
    }
  }
  console.log("完成所有内容的赋值");
  console.dir(object_chart);
  if (chartRef.value && chartRef.value.chart) {
    // 直接调用底层 echarts 实例的方法
    chartRef.value.chart.setOption(chartOption.value);
  }
}

//机房修改函数
function change_jifang(value){
  if(test_qidong===1) {
    alert("测试启动过程中无法进行机房切换");
  }
  else{
    //全局变量修改
    Pinia.change(value);
    test(0);//叠加上次数同时清空内容
    //当前页面的重置(携带上Pinia.signzhi)
    //页面重置,先跳到一个空路由，再跳回来
    router.replace('/empty').then(() => {
      router.replace('/test');
    })
    console.log("当前机房:"+Pinia.signzhi);
  }
}

//测试方法
async function test(value) {
  //获取到输入框对象
  const wendu_input = document.querySelector(".target_set>input:nth-child(1)");
  const shidu_input = document.querySelector(".target_set>input:nth-child(2)");
  if(value===0){//停止测试
    //清除计时器
    clearInterval(x);
    if(test_qidong!==1){
      alert("请先启动测试");
    }
    else{
      const result = await axios.get(`/api/test?d_no=${Pinia.signzhi}&qidong=no`);
      test_qidong = 0;
    }
  }else {//开启测试
    if((wendu_input.value<-10)&&(wendu_input.value>30) || (shidu_input.value<-50)&&(shidu_input.value>50)){
      alert("目标值设定必须为数值");
    }else{
      target_wen.value = wendu_input.value;
      target_shi.value = shidu_input.value;
      //清除时间数组内容、图像数组
      clearInterval(x);
      //清空折线图
      chartOption.value.series.forEach((item, index) => {
        item = [];
      })
      //清空时间数组
      time_array = [];
      //清空图像当前维度下的数组
      nowArray.value = [];
      //清空计时器(s)
      jishi_second = 0;
      //清空总量变量
      sum_wen = 0;
      sum_shi = 0;
      sum_hao = 0;

      x = setInterval(async () => {
        //定期渲染图像
        jishi_second++;
      },1000);
      test_qidong = 1;
      const result = await axios.get(`/api/test?d_no=${Pinia.signzhi}&qidong=yes`);
    }
  }
}

// 打印方法
async function print() {
  try {
    // 使用 html2canvas 库，需要先安装: npm install html2canvas
    const html2canvas = await import('html2canvas').then(module => module.default);
    // 获取图表元素
    const chartElement = document.querySelector('.zhexian');
    if (!chartElement) {
      alert("没有找到可打印的图表");
      return;
    }
    // 使用 html2canvas 直接截取 DOM 元素
    const canvas = await html2canvas(chartElement, {
      useCORS: true,
      scale: 2, // 提高分辨率
      backgroundColor: '#ffffff'
    });
    // 获取 canvas 上下文
    const ctx = canvas.getContext('2d');
    
    // 添加标题文本
    ctx.font = 'bold 16px Arial';
    ctx.fillStyle = '#333';
    ctx.textAlign = 'center';
    // 设置文本内容
    let titleText = `${Pinia.signzhi} - 实时测试数据`;
    
    // 在顶部添加标题
    ctx.fillText(titleText, canvas.width / 2, 30);
    
    // 在底部添加时间戳和其他信息
    ctx.font = '12px Arial';
    ctx.fillText(`生成时间: ${moment().format('YYYY-MM-DD HH:mm:ss')}`, canvas.width / 2, canvas.height - 20);
    
    // 在底部添加测试状态
    const testStatus = test_qidong === 1 ? "测试中" : "测试已停止";
    ctx.fillText(`测试状态: ${testStatus}`, canvas.width / 2, canvas.height - 40);

    // 底部添加工位信息
    ctx.fillText(`测试工位: ${Pinia.signzhi}`, canvas.width / 2, canvas.height - 60);

    //计算当前温湿平均值
    const wen_average = sum_wen/jishu_second;
    const shi_average = sum_shi/jishu_second;
    ctx.fillText(`目标温度: ${target_wen.value};平均温度: ${wen_average};目标湿度: ${target_shi.value};平均湿度: ${shi_average}`, canvas.width / 2, canvas.height - 80);

    
    // 创建下载链接
    const link = document.createElement('a');
    link.download = `测试数据_${Pinia.signzhi}_${moment().format('YYYYMMDD_HHmmss')}.png`;
    link.href = canvas.toDataURL('image/png');
    
    // 触发下载
    link.click();
    
  } catch (error) {
    console.error('打印图表时出错:', error);
    alert('打印失败: ' + error.message);
  }
}



//建立websocket连接，完成实时的图像内容填充
//全局建立websocket连接，使得告警内容被实时推送到页面的全局
const socket = new WebSocket('ws://localhost:8081');
// 连接成功
socket.onopen = function() {
    console.log('WebSocket连接成功');
    console.log('WebSocket连接成功');
    console.log('WebSocket连接成功');
    console.log('WebSocket连接成功');
    console.log('WebSocket连接成功');
}; 
// 接收消息
socket.onmessage = function(event) {
  // 发送的消息格式
  const data = JSON.parse(event.data);
  if(data.data){
    //插入当前nowArray中
    if(test_qidong===1){//当启动的情况下才进行插入
      //插入当前数据到时间内容中
      console.log("当前实际的data.data数组："+data.data);
      time_array.push(data.data[9]);//格式化时间值
      console.log("当前实际的time_array内容:"+time_array);
      //插入图像数组
      if(nowArray.value.length<=1){
        nowArray.value[0] = data.data[0];
        data.data.shift();
        nowArray.value.push([data.data]);
      }else {
        data.data.shift();
        console.log("nowA:"+nowArray.value);
        nowArray.value[1].push(data.data);
      }
      console.log("当前的nowArray:"+nowArray.value);
      //统计总量
      sum_wen += data.data[1];
      sum_shi += data.data[2];
      sum_hao += data.data[8];


      //立即完成x轴赋值
      chartOption.value.xAxis.data = OneMinute(time_array, "1");
      //重新渲染图像
      y_zhi(OneMinute(time_array, "0"), "device");
    }
  }
};

// 挂载时加载数据
onMounted(async () => {
  
  const result = await axios.get("/api/yingshe");//设备映射数组
  yingshe_array.value = result.data;
  // 定义图表配置--设备信息--折线图
  chartOption = ref({
    title: {
      text: ""
    },
    tooltip: {
      trigger: 'axis'
    },
    legend: {
      data: [1]
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
    series: [{
      name: '1',
      type: 'line',
      smooth: true,
      data: [1]
    }]
  });
  //需要注意的是初始化体表进行渲染的时候的赋值应该发生在异步处理中，否则报错且不生效
  time_array = [];
  chartOption.value.series = [];
  chartOption.value.legend.data = [];
  // 设备配置赋值
  yingshe_array.value.forEach((item, index) => {
    // 折线赋值
    console.log("检查当前实际插入的字段值:" + item[`field${index + 1}`]);
    chartOption.value.legend.data.push(item[`field${index + 1}`]);
    chartOption.value.series.push({
      name: item[`field${index + 1}`],
      type: 'line',
      smooth: true,
      data: []
    })
  })
});
// 上述代码需要注意的是：这个语句（setup语法糖的部分中包含了onMounted()和onUpdated()的情况）中，在多次的标签元素的动态修改的时候
//(由外部互动产生的标签元素),在onUpdated这个钩子会因每次的标签元素发生动态的改变而多次执行而setup()本身的内容(例如let i=0)和onMOounted仅执行一次,并且需要注意的是每次onUpdated执行的位置发生在原先的位置的地方进行叠加

//并且发生在屏幕停留在当前页面的情况下才执行上述函数
onUnmounted(() => {
  clearInterval(x);
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
    left: 570px;
    top:50px;
  }

  .container22>.el-dropdown:nth-child(2),
  .container222>.el-dropdown:nth-child(2) {
    position: absolute;
    left: 470px;
  }

  /* 行为设备选择器 */
  .container222>.el-dropdown{
    top:0px !important;  
  }

  /* 对最新数据表格进行渲染 */
  /* 对表格进行样式设计 */
  table {
    margin-top: 50px;
    border-top: 5px solid gray;
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
  h2.newest_device {
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
    /* margin-top: 300px; */
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
  .table_action {
    width:100%;
  }

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
  #videoCanvas{
    width: 80%;
    height: auto;
    max-width: 80%;
    max-height: 80%;
  }
  .containerxxx {
    width: 100%;
    display: flex;
    flex-direction: column;
  }
  .h1_one {
    margin-left: 44%;
  }
  .function {
    font-size: 14px;
    margin-top: 50px;
    margin-left: 30%;
    width:30%;
    background-color: yellow;
  }
  .function:hover {
    cursor:pointer;
    box-shadow: 1px 1px 1px 1px black;
  }

  .container_child {
    width: 100%;
    display: flex;
    flex-direction: row;
    justify-content: space-around;
  }
  /* 控制图片大小 */
  .img1>img,
  .img2>img {
    margin-top: 50px;
    width: 200px;
    height: 150px;
    max-width: 200px;
    max-height: 150px;
  }

  .el-dropdown {
    margin-left: 435px;
    margin-top: 40px;
  }
</style>

<!-- 
对于vue而言的样式设计当设计样式无法生效的时候针对位移属性position，首先可以观察检查栏目是否有其他组件对当前的标签进行提前的样式提前设计，
则此时在style中设置的样式可能会由于优先级的不足导致无法生效，但除了提高优先级的方式之外还可以通过使用反向赋值的方式向反方向赋负值达到相同的效果 -->
