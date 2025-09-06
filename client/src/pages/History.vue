<template>
  <div class="container">

    <h1 class="page-title">当前选中的测试次数：{{ Pinia.times }}</h1>


    <!-- 设备相关内容 -->
    <div class="control-section">
      <el-dropdown class="control-dropdown">
        <el-button type="primary" v-show="Pinia.type_len > 1" class="control-btn">
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
        当前工位：{{ Pinia.signzhi }}
      </div>

      <!-- 测试次数 -->
      <el-dropdown class="control-dropdown">
        <el-button type="primary" v-if="Pinia.test_type_len > 1" class="control-btn">
          测试次数<el-icon class="el-icon--right"><arrow-down /></el-icon>
        </el-button>
        <template #dropdown>
          <el-dropdown-menu>
            <div>
              <div class="device_list" v-for="item in Pinia.test_array">
                <el-dropdown-item>
                  <div class="device-item" @click="change_cishu(item)">{{ item }}</div>
                </el-dropdown-item>
              </div>
            </div>
          </el-dropdown-menu>
        </template>
      </el-dropdown>
      <div class="only1" v-if="Pinia.test_type_len < 1">
        当前选中的测试次数：{{ Pinia.times }}
      </div>
    </div>


    <div class="block1 block" v-show="Pinia.Device_sign">
      <el-date-picker v-model="value1" type="datetimerange" start-placeholder="Start Date" end-placeholder="End Date"
        :default-time="defaultTime1" class="date-picker" />
    </div>

    <!-- 用于表格信息提示的标签 -->
    <h2 class="h1" v-show="Pinia.Device_sign">设备表格内容</h2>
    <!-- 当激活了设备列表的时候 -->
    <div class="table-container" v-show="Pinia.Device_sign">
      <table class="device_table">
        <thead v-if="yingshe_array && unit_array">
          <tr>
            <!-- 直接考虑是否为多设备的情况 -->
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
            <!-- <th>数据类型</th> -->
          </tr>
        </thead>
        <tbody>
          <tr v-for="(item, index) in device_page_array">
            <td>{{ item[0] }}</td>
            <td>{{ item[1] }}</td>
            <td>{{ item[2] }}</td>
            <td>{{ item[3] }}</td>
            <td>{{ item[4] }}</td>
            <td>{{ item[5] }}</td>
            <td>{{ item[6] }}</td>
            <td>{{ item[7] }}</td>
            <td>{{ item[8] }}</td>
            <td>{{ moment(item[9]).format('YYYY-MM-DD HH:mm:ss') }}</td>
          </tr>
        </tbody>
      </table>
    </div>
    <!-- 分页栏部分 -->
    <div class="pagination-container" v-show="Pinia.Device_sign">
      <el-pagination v-model:current-page="currentPage" v-model:page-size="pageSize" :total="Number(total1)"
        layout=" prev ,pager, next" />
      <!-- 上述前者用于响应式提供当前选中的页数；第二者用于设置固定的每页中应当呈现的数据；第三者用于获取到总数，则element标签会自动进行计算用于将当前应当呈现的页数；第四者为分页标签的顺序设置；最后者表示设置当前的分页的标签的整体的大小为默认大小 -->
    </div>
    <!-- 设备图像 -->
    <div class="chart-controls" @click="change($event)" v-show="Pinia.Device_sign">
      <button id="zhexian" class="chart-btn active">折线图(默认)</button>
      <button id="zhuzhuang" class="chart-btn">柱状图</button>
    </div>
    <div class="chart-container">
      <ECharts :option="chartOption" class="zhexian chart" />
      <ECharts :option="chartOption1" class="zhuzhuang chart" />
    </div>
    <!-- 行为相关内容 -->
    <h2 v-show="Pinia.Action_sign" class="h2_action">不同传感器设备的行为数据记录</h2>
    <div class="block2 block" v-show="Pinia.Action_sign">
      <el-date-picker v-model="value2" type="datetimerange" start-placeholder="Start Date" end-placeholder="End Date"
        :default-time="defaultTime2" class="date-picker" />
    </div>
    <!-- 行为表格 -->
    <div class="table-container" v-if="Pinia.Action_sign">
      <table class="action_table">
        <thead>
          <tr v-if="yingshe_action && unit_action_array">
            <th>场景</th>
            <th>具体资源(原)</th>
            <th>具体资源(后)</th>
            <th>收集时间</th>
            <th>文件类型</th>
            <th>可信度</th>
            <th>操作</th>
          </tr>
        </thead>
        <tbody>
          <tr v-if="yingshe_action" v-for="item in device_array_action_page_array">
            <td>{{ item[0] }}</td>
            <td>{{ item[1] }} <button v-show="yingshe_action[0].type !== '0'" class="btn_modal"
                @click="start_block(item[1])">查看</button> </td>
            <td>{{ item[2] }} <button v-show="yingshe_action[0].type !== '0'" class="btn_modal"
            @click="start_block(item[2])">查看</button> </td>
            <td>{{ moment(item[3]).format('YYYY-MM-DD HH:mm:ss') }}</td>
            <td>{{ item[4] }}</td>
            <td>{{ item[5] }}</td>
            <td><button class="delete_button" @click="delete1(item)">删除</button></td>
          </tr>
        </tbody>
      </table>
    </div>

    <!-- 弹出框设计 -->
    <div id="modal" class="modal-overlay">
      <span class="X" @click="XXX">×</span>
      <div class="modal_child">
      </div>
    </div>

    <!-- 分页栏部分 -->
    <div class="pagination-container1" v-show="Pinia.Action_sign">
      <el-pagination v-model:current-page="currentPage1" v-model:page-size="pageSize" :total="Number(total2)"
        layout=" prev ,pager, next" />
      <!-- 上述前者用于响应式提供当前选中的页数；第二者用于设置固定的每页中应当呈现的数据；第三者用于获取到总数，则element标签会自动进行计算用于将当前应当呈现的页数；第四者为分页标签的顺序设置；最后者表示设置当前的分页的标签的整体的大小为默认大小 -->
    </div>

    <!-- 设备行为图像 -->
    <div class="chart-controls" @click="change1($event)"
      v-show="Pinia.Action_sign && yingshe_action && yingshe_action[0].is_show != '0'">
      <button id="zhexian1" class="chart-btn active">折线图(默认)</button>
      <button id="zhuzhuang1" class="chart-btn">柱状图</button>
    </div>

    <div class="chart-container" v-show="Pinia.Action_sign && yingshe_action && yingshe_action[0].is_show !== '0'">
      <ECharts :option="chartOption0" class="zhexian1 chart" />
      <ECharts :option="chartOption11" class="zhuzhuang1 chart" />
    </div>

  </div>
</template>

<script lang="ts" setup name="History">
import axios from 'axios';
import moment from "moment";//该引入的模块可搭配上format函数对时间字符串进行格式化为正规DateTime数据类型的值若正常直接对字符串时间值进行渲染得到的内容会出现格式错误
import { onMounted, ref, onUpdated, nextTick } from 'vue';
//导入echart启动函数
import { use } from 'echarts/core';
//导入渲染器
import { CanvasRenderer } from 'echarts/renderers';
import ECharts from "vue-echarts";
//导入折线图需要的组件
import { LineChart } from 'echarts/charts';
//导入柱状图剩余所需要的其它配置项
import { BarChart } from 'echarts/charts';
import { LabelLayout } from 'echarts/features';
import { UniversalTransition } from 'echarts/features';
import { ArrowDown } from '@element-plus/icons-vue'
import { watch } from "vue";
import { useRouter } from 'vue-router'
import {
  TitleComponent,
  TooltipComponent,
  GridComponent,
  LegendComponent,
  ToolboxComponent
} from 'echarts/components'
//调用渲染器以及其它配置项
use([
  CanvasRenderer,
  TitleComponent,
  TooltipComponent,
  GridComponent,
  LegendComponent,
  ToolboxComponent,
  LineChart,
  BarChart,
  LabelLayout,
  UniversalTransition]);
