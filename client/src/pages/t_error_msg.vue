<template>
  <div class="content1" v-if="Pinia.Device_sign">
    <!-- 设备选择 -->
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





    <!-- 上半部分 -->
    <div class="top_part">
      <!-- 设备表的时间选择器 -->
      <div class="error_date_time">
        <el-date-picker v-model="value1" type="datetimerange" start-placeholder="Start Date" end-placeholder="End Date"
          :default-time="defaultTime1" @change="submit" />
      </div>
    </div>


    <!-- 下半部分 -->
    <!-- 表格部分 -->
    <div class="bottom_part">
      <table>
        <thead>
          <tr>
            <th>场景</th>
            <th>错误信息</th>
            <th>出错时间</th>
          </tr>
        </thead>
        <tbody>
          <!-- 遍历的是设备数组的内容 -->
          <tr v-for="item in device_array" :key="item.id">
            <td v-show="Pinia.device_sign">{{ item[0] }}</td>
            <td>{{ item[1] }}</td>
            <td>{{ moment(item[2]).format('YYYY-MM-DD HH:mm:ss') }}</td>
          </tr>
        </tbody>
      </table>
      <!-- 分页栏部分 -->
      <div class="pagination-container">
        <el-pagination v-model:current-page="currentPage" v-model:page-size="pageSize" :total="Number(total1)"
          layout=" prev ,pager, next" />
        <!-- 上述前者用于响应式提供当前选中的页数；第二者用于设置固定的每页中应当呈现的数据；第三者用于获取到总数，则element标签会自动进行计算用于将当前应当呈现的页数；第四者为分页标签的顺序设置；最后者表示设置当前的分页的标签的整体的大小为默认大小 -->
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

const router = useRouter();
const defaultTime1 = [new Date(2000, 1, 1, 12, 0), new Date(2000, 1, 1, 12, 0, 0)]; // '12:00:00'


//方法
let update = () => { };



//专门用于更新的函数
update = async () => {//最好别在挂载阶段使用function否则容易提升到最高级导致变量未定义的隐藏错误
  if (start.value === end.value && end.value !== 1) {//单向查询
    const result = await axios.get(`/api/t_error_msg/first?d_no=${Pinia.signzhi}&start=end&end=${end.value}&currentPage=undefined&pageSize=undefined`);//获取到总内容用于type_array进行更新
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

div.content1 {
  background-color: white;
  width: 100%;
  height: 646px;
  position: relative;
  /* top:40px; */
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

.top_part {
  width: 100%;
  height: 25px;
  background-color: gray;
  /* 垂直方向上子元素靠齐侧轴的起点位置(也就是子标签的顶部对齐) */
  display: flex;
  align-items: center;
  border-bottom: 2px solid black;
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
  margin-top: 20px;
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
  left: 200px;
  top: -9px;
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
