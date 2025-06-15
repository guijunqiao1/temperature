<template>
  <div class="container">
    <!-- 设备相关内容 -->

    <div class="block1 block" v-show="Pinia.Device_sign">
      <el-date-picker v-model="value1" type="datetimerange" start-placeholder="Start Date" end-placeholder="End Date"
        :default-time="defaultTime1" />
    </div>



    <!-- 用于表格信息提示的标签 -->
    <h2 class="h1" v-show="Pinia.Device_sign">设备表格内容</h2>

    <!-- 当激活了设备列表的时候 -->
    <table class="device_table" v-show="Pinia.Device_sign">
      <thead v-if="yingshe_array && unit_array">
        <tr>
          <!-- 直接考虑是否为多设备的情况 -->
          <!-- <th>设备编号</th> -->
          <th>{{ yingshe_array[0].field1 }} {{ unit_array[0] !== "null" ? `(${unit_array[0]})` : "" }}</th>
          <th>{{ yingshe_array[1].field2 }} {{ unit_array[1] !== "null" ? `(${unit_array[1]})` : "" }}</th>
          <th>{{ yingshe_array[2].field3 }} {{ unit_array[2] !== "null" ? `(${unit_array[2]})` : "" }}</th>
          <th>{{ yingshe_array[3].field4 }} {{ unit_array[3] !== "null" ? `(${unit_array[3]})` : "" }}</th>
          <th>{{ yingshe_array[4].field5 }} {{ unit_array[4] !== "null" ? `(${unit_array[4]})` : "" }}</th>
          <th>{{ yingshe_array[5].field6 }} {{ unit_array[5] !== "null" ? `(${unit_array[5]})` : "" }}</th>
          <th>{{ yingshe_array[6].field7 }} {{ unit_array[6] !== "null" ? `(${unit_array[6]})` : "" }}</th>
          <th>{{ yingshe_array[7].field8 }} {{ unit_array[7] !== "null" ? `(${unit_array[7]})` : "" }}</th>
          <th>收集时间</th>
          <!-- <th>数据类型</th> -->
        </tr>
      </thead>
      <tbody>
        <tr v-for="(item, index) in device_page_array">
          <!-- <td>{{ item[0] }}</td> -->
          <td>{{ item[1] }} <button v-show="yingshe_array[0].type !== '1'" class="btn_modal"
              @click="start_block(item[1])">查看</button> </td>
          <td>{{ item[2] }} <button v-show="yingshe_array[1].type !== '1'" class="btn_modal"
              @click="start_block(item[2])">查看</button></td>
          <td>{{ item[3] }} <button v-show="yingshe_array[2].type !== '1'" class="btn_modal"
              @click="start_block(item[3])">查看</button></td>
          <td>{{ item[4] }} <button v-show="yingshe_array[3].type !== '1'" class="btn_modal"
              @click="start_block(item[4])">查看</button></td>
          <td>{{ item[5] }} <button v-show="yingshe_array[4].type !== '1'" class="btn_modal"
              @click="start_block(item[5])">查看</button></td>
          <td>{{ item[6] }} <button v-show="yingshe_array[5].type !== '1'" class="btn_modal"
              @click="start_block(item[6])">查看</button></td>
          <td>{{ item[7] }} <button v-show="yingshe_array[6].type !== '1'" class="btn_modal"
              @click="start_block(item[7])">查看</button></td>
          <td>{{ item[8] }} <button v-show="yingshe_array[7].type !== '1'" class="btn_modal"
              @click="start_block(item[8])">查看</button></td>
          <td>{{ moment(item[9]).format('YYYY-MM-DD HH:mm:ss') }}</td>
          <!-- <td>{{ item[10] }}</td> -->
        </tr>
      </tbody>
    </table>

    <!-- 弹出框设计 -->
    <div id="modal">
      <span class="X" @click="XXX">X</span>
      <div class="modal_child">
      </div>
    </div>

    <!-- 分页栏部分 -->
    <div class="pagination-container" v-show="Pinia.Device_sign">
      <el-pagination v-model:current-page="currentPage" v-model:page-size="pageSize" :total="Number(total1)"
        layout=" prev ,pager, next" />
      <!-- 上述前者用于响应式提供当前选中的页数；第二者用于设置固定的每页中应当呈现的数据；第三者用于获取到总数，则element标签会自动进行计算用于将当前应当呈现的页数；第四者为分页标签的顺序设置；最后者表示设置当前的分页的标签的整体的大小为默认大小 -->
    </div>


    <!-- 设备图像 -->
    <div class="change1" @click="change($event)" v-show="Pinia.Device_sign">
      <button id="zhexian" class="active">折线图(默认)</button>
      <button id="zhuzhuang">柱状图</button>
    </div>


    <ECharts :option="chartOption" style="width: 600px; height: 400px; display:block;" class="zhexian"
      v-show="Pinia.Device_sign" />
    <ECharts :option="chartOption1" style="width:600px; height:400px;display:none;" class="zhuzhuang"
      v-show="Pinia.Device_sign" />



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
// 设备数据图像配置变量
let chartOption = ref<any>({});//折线图配置变量
let chartOption1 = ref<any>({});//柱状图配置变量
let change = (value: any) => { };//用于控制切换图像的事件的定义
// 行为数据切换、行为数据图像切换事件变量
// let change0 = (value: any) => { };//用于控制切换行为图像的事件的定义