import { useUserStore } from "../store/curt";
const Pinia = useUserStore();

//定义响应式数据
let yingshe_array = ref();
let yingshe_action = ref();//将行为映射关系进行存储的数组
// 设备数据图像配置变量
let chartOption = ref<any>({});//折线图配置变量
let chartOption1 = ref<any>({});//柱状图配置变量
// 行为数据图像配置变量
let chartOption0 = ref<any>({});//折线图配置变量
let chartOption11 = ref<any>({});//柱状图配置变量
// 设备数据切换、设备数据图像切换事件变量
let change0 = (value: any, value1) => { };//用于控制切换设备按钮事件的定义
let change = (value: any) => { };//用于控制切换图像的事件的定义
// 行为数据切换、行为数据图像切换事件变量
let change2 = (value: any, value1) => { };//用于控制切换行为按钮事件的定义
let change1 = (value: any) => { };//用于控制切换行为图像的事件的定义

//设备数据介质数组
let date_Array = ref([]);//用于归还将所有内容获取到的数组
let time_array: any = [];//用于将折线图数据填充格式化的数组
//行为数据介质数组
let date_Array1 = ref([]);
let time_array1: any = [];
//定义记录设备列表长度的变量用于控制前端的组件的呈现
const a_length = ref();
const b_length = ref();
//定义记录设备(设备行为)种类数量的变量
const a1_length = ref();
const b1_length = ref();

// 设备数组的变量信息
let now_databasesArray = ref();//该数组用于将dataArray中确定的字段进行赋值--发生在change事件中
let type_array: any = ref([]);//databases筛选了d_no不重复的结果
let device_array: any = ref(null);//进行设备数组的定义，用于将设备信息单独作为内容呈现，并且也是从now_databasesArray中进行截取到的
let device_page_array: any = ref(null);//进行设备数组的定义，用于将device_array中的信息进行分页提取--用于呈现的数组
let unit_array = ref();//设备数据单位数组
let unitlen: any = ref(0);

// 行为数组的变量信息
let now_databasesArray1 = ref();
let type_array1: any = ref([]);
let device_array1: any = ref(null);
let device_array_action_page_array = ref();//用于行为设备的分页呈现
let unit_action_array = ref();//行为数据单位数组
let unitactionlen: any = ref(0);
// 页数变量
const currentPage = ref(1);//当前页数变量,当发生自身发生改变的时候就将数据库中对应页码的数据进行单独的databases_array的赋值
const currentPage1 = ref(1);//用于行为表格分页使用的页数变量
let pageSize = 12;
const total1 = ref(0)//总数变量,当发生增添事件、删除事件(包括单独删除以及搜索删除)之后进行总量变量的重新计算
const total2 = ref(0);//总数变量用于计算行为表格中动态的值的总数
let signzhi: any = ref(Pinia.signzhi);//记录设备数据编号
let signzhi1: any = ref(Pinia.signzhi);//记录书号值
//时间选择数据--设备数据
let value1 = ref([]);
let start: any = 1;
let end: any = 1;
//时间选择数据--行为数据
let value2 = ref([]);
let start1: any = 1;
let end1: any = 1;
//定义初始标记
let update = () => { };//普通数据表更新函数
let update1 = () => { };//行为表更新函数


//声明删除函数
let delete1 = (value) => {  };



const router = useRouter();


const defaultTime1 = [new Date(2000, 1, 1, 12, 0), new Date(2000, 1, 1, 12, 0, 0)]; // '12:00:00'
const defaultTime2 = [new Date(2000, 1, 1, 12, 0), new Date(2000, 1, 1, 12, 0, 0)]; // '12:00:00'

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

//机房切换重置方法
function change_jifang(value){
  Pinia.change(value);
  Pinia.change_times(0);
  //页面重置,先跳到一个空路由，再跳回来
  router.replace('/empty').then(() => {
    router.replace('/History');
  })
  console.log("当前机房:"+Pinia.signzhi);
}

//修改测试次数的方法
function change_cishu(value){
  Pinia.change_times(value);
  //页面重置,先跳到一个空路由，再跳回来
  router.replace('/empty').then(() => {
    router.replace('/History');
  })
  console.log("当前次数:"+Pinia.times);
}


//专门用于更新的函数--赋值device_page_array和jiezhi_array
update = async () => {//用于自动触发分页路由
  const boolean_x = start !== 1 && end !== 1 && start.getTime() === end.getTime();
  //直接进行赋值(由于本身databases_array就随着ok的变化而变化所以不需要进行条件判断)
  console.log("发送之前的times为："+Pinia.times);
  const result = await axios.get(`/api/test_history?currentPage=${currentPage.value}&pageSize=${pageSize}&start=${boolean_x ? "end" : start}&end=${end}&d_no=${signzhi.value}&times=${Pinia.times}`);
  device_page_array.value = result.data;//进行设备分页数组的赋值
  const result1 = await axios.get(`/api/test_history?start=${boolean_x ? "end" : start}&end=${end}&d_no=${signzhi.value}&times=${Pinia.times}`);//将设备编号与指定时间内容进行获取用于device_array的赋值(该数组用于ecahrts渲染)--该路由需要设计current的判断
  device_array.value = result1.data;
  const result_count = await axios.get(`/api/History_count?start=${boolean_x ? "end" : start}&end=${end}&d_no=${signzhi.value}&times=${Pinia.times}`);//用于获取总数
  total1.value = result_count.data;
  const result2 = await axios.get(`/api/device_unit`);
  unit_array.value = result2.data;
  unitlen.value = unit_array.value.length;
  // 数据更新阶段对type_array进行赋值
  const result111 = await axios.get("/api/data?start=1&end=1");
  type_array.value = qu_repeate(result111.data);//去重数组的获取
  enough();
};

//专门用于更新的函数--赋值device_action和action
update1 = async () => {//用于自动触发分页路由
  const boolean_x = start1 !== 1 && end1 !== 1 && start1.getTime() === end1.getTime();
  //直接进行赋值(由于本身databases_array就随着ok的变化而变化所以不需要进行条件判断)
  const result = await axios.get(`/api/data/action?currentPage=${currentPage1.value}&pageSize=${pageSize}&start=${boolean_x ? "end" : start1}&end=${end1}&d_no=${signzhi1.value}`);
  device_array_action_page_array.value = result.data;//进行设备分页数组的赋值
  const result1 = await axios.get(`/api/data/action?start=${boolean_x ? "end" : start1}&end=${end1}&d_no=${signzhi1.value}`);//将设备编号与指定时间内容进行获取用于device_array的赋值(该数组用于ecahrts渲染)--该路由需要设计current的判断
  device_array1.value = result1.data;
  const result_count = await axios.get(`/api/action_count?start=${boolean_x ? "end" : start1}&end=${end1}&d_no=${signzhi1.value}`);//用于获取总数
  total2.value = result_count.data;
  const result2 = await axios.get(`/api/action_unit`);
  unit_action_array.value = result2.data;
  unitactionlen.value = unit_action_array.value.length;
  // 数据更新阶段对type_array进行赋值
  const result111 = await axios.get("/api/data/action?start=1&end=1");
  type_array1.value = qu_repeate(result111.data);//去重数组的获取
  enough();
};


