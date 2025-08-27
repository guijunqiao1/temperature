<template>
  <div class="device-overview-container" v-show="Pinia.Device_sign">
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
      <div>最优工位：{{ best_great }}</div>
      <ECharts :option="chartoption" style="width:100%; height:400px;" class="zhuzhuang"
        v-show="a_length > 0 && !zhexian_device && Pinia.Device_sign" />
    </div>
  </div>
</template>

<script setup lang="ts">
  import { onMounted, ref } from "vue";
  import { defineProps } from "vue";
  import axios from "axios";
  //格式化时间变量(数据库中的datetime类型)的包
  import moment from "moment";
  import { ArrowDown } from '@element-plus/icons-vue'
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

  //时间选择器捕捉值
  const value1 = ref();

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

  // 设备配置赋值
  ['工位1','工位2','工位3'].forEach((item, index) => {
    // 折线赋值
    chartoption.value.legend.data.push(item);
    chartoption.value.series.push({
      name: '用电量',
      type: 'bar',
      data: []
    })
  })

  // 柱状比较图时间横轴赋值
  chartoption.value.xAxis.data = [];


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
  });
</script>

<style scoped>
.device-overview-container {
  width: 100%;
  min-height: 100vh;
  padding: 30px;
  background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
  font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
}

.device-overview-header {
  text-align: center;
  margin-bottom: 50px;
  padding: 40px;
  background: rgba(255, 255, 255, 0.9);
  border-radius: 20px;
  box-shadow: 0 8px 25px rgba(0, 0, 0, 0.1);
  backdrop-filter: blur(10px);
  border: 1px solid rgba(255, 255, 255, 0.2);
}

.page-title {
  font-size: 2.5rem;
  color: #2c3e50;
  margin-bottom: 15px;
  font-weight: 700;
  background: linear-gradient(45deg, #3498db, #e74c3c);
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
  background-clip: text;
}

.page-description {
  font-size: 1.2rem;
  color: #666;
  line-height: 1.6;
}

.device-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(350px, 1fr));
  gap: 30px;
  margin-top: 30px;
}

.device-card {
  background: rgba(255, 255, 255, 0.9);
  border-radius: 20px;
  padding: 25px;
  box-shadow: 0 8px 25px rgba(0, 0, 0, 0.1);
  backdrop-filter: blur(10px);
  border: 1px solid rgba(255, 255, 255, 0.2);
  transition: all 0.3s ease;
  text-align: center;
}

.device-card:hover {
  transform: translateY(-5px);
  box-shadow: 0 15px 35px rgba(0, 0, 0, 0.15);
}

.device-info {
  margin-bottom: 20px;
}

.device-title {
  font-size: 1.4rem;
  color: #2c3e50;
  margin-bottom: 10px;
  font-weight: 600;
}

.device-description {
  font-size: 1rem;
  color: #666;
  line-height: 1.5;
}

.device-link {
  display: block;
  position: relative;
  text-decoration: none;
  border-radius: 15px;
  overflow: hidden;
  transition: all 0.3s ease;
}

.device-link:hover {
  transform: scale(1.02);
}

.device-image {
  width: 100%;
  height: 200px;
  object-fit: cover;
  display: block;
  border-radius: 15px;
  transition: all 0.3s ease;
}

.device-overlay {
  position: absolute;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background: rgba(52, 152, 219, 0.8);
  display: flex;
  align-items: center;
  justify-content: center;
  opacity: 0;
  transition: all 0.3s ease;
  border-radius: 15px;
}

.device-link:hover .device-overlay {
  opacity: 1;
}

.overlay-text {
  color: white;
  font-size: 1.2rem;
  font-weight: 600;
  text-transform: uppercase;
  letter-spacing: 1px;
}

/* 响应式设计 */
@media (max-width: 1200px) {
  .device-overview-container {
    padding: 20px;
  }
  
  .device-grid {
    grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
    gap: 25px;
  }
}

@media (max-width: 768px) {
  .device-overview-container {
    padding: 15px;
  }
  
  .device-overview-header {
    padding: 30px 20px;
    margin-bottom: 30px;
  }
  
  .page-title {
    font-size: 2rem;
  }
  
  .page-description {
    font-size: 1rem;
  }
  
  .device-grid {
    grid-template-columns: 1fr;
    gap: 20px;
  }
  
  .device-card {
    padding: 20px;
  }
}

@media (max-width: 480px) {
  .device-overview-container {
    padding: 10px;
  }
  
  .device-overview-header {
    padding: 25px 15px;
  }
  
  .page-title {
    font-size: 1.8rem;
  }
  
  .device-title {
    font-size: 1.2rem;
  }
}
</style>