//设备数据介质数组
let date_Array = ref([]);//用于归还将所有内容获取到的数组
let time_array: any = [];//用于将折线图数据填充格式化的数组
//行为数据介质数组
// let time_array1: any = [];
//定义记录设备列表长度的变量用于控制前端的组件的呈现
const a_length = ref();
//定义记录设备(设备行为)种类数量的变量
// const a1_length = ref();

// 设备数组的变量信息
let now_databasesArray = ref();//该数组用于将dataArray中确定的字段进行赋值--发生在change事件中
let type_array: any = ref([]);//databases筛选了d_no不重复的结果
let device_array: any = ref(null);//进行设备数组的定义，用于将设备信息单独作为内容呈现，并且也是从now_databasesArray中进行截取到的
let device_page_array: any = ref(null);//进行设备数组的定义，用于将device_array中的信息进行分页提取--用于呈现的数组
let unit_array = ref();//设备数据单位数组
let unitlen: any = ref(0);



// 页数变量
const currentPage = ref(1);//当前页数变量,当发生自身发生改变的时候就将数据库中对应页码的数据进行单独的databases_array的赋值
// const currentPage1 = ref(1);//用于行为表格分页使用的页数变量

let pageSize = 12;
const total1 = ref(0)//总数变量,当发生增添事件、删除事件(包括单独删除以及搜索删除)之后进行总量变量的重新计算
// const total2 = ref(0);//总数变量用于计算行为表格中动态的值的总数
let signzhi: any = ref("null");//记录设备数据编号
// let signzhi1 = null;//记录书号值


//时间选择数据--设备数据
let value1 = ref([]);
let start: any = 1;
let end: any = 1;
//定义初始标记
let update = () => { };//普通数据表更新函数
// let update1 = () => { };//行为表更新函数

//定义查询方法--行为模块
// let search = (value) => { };



const defaultTime1 = [new Date(2000, 1, 1, 12, 0), new Date(2000, 1, 1, 12, 0, 0)]; // '12:00:00'

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


