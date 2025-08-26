<template>
  <div class="error-container" v-if="Pinia.Device_sign">
    <!-- 设备选择 -->
    <div class="error-header">
      <el-dropdown class="room-selector">
        <el-button type="primary" v-show="Pinia.type_len > 1" class="room-btn">
          工位<el-icon class="el-icon--right"><arrow-down /></el-icon>
        </el-button>
        <template #dropdown>
          <el-dropdown-menu>
            <div>
              <div class="device-list" v-for="item in Pinia.type_array" :key="item[0]">
                <el-dropdown-item>
                  <div class="room-option" @click="change_jifang(item[0])">{{ item[0] }}</div>
                </el-dropdown-item>
              </div>
            </div>
          </el-dropdown-menu>
        </template>
      </el-dropdown>
      <div class="current-room" v-if="type_len <= 1">
        当前工位：{{ Pinia.signzhi }}
      </div>
    </div>

    <!-- 时间选择器部分 -->
    <div class="time-selector-section">
      <div class="time-selector-container">
        <h3 class="section-title">选择时间范围</h3>
        <div class="error-date-time">
          <el-date-picker 
            v-model="value1" 
            type="datetimerange" 
            start-placeholder="开始时间" 
            end-placeholder="结束时间"
            :default-time="defaultTime1" 
            @change="submit"
            class="date-picker"
          />
        </div>
      </div>
    </div>

    <!-- 饼状图 -->
    <ECharts :option="chartOption_bing" style="width:100%; height:400px;" class="bingzhuang" />

    <!-- 错误信息表格部分 -->
    <div class="error-table-section">
      <h2 class="section-title">错误信息记录</h2>
      <div class="table-container">
        <table class="error-table">
          <thead class="table-header">
            <tr>
              <th>场景</th>
              <th>错误信息</th>
              <th>类型</th>
              <th>出错时间</th>
            </tr>
          </thead>
          <tbody class="table-body">
            <!-- 遍历的是设备数组的内容 -->
            <tr v-for="item in device_array" :key="item.id" class="table-row">
              <td v-show="Pinia.device_sign" class="scene-cell">{{ item[0] }}</td>
              <td class="error-cell">{{ item[1] }}</td>
              <td class="error-cell">{{ item[3] }}</td>
              <td class="time-cell">{{ moment(item[2]).format('YYYY-MM-DD HH:mm:ss') }}</td>
            </tr>
          </tbody>
        </table>
      </div>
      
      <!-- 分页栏部分 -->
      <div class="pagination-container">
        <el-pagination 
          v-model:current-page="currentPage" 
          v-model:page-size="pageSize" 
          :total="Number(total1)"
          layout="prev, pager, next" 
          class="custom-pagination"
        />
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { onMounted, ref } from "vue";
import { watch } from "vue";
import axios from "axios";
//格式化时间变量(数据库中的datetime类型)的包
import moment from "moment";
import { useRouter } from 'vue-router'
import { useUserStore } from "../store/curt";
import * as echarts from 'echarts';
import {
  TitleComponent,
  TitleComponentOption,
  TooltipComponent,
  TooltipComponentOption,
  LegendComponent,
  LegendComponentOption
} from 'echarts/components';
import { PieChart, PieSeriesOption } from 'echarts/charts';
import { LabelLayout } from 'echarts/features';
import { CanvasRenderer } from 'echarts/renderers';

echarts.use([
  TitleComponent,
  TooltipComponent,
  LegendComponent,
  PieChart,
  CanvasRenderer,
  LabelLayout
]);
import ECharts from "vue-echarts";

const Pinia = useUserStore();



//数据
let device_array = ref();//存放被d_no筛选后的数组
let type_array = ref();//设备选择器依据数组
//定义全局数据库内容对象，用于响应式重渲染的设计
const databases_array = ref();//需要注意的是响应式数据只会通过在程序中的改变进行前端的内容的响应式修改，而不会因为本身赋值依据的改变导致本身的动态的改变，需要明确的赋值才会发生改变
//此处为刚开始点击进入到t_device组件中进行呈现的根据表格信息的获取--立即执行函数发送获取数据库信息的请求

