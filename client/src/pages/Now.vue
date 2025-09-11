<template>
  <div class="container">
    <!-- 设备相关内容 -->
    <el-dropdown>
      <el-button type="primary" v-show="Pinia.type_len > 1" class="device-selector">
        工位<el-icon class="el-icon--right"><arrow-down /></el-icon>
      </el-button>
      <template #dropdown>
        <el-dropdown-menu>
          <div>
            <div class="device_list" v-for="item in Pinia.type_array" :key="item[0]">
              <el-dropdown-item>
                <div class="device-item" @click="change_jifang(item[0])">{{ item[0] }}</div>
              </el-dropdown-item>
            </div>
          </div>
        </el-dropdown-menu>
      </template>
    </el-dropdown>
    <div class="only" v-if="type_len <= 1">
      {{ Pinia.signzhi }}</div>

    <div class="jiance_text">全局自动检测</div>
    <div class="jiance_container">
      <button @click="start_all_jiance">开启</button>
      <button class="button_active" @click="end_all_jiance">关闭</button>
    </div>

    <!-- 监控相关内容 -->
    <h2 class="section-title">监控相关内容</h2>
    <div class="containerxxx">
      <h1 class="h1_one">实时监控</h1> 
      <div class="video-container">
        <img id="videoCanvas" :src="src0" alt="实时视频" class="video-stream"> 
      </div>
      <div class="change_model">
        <button class="no_auto button_active" @click="change_to_no_auto">手动</button>
        <button class="auto" @click="change_to_auto">自动</button>
      </div>
      <button class="function" @click="jiance">检测</button>

      <h1 class="h1_two">检测结果：</h1>
      <div class="result">
        <div class="result-header">
          <span class="result-time">检测时间: {{ moment(time).format('YYYY-MM-DD HH:mm:ss') }}</span>
        </div>
        <div class="result-content">
          <div class="result_person">实际检测结果: {{ REF==='1'?'有人':'没人' }}</div>
          <div class="confidence_person">可信度: {{ REF_confidence }}</div>
        </div>
        <div class="container_child">
          <div class="img1">
            <h3>原图片：</h3>
            <img :src="src1" alt="图片1">
          </div>
          <div class="img2">
            <h3>检测结果图片:</h3>
             <img :src="src2" alt="图片2">
          </div>
        </div>
      </div>
    </div>

    <!-- 设备信息  -->
    <div id="latestData" v-show="Pinia.Device_sign" class="data-section">
      <!-- 最新信息的提示 -->
      <h2 class="newest_device" v-show="Pinia.Device_sign">传感器最新记录表格</h2>
      <!-- 下方执行v-if语句用于优先对nowArray的值进行动态的判断之后在进行渲染(防止在控制台报错出现内容还没获取到就报错的问题，
      而之所以会报错是因为ref数据的"开始"渲染发生在"所有异步"处理完成之后) -->
      <div class="table-wrapper">
        <table v-if="nowArray && nowArray[1] && nowArray[1].length > 0 && c_length > 0" class="table_device">
          <thead>
            <tr>
              <th>场景</th>
              <th>{{ yingshe_array[0].field1 }} ({{ unit_array[0] }})</th>
              <th>{{ yingshe_array[1].field2 }} ({{ unit_array[1] }})</th>
              <th>{{ yingshe_array[2].field3 }} ({{ unit_array[2] }})</th>
              <th>{{ yingshe_array[3].field4 }} ({{ unit_array[3] }})</th>
              <th>{{ yingshe_array[4].field5 }} ({{ unit_array[4] }})</th>
              <th>{{ yingshe_array[5].field6 }} ({{ unit_array[5] }})</th>
              <th>{{ yingshe_array[6].field7 }} ({{ unit_array[6] }})</th>
              <th>{{ yingshe_array[7].field8 }} ({{ unit_array[7] }})</th>
              <th>收集时间</th>
            </tr>
          </thead>
          <tbody>
            <tr>
              <td>{{ nowArray[0] }}</td>
              <td>{{ nowArray[1][nowArray[1].length - 1][0] }}</td>
              <td>{{ nowArray[1][nowArray[1].length - 1][1] }}</td>
              <td>{{ nowArray[1][nowArray[1].length - 1][2] }}</td>
              <td>{{ nowArray[1][nowArray[1].length - 1][3] }}</td>
              <td>{{ nowArray[1][nowArray[1].length - 1][4] }}</td>
              <td>{{ nowArray[1][nowArray[1].length - 1][5] }}</td>
              <td>{{ nowArray[1][nowArray[1].length - 1][6] }}</td>
              <td>{{ nowArray[1][nowArray[1].length - 1][7] }}</td>
              <td>{{ nowArray[1][nowArray[1].length - 1][8]  }}</td>
            </tr>
          </tbody>
        </table>
      </div>

      <!-- 弹出框设计 -->
      <div id="modal">
        <span class="X" @click="XXX">×</span>
        <div class="modal_child">
        </div>
      </div>
    </div>

    <!-- 图像切换按钮--使用事件委托完成change事件的执行 -->
    <!-- 设备图像 -->
    <div class="change1" @click="change($event)" v-if="a_length > 0 && Pinia.Device_sign">
      <button id="zhexian" class="chart-btn active">折线图(默认)</button>
      <button id="zhuzhuang" class="chart-btn">柱状图</button>
    </div>

    <div class="chart-container">
      <ECharts :option="chartOption" style="width:100%; height: 400px;"
        v-show="a_length > 0 && zhexian_device && Pinia.Device_sign" class="zhexian" />
      <ECharts :option="chartOption1" style="width:100%; height:400px;" class="zhuzhuang"
        v-show="a_length > 0 && !zhexian_device && Pinia.Device_sign" />
    </div>


    <!-- 行为相关内容 -->

    <h2 v-show="Pinia.action_sign && Pinia.Action_sign" class="section-title">不同场地下的最新资源内容</h2>

    <!-- 行为信息 -->
    <div id="latestData" v-if="Pinia.Action_sign" class="data-section">
      <!-- 最新信息的提示 -->
      <h2 class="newest_action">实时数据表格</h2>

      <!-- 下方执行v-if语句用于优先对nowArray的值进行动态的判断之后在进行渲染(防止在控制台报错出现内容还没获取到就报错的问题，
      而之所以会报错是因为ref数据的"开始"渲染发生在"所有异步"处理完成之后) -->
      <div class="table-wrapper">
        <table v-if="nowArray1 && nowArray1[1] && nowArray1[1].length > 0 && d_length > 0" class="table_action">
          <thead>
            <tr>
              <th>场景</th>
              <th>具体资源(原始)</th>
              <th>结果资源(结果)</th>
              <th>可信度</th>
              <th>创建时间</th>
              <th>文件类型</th>
            </tr>
          </thead>
          <tbody>
            <tr>
              <td v-if="Pinia.action_sign">{{ nowArray1[0] }}</td>
              <td>{{ nowArray1[1][nowArray1[1].length - 1][0] }} <button v-show="yingshe_action_array[0].type !== '0'"
                  class="btn_modal" @click="start_block(nowArray1[1][nowArray1[1].length - 1][0])">查看</button> </td>
              <td>{{ nowArray1[1][nowArray1[1].length - 1][1] }} <button v-show="yingshe_action_array[0].type !== '0'"
                  class="btn_modal" @click="start_block(nowArray1[1][nowArray1[1].length - 1][1])">查看</button> </td>
              <td>{{ nowArray1[1][nowArray1[1].length - 1][3] }}</td>
              <td>{{ nowArray1[1][nowArray1[1].length - 1][2] }}</td>
              <td>{{ nowArray1[1][nowArray1[1].length - 1][4] }}</td>
            </tr>
          </tbody>
        </table>
      </div>
    </div>
    <!-- 图像切换按钮--使用事件委托完成change事件的执行 -->
    <div class="change" @click="change0($event)"
      v-if="b_length > 0 && yingshe_action_array && yingshe_action_array[0].is_show === '1' && Pinia.Action_sign">
      <button id="zhexian1" class="chart-btn active">折线图(默认)</button>
      <button id="zhuzhuang1" class="chart-btn">柱状图</button>
    </div>
    <div class="chart-container">
      <ECharts :option="chartOption0" style="width: 100%; height: 400px;" class="zhexian1"
        v-show="b_length > 0 && zhexian_action && Pinia.Action_sign && yingshe_action_array && yingshe_action_array[0].is_show === '1'" />
      <ECharts :option="chartOption11" style="width: 100%; height:400px;" class="zhuzhuang1"
        v-show="b_length > 0 && !zhexian_action && Pinia.Action_sign && yingshe_action_array && yingshe_action_array[0].is_show === '1'" />
    </div>
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

