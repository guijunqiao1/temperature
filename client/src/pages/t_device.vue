<template>
  <div class="device-overview-container" v-show="Pinia.Device_sign">
    <div class="block1 block">
      <el-date-picker v-model="timeArray_value" type="datetimerange" start-placeholder="Start Date" end-placeholder="End Date"
        :default-time="defaultTime" />
    </div>

    <div class="device-overview-header">
      <h1 class="page-title">设备概览</h1>
      <p class="page-description">查看和管理所有工位设备状态</p>
    </div>
    
    <div class="device-grid">
      <div class="device-card" v-for="item in type_array" :key="item[0]">
        <div class="device-info">
          <h3 class="device-title">工位编号：{{ item[1] }}</h3>
          <p class="device-description">点击进入工位详情</p>
        </div>
        <RouterLink to="/New" @click="change(item[0])" class="device-link">
          <img src="../../public/jifang.webp" alt="工位图片" class="device-image" />
          <div class="device-overlay">
            <span class="overlay-text">进入工位</span>
          </div>
        </RouterLink>
      </div>
    </div>

    <div class="the_best_great">
      <h1>用电量对比图像</h1>
      <div>最优工位：{{ best_great }}</div>
      <ECharts :option="chartoption" style="width:100%; height:400px;" class="zhuzhuang" />
    </div>
  </div>
</template>

