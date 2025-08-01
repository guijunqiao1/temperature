<template>
  <div class="content1" v-show="Pinia.Device_sign">
    <div class="device_container">
      <div class="device_item" v-for="item in type_array" >
        <div>机房编号为：{{ item[1] }}的机房</div>
        <RouterLink to="/New" @click="change(item[0])"><img src="../../public/jifang.webp" /></RouterLink>
        <!-- <a @click="change(item[1])" href="http://localhost:5173/New"></a> -->
      </div>
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
  });
</script>

<style scoped>
/* 设置了scoped则当前组件固定按照当前的style规则进行样式呈现,否则可能出现全局样式的一系列问题导致当前组件的样式无法正常呈现 */
* {
  text-decoration: none;
  color: black;
}

/* 控制机房盒子样式 */
.device_container{
  width: 1200px;
  height:100%;
  display: flex;
  flex-direction: row;  
  overflow: hidden;
  justify-content: space-evenly;
}
img {
  width: 100%;
  height: 100%;
  object-fit: contain; /* ✅ 等比例缩放，不裁剪 */
  display: block;
}
.device_container>.device_item {
  height:200px;
}
.device_container>.device_item>div {
  font-size: 21px;
  text-align: center;
  font-weight: 400; 
}
</style>