//监控相关变量
const src0 = ref();
const src1 = ref();
const src2 = ref();
const REF = ref();
const REF_confidence = ref();
const time = ref();
const result_person = ref();

const router = useRouter();


//定义额外的维度变量用于内容的扩展
// const alarm = ref();
// const ID_array = ref();

//定义长度变量
let a_length = ref();//设备数组长度记录变量
let b_length = ref();//行为数组长度记录变量
let c_length = ref();//记录设备映射变量
let d_length = ref();//记录行为映射变量

//定义临时变量用于存储点击之后的signzhi
let signzhi = Pinia.signzhi;
let signzhi1 = Pinia.signzhi;

//定义检测当前切换图像状态的变量 
let zhexian_device = ref(true);
let zhexian_action = ref(true);

//定义单位数组变量
let unit_array = ref();
let unit_action_array = ref();

//存储渲染块的变量
let xuanran_block_device = ref();

//定义全局检测button事件
let start_all_jiance = ()=>{};
let end_all_jiance = ()=>{};

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
  if (value_Extension === "jpeg") {
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
  let average: any = value2 === "device" ? [[], [], [],[],[],[],[],[]] : [[], []]; // 用于存储 5 个字段的平均值--设备信息
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
        let recordDate = new Date(record[value2 === "device" ? 8 : 2]);
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
}

//柱状图值的配置函数
function y_zhi0(value1, value2) {
  let sum1: any = value2 === "device" ? [[], [], [],[],[],[],[],[]] : [[], []]; // 用于存储 4 个字段的平均值--设备信息
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
        let recordDate = new Date(record[value2 == "device" ? 8 : 2]);
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
    if(object_chart.value.series[i]!==undefined){
      object_chart.value.series[i].data = sum1[i];
    }
  }
}

//定义定时器类全局id变量--控制设备信息
let x: any = 0;
//定义定时器类全局id变量--控制行为信息
let y: any = 0;

//定义检测定时器变量
let z: any = 0;

//机房修改函数
function change_jifang(value){
  //全局变量修改
  Pinia.change(value);
  //当前页面的重置(携带上Pinia.signzhi)
  //页面重置,先跳到一个空路由，再跳回来

  //优先清除定时器
  clearInterval(z);
  clearInterval(x);
  clearInterval(y);
  clearInterval(auto_x);
  clearInterval(auto_y);
  clearInterval(auto_z);

  router.replace('/empty').then(() => {
    router.replace('/New');
  })
  console.log("当前机房:"+Pinia.signzhi);
}