//分页相关数据
const currentPage = ref(0)//当前页数变量,当发生自身发生改变的时候就将数据库中对应页码的数据进行单独的databases_array的赋值
let pageSize = 12;
const total1 = ref()//总数变量,当发生增添事件、删除事件(包括单独删除以及搜索删除)之后进行总量变量的重新计算
//定义三个响应式变量用于动态接收add参数
// let type1 = ref("警告");//设备注释
// let e_msg1 = ref();//错误信息
let d_no1 = ref(Pinia.signzhi);//设备编号
// let update_one = 0;//用于控制update函数中执行编辑的只能是一次
let value1 = ref();//用于将时间值进行动态获取的变量
// 定义时间选择相关的变量
let start: any = ref(1);
let end: any = ref(1);

// 饼状图配置变量
let chartOption_bing = ref({
    tooltip: {
      trigger: 'item'
    },
    legend: {
      orient: 'vertical',
      left: 'left'
    },
    series: [
      {
        name: 'Access From',
        type: 'pie',
        radius: '50%',
        data: [
          { name: '温度' },
          { name: '湿度' },
          { name: '光照' },
        ],
        emphasis: {
          itemStyle: {
            shadowBlur: 10,
            shadowOffsetX: 0,
            shadowColor: 'rgba(0, 0, 0, 0.5)'
          }
        }
      }
    ]
  });


const router = useRouter();
const defaultTime1 = [new Date(2000, 1, 1, 12, 0), new Date(2000, 1, 1, 12, 0, 0)]; // '12:00:00'


//方法
let update = () => { };


//专门用于更新的函数
update = async () => {//最好别在挂载阶段使用function否则容易提升到最高级导致变量未定义的隐藏错误
  if (start.value === end.value && end.value !== 1) {//单向查询
    const result = await axios.get(`/api/t_error_msg/first?d_no=${Pinia.signzhi}&start=end&end=${end.value}&currentPage=undefined&pageSize=undefined`);//获取到总内容用于type_array进行更新
    //渲染饼状图
    xuanran(result.data);
    //上述为前端发送请求的示例内容
    databases_array.value = result.data;
    //得到type_array
    //得到device_array
    const result2 = await axios.get(`/api/t_error_msg/first?d_no=${Pinia.signzhi}&start=end&end=${end.value}&currentPage=${currentPage.value}&pageSize=${pageSize}`);//获取到总分页内容--d_no筛选后的
    device_array.value = result2.data;
    const result1 = await axios.get(`/api/t_error_msg/count?d_no=${Pinia.signzhi}&start=end&end=${end.value}`);//获取总数据
    total1.value = result1.data;
  }
  else if (start.value === 1 && end.value === 1) {
    const result = await axios.get(`/api/t_error_msg/first?d_no=${Pinia.signzhi}&start=${start.value}&end=${end.value}&currentPage=undefined&pageSize=undefined`);//获取到总内容用于type_array进行更新
    xuanran(result.data);
    //上述为前端发送请求的示例内容
    databases_array.value = result.data;
    //得到type_array
    //得到device_array
    const result2 = await axios.get(`/api/t_error_msg/first?d_no=${Pinia.signzhi}&start=${start.value}&end=${end.value}&currentPage=${currentPage.value}&pageSize=${pageSize}`);//获取到总分页内容--d_no筛选后的
    device_array.value = result2.data;
    const result1 = await axios.get(`/api/t_error_msg/count?d_no=${Pinia.signzhi}&start=${start.value}&end=${end.value}`);//获取总数据
    total1.value = result1.data;
  }
  else {
    const result = await axios.get(`/api/t_error_msg/first?d_no=${Pinia.signzhi}&start=${start.value}&end=${end.value}&currentPage=undefined&pageSize=undefined`);//获取到总内容用于type_array进行更新
    xuanran(result.data);
    //上述为前端发送请求的示例内容
    databases_array.value = result.data;
    //得到type_array
    //得到device_array
    const result2 = await axios.get(`/api/t_error_msg/first?d_no=${Pinia.signzhi}&start=${start.value}&end=${end.value}&currentPage=${currentPage.value}&pageSize=${pageSize}`);//获取到总分页内容--d_no筛选后的
    device_array.value = result2.data;

    const result1 = await axios.get(`/api/t_error_msg/count?d_no=${Pinia.signzhi}&start=${start.value}&end=${end.value}`);//获取总数据
    total1.value = result1.data;
  }

  // if (update_one === 0) {
  //   //对初始文本进行编辑
  //   const text = document.querySelector(".el-button.el-button--primary.el-tooltip__trigger>span") as HTMLElement;
  //   update_one++;
  // }
}