//专门用于更新的函数--赋值device_page_array和jiezhi_array
update = async () => {//用于自动触发分页路由
  const boolean_x = start !== 1 && end !== 1 && start.getTime() === end.getTime();
  //直接进行赋值(由于本身databases_array就随着ok的变化而变化所以不需要进行条件判断)
  const result = await axios.get(`/api/History?currentPage=${currentPage.value}&pageSize=${pageSize}&start=${boolean_x ? "end" : start}&end=${end}&d_no=${signzhi.value}`);
  device_page_array.value = result.data;//进行设备分页数组的赋值
  const result1 = await axios.get(`/api/History?start=${boolean_x ? "end" : start}&end=${end}&d_no=${signzhi.value}`);//将设备编号与指定时间内容进行获取用于device_array的赋值(该数组用于ecahrts渲染)--该路由需要设计current的判断
  device_array.value = result1.data;
  const result_count = await axios.get(`/api/History_count?start=${boolean_x ? "end" : start}&end=${end}&d_no=${signzhi.value}`);//用于获取总数
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
// update1 = async () => {//用于自动触发分页路由
//   //直接进行赋值(由于本身databases_array就随着ok的变化而变化所以不需要进行条件判断)
//   const result = await axios.get(`/api/action?currentPage=${currentPage1.value}&pageSize=${pageSize}&person=${person.value}&book_id=${book_id.value}&start_time=${start_time.value}`);
//   const result1 = await axios.get(`/api/action_count?person=${person.value}&book_id=${book_id.value}&start_time=${start_time.value}`);
//   const result2 = await axios.get(`/api/action_count?person=${person.value}&book_id=${book_id.value}&start_time=${start_time.value}&all=yes`);
//   device_array1.value = result2.data;
//   total2.value = result1.data;
//   device_array_action_page_array.value = result.data;
//   // 数据更新阶段对type_array1进行赋值
//   enough();
// };
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


  if (a_length.value >= 0 && Pinia.Device_sign) {//当对应上第一个组件正常显示的时候执行
    //折线图的横轴结构设计--柱状图不需要设计
    time_array = [];
    //设备判断
    if (Pinia.Device_sign && chartOption && chartOption.value && chartOption.value.title && chartOption1 && chartOption1.value && chartOption1.value.title) {
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
        let tem_index = 0;
        //设备赋值d
        for (let i = 0; i < device_array.value.length; i++) {
          // 和映射数组对比判断是否需要将值加入到渲染数组中
          chartOption.value.series.forEach((item, index) => {
            console.log("chart长度:" + chartOption.value.series.length);
            console.log("映射数组长度" + yingshe_array.value.length);
            console.log("当前条件nei'rong:" + yingshe_array.value[index].is_show);
            console.log("当前点击了ok之后的设备数组neirong:" + device_array.value);
            for (let k = tem_index; k < device_array.value[i].length; k++) {
              if (yingshe_array.value[k].is_show === "1") {//同步判断
                console.log("成功进入fuzhi一次");
                console.log("当前fuzhineirongwei:");
                console.dir(device_array.value[i][k + 1]);
                item.data.push(device_array.value[i][k + 1]);
                tem_index = k + 1;
                break;
              }
            }
          })
        }
        console.log("当前成功图像的：");
        console.dir(chartOption.value);
        chartOption1.value.series[0].data = [];
        //柱状图(设备生产总量,定义总和变量)
        let sum1 = 0;
        let sum2 = 0;
        let sum3 = 0;
        let sum4 = 0;
        let sum5 = 0;
        //设备信息
        for (let i = 0; i < device_array.value.length; i++) {
          console.log("当前设备为：" + device_array.value[i]);
          sum1 += Number(device_array.value[i][4]);
          sum2 += Number(device_array.value[i][5]);
          sum3 += Number(device_array.value[i][6]);
          sum4 += Number(device_array.value[i][7]);
          sum5 += Number(device_array.value[i][8]);
        }
        //设备赋值
        chartOption1.value.series[0].data.push(sum1);
        chartOption1.value.series[0].data.push(sum2);
        chartOption1.value.series[0].data.push(sum3);
        chartOption1.value.series[0].data.push(sum4);
        chartOption1.value.series[0].data.push(sum5);

        //赋值后的总数
        console.log("当前总数:");
        console.dir(chartOption1.value);
        console.log("实际总数:");
        console.log("sum1:" + sum1, "sum2:" + sum2, "su3:" + sum3, "sum4:" + sum4, "sum5:" + sum5);


        //修改柱状图标题
        //设备判断
        if (!start || !end) {//若起始
          chartOption1.value.title.text = `从起始统计到现在的数据总量`;
        }
        else {
          if (start === 1 || end === 1) {
            chartOption1.value.title.text = `传感器设备的各项数据总量`;
          }
          else {
            chartOption1.value.title.text = `从${moment(start).format('YYYY-MM-DD HH:mm')}到${moment(end).format('YYYY-MM-DD HH:mm')}传感器设备的各项数据总量`;
          }
        }
      }
      else{
        //清空
        chartOption.value.xAxis.data = [];
        chartOption.value.series.forEach((item, index) => {
          item.data = [];
        })
        chartOption1.value.series[0].data = [];
      }
    }
  }

}



//自当前组件创建阶段就对currentPage变量的值进行监视，若发生了修改，则结合上currentPage变量对databases_array赋值(模版为jiezhi_array)
watch(() => currentPage.value, (newValue, oldValue) => {
  update();
}, { deep: true, immediate: true });
//监听行为表
// watch(() => currentPage1.value, (newValue, oldValue) => {
//   update1();
// }, { deep: true, immediate: true });