//定义检测方法--单工位
async function jiance(value){
  console.log("触发检测事件");
  let waibu;
  if(Pinia.signzhi==='工位1'){
    waibu = "0";
  }
  else if(Pinia.signzhi==='工位2'){
    waibu = "1";
  }
  else{
    waibu = "2";
  }
  //截图
  const result1 = await axios.get('http://192.168.1.102:5000/api/screenshot/'+waibu);
  console.log('最终jieguo:'+result1.data['screenshot']);
  const imageData = result1.data['screenshot'];
  //发出检测请求
  const result = await axios.post('http://192.168.1.102:5000/infer', {
    // image: 'iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAADUlEQVR42mP8z8BQDwAEhQGAhKmMIQAAAABJRU5ErkJggg==',
    image: imageData,  // 发送 Base64 编码的图像
  });
  console.log("result_data:");
  console.dir(result.data);
  // console.log("confidence:"+result.data['inference_results'][0]['confidence']);

  //遍历推理结果--得到人类所处的框对应的下标
  let index1=0;
  let have = false;
  result.data['inference_results'].forEach((item,index)=>{
    if(item['class']===0){//当为人的情况
      index1 = index;
      have = true;
    }
  })
  //推断成功才进行内容图片的插入，失败则插入原图，同时修改全局检测变量
  if(have){
    //存到数据库中--原图和结果图
    const result_insert = await axios.post('/api/insert_img',{
      image: [imageData,result.data['processed_image']],
      d_no: Pinia.signzhi,
      person: result.data['inference_results'][index1]['class'],
      confidence: result.data['inference_results'][index1]['confidence']
    }) 
    //检测到了人的分支下请求后端是否进行设备的管控
    await axios.get(`/api/operate_device?d_no=${Pinia.signzhi}`);
  }else{
    if(result.data['inference_results']&&result.data['inference_results'].length>0){//没人但是存在物品时
      //存到数据库中--原图和结果图
      const result_insert = await axios.post('/api/insert_img',{
        image: [imageData,result.data['processed_image']],
        d_no: Pinia.signzhi,
        person: result.data['inference_results'][0]['class'],
        confidence: result.data['inference_results'][0]['confidence']
      }) 
    }else{
      await axios.post(`/api/insert_img`,{
        image: [imageData,imageData],
        d_no: Pinia.signzhi
      });
    }
    //没人情况下主动发送关灯指令
    await axios.get(`/api/zhiling/led?d_no=${Pinia.signzhi}&content=关`);
  }
  //获取库中最新记录
  const result_newest = await axios.get(`/api/recent/img?d_no=${Pinia.signzhi}`);
  //实时更新图片内容--在当前机房的情况下
  src1.value = "../../public/" + result_newest.data.field1;
  src2.value = "../../public/" + result_newest.data.field2;
  console.log("src1:"+src1.value);
  console.log("src2:"+src2.value);
  //实时更新最新检测时间
  time.value = result_newest.data.c_time;//最后元素规定为时间值的情况
  REF.value = result_newest.data.result;
  REF_confidence.value = result_newest.data.confidence;
  alert("成功完成本次的检测");
}


//定义自动检测的定时器变量--三者
let auto_x;
let auto_y;
let auto_z;


//定义检测方法--全工位
async function start_jiance_all(){
  console.log("触发检测事件");
  //封装三个维度通用的公共检测代码--自动模式下
  async function all_auto_jiance(value){//返回自定义的定时器
    //截图
    const result1 = await axios.get('http://192.168.1.102:5000/api/screenshot/'+value.split("工位")[1]);
    const imageData = result1.data['screenshot'];
    //发出检测请求
    const result = await axios.post('http://192.168.1.102:5000/infer', {
      // image: 'iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAADUlEQVR42mP8z8BQDwAEhQGAhKmMIQAAAABJRU5ErkJggg==',
      image: imageData,  // 发送 Base64 编码的图像
    });
    //遍历推理结果--得到人类所处的框对应的下标
    let index1=0;
    let have = false;
    result.data['inference_results'].forEach((item,index)=>{
      if(item['class']===0){//当为人的情况
        index1 = index;
        have = true;
      }
    })
    //推断成功才进行内容图片的插入，失败则插入原图，同时修改全局检测变量
    if(have){
      //存到数据库中--原图和结果图
      const result_insert = await axios.post('/api/insert_img',{
        image: [imageData,result.data['processed_image']],
        d_no: Pinia.signzhi,
        person: result.data['inference_results'][index1]['class'],
        confidence: result.data['inference_results'][index1]['confidence']
      }) 
      //更新面板状态
      //获取库中最新记录
      const result_newest = await axios.get(`/api/recent/img?d_no=${Pinia.signzhi}`);
      //实时更新图片内容--在当前机房的情况下
      src1.value = "../../public/" + result_newest.data.field1;
      src2.value = "../../public/" + result_newest.data.field2;
      console.log("src1:"+src1.value);
      console.log("src2:"+src2.value);
      //实时更新最新检测时间
      time.value = result_newest.data.c_time;//最后元素规定为时间值的情况
      REF.value = result_newest.data.result;
      REF_confidence.value = result_newest.data.confidence;

      //检测到了人的分支下请求后端是否进行设备的管控
      await axios.get(`/api/operate_device?d_no=${value}`);
    }else{
      //没人情况下主动发送关灯指令
      await axios.get(`/api/zhiling/led?d_no=${value}&content=关`);
    }
  }
  //触发三者的自动检测
  auto_x = setInterval(()=>{
    all_auto_jiance('工位1');
  },5000);
  auto_y = setInterval(()=>{
    all_auto_jiance('工位2');
  },5000);
  auto_z = setInterval(()=>{
    all_auto_jiance('工位3');
  },5000);
}