//专门用于将数组去重复化的函数--赋值type_array
function qu_repeate(databases) {
  const result: any[] = [];
  const seen: Set<string> = new Set(); // 用来记录已经出现过的设备编号

  // 遍历数据库数组
  for (let i = 0; i < databases.length; i++) {
    const [deviceId, data] = databases[i];

    // 如果设备编号未出现过，添加到结果数组中
    if (!seen.has(deviceId)) {
      result.push([deviceId, data]);
      seen.add(deviceId); // 标记该设备编号为已出现
    }
  }
  return result;
}

//专门用于填充图表以及echarts的函数
function enough() {
  console.log("当前进入成功enough后的device_array:" + device_array.value);

  // 设备信息
  if (a_length.value >= 0 && Pinia.Device_sign) {//当对应上第一个组件正常显示的时候执行
    //折线图的横轴结构设计--柱状图不需要设计
    time_array = [];
    //设备判断
    if (chartOption && chartOption.value && chartOption.value.title && chartOption1 && chartOption1.value && chartOption1.value.title) {
      if (start === 1 || end === 1) {
        chartOption.value.title.text = `传感器设备变化情况`;
      }
      else {
        chartOption.value.title.text = `从${moment(start).format('YYYY-MM-DD HH:mm')}到${moment(end).format('YYYY-MM-DD HH:mm')}传感器设备变化情况`;
      }
      // 确保device_array已初始化且有数据
      if (device_array && device_array.value && device_array.value.length > 0) {
        //时间轴赋值
        for (let i = 0; i < device_array.value.length; i++) {
          time_array.push(moment(device_array.value[i][9]).format('YYYY-MM-DD HH:mm'));
        }
        chartOption.value.xAxis.data = time_array;

        // 折线清空
        chartOption.value.series.forEach((item, index) => {
          item.data = [];
        })

        //设备赋值
        for (let i = 0; i < device_array.value.length; i++) {
          // 和映射数组对比判断是否需要将值加入到渲染数组中
          chartOption.value.series.forEach((item, index) => {
            item.data.push(device_array.value[i][index + 1]);
          })
        }
        console.dir(chartOption.value);
        chartOption1.value.series[0].data = [];
        //柱状图(设备生产总量,定义总和变量)
        let sum1 = 0;
        let sum2 = 0;
        let sum3 = 0;
        let sum4 = 0;
        let sum5 = 0;
        let sum6 = 0;
        let sum7 = 0;
        let sum8 = 0;
        //设备信息
        for (let i = 0; i < device_array.value.length; i++) {
          console.log("当前设备为：" + device_array.value[i]);
          sum1 += Number(device_array.value[i][1]);
          sum2 += Number(device_array.value[i][2]);
          sum3 += Number(device_array.value[i][3]);
          sum4 += Number(device_array.value[i][4]);
          sum5 += Number(device_array.value[i][5]);
          sum6 += Number(device_array.value[i][6]);
          sum7 += Number(device_array.value[i][7]);
          sum8 += Number(device_array.value[i][8]);
        }
        //设备赋值
        chartOption1.value.series[0].data.push(sum1);
        chartOption1.value.series[0].data.push(sum2);
        chartOption1.value.series[0].data.push(sum3);
        chartOption1.value.series[0].data.push(sum4);
        chartOption1.value.series[0].data.push(sum5);
        chartOption1.value.series[0].data.push(sum6);
        chartOption1.value.series[0].data.push(sum7);
        chartOption1.value.series[0].data.push(sum8);

        //修改柱状图标题
        //设备判断
        // if (!start || !end) {//若起始
        //   chartOption1.value.title.text = `从起始统计到现在的数据总量`;
        // }
        // else {
        //   if (start === 1 || end === 1) {
        //     chartOption1.value.title.text = `传感器设备的各项数据总量`;
        //   }
        //   else {
        //     chartOption1.value.title.text = `从${moment(start).format('YYYY-MM-DD HH:mm')}到${moment(end).format('YYYY-MM-DD HH:mm')}传感器设备的各项数据总量`;
        //   }
        // }
      }
      else {
        //清空
        chartOption.value.xAxis.data = [];
        chartOption.value.series.forEach((item, index) => {
          item.data = [];
        })
        chartOption1.value.series[0].data = [];
      }
    }
    console.log("折线得到最终的结果为：");
    console.dir(chartOption.value);
  }
  // 行为信息
  if (b_length.value >= 0 && Pinia.Action_sign) {//当对应上第一个组件正常显示的时候执行
    console.log("成功第一层-----------------------------------")
    //折线图的横轴结构设计--柱状图不需要设计
    time_array1 = [];
    //设备判断
    if (chartOption0 && chartOption0.value && chartOption0.value.title && chartOption11 && chartOption11.value && chartOption11.value.title) {
      console.log("成功第二层-----------------------------------");
      if (start1 === 1 || end1 === 1) {
        chartOption0.value.title.text = `传感器设备变化情况`;
      }
      else {
        chartOption0.value.title.text = `从${moment(start1).format('YYYY-MM-DD HH:mm')}到${moment(end1).format('YYYY-MM-DD HH:mm')}传感器设备变化情况`;
      }
      // 确保device_array已初始化且有数据
      if (device_array1 && device_array1.value && device_array1.value.length > 0) {
        //时间轴赋值
        for (let i = 0; i < device_array1.value.length; i++) {
          time_array1.push(moment(device_array1.value[i][3]).format('YYYY-MM-DD HH:mm'));
        }
        chartOption0.value.xAxis.data = time_array1;
        // 折线清空
        chartOption0.value.series.forEach((item, index) => {
          item.data = [];
        })
        //设备赋值
        for (let i = 0; i < device_array1.value.length; i++) {
          // 和映射数组对比判断是否需要将值加入到渲染数组中
          chartOption0.value.series.forEach((item, index) => {
            item.data.push(device_array1.value[i][index + 1]);
          })
        }
        console.log("行为配置wancheng:");
        console.dir(chartOption0.value);
        chartOption11.value.series[0].data = [];
        //柱状图(设备生产总量,定义总和变量)
        let sum1 = 0;
        let sum2 = 0;
        //设备信息
        for (let i = 0; i < device_array1.value.length; i++) {
          console.log("当前设备为：" + device_array1.value[i]);
          sum1 += Number(device_array1.value[i][1]);
          sum2 += Number(device_array1.value[i][2]);
        }
        //设备赋值
        chartOption11.value.series[0].data.push(sum1);
        chartOption11.value.series[0].data.push(sum2);

        //赋值后的总数
        console.log("当前总数:");
        console.dir(chartOption11.value);
        console.log("实际总数:");


        //修改柱状图标题
        //设备判断
        // if (!start1 || !end1) {//若起始
        //   chartOption11.value.title.text = `从起始统计到现在的数据总量`;
        // }
        // else {
        //   if (start1 === 1 || end1 === 1) {
        //     chartOption11.value.title.text = `传感器设备的各项数据总量`;
        //   }
        //   else {
        //     chartOption11.value.title.text = `从${moment(start1).format('YYYY-MM-DD HH:mm')}到${moment(end1).format('YYYY-MM-DD HH:mm')}传感器设备的各项数据总量`;
        //   }
        // }
      }
      else {
        //清空
        chartOption0.value.xAxis.data = [];
        chartOption0.value.series.forEach((item, index) => {
          item.data = [];
        })
        chartOption11.value.series[0].data = [];
      }
    }
  }
}