onMounted(async () => {
  // 立即执行函数的位置替换后的状态
  // 对上述内容进行同意替换
  update();
  const result = await axios.get("/api/yingshe");
  yingshe_array.value = result.data;

  const result1 = await axios.get("/api/data?start=1&end=1");
  date_Array.value = result1.data;
  type_array.value = qu_repeate(date_Array.value);//去重数组的获取
  // a1_length.value = type_array.value.length;
  // console.log("length:" + a1_length.value);

  //需要注意的是不要将响应式数据的修改发生在不同的分支下，否则会导致逻辑分支进而导致执行onUpdated钩子的时候另外的数据可能还没有加载会好
  a_length.value = date_Array.value.length;//需要注意的是a_length赋值的内容是总设备的数量(故需要的是date_Array的总数)


  if (a_length.value > 0 && Pinia.Device_sign) {//当且仅当date_Array中存在值且Device_sign为true时才进行处理
    signzhi.value = date_Array.value[0][0];
    //在监视阶段进行currentPage的赋值用于进行初次切割的验证
    currentPage.value = 1;
    const result2 = await axios.get(`/api/History?start=${start}&end=${end}&d_no=${signzhi.value}`);//此处同理将指定d_No的起始位置以及最终位置进行定位
    //故不需要再使用filter函数进行d_no的筛选
    now_databasesArray.value = result2.data;
    device_array.value = now_databasesArray.value;
    const result11 = await axios.get(`/api/History_count?start=${start}&end=${end}&d_no=${signzhi.value}`);
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

    // 获取可渲染总数
    let is_show_total = 0;

    // chartOption(1)内容仅存放is_show为1的字段
    yingshe_array.value.forEach((item, index) => {
      if (item.is_show === "1") {
        is_show_total++;
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
      }
    })

    console.log("当前图像完成基本赋值：");
    console.dir(chartOption.value);
    console.dir(chartOption1.value);

    //需要注意的是初始化体表进行渲染的时候的赋值应该发生在异步处理中，否则报错且不生效

  }

  // 根据当前的Pinia状态决定是否调用enough函数
  if ((a_length.value > 0 && Pinia.Device_sign) || (Pinia.Action_sign)) {
    // 确保需要的图表对象都已初始化
    try {
      if (Pinia.Device_sign && (!chartOption || !chartOption.value)) {
        console.warn("设备图表未初始化，跳过enough函数");
        return;
      }
      // if (Pinia.Action_sign && (!chartOption0 || !chartOption0.value)) {
      //   console.warn("行为图表未初始化，跳过enough函数");
      //   return;
      // }
      console.log("成功调用渲染函数");
      enough();
    } catch (error) {
      console.error("调用enough函数时出错:", error);
    }
  }
  if (Pinia.Action_sign) {//替换上方注释了Device之后的enough的执行条件内容
    enough();
  }


  //启用渲染递归---注意这个DOM加载后的回调函数的任务队列的产生的时机为实际代码运行的位置
  nextTick(() => {
    const text_array: any = document.querySelectorAll(".el-button.el-button--primary.el-tooltip__trigger>span");
    if (text_array) { }
    else {
      text_array[0].innerText = `设备编号为${signzhi.value}的信息`;//需要注意的是当标签中的Content中包含文本加上标签时，DOM操作获取到后的innerHTML以及innerText分别对应全部内容、文本内容
    }
  })

  console.log("gui");
  if (a_length.value === 0) {
    //当为没有元素的情况不执行对端的代码
  }
  else {
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

      if (type_array.value.length > 0) {
        signzhi.value = type_array.value[0][0];
      }
      //将cc清为0
      cc = 0;
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
      if (a_length.value > 0) {
        signzhi.value = jiezhi.data[0][0];
      }
      //当点击ok的时候则对date_array进行获取
      const resultk = await axios.get(`/api/History?start=${boolean_x ? "end" : start}&end=${end}`);
      date_Array.value = resultk.data;//分页内容的呈现数组赋值
      type_array.value = qu_repeate(date_Array.value);//去重数组的获取

      const resultx = await axios.get(`/api/History?start=${boolean_x ? "end" : start}&end=${end}&d_no=${signzhi.value}&currentPage=${currentPage.value}&pageSize=${pageSize}`);//将数组指定分页的内容进行指定内容的获取用于device_array_page数组的赋值
      now_databasesArray.value = resultx.data;//进行总ok内容的赋值
      device_page_array.value = resultx.data;
      const resultxx = await axios.get(`/api/History?start=${boolean_x ? "end" : start}&end=${end}&d_no=${signzhi.value}`);//将数组总内容进行获取，并且指明id,用于device_array数组的赋值
      if (resultxx.data.length > 0) {
        signzhi.value = resultxx.data[0][0];//记录编号
      }
      device_array.value = resultxx.data;//赋值完毕
      const resultxxx = await axios.get(`/api/History_count?start=${boolean_x ? "end" : start}&end=${end}&d_no=${signzhi.value}`);//将数组的总内容数进行获取用于total1的赋值
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

  }
  enough();
})

