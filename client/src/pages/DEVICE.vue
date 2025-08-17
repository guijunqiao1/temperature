<template>
  <div class="device-container" v-show="Pinia.Action_sign">
    <!-- 上半部分 -->
    <div class="device-header">
      <!-- 设备查询下拉框--动态对a_length获取用于进行当前应当展现内容的判断 -->
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
        {{ Pinia.signzhi }}
      </div>
    </div>

    <!-- 表格部分 -->
    <div class="device-table-section">
      <h2 class="section-title">设备信息表</h2>
      <div class="table-container">
        <table class="device-table">
          <thead class="table-header">
            <tr>
              <th>地点</th>
              <th>设备名称</th>
              <th>注释</th>
              <th>创建时间</th>
            </tr>
          </thead>
          <tbody class="table-body">
            <!-- 遍历的是设备数组的内容 -->
            <tr v-for="item in device_array" :key="item.id" class="table-row">
              <td>{{ item[3] }}</td>
              <td>{{ item[0] }}</td>
              <td>{{ item[1] }}</td>
              <td>{{ moment(item[2]).format('YYYY-MM-DD HH:mm:ss') }}</td>
            </tr>
          </tbody>
        </table>
      </div>
    </div>
  </div>
</template>

<script name="Device" setup lang="ts">
import { onMounted, ref } from "vue";
import { defineProps } from "vue";
import { useRouter } from 'vue-router';
import axios from "axios";
//格式化时间变量(数据库中的datetime类型)的包
import moment from "moment";
import { ArrowDown } from '@element-plus/icons-vue'
import { onUpdated } from "vue";
import { useUserStore } from "../store/curt";
const Pinia = useUserStore();

let device_array = ref();//存放被d_no筛选后的数组
let type_array = ref(Pinia.type_array);//存放设备列表展示内容的数组
//定义全局数据库内容对象，用于响应式重渲染的设计
const databases_array = ref();//需要注意的是响应式数据只会通过在程序中的改变进行前端的内容的响应式修改，而不会因为本身赋值依据的改变导致本身的动态的改变，需要明确的赋值才会发生改变
//此处为刚开始点击进入到t_device组件中进行呈现的根据表格信息的获取--立即执行函数发送获取数据库信息的请求

//分页相关数据
let signzhi: any = ref(Pinia.signzhi);//用于存放当前选中的设备的设备编号
let a_length = ref();//用于存储type_array的长度的变量
let update_one = 0;//用于控制update函数中执行编辑的只能是一次
let change_ok = 0;//用于标记是否为点击后的状态

const router = useRouter();


//方法
let change = (value, value1) => { };//设备列表的方法
let update = () => { };

//对父组件中传递过来的变量进行呈现,测试
const Props = defineProps({//需要注意使用该方法进行变量的接受可以不提前进行响应式定义(ref())但是必须在属性中声明类型
  select_sign: Object,
  table_sign: Object
})
console.log("select_sign:" + Props.select_sign);
if (Props.select_sign) {
  console.log("select_sign.value:" + Props.select_sign.value);
}
console.log("table_sign:" + Props.table_sign);
if (Props.table_sign) {
  console.log("table_sign.value:" + Props.table_sign.value);
}


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

//机房修改函数
function change_jifang(value){
  //全局变量修改
  Pinia.change(value);
  //当前页面的重置(携带上Pinia.signzhi)
  //页面重置,先跳到一个空路由，再跳回来
  router.replace('/empty').then(() => {
    router.replace('/DEVICE');
  })
}



// 更新函数--不需要分页的情况下的总内容呈现的方法
update = async () => {
  const result = await axios.get(`/api/DEVICE?d_no=${Pinia.signzhi}`);//获取到总内容用于type_array进行更新
  //上述为前端发送请求的示例内容
  databases_array.value = result.data;
  //得到type_array
  a_length.value = type_array.value.length;
  //得到device_array
  const result2 = await axios.get(`/api/DEVICE?d_no=${Pinia.signzhi}`);//获取到总分页内容--d_no筛选后的
  device_array.value = result2.data;
  //每执行一次update函数都对实际的文本的内容进行一次更新
  if (update_one === 0) {
    //对初始文本进行编辑
    const text = document.querySelector(".el-button.el-button--primary.el-tooltip__trigger>span") as HTMLElement;
    text.innerText = `${Pinia.signzhi}`;//需要注意的是当标签中的Content中包含文本加上标签时，DOM操作获取到后的innerHTML以及innerText分别对应全部内容、文本内容
    update_one++;
  }
}