//定义停止全局自动检测的方法
async function end_jiance_all() {
  clearInterval(auto_x);
  clearInterval(auto_y);
  clearInterval(auto_z);
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
  const result11 = await axios.get("/api/recent/action");//行为种类数组
  action_Array.value = result11.data;
  date_Array.value.forEach((item, index) => {
    console.log("item[0]:"+item[0]);
    console.log("signzhi:"+signzhi);
    if (item[0] === signzhi) {
      nowArray.value = item;
    }
  })
  tem_array.value = [, []];
  console.dir(nowArray.value);
  tem_array.value[0] = nowArray.value[0];
  nowArray.value[1].forEach((item, index) => {
    item[8] = moment(item[8]).format('YYYY-MM-DD HH:mm:ss');
    tem_array.value[1].push(item);
  })
  action_Array.value.forEach((item, index) => {
    if (item[0] === signzhi1) {
      nowArray1.value = item;
    }
  })
  tem_array1.value = [, []];
  tem_array1.value[0] = nowArray1.value[0];
  nowArray1.value[1].forEach((item, index) => {
    item[2] = moment(item[2]).format('YYYY-MM-DD HH:mm:ss');
    tem_array1.value[1].push(item);
  })
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
  // 折线图、柱状图--设备
  for (let i = 0; i < tem_array.value[1].length; i++) {
    time_array.push(tem_array.value[1][i][8]);
  }
  chartOption.value.xAxis.data = OneMinute(time_array, "1");
  chartOption1.value.xAxis.data = OneMinute(time_array, "1");
  //为time_array填充上原先时间格式的内容
  time_array = [];
  for (let i = 0; i < tem_array.value[1].length; i++) {
    time_array.push(tem_array.value[1][i][8]);
  }
  y_zhi(OneMinute(time_array, "1"), "device");
  y_zhi0(OneMinute(time_array, "1"), "device");
  // 折线图、柱状图--行为
  time_array = [];
  for (let i = 0; i < tem_array1.value[1].length; i++) {
    time_array.push(tem_array1.value[1][i][2]);
  }
  chartOption0.value.xAxis.data = OneMinute(time_array, "1");
  chartOption11.value.xAxis.data = OneMinute(time_array, "1");
  time_array = [];
  for (let i = 0; i < tem_array1.value[1].length; i++) {
    time_array.push(tem_array1.value[1][i][2]);
  }
  y_zhi(OneMinute(time_array, "0"), "action");
  y_zhi0(OneMinute(time_array, "0"), "action");
})()

//定义手动自动模式修改的方法变量
let change_to_auto:any = ()=>{};
let change_to_no_auto:any = ()=>{};