//初始化第一个选项
let cc = 0;
//需要注意和New之间的区别，此处的.device_list并不会同时存在，因为同时存在意味着同时悬浮，故无法同时进行操作，只能根据一次的响应式的dom出现进行单次的判断
onUpdated(() => {//使用updated钩子解决onMounted无法动态挂载完随响应式数据变化而变化的dom,并且此处仅要求执行一次,否则定时器一直运行导致当前的一号为的内容同样一直运行
  if (cc < 1) {
  }
  else { }
})

</script>

<style scoped>
.container {
  width: 100%;
  border: 2px solid gray;
  position: absolute;
  top: 0px;
}

.block {
  display: inline-block;
  padding: 30px 0;
  text-align: center;
  border-right: 0;
  flex: 1;
  position: relative;
  left: 40px;
  bottom: 0px;
  margin-top: 10px !important;
}

.block:last-child {
  border-right: none;
}

.block .demonstration {
  display: block;
  color: var(--el-text-color-secondary);
  font-size: 14px;
  margin-bottom: 20px;
}

#timeTotime {
  width: 1200px;
  height: 100px;
  display: flex;
  flex-wrap: wrap;
  position: static;
  left: 10px;
}

.device_list>div {
  border: 1px solid gray;
  width: 200px;
  height: 25px;
  text-align: center;
  line-height: 25px;
  background-color: rgb(35, 213, 136);
  cursor: pointer;
}

.device_list {
  height: 25px;
}

h2 {
  font-size: 2.5em;
}

.container.fit-view {
  position: absolute;
  top: 0;
  border-left: 26px solid gray;
  border-right: 10px solid gray;
}

.echarts {
  margin-top: 80px;
  width: 900px !important;
  justify-self: center;
}

.echarts>div {
  transform: scale(1.5);
}

.one {
  display: none;
}

/* 控制下拉框组件居中--统一样式 */
/* .el-dropdown {
  position: relative;
  left: 380px;
  bottom: 30px;
} */

/* 控制下拉框盒子居右 */
#timeTotime1,
#timeTotime2 {
  display: inline-block;
  position: relative;
  left: 380px;
  bottom: 0px;
  margin-top: 10px;
}

/* 开启相对定位用于only的绝对定位布局 */
#timeTotime2 {
  position: relative;
}



/* 控制下拉框组件标签的宽度 */
.el-dropdown>button {
  width: 176.33px;
}

/* 控制标志的位置 */
.el-dropdown>button>span>i>svg {
  position: absolute;
  left: 10px;
}


/* 对表格进行样式设计 */
table {
  margin-top: 18px;
  border-top: 5px solid gray;
  /* width: 1020px; */
  height: 66px;
  /* 需要注意的是此处不能设置固定的table的高度否则则会导致其中只有一个tr的情况下会占据整个tbody的高度 */
  border-spacing: 0;
  /* 下方设置使得table标签变得其中的th、td标签不会随着内容的变化而发生变化 */
  table-layout: fixed;
}

table>thead,
table>tbody {
  min-height: 0;
  width: 1020px;
  height: 33px;
  background-color: #cecece;
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

/* 分页标签样式 */
.pagination-container {
  position: relative;
  margin-top: 20px;
  text-align: center;
  top: 20px;
}

/* 对按钮标签样式进行修改--设备信息 */
#zhexian:hover {
  cursor: pointer;
  box-shadow: 1px 1px 1px 1px gray;
}

#zhexian {
  width: 100px;
  font-size: 14px;
  align-items: center;
  line-height: 28px;
  height: 28px;
  border: 1px solid gray;
  background-color: rgb(97, 170, 172);
}