// 主动调用一次update1
update();

//在onMounted方法中定义add_td方法便于后续使用DOM进行tbody标签中的tr、td标签的创建以及添加操作
onMounted(async () => {


});




</script>

<style scoped>
/* 设置了scoped则当前组件固定按照当前的style规则进行样式呈现,否则可能出现全局样式的一系列问题导致当前组件的样式无法正常呈现 */
* {
  text-decoration: none;
  color: black;
}

div.gray {
  background-color: gray;
  /* 开启弹性盒模型的布局对内容进行居中处理 */
  display: flex;
  align-items: center;
  justify-content: center;
}

.device-container {
  width: 100%;
  min-height: 100vh;
  padding: 30px;
  background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
  font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
}

/* 对输入框和选择框进行样式设计 */
button.Big {
  box-sizing: border-box;
  width: 127.2px;
  height: 20px;
  border: 0;
  border: 1px solid rgb(118, 118, 118);
  border-radius: 0;
  margin-left: 5px;
  font-size: 14px;
  /* 此处的font-size不仅可以设置input中placeholder中的字体大小同时还能设置上主动输入的内容的大小 */
}

/* 确保输入框在被选中时保持一致 */
input:focus,
select:focus {
  outline: none;
  /* 设置被选中的时候的input的样式发生改变,outline属性本意用于控制主题的类型，并且默认值为auto */
}

/* 上述需要注意的是input输入框和select输入框前者默认的box-sizing为contnet-box;后者为border-box */

button.Big {
  width: 25px;
  margin-left: 0;
}

.device-header {
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

.top_part>input:nth-child(3) {
  border-right: 0;
}

button.Big::before {
  content: "\e608";
}

.Big:hover,
.search:hover,
.delete:hover,
.add:hover,
a:hover {
  cursor: pointer;
}

/* 对表格进行样式设计 */
table {
  border-top: 5px solid gray;
  width: 100%;
  /* 需要注意的是此处不能设置固定的table的高度否则则会导致其中只有一个tr的情况下会占据整个tbody的高度 */
  border-spacing: 0;
  /* 下方设置使得table标签变得其中的th、td标签不会随着内容的变化而发生变化 */
  table-layout: fixed;
}

table>thead,
table>tbody {
  min-height: 0;
  width: 100%;
  height: 40px;
  background-color: #cecece;
}

table thead>tr,
table tbody>tr {
  width: 100%;
  height: 40px;
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
  margin-top: 51px;
  text-align: center;
  position: absolute;
  top: 595px;
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
  left: 290px;
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
  left: 118px;
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
  left: 240px;
}

.se_re:hover {
  cursor: pointer;
}

/* 为only盒子进行单独的样式设计 */
.only {
  position: absolute;
  left: 250px;
  width: 200px;
  height: 32px;
  font-size: 14px;
  text-align: center;
  line-height: 32px;
}

.only:hover {
  cursor: pointer;
}

/* 为时间选择器进行样式设计 */
.block {
  text-align: center;
  border-right: solid 1px var(--el-border-color);
  flex: 1;
  margin-left: 350px;
  display: inline-block;
}


/* 为屏蔽器进行样式设计 */
.select_checkbox {
  position: relative;
  left: 100px
}

.time_checkbox {
  position: relative;
  left: 400px;
}

.table_checkbox {
  width: 1086px !important;
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
</style>

<!-- 对于上述样式设计需要注意的是width:100%这种写法是针对进行嵌套后的父元素的100% -->
<!-- 同时需要注意的是在thead设置了固定的值，但是后续的th的样式设计如果过大同样会导致thead被撑大(因为thead默认overflow为visible) -->