function submit() {
  if (value1.value && value1.value[0] && value1.value[1]) {
    start.value = value1.value[0];
    end.value = value1.value[1];
    update();
  }
}

function change_jifang(value){
  //全局变量修改
  Pinia.change(value);
  //当前页面的重置(携带上Pinia.signzhi)
  //页面重置,先跳到一个空路由，再跳回来
  router.replace('/empty').then(() => {
    router.replace('/t_error_msg');
  })
  console.log("当前机房:"+Pinia.signzhi);
}


//自当前组件创建阶段就对currentPage变量的值进行监视，若发生了修改，则结合上currentPage变量对databases_array赋值(模版为jiezhi_array)
watch(() => currentPage.value, () => {
  update();
}, { deep: true })
// //在监视阶段进行currentPage的赋值用于进行初次切割的验证
currentPage.value = 1;//该代码块的执行应当放置在setup中，否则会异步替代执行不到渲染的效果

//专门用于将数组去重复化的函数--赋值type_array
function qu_repeate(databases) {
  const seen = new Set(); // 用来记录已经出现过的 d_no

  // 遍历输入数组并收集唯一的 d_no
  for (let i = 0; i < databases.length; i++) {
    const d_no = databases[i].d_no;
    seen.add(d_no);
  }

  // 将 Set 转换为数组
  return Array.from(seen);
}

//封装渲染饼状图的函数
async function xuanran(value){
  //清空内容

  //计算各个维度下的值的分配情况
  const result_array = [0,0,0];//分别表示的是温度、湿度、光照过界
  //进行配置变量的维度分配
  value.forEach((item,index)=>{
    if(item.e_msg==='光照过界'){
      result_array[2]++;
    }else if(item.e_msg==='温度过界'){
      result_array[0]++;
    }else{
      result_array[1]++;
    }
  })

  // 设备配置赋值
  chartOption_bing.value.series[0].data.forEach((item, index) => {
    // 饼状赋值
    item.value = result_array[index];
  })

  console.log("完成赋值后的配置：");
  console.dir(chartOption_bing);
  
}
//在onMounted方法中定义add_td方法便于后续使用DOM进行tbody标签中的tr、td标签的创建以及添加操作
onMounted(async () => {

  // 初始化阶段完成总type_array固定内容的获取
  const result = await axios.get("/api/t_error_msg/all");
  type_array.value = qu_repeate(result.data);
  console.log("当前type:");
  console.dir(type_array.value);


  if (Pinia.Device_sign) {
    currentPage.value = 0;
    currentPage.value = 1;

    // // 挂载阶段对时间组件进行激活
    const btn = document.querySelector(".el-icon.el-input__icon.el-range__close-icon.el-range__close-icon--hidden") as HTMLElement;
    //进行x按钮的事件绑定
    btn.addEventListener("click", (event) => {
      //将start、end重置
      start.value = 1;
      end.value = 1;
      update();
    })

    //对ok按钮进行获取
    const ok = document.querySelector(".el-button.el-button--small.is-disabled.is-plain.el-picker-panel__link-btn") as HTMLElement;
    ok.addEventListener("click", (event) => {
      start.value = value1.value[0];
      end.value = value1.value[1];
      console.log("当前时间取值为:");
      console.log("start:" + start.value);
      console.log("end:" + end.value);
      update();
    })

    //挂载阶段对search函数进行赋值
    // search = async (value) => {
    //   //至少存在一个指标
    //   if (e_msg1.value || d_no1.value) {
    //     search_ok = true;
    //     //主动激活监视器，并且在监视器中进行监听
    //     currentPage.value = 0;
    //     currentPage.value = 1;
    //   }
    //   else {
    //     alert("查询的维度至少存在一个");
    //   }
    // }
  }


  
})
</script>

<style scoped>
.error-container {
  width: 100%;
  min-height: 100vh;
  padding: 30px;
  background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
  font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
}

.error-header {
  display: flex;
  align-items: center;
  gap: 20px;
  margin-bottom: 40px;
  padding: 20px;
  background: rgba(255, 255, 255, 0.9);
  border-radius: 15px;
  box-shadow: 0 8px 25px rgba(0, 0, 0, 0.1);
  backdrop-filter: blur(10px);
  border: 1px solid rgba(255, 255, 255, 0.2);
}