#zhuzhuang:hover {
  cursor: pointer;
  box-shadow: 1px 1px 1px 1px gray;
}

#zhuzhuang {
  width: 100px;
  height: 28px;
  font-size: 14px;
  align-items: center;
  line-height: 28px;
  border: 1px solid gray;
  background-color: rgb(97, 170, 172);
  position: relative;
  left: 25px;
}

/* 对按钮标签样式进行修改--行为信息 */
#zhexian1:hover {
  cursor: pointer;
  box-shadow: 1px 1px 1px 1px gray;
}

#zhexian1 {
  width: 100px;
  font-size: 14px;
  align-items: center;
  line-height: 28px;
  height: 28px;
  border: 1px solid gray;
  background-color: rgb(97, 170, 172);
}

#zhuzhuang1:hover {
  cursor: pointer;
  box-shadow: 1px 1px 1px 1px gray;
}

#zhuzhuang1 {
  width: 100px;
  height: 28px;
  font-size: 14px;
  align-items: center;
  line-height: 28px;
  border: 1px solid gray;
  background-color: rgb(97, 170, 172);
  position: relative;
  left: 25px;
}

#baifenbi1 {
  width: 100px;
  height: 28px;
  font-size: 14px;
  align-items: center;
  line-height: 28px;
  border: 1px solid gray;
  background-color: rgb(97, 170, 172);
  position: relative;
  left: 50px;
}

#baifenbi1:hover {
  cursor: pointer;
  box-shadow: 1px 1px 1px 1px gray;
}

/* 设计提示标签的样式 */
.h1 {
  width: 1103.8px;
  position: relative;
  top: 22px;
  background-color: #9da79f;
  margin: 0;
  text-align: center;
}

.h2 {
  width: 1103.8px;
  position: relative;
  top: 22px;
  background-color: #9da79f;
  margin: 0;
  text-align: center;
}

/* 进行单标签的样式设计 */
.only {
  width: 176.33px;
  height: 32px;
  position: absolute;
  left: 0px;
  top: -21px;

  background-color: #409eff;
  text-align: center;
  line-height: 32px;
  font-size: 14px;
  font-weight: 400;
}

.only:hover {
  cursor: pointer;
}

.only1 {
  width: 176.33px;
  height: 32px;
  position: absolute;
  left: 290px;
  bottom: 34px;
  text-align: center;
  line-height: 32px;
  font-size: 14px;
  font-weight: 400;
  background-color: #409eff;
}

.only1:hover {
  cursor: pointer;
}


/* 为选中元素进行样式设计 */
.active {
  background-color: aqua !important;
}

/* 为屏蔽器进行样式设计 */
.select_checkbox {
  width: 100%;
  height: 19px !important;
  background-color: gray;
  display: flex;
  justify-content: center;

}

.time_checkbox {
  width: 100%;
  height: 19px !important;
  background-color: gray;
  display: flex;
  justify-content: center;
}

.table_checkbox {
  width: 100%;
  height: 19px !important;
  background-color: gray;
  display: flex;
  justify-content: center;

}

.change_checkbox {
  width: 100%;
  height: 19px !important;
  background-color: gray;
  display: flex;
  justify-content: center;

}

.h2_checkbox {
  width: 100%;
  height: 19px !important;
  background-color: gray;
  display: flex;
  justify-content: center;

}

.image_checkbox {
  width: 100%;
  height: 19px !important;
  background-color: gray;
  display: flex;
  justify-content: center;
}

/* 为屏蔽器添加上悬浮样式 */
input[type="checkbox"]:hover {
  cursor: pointer;
}

/* 控制表格宽度铺满全屏  */
/* .device_table {
  width: 100% !important;
}

.action_table {
  width: 100% !important;
} */

.pagination-container1>.el-pagination {
  margin-left: 800px;
  margin-top: 30px;
}

.pagination-container1,
.pagination-container {
  margin-bottom: 34px !important;
}

.pagination-container>.el-pagination {
  margin-left: 800px;
  margin-top: 30px;
}


/* 为查询条件统一样式设计  */
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

/* 为查询按钮进行样式设计 */
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
<!-- flex-flow属性可用于同时控制flex-direction和flex-wrap  -->
<!-- 实时数据用于在前端进行对应的表格的内容设计的时候如果该变量发生了变化则导致template表格的内容发生动态的变化方便响应式布局的设计 -->