//自当前组件创建阶段就对currentPage变量的值进行监视，若发生了修改，则结合上currentPage变量对databases_array赋值(模版为jiezhi_array)
watch(() => currentPage.value, (newValue, oldValue) => {
  update();
}, { deep: true, immediate: true });
//监听行为表
watch(() => currentPage1.value, (newValue, oldValue) => {
  update1();
}, { deep: true, immediate: true });


onMounted(async () => {
  const result = await axios.get("/api/yingshe");
  yingshe_array.value = result.data;
  const result_action = await axios.get("/api/yingshe/action");
  yingshe_action.value = result_action.data;
  // 立即执行函数的位置替换后的状态
  // 对上述内容进行同意替换
  update();
  update1();
  const result1 = await axios.get("/api/data?start=1&end=1");
  date_Array.value = result1.data;
  const result2 = await axios.get("/api/data/action?start=1&end=1");
  date_Array1.value = result2.data;
  type_array.value = qu_repeate(date_Array.value);//去重数组的获取
  type_array1.value = qu_repeate(date_Array1.value);//去重数组的获取
  a1_length.value = type_array.value.length;
  b1_length.value = type_array1.value.length;
  //需要注意的是不要将响应式数据的修改发生在不同的分支下，否则会导致逻辑分支进而导致执行onUpdated钩子的时候另外的数据可能还没有加载会好
  a_length.value = date_Array.value.length;//需要注意的是a_length赋值的内容是总设备的数量(故需要的是date_Array的总数)
  b_length.value = date_Array1.value.length;
  console.log("a_length:" + a_length.value);
  console.log("b_length:" + b_length.value);
  //设备维度
  if (a_length.value > 0 && Pinia.Device_sign) {//当且仅当date_Array中存在值且Device_sign为true时才进行处理
    //在监视阶段进行currentPage的赋值用于进行初次切割的验证
    currentPage.value = 1;
    const result2 = await axios.get(`/api/test_history?start=${start}&end=${end}&d_no=${signzhi.value}&times=${Pinia.times}`);//此处同理将指定d_No的起始位置以及最终位置进行定位
    //故不需要再使用filter函数进行d_no的筛选
    now_databasesArray.value = result2.data;
    device_array.value = now_databasesArray.value;
    const result11 = await axios.get(`/api/History_count?start=${start}&end=${end}&d_no=${signzhi.value}&times=${Pinia.times}`);
    total1.value = result11.data;//某设备总量的获取
    //设备数据
    // 定义图表配置--折线图
    chartOption = ref({
      title: {
        text: "",
        left: 'center',//标题居中
      },
      tooltip: {
        trigger: 'axis'
      },
      legend: {
        top: "25px",
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
        //   smooth: true,
        //   data: []
        // },
        // {
        //   name: yingshe_array.value[1].field2,
        //   type: 'line',
        //   smooth: true,

        //   data: []
        // },
        // {
        //   name: yingshe_array.value[2].field3,
        //   type: 'line',
        //   smooth: true,

        //   data: []
        // }
      ]
    });
    // 定义图表配置--柱状图
    chartOption1 = ref({
      // 标题.value
      title: {
        text: '柱形图示例',
        left: 'center' // 标题居中
      },
      // 提示框
      tooltip: {
        trigger: 'axis', // 触发方式：坐标轴触发
        axisPointer: {
          type: 'shadow' // 阴影指示器
        }
      },
      // X 轴
      xAxis: {
        type: 'category', // 类目轴
        data: [] // X 轴数据
        // yingshe_array.value[0].field1, yingshe_array.value[1].field2, yingshe_array.value[2].field3
      },
      // Y 轴
      yAxis: {
        type: 'value' // 数值轴
      },
      // 数据系列
      series: [
        {
          name: '实时量', // 系列名称
          type: 'bar', // 柱形图
          data: [], // 数据
          itemStyle: {
            color: '#5470C6' // 柱形图颜色
          }
        }
      ]
    });
    // 设备架构
    // chartOption(1)内容仅存放is_show为1的字段
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
      //柱状赋值
      chartOption1.value.xAxis.data.push(item[`field${index + 1}`]);
    })
    //需要注意的是初始化体表进行渲染的时候的赋值应该发生在异步处理中，否则报错且不生效
  }
  //行为维度
  if (b_length.value > 0 && Pinia.Action_sign) {
    console.log("此处完成行为架构hhhhhhhhhhhhhhhhhhhhhhhhhhh");
    //在监视阶段进行currentPage的赋值用于进行初次切割的验证
    currentPage1.value = 1;
    const result2 = await axios.get(`/api/data/action?start=${start1}&end=${end1}&d_no=${signzhi1.value}`);//此处同理将指定d_No的起始位置以及最终位置进行定位
    //故不需要再使用filter函数进行d_no的筛选
    now_databasesArray1.value = result2.data;
    device_array.value = now_databasesArray.value;
    const result11 = await axios.get(`/api/action_count?start=${start1}&end=${end1}&d_no=${signzhi1.value}`);
    total2.value = result11.data;//某设备总量的获取
    //行为数据
    // 定义图表配置--折线图
    chartOption0 = ref({
      title: {
        text: "",
        left: 'center',//标题居中
      },
      tooltip: {
        trigger: 'axis'
      },
      legend: {
        top: "25px",
        data: []
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

      ]
    });
    // 定义图表配置--柱状图
    chartOption11 = ref({
      // 标题.value
      title: {
        text: '柱形图示例',
        left: 'center' // 标题居中
      },
      // 提示框
      tooltip: {
        trigger: 'axis', // 触发方式：坐标轴触发
        axisPointer: {
          type: 'shadow' // 阴影指示器
        }
      },
      // X 轴
      xAxis: {
        type: 'category', // 类目轴
        data: [] // X 轴数据
      },
      // Y 轴
      yAxis: {
        type: 'value' // 数值轴
      },
      // 数据系列
      series: [
        {
          name: '实时量', // 系列名称
          type: 'bar', // 柱形图
          data: [], // 数据
          itemStyle: {
            color: '#5470C6' // 柱形图颜色
          }
        }
      ]
    });
    //行为架构
    yingshe_action.value.forEach((item, index) => {
      // 折线赋值
      console.log("检查当前实际插入的字段值:" + item[`field${index + 1}`]);
      chartOption0.value.legend.data.push(item[`field${index + 1}`]);
      chartOption0.value.series.push({
        name: item[`field${index + 1}`],
        type: 'line',
        smooth: true,
        data: []
      })
      //柱状赋值
      chartOption11.value.xAxis.data.push(item[`field${index + 1}`]);
    })
  }

  // 根据当前的Pinia状态决定是否调用enough函数
  // if ((a_length.value > 0 && Pinia.Device_sign) || (Pinia.Action_sign)) {
  //   // 确保需要的图表对象都已初始化
  //   try {
  //     if (Pinia.Device_sign && (!chartOption || !chartOption.value)) {
  //       console.warn("设备图表未初始化，跳过enough函数");
  //       return;
  //     }
  //     // if (Pinia.Action_sign && (!chartOption0 || !chartOption0.value)) {
  //     //   console.warn("行为图表未初始化，跳过enough函数");
  //     //   return;
  //     // }
  //     console.log("成功调用渲染函数");
  //     enough();
  //   } catch (error) {
  //     console.error("调用enough函数时出错:", error);
  //   }
  // }
  if (Pinia.Action_sign) {//替换上方注释了Device之后的enough的执行条件内容
    enough();
  }


  //启用渲染递归---注意这个DOM加载后的回调函数的任务队列的产生的时机为实际代码运行的位置
  // nextTick(() => {
  //   const text_array: any = document.querySelectorAll(".el-button.el-button--primary.el-tooltip__trigger>span");
  //   if (text_array) { }
  //   else {
  //     text_array[0].innerText = `设备编号为${signzhi.value}的信息`;//需要注意的是当标签中的Content中包含文本加上标签时，DOM操作获取到后的innerHTML以及innerText分别对应全部内容、文本内容
  //   }
  // })

  console.log("gui");
  //设备绑定
  if (a_length.value !== 0) {
    let btn;
    let ok;
    // 判断有几个x按钮之后再进行x按钮对象的获取
    if (a_length.value > 0) {
      //为x按钮绑定上清空事件
      const btn_array = document.querySelectorAll(".el-icon.el-input__icon.el-range__close-icon.el-range__close-icon--hidden");
      btn = btn_array[0];
      //在当前组件进行呈现的时候立即进行映射数组的发送的请求
      const ok_array = document.querySelectorAll(".el-button.el-button--small.is-disabled.is-plain.el-picker-panel__link-btn");
      ok = ok_array[0];
    }
    //设备信息
    btn.addEventListener("click", async (event) => {
      //将start、end清空并且完成内容重置的效果
      start = 1;
      end = 1;
      //对signzhi进行重新赋值
      const result111 = await axios.get("/api/data?start=1&end=1");
      type_array.value = qu_repeate(result111.data);//去重数组的获取
      currentPage.value = 0;
      currentPage.value = 1;
      console.log("朱国锋" + device_array.value);
      //清空其余的选中的样式
      const option_array: any = document.querySelectorAll(".device_list");
      option_array.forEach((item, index) => {
        item.children[0].style.color = "black";
        item.children[0].style.backgroundColor = "white";
        if (index === 1) {
          item.children[0].style.color = "#409eff";
          item.children[0].style.backgroundColor = "rgb(235.9, 245.3, 255)";
        }
      })
      const jiezhi = await axios.get(`/api/data?start=1&end=1`);//data路由在有start\end参与的情况下同样进行查询
      a_length.value = jiezhi.data.length;//进行总设备数量的赋值
      console.log("a_length:" + a_length.value);
      //对文本进行修改
      const text_array: any = document.querySelectorAll(".el-button.el-button--primary.el-tooltip__trigger>span");
      text_array[0].innerText = `设备编号为${signzhi.value}的信息`;
    })
    ok.addEventListener("click", async () => {
      start = value1.value[0];
      end = value1.value[1];
      let jiezhi;
      let boolean_x = start !== 1 && end !== 1 && start.getTime() === end.getTime();
      jiezhi = await axios.get(`/api/data?start=${boolean_x ? "end" : start}&end=${end}`);//data路由在有start\end参与的情况下同样进行查询
      a_length.value = jiezhi.data.length;//进行总设备数量的赋值
      currentPage.value = 1;
      //当点击ok的时候则对date_array进行获取
      const resultk = await axios.get(`/api/test_history?start=${boolean_x ? "end" : start}&end=${end}&times=${Pinia.times}`);
      date_Array.value = resultk.data;//分页内容的呈现数组赋值
      type_array.value = qu_repeate(date_Array.value);//去重数组的获取
      const resultx = await axios.get(`/api/test_history?start=${boolean_x ? "end" : start}&end=${end}&d_no=${Pinia.signzhi}&times=${Pinia.times}&currentPage=${currentPage.value}&pageSize=${pageSize}`);//将数组指定分页的内容进行指定内容的获取用于device_array_page数组的赋值
      now_databasesArray.value = resultx.data;//进行总ok内容的赋值
      device_page_array.value = resultx.data;
      const resultxx = await axios.get(`/api/test_history?start=${boolean_x ? "end" : start}&end=${end}&d_no=${Pinia.signzhi}&times=${Pinia.times}`);//将数组总内容进行获取，并且指明id,用于device_array数组的赋值
      device_array.value = resultxx.data;//赋值完毕
      const resultxxx = await axios.get(`/api/History_count?start=${boolean_x ? "end" : start}&end=${end}&d_no=${Pinia.signzhi}&times=${Pinia.times}`);//将数组的总内容数进行获取用于total1的赋值
      total1.value = resultxxx.data;//进行某设备总值的赋值

      console.log("点击了Ok但是还没有进入到enough中的device_array:" + device_array.value);
      //进行时间段总数据的d_no不重复筛选
      enough();
    });
    //定义切换图像事件--设备信息上的change事件
    change = (value) => {//需要注意的是点击了按钮之后需要对整个表格的内容进行填充
      const zhexian_btn = document.querySelector("#zhexian") as HTMLElement;
      const zhuzhuang_btn = document.querySelector("#zhuzhuang") as HTMLElement;
      const zhexian = document.querySelector(".zhexian") as HTMLElement;
      const zhuzhuang = document.querySelector(".zhuzhuang") as HTMLElement;
      if (value.target === zhexian_btn) {
        //为选中元素进行样式修改
        zhexian_btn.classList.add("active");
        zhuzhuang_btn.classList.remove("active");

        // 对剩余对象进行隐藏
        zhexian.style.display = "block";
        zhuzhuang.style.display = "none";

      }
      else if (value.target === zhuzhuang_btn) {
        //为选中元素进行样式修改
        zhuzhuang_btn.classList.add("active");
        zhexian_btn.classList.remove("active");

        // 对剩余对象进行隐藏
        zhexian.style.display = "none";
        zhuzhuang.style.display = "block";

      }
      enough();
    }

    change0 = async (value, value1) => {//点击了这个按钮就说明本身其实是存在着这个数组的
      //点击了设备按钮之后对样式进行修改
      //对所有内容进行统一的设计
      if (a1_length.value > 1) {
        const option_array: any = document.querySelectorAll(".device_list");
        option_array.forEach(item => {
          item.children[0].style.color = "black";
          item.children[0].style.backgroundColor = "white";
        })
        value1.target.parentNode.style.color = "#409eff";
        value1.target.parentNode.style.backgroundColor = "rgb(235.9, 245.3, 255)";
      }
      else { }

      //首先判断signzhi是否发生改变
      if (signzhi.value !== value[0]) {//改变则进行device_array的从新请求赋值
        if (start !== 1 && end !== 1 && start.getTime() === end.getTime()) {
          const result = await axios.get(`/api/test_history?&start=end&end=${end}&d_no=${signzhi.value}&times=${Pinia.times}`);
          device_array.value = result.data;
          const result11 = await axios.get(`/api/History_count?start=end&end=${end}&d_no=${signzhi.value}&times=${Pinia.times}`);
          total1.value = result11.data;//进行某设备总数的获取
          const result2 = await axios.get(`/api/data?start=end&end=${end}`);
          a_length.value = result2.data.length;//进行设备总数的获取
        }
        else {
          const result = await axios.get(`/api/test_history?&start=${start}&end=${end}&d_no=${signzhi.value}&times=${Pinia.times}`);
          device_array.value = result.data;
          const result11 = await axios.get(`/api/History_count?start=${start}&end=${end}&d_no=${signzhi.value}&times=${Pinia.times}`);
          total1.value = result11.data;//进行某设备总数的获取
          const result2 = await axios.get(`/api/data?start=${start}&end=${end}`);
          a_length.value = result2.data.length;//进行设备总数的获取
        }

        //进行watch事件的动态执行
        currentPage.value = 0;
        currentPage.value = 1;
        //设备信息填充
        if (start === 1 || end === 1) {
          // chartOption.value.title.text = `传感器设备${device_array.value[0][0]}的变化情况`;
          chartOption.value.title.text = `传感器设备的变化情况`;
        }
        else {
          // chartOption.value.title.text = `从${moment(start).format('YYYY-MM-DD HH:mm')}到${moment(end).format('YYYY-MM-DD HH:mm')}传感器设备${device_array.value[0][0]}的变化情况`;
          chartOption.value.title.text = `从${moment(start).format('YYYY-MM-DD HH:mm')}到${moment(end).format('YYYY-MM-DD HH:mm')}传感器设备的变化情况`;
        }
      }
      //调用填充函数
      enough();

      //对初始文本进行编辑
      const text_array: any = document.querySelectorAll(".el-button.el-button--primary.el-tooltip__trigger>span");
      text_array[0].innerText = `设备编号为${value[0]}的信息`;//需要注意的是当标签中的Content中包含文本加上标签时，DOM操作获取到后的innerHTML以及innerText分别对应全部内容、文本内容
    };

  }
  enough();

  //行为绑定
  if (b_length.value !== 0) {
    let btn;
    let ok;
    // 判断有几个x按钮之后再进行x按钮对象的获取
    //为x按钮绑定上清空事件
    const btn_array = document.querySelectorAll(".el-icon.el-input__icon.el-range__close-icon.el-range__close-icon--hidden");
    btn = btn_array[1];
    //在当前组件进行呈现的时候立即进行映射数组的发送的请求
    const ok_array = document.querySelectorAll(".el-button.el-button--small.is-disabled.is-plain.el-picker-panel__link-btn");
    ok = ok_array[1];
    //设备信息
    btn.addEventListener("click", async (event) => {
      //将start、end清空并且完成内容重置的效果
      start1 = 1;
      end1 = 1;
      //对signzhi进行重新赋值
      const result111 = await axios.get(`/api/data/action?start=1&end=1&d_no=${signzhi1.value}`);
      type_array1.value = qu_repeate(result111.data);//去重数组的获取

      currentPage1.value = 0;
      currentPage1.value = 1;
      console.log("朱国锋" + device_array1.value);

      //清空其余的选中的样式
      // const option_array: any = document.querySelectorAll(".device_list");
      // option_array.forEach((item, index) => {
      //   item.children[0].style.color = "black";
      //   item.children[0].style.backgroundColor = "white";
      //   if (index === 1) {
      //     item.children[0].style.color = "#409eff";
      //     item.children[0].style.backgroundColor = "rgb(235.9, 245.3, 255)";
      //   }
      // })

      const jiezhi = await axios.get(`/api/data/action?start=1&end=1`);//data路由在有start\end参与的情况下同样进行查询
      b_length.value = jiezhi.data.length;//进行总设备数量的赋值
      console.log("b_length:" + b_length.value);
      //对文本进行修改
      // const text_array: any = document.querySelectorAll(".el-button.el-button--primary.el-tooltip__trigger>span");
      // text_array[0].innerText = `设备编号为${signzhi.value}的信息`;
    })
    ok.addEventListener("click", async () => {
      start1 = value2.value[0];
      end1 = value2.value[1];
      let jiezhi;
      let boolean_x = start1 !== 1 && end1 !== 1 && start1.getTime() === end1.getTime();
      jiezhi = await axios.get(`/api/data/action?start=${boolean_x ? "end" : start1}&end=${end1}&d_no=${signzhi1.value}`);//data路由在有start\end参与的情况下同样进行查询
      b_length.value = jiezhi.data.length;//进行总设备数量的赋值
      console.log("b_length:"+b_length.value);
      currentPage1.value = 1;
      //当点击ok的时候则对date_array进行获取
      const resultk = await axios.get(`/api/data/action?start=${boolean_x ? "end" : start1}&end=${end1}&d_no=${signzhi1.value}`);
      date_Array1.value = resultk.data;//分页内容的呈现数组赋值
      type_array1.value = qu_repeate(date_Array1.value);//去重数组的获取
      const resultx = await axios.get(`/api/data/action?start=${boolean_x ? "end" : start1}&end=${end1}&d_no=${signzhi1.value}&currentPage=${currentPage1.value}&pageSize=${pageSize}`);//将数组指定分页的内容进行指定内容的获取用于device_array_page数组的赋值
      now_databasesArray1.value = resultx.data;//进行总ok内容的赋值
      device_array_action_page_array.value = resultx.data;
      const resultxx = await axios.get(`/api/data/action?start=${boolean_x ? "end" : start1}&end=${end1}&d_no=${signzhi1.value}`);//将数组总内容进行获取，并且指明id,用于device_array数组的赋值
      device_array1.value = resultxx.data;//赋值完毕
      const resultxxx = await axios.get(`/api/action_count?start=${boolean_x ? "end" : start1}&end=${end1}&d_no=${signzhi1.value}`);//将数组的总内容数进行获取用于total1的赋值
      total2.value = resultxxx.data;//进行某设备总值的赋值
      console.log("点击了Ok但是还没有进入到enough中的device_array:" + device_array1.value);
      //进行时间段总数据的d_no不重复筛选
      enough();
    });
    //定义切换图像事件
    change1 = (value) => {//需要注意的是点击了按钮之后需要对整个表格的内容进行填充
      console.log("成功触发");
      const zhexian_btn = document.querySelector("#zhexian1") as HTMLElement;
      const zhuzhuang_btn = document.querySelector("#zhuzhuang1") as HTMLElement;
      const zhexian = document.querySelector(".zhexian1") as HTMLElement;
      const zhuzhuang = document.querySelector(".zhuzhuang1") as HTMLElement;
      if (value.target === zhexian_btn) {
        //为选中元素进行样式修改
        zhexian_btn.classList.add("active");
        zhuzhuang_btn.classList.remove("active");
        // 对剩余对象进行隐藏
        zhexian.style.display = "block";
        zhuzhuang.style.display = "none";
      }
      else if (value.target === zhuzhuang_btn) {
        //为选中元素进行样式修改
        zhuzhuang_btn.classList.add("active");
        zhexian_btn.classList.remove("active");

        // 对剩余对象进行隐藏
        zhexian.style.display = "none";
        zhuzhuang.style.display = "block";

      }
      enough();
    }

    //定义change事件
    change2 = async (value, value1) => {//点击了这个按钮就说明本身其实是存在着这个数组的
      //点击了设备按钮之后对样式进行修改
      //对所有内容进行统一的设计
      if (b1_length.value > 1) {
        const option_array: any = document.querySelectorAll(".device_list1");
        option_array.forEach(item => {
          item.children[0].style.backgroundColor = "white";
          item.children[0].style.color = "black";
        })
        value1.target.parentNode.style.color = "#409eff";
        value1.target.parentNode.style.backgroundColor = "rgb(235.9, 245.3, 255)";
      }

      //首先判断signzhi是否发生改变
      if (signzhi1.value !== value[0]) {//改变则进行device_array的从新请求赋值
        if (start1 !== 1 && end1 !== 1 && start1.getTime() === end1.getTime()) {
          const result = await axios.get(`/api/action?&start=end&end=${end1}&d_no=${signzhi1.value}`);
          device_array1.value = result.data;
          const result11 = await axios.get(`/api/action_count?start=end&end=${end1}&d_no=${signzhi1.value}`);
          total2.value = result11.data;//进行某设备总数的获取
          const result2 = await axios.get(`/api/action?start=end&end=${end1}&d_no=${signzhi1.value}`);
          b_length.value = result2.data.length;//进行设备总数的获取
          console.log("b_length:"+b_length.value);

          device_array_action_page_array.value = result.data;
        }
        else {
          const result = await axios.get(`/api/action?&start=${start1}&end=${end1}&d_no=${signzhi1.value}`);
          device_array1.value = result.data;
          device_array_action_page_array.value = result.data;
          const result11 = await axios.get(`/api/action_count?start=${start1}&end=${end1}&d_no=${signzhi1.value}`);
          total2.value = result11.data;//进行某设备总数的获取
        }
        //修改折线图标题,柱状图不需要进行修改，标题内容只随着时间发生改变
        //设备信息填充
        if (start === 1 || end === 1) {
          chartOption0.value.title.text = `传感器设备的变化情况`;
        }
        else {
          chartOption0.value.title.text = `从${moment(start1).format('YYYY-MM-DD HH:mm')}到${moment(end1).format('YYYY-MM-DD HH:mm')}传感器设备的变化情况`;
        }
      }
      //调用填充函数
      enough();
      //对初始文本进行编辑
      const text_array: any = document.querySelectorAll(".el-button.el-button--primary.el-tooltip__trigger>span");
      text_array[0].innerText = `${value[0]}`;//需要注意的是当标签中的Content中包含文本加上标签时，DOM操作获取到后的innerHTML以及innerText分别对应全部内容、文本内容
    }
  };

  currentPage.value =0;
  currentPage.value =1;


  //绑定上删除方法(将当前行中的新旧图片记录库内容删除以及前端更新(即重新请求))
  delete1 = async(value)=>{
    console.log("选中对象内容：");
    console.dir(value);
    await axios.get(`/api/delete?sign=${value[3]}`);
    update1();
  }

});