// 挂载时加载数据
onMounted(async () => {
  //获取检测按钮
  const jiance_button = document.querySelector(".function") as HTMLElement;
  //自动手动按钮本身
  const auto_button = document.querySelector(".change_model>.auto") as HTMLElement;
  const no_auto_button = document.querySelector(".change_model>.no_auto") as HTMLElement;
  //获取全局自动检测button
  const start_all_button = document.querySelector(".jiance_container>button:nth-child(1)") as HTMLElement;
  const end_all_button = document.querySelector(".jiance_container>button:nth-child(2)") as HTMLElement;
  //定义手动自动切换方法
  change_to_auto = () => {
    //隐藏检测按钮
    jiance_button.style.display = 'none';

    //禁用全局button
    start_all_button.disabled = true;
    end_all_button.disabled = true;

    //修改样式
    auto_button.classList.add('button_active');
    no_auto_button.classList.remove('button_active');
    //清除先前定时器
    clearInterval(z);
    //启动检测定时器
    z = setInterval(()=>{
      //主动执行检测内容
      jiance();
    },5000);
  }
  change_to_no_auto = () => {
    console.log('成功触');
    //启用全局button
    start_all_button.disabled = false;
    end_all_button.disabled = false;

    //显示检测按钮
    jiance_button.style.display = 'block';
    //修改样式
    auto_button.classList.remove('button_active');
    no_auto_button.classList.add('button_active');
    //清除定时器
    clearInterval(z);
  }
  //定义全局自动检测button方法
  start_all_jiance = ()=>{
    //禁用局部自动检测以及检测
    auto_button.disabled = true;
    no_auto_button.disabled = true;
    jiance_button.disabled = true;


    //屏蔽单工位的自动检测button
    start_all_button.style.display = 'hidden';
    end_all_button.style.display = 'span';
    //修改交互button样式
    start_all_button.classList.add('button_active');
    end_all_button.classList.remove('button_active');
    //提前清空
    end_jiance_all();
    //启动检测程序
    start_jiance_all();
  }
  end_all_jiance = ()=>{
    //启用局部自动检测以及检测
    auto_button.disabled = false;  
    no_auto_button.disabled = false;
    jiance_button.disabled = false;

    //显示单工位的自动检测button
    start_all_button.style.display = 'span';
    end_all_button.style.display = 'hidden';
    //修改交互button样式
    end_all_button.classList.add('button_active');
    start_all_button.classList.remove('button_active');
    //停止检测程序
    end_jiance_all();
  }



  //监控相关内容
  const cameras = [
    {
      id: 'camera_1',           // 摄像头的唯一标识符
      name: '工位1',            // 摄像头名称
      url: 'http://192.168.1.102:5000/stream/0',  // 摄像头视频流对象，0表示默认摄像头
    },
    {
      id: 'camera_2',           // 摄像头的唯一标识符
      name: '工位2',            // 摄像头名称
      url: 'http://192.168.1.102:5000/stream/1',  // 1表示第二个摄像头
    },
    {
      id: 'camera_3',           // 摄像头的唯一标识符
      name: '工位3',            // 摄像头名称
      url: 'http://192.168.1.102:5000/stream/2',  // 2表示第三个摄像头
    }
  ];
  cameras.forEach((item)=>{
    if(item.name===Pinia.signzhi) src0.value = item.url;
  });
  
  x = setInterval(async () => {
    const result_alarm = await axios.get("/api/alarm");
    // alarm.value = result_alarm.data;
    // const result_ID = await axios.get("/api/recent/list_obj");
    // ID_array.value = result_ID.data;
    const result1 = await axios.get("/api/recent");
    date_Array.value = result1.data;
    a_length.value = date_Array.value.length;
    date_Array.value.forEach((item, index) => {
      if (item[0] === signzhi) {
        nowArray.value = item;
      }
    })
    


    tem_array.value = [, []];
    tem_array.value[0] = nowArray.value[0];
    nowArray.value[1].forEach((item, index) => {
      item[8] = moment(item[8]).format('YYYY-MM-DD HH:mm:ss');
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
      time_array.push(tem_array.value[1][i][8]);
    }
    chartOption.value.xAxis.data = OneMinute(time_array, "1");
    time_array = [];
    for (let i = 0; i < tem_array.value[1].length; i++) {
      time_array.push(tem_array.value[1][i][8]);
    }
    y_zhi(OneMinute(time_array, "0"), "device");
  }, 2000);
  y = setInterval(async () => {
    const result1 = await axios.get("/api/recent/action");
    action_Array.value = result1.data;
    b_length.value = action_Array.value.length;
    action_Array.value.forEach((item, index) => {
    if (item[0] === signzhi1) {
        nowArray1.value = item;
      }
    })
    tem_array1.value = [, []];
    tem_array1.value[0] = nowArray1.value[0];
    nowArray1.value[1].forEach((item, index) => {
      item[2] = moment(item[2]).format('YYYY-MM-DD HH:mm:ss');
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
      time_array.push(tem_array1.value[1][i][2]);
    }
    chartOption0.value.xAxis.data = OneMinute(time_array, "1");
    time_array = [];
    for (let i = 0; i < tem_array1.value[1].length; i++) {
      time_array.push(tem_array1.value[1][i][2]);
    }

    y_zhi(OneMinute(time_array, "0"), "action");
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
        item[8] = moment(item[8]).format('YYYY-MM-DD HH:mm:ss');
        tem_array.value[1].push(item);
      })
      //渲染折线图
      chartOption.value.series.forEach((item, index) => {
        item = [];
      })
      time_array = [];
      // chartOption.value.title.text = `传感器设备${nowArray.value[0]}的最近5分钟的数据`;
      // chartOption.value.title.text = `传感器设备的最近5分钟的数据`;
      for (let i = 0; i < tem_array.value[1].length; i++) {
        time_array.push(tem_array.value[1][i][8]);
      }
      chartOption.value.xAxis.data = OneMinute(time_array, "1");
      time_array = [];
      for (let i = 0; i < tem_array.value[1].length; i++) {
        time_array.push(tem_array.value[1][i][8]);
      }
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
          item[8] = moment(item[8]).format('YYYY-MM-DD HH:mm:ss');
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
          time_array.push(tem_array.value[1][i][8]);
        }
        chartOption.value.xAxis.data = OneMinute(time_array, "1");
        time_array = [];
        for (let i = 0; i < tem_array.value[1].length; i++) {
          time_array.push(tem_array.value[1][i][8]);
        }
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
        item[8] = moment(item[8]).format('YYYY-MM-DD HH:mm:ss');
        tem_array.value[1].push(item);
      })
      // 渲染柱状图
      chartOption1.value.series[0].data = [];
      chartOption1.value.series[1].data = [];
      chartOption1.value.series[2].data = [];
      chartOption1.value.series[3].data = [];
      chartOption1.value.series[4].data = [];
      chartOption1.value.series[5].data = [];
      chartOption1.value.series[6].data = [];
      chartOption1.value.series[7].data = [];
      time_array = [];
      // chartOption1.value.title.text = `传感器设备${nowArray.value[0]}的最近5分钟的数据`;
      chartOption1.value.title.text = `传感器设备的最近5分钟的数据`;
      for (let i = 0; i < tem_array.value[1].length; i++) {
        time_array.push(tem_array.value[1][i][8]);
      }
      chartOption1.value.xAxis.data = OneMinute(time_array, "1");
      time_array = [];
      for (let i = 0; i < tem_array.value[1].length; i++) {
        time_array.push(tem_array.value[1][i][8]);
      }
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
          item[8] = moment(item[8]).format('YYYY-MM-DD HH:mm:ss');
          tem_array.value[1].push(item);
        })
        console.log("tem_array:" + tem_array.value);

        console.log("设备zhexian===none");
        // 渲染柱状图
        chartOption1.value.series[0].data = [];
        chartOption1.value.series[1].data = [];
        chartOption1.value.series[2].data = [];
        chartOption1.value.series[3].data = [];
        chartOption1.value.series[4].data = [];
        chartOption1.value.series[5].data = [];
        chartOption1.value.series[6].data = [];
        chartOption1.value.series[7].data = [];
        time_array = [];
        chartOption1.value.title.text = `传感器设备的最近5分钟的数据`;
        for (let i = 0; i < tem_array.value[1].length; i++) {
          time_array.push(tem_array.value[1][i][8]);
        }
        chartOption1.value.xAxis.data = OneMinute(time_array, "1");
        time_array = [];
        for (let i = 0; i < tem_array.value[1].length; i++) {
          time_array.push(tem_array.value[1][i][8]);
        }
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
        item[2] = moment(item[2]).format('YYYY-MM-DD HH:mm:ss');
        tem_array1.value[1].push(item);
      })
      // 对dom元素进行判断若存在则渲染对应的图像
      chartOption0.value.series[0].data = [];
      chartOption0.value.series[1].data = [];
      // chartOption0.value.series[2].data = [];
      // chartOption0.value.series[3].data = [];
      time_array = [];
      // chartOption0.value.title.text = `传感器设备${nowArray1.value[0]}的最近5分钟的数据`;
      chartOption0.value.title.text = `传感器设备的最近5分钟的数据`;
      for (let i = 0; i < tem_array1.value[1].length; i++) {
        time_array.push(tem_array1.value[1][i][2]);
      }
      chartOption0.value.xAxis.data = OneMinute(time_array, "1");
      time_array = [];
      for (let i = 0; i < tem_array1.value[1].length; i++) {
        time_array.push(tem_array1.value[1][i][2]);
      }
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
          item[2] = moment(item[2]).format('YYYY-MM-DD HH:mm:ss');
          tem_array1.value[1].push(item);
        })
        // 对dom元素进行判断若存在则渲染对应的图像
        chartOption0.value.series[0].data = [];
        chartOption0.value.series[1].data = [];
        // chartOption0.value.series[2].data = [];
        // chartOption0.value.series[3].data = [];
        time_array = [];
        // chartOption0.value.title.text = `传感器设备${nowArray1.value[0]}的最近5分钟的数据`;
        chartOption0.value.title.text = `传感器设备的最近5分钟的数据`;
        for (let i = 0; i < tem_array1.value[1].length; i++) {
          time_array.push(tem_array1.value[1][i][2]);
        }
        chartOption0.value.xAxis.data = OneMinute(time_array, "1");
        time_array = [];
        for (let i = 0; i < tem_array1.value[1].length; i++) {
          time_array.push(tem_array1.value[1][i][2]);
        }
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
        item[2] = moment(item[2]).format('YYYY-MM-DD HH:mm:ss');
        tem_array1.value[1].push(item);
      })
      // 对dom元素进行判断若存在则渲染对应的图像
      // 渲染柱状图
      chartOption11.value.series[0].data = [];
      chartOption11.value.series[1].data = [];
      // ;
      // chartOption11.value.series[3].data = [];
      time_array = [];
      // chartOption11.value.title.text = `传感器设备${nowArray1.value[0]}的最近5分钟的数据`;
      chartOption11.value.title.text = `传感器设备的最近5分钟的数据`;
      for (let i = 0; i < tem_array1.value[1].length; i++) {
        time_array.push(tem_array1.value[1][i][2]);
      }

      chartOption11.value.xAxis.data = OneMinute(time_array, "1");
      time_array = [];
      for (let i = 0; i < tem_array1.value[1].length; i++) {
        time_array.push(tem_array1.value[1][i][2]);
      }
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
          item[2] = moment(item[2]).format('YYYY-MM-DD HH:mm:ss');
          tem_array1.value[1].push(item);
        })
        // 对dom元素进行判断若存在则渲染对应的图像
        // 渲染柱状图
        chartOption11.value.series[0].data = [];
        chartOption11.value.series[1].data = [];
        // chartOption11.value.series[3].data = [];
        time_array = [];
        // chartOption11.value.title.text = `传感器设备${nowArray1.value[0]}的最近5分钟的数据`;
        chartOption11.value.title.text = `传感器设备的最近5分钟的数据`;
        for (let i = 0; i < tem_array1.value[1].length; i++) {
          time_array.push(tem_array1.value[1][i][2]);
        }
        chartOption11.value.xAxis.data = OneMinute(time_array, "1");
        time_array = [];
        for (let i = 0; i < tem_array1.value[1].length; i++) {
          time_array.push(tem_array1.value[1][i][2]);
        }
        y_zhi0(OneMinute(time_array, "0"), "action");
      }, 2000);
    }
  }


  //初始化对照资源src1、src2、time
  //获取库中最新记录
  const result_newest = await axios.get(`/api/recent/img?d_no=${Pinia.signzhi}`);
  //实时更新图片内容--在当前机房的情况下
  src1.value = "../../public/" + result_newest.data.field1;
  src2.value = "../../public/" + result_newest.data.field2;
  console.log("src1:"+src1.value);
  console.log("src2:"+src2.value);
  //实时更新最新检测时间
  time.value = result_newest.data.c_time;//最后元素规定为时间值的情况
  REF.value = result_newest.data.result;
  REF_confidence.value = result_newest.data.confidence;


});
// 上述代码需要注意的是：这个语句（setup语法糖的部分中包含了onMounted()和onUpdated()的情况）中，在多次的标签元素的动态修改的时候
//(由外部互动产生的标签元素),在onUpdated这个钩子会因每次的标签元素发生动态的改变而多次执行而setup()本身的内容(例如let i=0)和onMOounted仅执行一次,并且需要注意的是每次onUpdated执行的位置发生在原先的位置的地方进行叠加

