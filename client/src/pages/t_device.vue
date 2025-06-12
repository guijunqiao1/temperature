<template>
  <div class="content1" v-show="Pinia.Device_sign">
    <!-- 上半部分 -->
    <div class="top_part">

      <!-- 设备查询下拉框--动态对a_length获取用于进行当前应当展现内容的判断 -->
      <el-dropdown v-show="Pinia.device_sign">
        <!-- 当前框只在保底一个的情况下才出现 -->
        <el-button type="primary" v-show="a_length > 1">
          设备<el-icon class="el-icon--right"><arrow-down /></el-icon>
        </el-button>
        <template #dropdown>
          <el-dropdown-menu>
            <div>
              <div class="device_list" v-for="item in type_array" :key="item[0]">
                <el-dropdown-item>
                  <div style="border-radius: 5px;" @click="change(item, $event)">设备编号为{{ item[0] }}的数据统计</div>
                </el-dropdown-item>
              </div>
            </div>
          </el-dropdown-menu>
        </template>
      </el-dropdown>
      <!-- 当检查得到的数组的长度为1的时候进行当前的div的呈现 -->
      <div class="only" style="border-radius: 5px;background-color: #409eff;" v-if="a_length <= 1"
        v-show="Pinia.device_sign">
        查看设备编号为{{ signzhi }}的数据统计</div>
    </div>

    <!-- 表格部分 -->
    <div class="bottom_part">
      <table>
        <thead>
          <tr>
            <th>设备名称</th>
            <th>注释</th>
            <th>创建时间</th>
            <th>设备编号</th>
          </tr>
        </thead>
        <tbody>
          <!-- 遍历的是设备数组的内容 -->
          <tr v-for="item in device_array" :key="item.id">
            <td>{{ item.device_name }}</td>
            <td>{{ item.remarks }}</td>
            <td>{{ moment(item.ctime).format('YYYY-MM-DD HH:mm:ss') }}</td>
            <td>{{ item.number }}</td>
          </tr>
        </tbody>
      </table>
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
  let change = (value, value1) => { };//设备列表的方法

  const defaultTime1 = [new Date(2000, 1, 1, 12, 0), new Date(2000, 1, 1, 12, 0, 0)]; // '12:00:00'


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

  // 更新函数--不需要分页的情况下的总内容呈现的方法
  function update() {
    console.log("result_all:" + result_all);
    xuanran(result_all.data);
  }

  //全局请求存储变量
  let result_all;
  (async function () {
    result_all = await axios.get(`/api/t_device`);//获取到总内容用于type_array进行更新
    // 主动调用一次update1
    update();
  })()

  //重渲染函数--和update的区别在于是否重置时间
  async function xuanran(value) {
    console.log("device_array:");
    console.dir(value);
    databases_array.value = value;
    //得到type_array
    type_array.value = qu_repeate(databases_array.value);
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
    if (update_one === 0) {
      //对初始文本进行编辑
      const text = document.querySelector(".el-button.el-button--primary.el-tooltip__trigger>span") as HTMLElement;
      if (type_array.value[0] && type_array.value[0][0]) {
        text.innerText = `设备编号为${type_array.value[0][0]}的信息`;//需要注意的是当标签中的Content中包含文本加上标签时，DOM操作获取到后的innerHTML以及innerText分别对应全部内容、文本内容
        update_one++;
      }
    }
  }

  //在onMounted方法中定义add_td方法便于后续使用DOM进行tbody标签中的tr、td标签的创建以及添加操作
  onMounted(async () => {
    //用于修改signzhi的change函数的赋值
    change = async (value, value1) => {
      change_ok++;//标记为点击change后的状态
      //首先进行signzhi的重置--对当前指向的d_no标签进行获取，需要在遍历type_array的阶段的时候将每个标签对象进行标记，并且此处就可以直接对该对象进行获取
      signzhi.value = value[0];//需要注意的是value位置为item，则直接使用[0]访问d_no即可
      console.log("change:" + signzhi.value);
      update();

      //点击了设备按钮之后对样式进行修改
      //对所有内容进行统一的设计
      if (a_length.value > 1) {
        const option_array: any = document.querySelectorAll(".device_list");
        option_array.forEach(item => {
          item.children[0].style.color = "black";
          item.children[0].style.backgroundColor = "white";
        })
        value1.target.parentNode.style.color = "#409eff";
        value1.target.parentNode.style.backgroundColor = "skyblue";
      }
      else { }


      //对初始文本进行编辑
      const text = document.querySelector(".el-button.el-button--primary.el-tooltip__trigger>span") as HTMLElement;
      text.innerText = `设备编号为${value[0]}的信息`;//需要注意的是当标签中的Content中包含文本加上标签时，DOM操作获取到后的innerHTML以及innerText分别对应全部内容、文本内容
    }
  });


  let cc = 0;
  onUpdated(() => {//每一次响应式数据发生修改都会执行
    //进行第一个默认样式的添加
    if (cc === 0) {//当为第一次打开页面的时候
      if (a_length.value > 1) {
        console.log(1);
        const father: any = document.querySelectorAll(".device_list");
        father[0].children[0].style.color = "#409eff";
        father[0].children[0].style.backgroundColor = "skyblue";
        console.log(father);
        cc++;//放置后续挂载阶段对内容进行多次的第一个元素上色
      }
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
  border-left: 18px solid gray;
  margin-left: 0 !important;
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
  height: 43px;
  background-color: gray;
  /* 垂直方向上子元素靠齐侧轴的起点位置(也就是子标签的顶部对齐) */
  display: flex;
  justify-content: center;
  align-items: center;
  border-bottom: 3px solid black;
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