</script>

<style scoped>
.container {
  width: 100%;
  min-height: 100vh;
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  padding: 20px;
  box-sizing: border-box;
  font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
}

.page-title {
  text-align: center;
  color: white;
  font-size: 2.5em;
  margin-bottom: 30px;
  text-shadow: 2px 2px 4px rgba(0,0,0,0.3);
  font-weight: 300;
}

.control-section {
  display: flex;
  flex-wrap: wrap;
  gap: 20px;
  justify-content: center;
  margin-bottom: 30px;
  padding: 20px;
  background: rgba(255, 255, 255, 0.1);
  border-radius: 15px;
  backdrop-filter: blur(10px);
  border: 1px solid rgba(255, 255, 255, 0.2);
}

.control-dropdown {
  margin: 0;
}

.control-btn {
  background: linear-gradient(45deg, #409eff, #67c23a);
  border: none;
  border-radius: 25px;
  padding: 12px 24px;
  font-weight: 500;
  box-shadow: 0 4px 15px rgba(64, 158, 255, 0.3);
  transition: all 0.3s ease;
}

.control-btn:hover {
  transform: translateY(-2px);
  box-shadow: 0 6px 20px rgba(64, 158, 255, 0.4);
}

.only, .only1 {
  background: linear-gradient(45deg, #409eff, #67c23a);
  color: white;
  padding: 12px 24px;
  border-radius: 25px;
  text-align: center;
  font-weight: 500;
  box-shadow: 0 4px 15px rgba(64, 158, 255, 0.3);
  transition: all 0.3s ease;
  cursor: pointer;
}

.only:hover, .only1:hover {
  transform: translateY(-2px);
  box-shadow: 0 6px 20px rgba(64, 158, 255, 0.4);
}

.block {
  display: flex;
  justify-content: center;
  padding: 20px;
  margin: 20px 0;
}

.date-picker {
  background: rgba(255, 255, 255, 0.9);
  border-radius: 10px;
  box-shadow: 0 4px 15px rgba(0,0,0,0.1);
}

.h1, .h2_action {
  background: linear-gradient(45deg, #9da79f, #7a8c7a);
  color: white;
  padding: 15px;
  border-radius: 10px;
  text-align: center;
  margin: 30px 0 20px 0;
  font-size: 1.8em;
  font-weight: 500;
  box-shadow: 0 4px 15px rgba(0,0,0,0.2);
}

.table-container {
  overflow-x: auto;
  margin: 20px 0;
  background: rgba(255, 255, 255, 0.95);
  border-radius: 15px;
  box-shadow: 0 8px 25px rgba(0,0,0,0.1);
  padding: 20px;
}

table {
  width: 100%;
  border-collapse: collapse;
  border-radius: 10px;
  overflow: hidden;
  box-shadow: 0 4px 15px rgba(0,0,0,0.1);
}

table thead {
  background: linear-gradient(45deg, #667eea, #764ba2);
}

table thead th {
  color: white;
  padding: 15px 10px;
  font-weight: 600;
  text-align: center;
  border: none;
  font-size: 14px;
}

table tbody tr {
  transition: all 0.3s ease;
}

table tbody tr:nth-child(even) {
  background: rgba(102, 126, 234, 0.05);
}

table tbody tr:hover {
  background: rgba(102, 126, 234, 0.1);
  transform: scale(1.01);
}

table tbody td {
  padding: 12px 10px;
  text-align: center;
  border: 1px solid rgba(102, 126, 234, 0.1);
  font-size: 14px;
  color: #333;
}

.pagination-container, .pagination-container1 {
  display: flex;
  justify-content: center;
  margin: 30px 0;
  padding: 20px;
}

.pagination-container .el-pagination, .pagination-container1 .el-pagination {
  background: rgba(255, 255, 255, 0.9);
  padding: 15px;
  border-radius: 10px;
  box-shadow: 0 4px 15px rgba(0,0,0,0.1);
}

.chart-controls {
  display: flex;
  justify-content: center;
  gap: 15px;
  margin: 30px 0;
}

.chart-btn {
  background: linear-gradient(45deg, #61aab8, #4a8a9a);
  color: white;
  border: none;
  padding: 12px 24px;
  border-radius: 25px;
  font-size: 14px;
  font-weight: 500;
  cursor: pointer;
  transition: all 0.3s ease;
  box-shadow: 0 4px 15px rgba(97, 170, 184, 0.3);
}

.chart-btn:hover {
  transform: translateY(-2px);
  box-shadow: 0 6px 20px rgba(97, 170, 184, 0.4);
}

.chart-btn.active {
  background: linear-gradient(45deg, #00d4ff, #0099cc);
  box-shadow: 0 4px 15px rgba(0, 212, 255, 0.4);
}

.chart-container {
  display: flex;
  justify-content: center;
  margin: 30px 0;
  padding: 20px;
  background: rgba(255, 255, 255, 0.95);
  border-radius: 15px;
  box-shadow: 0 8px 25px rgba(0,0,0,0.1);
}

.chart {
  width: 600px !important;
  height: 400px !important;
  display: block;
}

.zhexian1, .zhuzhuang1 {
  display: none;
}

.device_list > div {
  border: none;
  width: 200px;
  height: 35px;
  text-align: center;
  line-height: 35px;
  background: linear-gradient(45deg, #23d588, #1db954);
  color: white;
  cursor: pointer;
  border-radius: 8px;
  transition: all 0.3s ease;
  font-weight: 500;
}

.device_list > div:hover {
  transform: translateY(-2px);
  box-shadow: 0 4px 15px rgba(35, 213, 136, 0.4);
}

.device-item {
  border-radius: 8px;
  padding: 8px 16px;
  transition: all 0.3s ease;
}

.device-item:hover {
  background: rgba(102, 126, 234, 0.1);
}

.modal-overlay {
  position: fixed;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  background: rgba(0, 0, 0, 0.7);
  z-index: 1000;
  display: none;
  backdrop-filter: blur(5px);
}

.modal_child {
  position: absolute;
  top: 50%;
  left: 50%;
  transform: translate(-50%, -50%);
  background: white;
  padding: 30px;
  border-radius: 15px;
  box-shadow: 0 20px 40px rgba(0,0,0,0.3);
  min-width: 400px;
  max-width: 80%;
  max-height: 80%;
  overflow: auto;
}

.X {
  position: absolute;
  top: 15px;
  right: 20px;
  color: #ff4757;
  font-size: 24px;
  cursor: pointer;
  font-weight: bold;
  transition: all 0.3s ease;
}

.X:hover {
  color: #c44569;
  transform: scale(1.1);
}

.btn_modal {
  background: linear-gradient(45deg, #ff6b6b, #ee5a24);
  color: white;
  border: none;
  padding: 6px 12px;
  border-radius: 15px;
  font-size: 12px;
  cursor: pointer;
  transition: all 0.3s ease;
  margin-left: 8px;
}

.btn_modal:hover {
  transform: translateY(-1px);
  box-shadow: 0 4px 15px rgba(255, 107, 107, 0.4);
}

.delete_button {
  background: linear-gradient(45deg, #ff4757, #c44569);
  color: white;
  border: none;
  padding: 8px 16px;
  border-radius: 20px;
  font-size: 12px;
  cursor: pointer;
  transition: all 0.3s ease;
  font-weight: 500;
}

.delete_button:hover {
  transform: translateY(-1px);
  box-shadow: 0 4px 15px rgba(255, 71, 87, 0.4);
}

/* 响应式设计 */
@media (max-width: 1200px) {
  .container {
    padding: 15px;
  }
  
  .control-section {
    flex-direction: column;
    align-items: center;
  }
  
  .chart {
    width: 100% !important;
    max-width: 500px !important;
  }
  
  .table-container {
    padding: 15px;
  }
  
  table {
    font-size: 12px;
  }
  
  table thead th, table tbody td {
    padding: 8px 6px;
  }
}

@media (max-width: 768px) {
  .page-title {
    font-size: 2em;
  }
  
  .h1, .h2_action {
    font-size: 1.5em;
    padding: 12px;
  }
  
  .control-btn, .only, .only1 {
    padding: 10px 20px;
    font-size: 14px;
  }
  
  .chart-controls {
    flex-direction: column;
    align-items: center;
  }
  
  .chart-btn {
    width: 200px;
  }
  
  .modal_child {
    min-width: 300px;
    padding: 20px;
  }
  
  .pagination-container .el-pagination, .pagination-container1 .el-pagination {
    padding: 10px;
  }
}

@media (max-width: 480px) {
  .container {
    padding: 10px;
  }
  
  .page-title {
    font-size: 1.8em;
  }
  
  .control-section {
    padding: 15px;
  }
  
  .table-container {
    padding: 10px;
  }
  
  .chart {
    height: 300px !important;
  }
  
  .modal_child {
    min-width: 280px;
    padding: 15px;
  }
}

/* 保持原有的特定样式 */
.device_list {
  height: 35px;
}

.container.fit-view {
  position: absolute;
  top: 0;
}

.echarts {
  margin-top: 80px;
  width: 900px !important;
  justify-self: center;
}

.echarts > div {
  transform: scale(1.5);
}

.one {
  display: none;
}

#timeTotime1, #timeTotime2 {
  display: inline-block;
  position: relative;
  left: 380px;
  bottom: 0px;
  margin-top: 10px;
}

#timeTotime1 {
  left: 850px;
}

.el-dropdown > button {
  width: 176.33px;
}

.el-dropdown > button > span > i > svg {
  position: absolute;
  left: 10px;
}

#timeTotime {
  width: 1200px;
  height: 100px;
  display: flex;
  flex-wrap: wrap;
  position: static;
  left: 10px;
}

.pagination-container1 > .el-pagination {
  margin-left: 800px;
  margin-top: 30px;
}

.pagination-container > .el-pagination {
  margin-left: 800px;
  margin-top: 30px;
}

.search {
  height: 32px;
  margin-left: 0;
  position: absolute;
  left: 0;
  top: 60px;
  display: flex;
  align-items: center;
  justify-content: center;
}

.search input {
  font-size: 10px;
}

.search label {
  width: 55px !important;
  font-size: 12px;
  text-align: center;
  height: 20px;
  line-height: 20px;
  margin-left: 2px;
}

.search label:hover {
  cursor: pointer;
}

.submit {
  margin-left: 2px;
  font-size: 10px;
  border-radius: 1px;
  width: 35px;
  height: 20px;
  background-color: wheat;
  border: 1px solid black;
}

.submit:hover {
  cursor: pointer;
}

.select_checkbox, .time_checkbox, .table_checkbox, .change_checkbox, .h2_checkbox, .image_checkbox {
  width: 100%;
  height: 19px !important;
  background-color: gray;
  display: flex;
  justify-content: center;
}

input[type="checkbox"]:hover {
  cursor: pointer;
}

.action_table {
  width: 100%;
}

.container.fit-view .only1 {
  position: relative;
  left: 700px;
}

/* 动画效果 */
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

.container > * {
  animation: fadeInUp 0.6s ease-out;
}

.container > *:nth-child(2) { animation-delay: 0.1s; }
.container > *:nth-child(3) { animation-delay: 0.2s; }
.container > *:nth-child(4) { animation-delay: 0.3s; }
.container > *:nth-child(5) { animation-delay: 0.4s; }
.container > *:nth-child(6) { animation-delay: 0.5s; }

/* 滚动条美化 */
::-webkit-scrollbar {
  width: 8px;
  height: 8px;
}

::-webkit-scrollbar-track {
  background: rgba(255, 255, 255, 0.1);
  border-radius: 4px;
}

::-webkit-scrollbar-thumb {
  background: linear-gradient(45deg, #667eea, #764ba2);
  border-radius: 4px;
}

::-webkit-scrollbar-thumb:hover {
  background: linear-gradient(45deg, #5a6fd8, #6a4190);
}
</style>