//并且发生在屏幕停留在当前页面的情况下才执行上述函数
onUnmounted(() => {
  clearInterval(x);
  clearInterval(y);
});

</script>

<style scoped>
/* 全局样式重置和基础设置 */
* {
  box-sizing: border-box;
}

/* 响应式容器 */
.container {
  width: 100%;
  max-width: 1400px;
  margin: 0 auto;
  padding: 20px;
  background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
  min-height: 100vh;
  border-radius: 15px;
  box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
}

/* 标题样式 */
.section-title {
  font-size: 2.5em;
  color: #2c3e50;
  text-align: center;
  margin: 30px 0;
  font-weight: 600;
  text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.1);
  position: relative;
}

.section-title::after {
  content: '';
  position: absolute;
  bottom: -10px;
  left: 50%;
  transform: translateX(-50%);
  width: 100px;
  height: 3px;
  background: linear-gradient(90deg, #409eff, #67c23a);
  border-radius: 2px;
}

/* 设备选择器样式 */
.device-selector {
  margin: 20px auto;
  display: block;
  padding: 12px 24px;
  font-size: 16px;
  border-radius: 25px;
  box-shadow: 0 4px 15px rgba(64, 158, 255, 0.3);
  transition: all 0.3s ease;
}

.device-selector:hover {
  transform: translateY(-2px);
  box-shadow: 0 6px 20px rgba(64, 158, 255, 0.4);
}

.device-item {
  padding: 8px 16px;
  border-radius: 8px;
  transition: all 0.3s ease;
  cursor: pointer;
}

.device-item:hover {
  background-color: #f0f9ff;
  color: #409eff;
}

/* 唯一选择器样式 */
.only {
  width: 200px;
  height: 40px;
  font-size: 16px;
  text-align: center;
  line-height: 40px;
  margin: 20px auto;
  display: block;
  font-weight: 500;
  background: linear-gradient(135deg, #409eff, #67c23a);
  color: white;
  border-radius: 20px;
  box-shadow: 0 4px 15px rgba(64, 158, 255, 0.3);
  transition: all 0.3s ease;
}

.only:hover {
  cursor: pointer;
  transform: translateY(-2px);
  box-shadow: 0 6px 20px rgba(64, 158, 255, 0.4);
}

/* 监控相关内容样式 */
.containerxxx {
  width: 100%;
  display: flex;
  flex-direction: column;
  align-items: center;
  background: white;
  border-radius: 15px;
  padding: 30px;
  margin: 30px 0;
  box-shadow: 0 8px 25px rgba(0, 0, 0, 0.1);
}

.h1_one, .h1_two {
  font-size: 2em;
  color: #2c3e50;
  margin: 20px 0;
  text-align: center;
  font-weight: 600;
}

/* 视频容器样式 */
.video-container {
  width: 100%;
  max-width: 800px;
  margin: 20px 0;
  border-radius: 15px;
  overflow: hidden;
  box-shadow: 0 8px 25px rgba(0, 0, 0, 0.15);
}

.video-stream {
  width: 100%;
  height: auto;
  display: block;
  border-radius: 15px;
}

/* 检测按钮样式 */
.function {
  font-size: 16px;
  margin: 30px auto;
  padding: 15px 40px;
  width: auto;
  min-width: 200px;
  background: linear-gradient(135deg, #ffd700, #ffed4e);
  border: none;
  border-radius: 25px;
  color: #2c3e50;
  font-weight: 600;
  cursor: pointer;
  transition: all 0.3s ease;
  box-shadow: 0 4px 15px rgba(255, 215, 0, 0.3);
}

.function:hover {
  transform: translateY(-3px);
  box-shadow: 0 8px 25px rgba(255, 215, 0, 0.4);
  background: linear-gradient(135deg, #ffed4e, #ffd700);
}

/* 检测结果样式 */
.result {
  width: 100%;
  background: #f8f9fa;
  border-radius: 15px;
  padding: 25px;
  margin: 20px 0;
  border-left: 5px solid #409eff;
}

.result-header {
  margin-bottom: 20px;
}

.result-time {
  font-size: 18px;
  color: #2c3e50;
  font-weight: 600;
}

.result-content {
  display: flex;
  justify-content: space-around;
  margin: 20px 0;
  flex-wrap: wrap;
  gap: 20px;
}

.result_person, .confidence_person {
  font-size: 16px;
  color: #495057;
  padding: 10px 20px;
  background: white;
  border-radius: 10px;
  box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
}

/* 图片容器样式 */
.container_child {
  width: 100%;
  display: flex;
  flex-direction: row;
  justify-content: space-around;
  flex-wrap: wrap;
  gap: 20px;
  margin-top: 30px;
}

.img1, .img2 {
  text-align: center;
  flex: 1;
  min-width: 250px;
}

.img1 h3, .img2 h3 {
  color: #2c3e50;
  margin-bottom: 15px;
  font-size: 18px;
}

.img1>img, .img2>img {
  width: 100%;
  max-width: 300px;
  height: auto;
  border-radius: 10px;
  box-shadow: 0 4px 15px rgba(0, 0, 0, 0.15);
  transition: transform 0.3s ease;
}

.img1>img:hover, .img2>img:hover {
  transform: scale(1.05);
}

/* 数据表格区域样式 */
.data-section {
  width: 100%;
  margin: 40px 0;
}

.newest_device, .newest_action {
  width: 100%;
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  color: white;
  margin: 0;
  text-align: center;
  padding: 20px;
  border-radius: 15px 15px 0 0;
  font-size: 1.8em;
  font-weight: 600;
  box-shadow: 0 4px 15px rgba(102, 126, 234, 0.3);
}

/* 表格包装器 */
.table-wrapper {
  width: 100%;
  overflow-x: auto;
  background: white;
  border-radius: 0 0 15px 15px;
  box-shadow: 0 8px 25px rgba(0, 0, 0, 0.1);
}

/* 表格样式 */
table {
  width: 100%;
  border-collapse: collapse;
  margin: 0;
  background: white;
}

table>thead, table>tbody {
  width: 100%;
}

table thead>tr {
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  color: white;
}

table thead>tr>th {
  padding: 15px 10px;
  color: white;
  font-size: 14px;
  border: none;
  font-weight: 600;
  text-align: center;
  position: relative;
}

table thead>tr>th::after {
  content: '';
  position: absolute;
  bottom: 0;
  left: 50%;
  transform: translateX(-50%);
  width: 80%;
  height: 2px;
  background: rgba(255, 255, 255, 0.5);
}

table tbody>tr {
  transition: background-color 0.3s ease;
}

table tbody>tr:hover {
  background-color: #f8f9fa;
}

table tbody>tr>td {
  padding: 12px 10px;
  color: #2c3e50;
  font-size: 14px;
  border: 1px solid #e9ecef;
  text-align: center;
  font-weight: 500;
}

/* 图表切换按钮样式 */
.change, .change1 {
  display: flex;
  justify-content: center;
  gap: 20px;
  margin: 30px 0;
  flex-wrap: wrap;
  margin-top: 100px;
}

.chart-btn {
  padding: 12px 24px;
  border: none;
  border-radius: 25px;
  font-size: 14px;
  font-weight: 600;
  cursor: pointer;
  transition: all 0.3s ease;
  background: #e9ecef;
  color: #495057;
  box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
}

.chart-btn:hover {
  transform: translateY(-2px);
  box-shadow: 0 4px 15px rgba(0, 0, 0, 0.15);
}

.chart-btn.active {
  background: linear-gradient(135deg, #409eff, #67c23a);
  color: white;
  box-shadow: 0 4px 15px rgba(64, 158, 255, 0.3);
}

/* 图表容器样式 */
.chart-container {
  width: 100%;
  max-width: 1000px;
  margin: 30px auto;
  background: white;
  border-radius: 15px;
  padding: 20px;
  box-shadow: 0 8px 25px rgba(0, 0, 0, 0.1);
}

/* 弹窗样式 */
#modal {
  position: fixed;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  background: rgba(0, 0, 0, 0.7);
  z-index: 1000;
  display: none;
  justify-content: center;
  align-items: center;
}

.modal_child {
  background: white;
  padding: 30px;
  border-radius: 15px;
  box-shadow: 0 20px 60px rgba(0, 0, 0, 0.3);
  max-width: 90%;
  max-height: 90%;
  overflow: auto;
  position: relative;
}

.X {
  position: absolute;
  top: 15px;
  right: 20px;
  font-size: 24px;
  color: #dc3545;
  cursor: pointer;
  width: 30px;
  height: 30px;
  display: flex;
  align-items: center;
  justify-content: center;
  border-radius: 50%;
  transition: all 0.3s ease;
}

.X:hover {
  background: #f8d7da;
  transform: scale(1.1);
}

/* 弹窗按钮样式 */
.btn_modal {
  background: linear-gradient(135deg, #409eff, #67c23a);
  color: white;
  border: none;
  padding: 8px 16px;
  border-radius: 20px;
  cursor: pointer;
  font-size: 12px;
  margin-left: 10px;
  transition: all 0.3s ease;
  box-shadow: 0 2px 8px rgba(64, 158, 255, 0.3);
}

.btn_modal:hover {
  transform: translateY(-2px);
  box-shadow: 0 4px 15px rgba(64, 158, 255, 0.4);
}

/* 响应式设计 */
@media (max-width: 1200px) {
  .container {
    padding: 15px;
  }
  
  .section-title {
    font-size: 2em;
  }
  
  .h1_one, .h1_two {
    font-size: 1.6em;
  }
}

@media (max-width: 768px) {
  .container {
    padding: 10px;
    border-radius: 10px;
  }
  
  .section-title {
    font-size: 1.8em;
  }
  
  .h1_one, .h1_two {
    font-size: 1.4em;
  }
  
  .containerxxx {
    padding: 20px;
  }
  
  .result-content {
    flex-direction: column;
    align-items: center;
  }
  
  .container_child {
    flex-direction: column;
    align-items: center;
  }
  
  .change, .change1 {
    flex-direction: column;
    align-items: center;
  }
  
  .chart-btn {
    width: 200px;
  }
  
  .table-wrapper {
    font-size: 12px;
  }
  
  table thead>tr>th,
  table tbody>tr>td {
    padding: 8px 5px;
    font-size: 12px;
  }
}

@media (max-width: 480px) {
  .container {
    padding: 5px;
  }
  
  .section-title {
    font-size: 1.5em;
  }
  
  .h1_one, .h1_two {
    font-size: 1.2em;
  }
  
  .containerxxx {
    padding: 15px;
  }
  
  .function {
    padding: 12px 30px;
    font-size: 14px;
  }
  
  .result {
    padding: 15px;
  }
  
  .img1>img, .img2>img {
    max-width: 250px;
  }
}

/* 保持原有的特定样式 */
.example-showcase .el-dropdown+.el-dropdown {
  margin-left: 15px;
}

.example-showcase .el-dropdown-link {
  cursor: pointer;
  color: var(--el-color-primary);
  display: flex;
  align-items: center;
}

.c_time1, .c_time2 {
  font-size: 20px;
}

#latestData {
  display: flex;
  width: 100%;
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
.container22, .container222 {
  width: 100%;
  position: relative;
}

.container22>.el-dropdown:nth-child(1),
.container222>.el-dropdown:nth-child(1) {
  position: absolute;
  left: 570px;
  top: 50px;
}

.container22>.el-dropdown:nth-child(2),
.container222>.el-dropdown:nth-child(2) {
  position: absolute;
  left: 470px;
}

/* 行为设备选择器 */
.container222>.el-dropdown {
  top: 0px !important;
}

/* 为屏蔽器进行样式设计 */
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
  width: 100%;
}

/* 为屏蔽器添加上悬浮样式 */
input[type="checkbox"]:hover {
  cursor: pointer;
}

.newest_device {
  width: 100% !important;
}

/* 为机房修改进行样式设计 */
.change_jifang {
}

/* 保持原有的特定样式 */
.el-dropdown {
  margin-left: 376px;
}

/* 响应式调整 */
@media (max-width: 1200px) {
  .el-dropdown {
    margin-left: 20px;
    margin-top: 20px;
  }
  
  .container22>.el-dropdown:nth-child(1),
  .container222>.el-dropdown:nth-child(1) {
    left: 50%;
    transform: translateX(-50%);
    top: 20px;
  }
  
  .container22>.el-dropdown:nth-child(2),
  .container222>.el-dropdown:nth-child(2) {
    left: 50%;
    transform: translateX(-50%);
    top: 70px;
  }
}

@media (max-width: 768px) {
  .el-dropdown {
    margin-left: 10px;
    margin-top: 15px;
  }
  
  .container22>.el-dropdown:nth-child(1),
  .container222>.el-dropdown:nth-child(1),
  .container22>.el-dropdown:nth-child(2),
  .container222>.el-dropdown:nth-child(2) {
    position: static;
    left: auto;
    top: auto;
    transform: none;
    margin: 10px auto;
    display: block;
  }
}


/* 手动自动激活样式 */
.button_active {
  background-color: green;
}

/* 手动自动样式 */
.change_model {
  width: 300px;
  height: 60px;
}
.change_model>button {
  width: 50%;
  height: 50%;
  font-size: 14px;
}
.change_model>button:hover {
  cursor:pointer;
}

/* 全局检测样式 */
/* 全局检测容器 */
.jiance_container {
  width: 17%;
    position: absolute;
    right: 123px;
    top: 100px;
}
/* 全局检测文本 */
.jiance_text {
  position: absolute;
    right: 72px;
    top: 51px;
    width: 17%;
    height: 50px;
    font-size: 20px;
}
/* 全局检测时间button */
.jiance_container>button:nth-child(1) {
  width: 50%;
  height: 50%;
  font-size: 14px;
}
.jiance_container>button:nth-child(1):hover {
  cursor:pointer;
}
.jiance_container>button:nth-child(2) {
  width: 50%;
  height: 50%;
  font-size: 14px;
}
.jiance_container>button:nth-child(2):hover {
  cursor:poniter;
}

</style>

<!-- 
对于vue而言的样式设计当设计样式无法生效的时候针对位移属性position，首先可以观察检查栏目是否有其他组件对当前的标签进行提前的样式提前设计，
则此时在style中设置的样式可能会由于优先级的不足导致无法生效，但除了提高优先级的方式之外还可以通过使用反向赋值的方式向反方向赋负值达到相同的效果 -->