<script setup lang="ts">
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
  import { onMounted, ref } from "vue";
  import { defineProps } from "vue";
  import axios from "axios";
  //格式化时间变量(数据库中的datetime类型)的包
  import moment from "moment";
  import { onUpdated } from "vue";
  import { RouterView, RouterLink } from "vue-router";
  import { useUserStore } from "../store/curt";
  const Pinia = useUserStore();

  let device_array = ref();//存放被d_no筛选后的数组
  let type_array = ref();//存放设备列表展示内容的数组
  //定义全局数据库内容对象，用于响应式重渲染的设计
  const databases_array = ref();//需要注意的是响应式数据只会通过在程序中的改变进行前端的内容的响应式修改，而不会因为本身赋值依据的改变导致本身的动态的改变，需要明确的赋值才会发生改变
  //此处为刚开始点击进入到t_device组件中进行呈现的根据表格信息的获取--立即执行函数发送获取数据库信息的请求

  //分页相关数据
  let signzhi: any = ref(null);//用于存放当前选中的设备的设备编号
  let a_length = ref();//用于存储type_array的长度的变量
  let update_one = 0;//用于控制update函数中执行编辑的只能是一次
  let change_ok = 0;//用于标记是否为点击后的状态

  //最优解变量
  const best_great = ref();

  //时间选择器捕捉值
  const timeArray_value = ref();

  //时间选择器配置变量
  const defaultTime = [new Date(2000, 1, 1, 12, 0), new Date(2000, 1, 1, 12, 0, 0)]; // '12:00:00'

  //时间范围比较值参考数组
  const nowArray = ref();


  //方法
  let change = (value) => { };//设备列表的方法
  const defaultTime1 = [new Date(2000, 1, 1, 12, 0), new Date(2000, 1, 1, 12, 0, 0)]; // '12:00:00'
  //专门用于将数组去重复化的函数--赋值type_array
  function qu_repeate(databases) {
    const result: any[] = [];
    const seen: Set<string> = new Set(); // 用来记录已经出现过的设备编号

    // 遍历数据库数组
    console.log("databases:");
    console.dir(databases);
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

  // 更新函数--不需要分页的情况下的总内容呈现的方法
  function update() {
    console.log("result_all:" + result_all);
    xuanran(result_all.data);
  }

  //全局请求存储变量
  let result_all;

  //重渲染函数--和update的区别在于是否重置时间
  async function xuanran(value) {
    console.log("device_array:");
    console.dir(value);
    databases_array.value = value;
    //得到type_array
    type_array.value = qu_repeate(databases_array.value);

    console.log("type_array:");
    console.dir(type_array.value);
    a_length.value = type_array.value.length;
    console.log("type_array:" + type_array.value);
    //为signzhi赋值为type_array中的第一个元素
    if (!signzhi.value && databases_array.value && databases_array.value[0] && databases_array.value[0][0]) {
      signzhi.value = databases_array.value[0][0];//将一号位的设备编号进行获取
    }
    //得到device_array
    // const result2 = await axios.get(`/api/t_device/first?d_no=${signzhi.value}`);//获取到总分页内容--d_no筛选后的

    device_array.value = value;

    console.log("当前device_array：");
    console.dir(device_array.value);
    console.log("当前device_array_length：" + device_array.value.length);
    //每执行一次update函数都对实际的文本的内容进行一次更新
    // }
  }

  //柱状图配置变量
  const chartoption = ref({
    title: {
      text: ""
    },
    tooltip: {
      trigger: 'axis',
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
      data: [1],
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

  // 设备配置赋值
  ['工位1','工位2','工位3'].forEach((item, index) => {
    // 折线赋值
    chartoption.value.legend.data.push(item);
    chartoption.value.series.push({
      name: item,
      type: 'bar',
      data: [0]
    })
  })

  // 柱状比较图时间横轴赋值
  chartoption.value.xAxis.data = [''];

  //柱状图值的配置函数
  function yong_calculator(value1) {
    // 确保为每个系列创建单独的数据数组
    let seriesData = [[], [], []];
    
    // 处理每个工位的数据
    for (let j = 0; j < 3; j++) {
      if (nowArray.value && nowArray.value[j] && nowArray.value[j][1]) {
        let records = nowArray.value[j][1];
        let sum = 0;
        
        records.forEach(record => {
          if (record && record[0]) {
            sum += parseFloat(record[0]);
          }
        });
        
        seriesData[j] = sum; // 存储计算的和
      } else {
        seriesData[j] = 0; // 没有数据时设为0
      }
    }
    
    // 更新图表数据
    for (let i = 0; i < seriesData.length; i++) {
      if (chartoption.value.series[i]) {
        chartoption.value.series[i].data = [seriesData[i]]; // 注意这里要是数组
      }
    }
    
    // 更新最优解
    const min = Math.min(...seriesData);
    if (seriesData[0] === min) best_great.value = '工位1';
    else if (seriesData[1] === min) best_great.value = '工位2';
    else best_great.value = '工位3';
    
    console.log("更新后的图表配置:", chartoption.value);
  }


  //在onMounted方法中定义add_td方法便于后续使用DOM进行tbody标签中的tr、td标签的创建以及添加操作
  onMounted(async () => {
    result_all = await axios.get(`/api/t_device`);//获取到总内容用于type_array进行更新
    // 主动调用一次update1
    update();
    //用于修改signzhi的change函数的赋值
    change = async (value) => {
      //全局变量修改
      Pinia.change(value);
    }
    //主动初始化一次第一个设备
    change(type_array.value[0][0]);
    Pinia.change_jifang(type_array.value);
    //初始化相应的次数（Pinia.times）
    // if(Pinia.signzhi==='工位1'){
    //   const result = await axios.get(`/api/times?id=1`);
    // }
    // else if(Pinia.signzhi==='工位2'){
    //   const result = await axios.get(`/api/times?id=2`);
    // }
    // else{
    //   const result = await axios.get(`/api/times?id=3`);
    // }
    //完成数组的内容重置获取
    const result = await axios.get(`/api/Test_array_get`);
    Pinia.change_Test_array = result.data;


    //获取nowArray，进行图像初次赋值
    const result_nowArray = await axios.get("/api/get_array_by_time?start=1&end=1");//初次查询
    nowArray.value = result_nowArray.data;
    console.log("当前Nowarray:");
    console.dir(nowArray);
    yong_calculator(nowArray.value);

    
    //分别获取时间选择器的btn以及ok按钮
    const ok = document.querySelector(".el-button.el-button--small.is-disabled.is-plain.el-picker-panel__link-btn") as HTMLElement;
    const btn = document.querySelector(".el-icon.el-input__icon.el-range__close-icon.el-range__close-icon--hidden") as HTMLElement;

    ok.addEventListener("click",async(e)=>{
      //获取到时间值
      const start = timeArray_value.value[0];
      const end = timeArray_value.value[1];
      //请求发送
      const result = await axios.get(`/api/get_array_by_time?start=${start}&end=${end}`);
      nowArray.value = result.data;
      console.log("nowArray:");
      console.dir(nowArray.value);
      yong_calculator(nowArray.value);
      //判断检查
      if(nowArray.value.length<1){
        alert("得到的内容为空");
        best_great.value = '无';
      }
    })
    btn.addEventListener("click",async(e)=>{
      //请求发送
      const result = await axios.get(`/api/get_array_by_time?start=1&end=1`);
      nowArray.value = result.data;
      console.log("nowArray:");
      console.dir(nowArray.value);
      yong_calculator(nowArray.value);

    })

  });
</script>

<style scoped>
.device-overview-container {
  width: 100%;
  min-height: 100vh;
  padding: 30px;
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
  position: relative;
  overflow-x: hidden;
}

.device-overview-container::before {
  content: '';
  position: absolute;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background: url('data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><defs><pattern id="grain" width="100" height="100" patternUnits="userSpaceOnUse"><circle cx="50" cy="50" r="1" fill="rgba(255,255,255,0.1)"/></pattern></defs><rect width="100" height="100" fill="url(%23grain)"/></svg>');
  opacity: 0.3;
  pointer-events: none;
}

.block1 {
  margin-bottom: 30px;
  text-align: center;
}

.block1 .el-date-picker {
  background: rgba(255, 255, 255, 0.95);
  border-radius: 15px;
  box-shadow: 0 8px 32px rgba(0, 0, 0, 0.1);
  backdrop-filter: blur(20px);
  border: 1px solid rgba(255, 255, 255, 0.2);
}

.device-overview-header {
  text-align: center;
  margin-bottom: 50px;
  padding: 50px 40px;
  background: rgba(255, 255, 255, 0.95);
  border-radius: 25px;
  box-shadow: 0 20px 60px rgba(0, 0, 0, 0.15);
  backdrop-filter: blur(25px);
  border: 1px solid rgba(255, 255, 255, 0.3);
  position: relative;
  overflow: hidden;
}

.device-overview-header::before {
  content: '';
  position: absolute;
  top: -50%;
  left: -50%;
  width: 200%;
  height: 200%;
  background: linear-gradient(45deg, transparent, rgba(255, 255, 255, 0.1), transparent);
  transform: rotate(45deg);
  animation: shimmer 3s infinite;
}

@keyframes shimmer {
  0% { transform: translateX(-100%) translateY(-100%) rotate(45deg); }
  100% { transform: translateX(100%) translateY(100%) rotate(45deg); }
}

.page-title {
  font-size: 3rem;
  color: #2c3e50;
  margin-bottom: 20px;
  font-weight: 800;
  background: linear-gradient(135deg, #667eea 0%, #764ba2 50%, #f093fb 100%);
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
  background-clip: text;
  text-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
  position: relative;
  z-index: 1;
}

.page-description {
  font-size: 1.3rem;
  color: #5a6c7d;
  line-height: 1.8;
  font-weight: 500;
  position: relative;
  z-index: 1;
}

.device-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(380px, 1fr));
  gap: 35px;
  margin: 40px 0;
  padding: 0 10px;
}

.device-card {
  background: rgba(255, 255, 255, 0.95);
  border-radius: 25px;
  padding: 30px;
  box-shadow: 0 15px 50px rgba(0, 0, 0, 0.12);
  backdrop-filter: blur(25px);
  border: 1px solid rgba(255, 255, 255, 0.3);
  transition: all 0.4s cubic-bezier(0.175, 0.885, 0.32, 1.275);
  text-align: center;
  position: relative;
  overflow: hidden;
}

.device-card::before {
  content: '';
  position: absolute;
  top: 0;
  left: -100%;
  width: 100%;
  height: 100%;
  background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.4), transparent);
  transition: left 0.6s;
}

.device-card:hover::before {
  left: 100%;
}

.device-card:hover {
  transform: translateY(-10px) scale(1.02);
  box-shadow: 0 25px 80px rgba(0, 0, 0, 0.2);
}

.device-info {
  margin-bottom: 25px;
  position: relative;
  z-index: 1;
}

.device-title {
  font-size: 1.6rem;
  color: #2c3e50;
  margin-bottom: 15px;
  font-weight: 700;
  background: linear-gradient(135deg, #667eea, #764ba2);
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
  background-clip: text;
}

.device-description {
  font-size: 1.1rem;
  color: #7f8c8d;
  line-height: 1.6;
  font-weight: 500;
}

.device-link {
  display: block;
  position: relative;
  text-decoration: none;
  border-radius: 20px;
  overflow: hidden;
  transition: all 0.4s cubic-bezier(0.175, 0.885, 0.32, 1.275);
  box-shadow: 0 8px 25px rgba(0, 0, 0, 0.1);
}

.device-link:hover {
  transform: scale(1.03);
  box-shadow: 0 15px 40px rgba(0, 0, 0, 0.2);
}

.device-image {
  width: 100%;
  height: 220px;
  object-fit: cover;
  display: block;
  border-radius: 20px;
  transition: all 0.4s ease;
  filter: brightness(0.9);
}

.device-link:hover .device-image {
  filter: brightness(1.1);
  transform: scale(1.05);
}

.device-overlay {
  position: absolute;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background: linear-gradient(135deg, rgba(102, 126, 234, 0.9), rgba(118, 75, 162, 0.9));
  display: flex;
  align-items: center;
  justify-content: center;
  opacity: 0;
  transition: all 0.4s cubic-bezier(0.175, 0.885, 0.32, 1.275);
  border-radius: 20px;
  backdrop-filter: blur(10px);
}

.device-link:hover .device-overlay {
  opacity: 1;
}

.overlay-text {
  color: white;
  font-size: 1.3rem;
  font-weight: 700;
  text-transform: uppercase;
  letter-spacing: 2px;
  text-shadow: 0 2px 10px rgba(0, 0, 0, 0.3);
  animation: pulse 2s infinite;
}

@keyframes pulse {
  0%, 100% { transform: scale(1); }
  50% { transform: scale(1.05); }
}

.the_best_great {
  background: rgba(255, 255, 255, 0.95);
  border-radius: 25px;
  padding: 40px;
  margin-top: 50px;
  box-shadow: 0 20px 60px rgba(0, 0, 0, 0.12);
  backdrop-filter: blur(25px);
  border: 1px solid rgba(255, 255, 255, 0.3);
  text-align: center;
}

.the_best_great h1 {
  font-size: 2.2rem;
  color: #2c3e50;
  margin-bottom: 20px;
  font-weight: 700;
  background: linear-gradient(135deg, #667eea, #764ba2);
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
  background-clip: text;
}

.the_best_great div {
  font-size: 1.3rem;
  color: #e74c3c;
  font-weight: 600;
  margin-bottom: 30px;
  padding: 15px 25px;
  background: linear-gradient(135deg, #ffeaa7, #fab1a0);
  border-radius: 15px;
  display: inline-block;
  box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
}

.zhuzhuang {
  border-radius: 20px;
  overflow: hidden;
  box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
}

/* 响应式设计 */
@media (max-width: 1400px) {
  .device-grid {
    grid-template-columns: repeat(auto-fit, minmax(350px, 1fr));
    gap: 30px;
  }
  
  .page-title {
    font-size: 2.8rem;
  }
}

@media (max-width: 1200px) {
  .device-overview-container {
    padding: 25px;
  }
  
  .device-grid {
    grid-template-columns: repeat(auto-fit, minmax(320px, 1fr));
    gap: 28px;
  }
  
  .page-title {
    font-size: 2.5rem;
  }
  
  .the_best_great h1 {
    font-size: 2rem;
  }
}

@media (max-width: 768px) {
  .device-overview-container {
    padding: 20px;
  }
  
  .device-overview-header {
    padding: 40px 25px;
    margin-bottom: 40px;
  }
  
  .page-title {
    font-size: 2.2rem;
  }
  
  .page-description {
    font-size: 1.1rem;
  }
  
  .device-grid {
    grid-template-columns: 1fr;
    gap: 25px;
    margin: 30px 0;
  }
  
  .device-card {
    padding: 25px;
  }
  
  .device-title {
    font-size: 1.4rem;
  }
  
  .the_best_great {
    padding: 30px 25px;
    margin-top: 40px;
  }
  
  .the_best_great h1 {
    font-size: 1.8rem;
  }
  
  .the_best_great div {
    font-size: 1.1rem;
    padding: 12px 20px;
  }
}

@media (max-width: 480px) {
  .device-overview-container {
    padding: 15px;
  }
  
  .device-overview-header {
    padding: 30px 20px;
    border-radius: 20px;
  }
  
  .page-title {
    font-size: 2rem;
  }
  
  .page-description {
    font-size: 1rem;
  }
  
  .device-card {
    padding: 20px;
    border-radius: 20px;
  }
  
  .device-title {
    font-size: 1.3rem;
  }
  
  .device-description {
    font-size: 1rem;
  }
  
  .device-image {
    height: 180px;
  }
  
  .the_best_great {
    padding: 25px 20px;
    border-radius: 20px;
  }
  
  .the_best_great h1 {
    font-size: 1.6rem;
  }
  
  .the_best_great div {
    font-size: 1rem;
    padding: 10px 15px;
  }
}

@media (max-width: 360px) {
  .device-overview-container {
    padding: 10px;
  }
  
  .device-overview-header {
    padding: 25px 15px;
  }
  
  .page-title {
    font-size: 1.8rem;
  }
  
  .device-grid {
    gap: 20px;
  }
  
  .device-card {
    padding: 18px;
  }
  
  .the_best_great {
    padding: 20px 15px;
  }
}
</style>