.room-selector {
  margin-right: 20px;
}

.room-btn {
  background: linear-gradient(135deg, #667eea, #764ba2);
  border: none;
  border-radius: 25px;
  padding: 12px 24px;
  font-weight: 600;
  box-shadow: 0 4px 15px rgba(102, 126, 234, 0.3);
  transition: all 0.3s ease;
}

.room-btn:hover {
  transform: translateY(-2px);
  box-shadow: 0 6px 20px rgba(102, 126, 234, 0.4);
}

.room-option {
  padding: 8px 16px;
  border-radius: 8px;
  transition: background-color 0.3s ease;
}

.room-option:hover {
  background-color: #f0f2f5;
}

.current-room {
  padding: 12px 24px;
  background: linear-gradient(135deg, #409eff, #36a3f7);
  color: white;
  border-radius: 25px;
  font-weight: 600;
  box-shadow: 0 4px 15px rgba(64, 158, 255, 0.3);
}

.time-selector-section {
  margin-bottom: 40px;
}

.time-selector-container {
  background: rgba(255, 255, 255, 0.9);
  border-radius: 20px;
  padding: 30px;
  box-shadow: 0 8px 25px rgba(0, 0, 0, 0.1);
  backdrop-filter: blur(10px);
  border: 1px solid rgba(255, 255, 255, 0.2);
  text-align: center;
}

.section-title {
  font-size: 1.8rem;
  color: #2c3e50;
  margin-bottom: 25px;
  padding-bottom: 15px;
  border-bottom: 3px solid #3498db;
  font-weight: 700;
}

.error-date-time {
  display: flex;
  justify-content: center;
  align-items: center;
}

.date-picker {
  min-width: 300px;
}

.error-table-section {
  background: rgba(255, 255, 255, 0.9);
  border-radius: 20px;
  padding: 30px;
  box-shadow: 0 8px 25px rgba(0, 0, 0, 0.1);
  backdrop-filter: blur(10px);
  border: 1px solid rgba(255, 255, 255, 0.2);
}

.table-container {
  overflow-x: auto;
  border-radius: 15px;
  box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
  margin-bottom: 30px;
}

.error-table {
  width: 100%;
  border-collapse: collapse;
  border-radius: 15px;
  overflow: hidden;
  background: white;
}

.table-header {
  background: linear-gradient(135deg, #e74c3c, #c0392b);
  color: white;
}

.table-header th {
  padding: 18px 15px;
  text-align: center;
  font-weight: 600;
  font-size: 1.1rem;
  border: none;
  position: relative;
}

.table-header th:not(:last-child)::after {
  content: '';
  position: absolute;
  right: 0;
  top: 50%;
  transform: translateY(-50%);
  width: 1px;
  height: 60%;
  background: rgba(255, 255, 255, 0.3);
}

.table-body {
  background: white;
}

.table-row {
  transition: all 0.3s ease;
  border-bottom: 1px solid #e9ecef;
}

.table-row:hover {
  background: linear-gradient(135deg, #f8f9fa, #e9ecef);
  transform: scale(1.01);
  box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
}

.table-body td {
  padding: 18px 15px;
  text-align: center;
  color: #2c3e50;
  font-size: 1rem;
  font-weight: 500;
  border: none;
}

.scene-cell {
  font-weight: 600;
  color: #3498db;
}

.error-cell {
  color: #e74c3c;
  font-weight: 600;
  max-width: 300px;
  word-wrap: break-word;
}

.time-cell {
  color: #7f8c8d;
  font-size: 0.9rem;
}

.pagination-container {
  display: flex;
  justify-content: center;
  margin-top: 30px;
}

.custom-pagination {
  --el-pagination-bg-color: transparent;
  --el-pagination-text-color: #2c3e50;
  --el-pagination-border-color: #e9ecef;
}

/* 响应式设计 */
@media (max-width: 1200px) {
  .error-container {
    padding: 20px;
  }
  
  .time-selector-container,
  .error-table-section {
    padding: 25px;
  }
}

@media (max-width: 768px) {
  .error-container {
    padding: 15px;
  }
  
  .error-header {
    flex-direction: column;
    align-items: stretch;
    gap: 15px;
  }
  
  .section-title {
    font-size: 1.5rem;
  }
  
  .date-picker {
    min-width: 250px;
  }
  
  .table-header th,
  .table-body td {
    padding: 12px 8px;
    font-size: 0.9rem;
  }
}

@media (max-width: 480px) {
  .error-container {
    padding: 10px;
  }
  
  .time-selector-container,
  .error-table-section {
    padding: 20px;
  }
  
  .section-title {
    font-size: 1.3rem;
  }
  
  .date-picker {
    min-width: 200px;
  }
  
  .table-header th,
  .table-body td {
    padding: 10px 5px;
    font-size: 0.8rem;
  }
}

table thead>tr>th,
table tbody>tr>td {
  width: 180px;
  height: 40px;
  color: black;
  font-size: 14px;
  border: 1px solid #9DA79F;
  font-weight: 800;
  text-align: center;
}

/* 为顶部功能按钮标签设置统一样式 */
.search {
  border: 0;
  border-radius: 1px;
  color: white;
  margin-left: 5px;
  height: 20px;
  margin-top: 0;
  font-size: 14px;
  line-height: 20px;
}

.add {
  background-color: #317C77;
}

.delete {
  background-color: rgb(194, 44, 44);
}

.search {
  color: black;
  border: 0.1px solid rgb(118, 118, 118);
  background-color: white;
}

.bottom_part {
  /* 开启相对定位作为包含块元素存在 */
  /* position: relative; */
  height: 680px;
}

/* 分页容器标签的样式设计 */
.pagination-container {
  margin-top: 20px;
  text-align: center;
  position: absolute;
  bottom: 8px;
  right: 20px;
}

.el-pagination {
  margin-right: 40px;
}

/* 设置单选框样式 */
.late_active {
  width: 30px;
  margin-right: 0;
  position: relative;
  left: 400px;
}

/* 近十天的文本内容 */
.text {
  position: relative;
  left: 400px;
}

/* 对添加按钮组件相关的标签进行样式设计 */
.add1 {
  width: 37px;
  height: 17px;
  position: absolute;
  left: 309px;
  font-size: 10px;
  line-height: 14px;
  background-color: rgb(240, 185, 185);
  border: 0;
  border: 1px solid black;
}

.add1:hover {
  cursor: pointer;
}

.in_name {
  height: 10px;
  width: 108px;
  /* 直接控制input中的value的字体大小 */
  font-size: 10px;
  margin-left: 5px;
}

.in_name::placeholder {
  font-size: 10px;
  line-height: 14px;

}

.in_no {
  height: 11px;
  /* 直接控制input中的value的字体大小 */
  font-size: 10px;
  position: absolute;
  left: 129px;
  width: 116px;
  border: 0;
  border: 1px solid white;
  border-radius: 2px;
}

.in_no::placeholder {
  font-size: 10px;
  line-height: 14px;
}

.se_re {
  font-size: 10px;
  line-height: 14px;
  width: 47px;
  height: 17px;
  position: absolute;
  left: 256px;
}

.se_re:hover {
  cursor: pointer;
}


/* 为only盒子进行单独的样式设计 */
.only {
  position: absolute;
  left: 350px;
}

.only:hover {
  cursor: pointer;
}

/* 为设备列表盒子进行样式设计 */
.el-dropdown {
  position: absolute;
  left: 42px;
  top: 4px;
  height: 10px;
}

/* 为时间选择器进行样式设计 */
.block {
  text-align: center;
  border-right: solid 1px var(--el-border-color);
  flex: 1;
  margin-left: 350px;
  display: inline-block;
}

/* 为表格屏蔽器进行样式设计 */
.table_checkbox {
  width: 100% !important;
  background-color: gray;
  position: relative;
  text-align: center;
  top: 0;
  z-index: 1;
}

/* 为屏蔽器添加上悬浮样式 */
input[type="checkbox"]:hover {
  cursor: pointer;
}

/* 进行时间框的样式设计 */
.error_date_time {
  position: relative;
  top: -2px;
  left: 400px;
}

/* 屏蔽icon */
.el-icon.el-icon--right {
  display: none !important;
}
</style>

<!-- 对于上述样式设计需要注意的是width:100%这种写法是针对进行嵌套后的父元素的100% -->
<!-- 同时需要注意的是在thead设置了固定的值，但是后续的th的样式设计如果过大同样会导致thead被撑大(因为thead默认overflow为visible) -->
