<template>
  <!-- 顶部导航 -->
  <div class="nav_top">
    <div class="ren">桂军桥的项目</div>
    <div class="aler" @click="aler" style="cursor:pointer">#</div>
    <div class="getnew" @click="getnew" style="cursor:pointer">@</div>
    <span ref="add" class="add">主页</span>
    <!-- 下方标签专门用于向后端发送请求，并且后端的router文件夹中的route.js文件提前设置好对应的路由，主页面为当前App.vue文件所搭载的内容，
    而路由发生跳转的文件为后端的view中的.ejs文件临时渲染的内容 -->
    <a href="#" class="register_outer"><img src="../public/ok2.png" alt="" class="register_inner"></a>
  </div>
  <!-- 底部主区域 -->
  <div class="content">
    <!-- 侧边栏 -->
    <!-- 下方对于没有多余的pages页面用于呈现的路由部分统一设置为/home主页面的路由 -->
    <div class="left">
      <el-row class="tac">
        <el-col>
          <el-menu active-text-color="#ffd04b" background-color="#545c64" class="el-menu-vertical-demo"
            default-active="2" text-color="#fff">
            <!-- 下方的3、4个el-menu-item标签的路由路径设置为首页(因为要求中只提供了2个路径条件：/t_device、/t-error-msg) -->
            <el-menu-item index="1-1">
              <RouterLink to="/t_Container" @click="add2($event)"> 储运箱及物品信息
              </RouterLink>
            </el-menu-item>
            <!-- 此处需要注意的是使用了div包裹原先的el-menu-item组件标签中的内容实现整体内容发生插槽优化后的div嵌套原先内容的效果的实现，
            这么做的好处是原先针对这个el-menu-item组件标签而言无法直接对标签进行事件的绑定后的$event进行准确的获取，但是通过这种嵌套的
            方式则能在传递参数的时候的$event进行明确的事件对象进行获取--补充：对于原生事件而言$event一般获取到的是事件对象(针对普通标签，而非组件标签) -->
            <el-menu-item index="1-2">
              <RouterLink to="/New" @click="add2($event)">
                实时数据
              </RouterLink>
            </el-menu-item>
            <el-menu-item index="1-3">
              <RouterLink to="/History" @click="add2($event)"> 历史数据</RouterLink>
            </el-menu-item>
            <el-menu-item index="1-4">
              <RouterLink to="/t_error_msg" @click="add2($event)"> 错误内容
              </RouterLink>
            </el-menu-item>
            <el-menu-item index="1-5">
              <RouterLink to="/t_Control" @click="add2($event)"> 指令控制台</RouterLink>
            </el-menu-item>
            <el-menu-item index="1-6">
              <RouterLink to="/ex" @click="add2($event)"> 试验台</RouterLink>
            </el-menu-item>
          </el-menu>
        </el-col>
      </el-row>
    </div>
    <div class="nothing2"></div>
    <!-- 内容区--第一个container标签用于将整体的位置控制在div.left标签的右方(需要占用display)，第二个则设置内容区域的布局(需要占用display) -->
    <!-- 同时需要注意的是，如果需要将多个元素共行，则必须同时满足都不是块级元素的性质 -->
    <div class="container1">
      <div class="nothing"></div>
      <div class="container2">
        <!-- 需要注意：Router-Link\RouterView的通信结构中后者被当做所有子组件的复合体,需要注意子组件中暴露的变量名不可重名 -->
        <RouterView class="fit-view"></RouterView>
      </div>
      <!-- 此处需要注意的是对.fit-view进行样式设计的本质为对RouterView子组件标签中的最靠近template标签的那个标签进行样式设计的 -->
    </div>
  </div>
</template>

<script lang="ts" setup>
import { RouterView, RouterLink } from "vue-router";
import { ref } from "vue";
import { onMounted } from 'vue';
//使用vue中的路由进行类似a标签功能的RouteLink标签以及RouteView标签的使用(需要对to属性进行理解性的设置以及对路由器进行动态的引入并在
//main.ts文件中配置上盖路由器并且挂载到当前App文件对象(应用对象)身上)


//接收从Control子组件中传递过来的响应式变量
// select_sign;
// input_sign;
// image_sign;
// change_sign;
// table_sign;
// time_sign;

//数据
const add = ref();

//定义add1变量存储一个空方法，由于是let定义的变量则能够进行正常的函数内容的重写，若为function定义的函数则直接提升变量到模版中直接进行使用而无法进行重写完成标签内容的修改
let add1 = (value) => { };
let add2 = (value) => { };
let change = (value) => { };

//方法
// 重置页面方法
function aler() {
  location.assign("/");
}
// 刷新页面方法
function getnew() {
  //刷新页面
  location.reload();
}
//用于检测字符串中有多少指定字符的个数方法
function numbers(value1, value2) {
  let sum = 0;
  for (let i = 0; value1[i]; i++) {
    if (value1[i] === value2) sum++;
  }
  return sum;
}
//用于将原先字符串中的首字符进行删除并将后续字符串进行返回的方法
function new_string(string) {
  let New = "";
  for (let i = 1; string[i]; i++) {
    New += string[i];
  }
  return New;//注意js中支持将整个字符串(数组进行直接的返回)
}

//首先对生命周期钩子之间的关系以及一些注意事项进行归纳：
//首先要知道，整个生命周期(针对vue3而言)钩子，在实际执行的时候本质上都是在setup创建组件这个生命周期钩子中作为回调执行的，
//这样就会导致在setup这个层级能够正常和模版(template标签的范围中)的内容进行信息交流的功能的实现，而setup语法糖中的其他的
//生命周期钩子中则无法和模版的内容进行信息交流：比如在setup中执行的const title = ref()能够正常获取到标签对象，而在setup中的
//onMounted中执行的const title = ref()则无法获取到对象--本质还是作用域的问题

onMounted(async () => {//此处在setup中设置onMounted()的回调
  add1 = (value) => {//和setup中的方法进行对应，同样是typescript中的语法
    // 向显示栏目中动态添加修改内容
    //当仅有首页层级的时候
    if (value.target.innerHTML)
      add.value.innerHTML = `主页 / ${new_string(value.target.innerHTML)}`;
  }
  add2 = (value) => {
    if (value.target.innerHTML) {
      add.value.innerHTML = `主页 / ${new_string(value.target.innerHTML)}`;
    }
  }
  //此处需要对整个script标签使用setup语法糖以及正常的setup钩子的含义进行解析：
  //首先本身setup方法本身的含义就是组件创建的时候立即执行的方法(也就是程序的入口)，所以在这个方法的内容进行
  //其他生命周期方法的使用是合理的，并且需要注意的是function定义函数的方式以及其他的变量的定义方式(包括返回方式)
  //针对整个组合式API的语法而言--那么如何确定当前的脚本标签所处的环境正是组合式API的环境呢，首先本身当前的vue项目在创建的时候
  //就已经决定是vue2的选项式API还是vue3的组合式API了(前者使用vue-cil创建、后者使用vite进行创建),并且同时也可以通过使用
  //setup方法的位置进行确定(使用了方法或者该方法对应的语法糖都表明当前属于组合式API环境);从而表明在setup生命周期钩子中
  //引用的onMounted()方法的函数体内容也应该是组合式API的写法,由上述可以得出对于在setup中定义的onMOUnted()方法中定义的函数
  //的函数体内容中如果有console.log(title.value)则可以正常将值进行输出(因为本质上该内容对象(title = ref())在获取的时候所处
  //的环境是onMounted()方法中)



});


//注意Vue中通过ref方法获取到对象应该发生在挂载完毕组件(所谓组件也就是template整体所呈现出来的内容)之后，所以也应当书写在
//onMounted方法之中或者之后，否则即使页面成功加载或者成功挂载，但是由于函数被定义的位置仍然是出于挂载之前的环境，则导致标签
//对象获取失败,但是即使获取失败，由于编译的特性，所以在对象中是仍然有着Proxy对象的信息，以及单纯的value指向的标签对象的名称
//，但是该对象的具体信息是无法通过这种方式明确获取到的
</script>

<style>
/* 上部导航栏样式 */
.nav_top {
  /* 此处需要注意的是开启fixed布局并不会脱离标准文档流 */
  position: fixed;
  /* 此处开启了fixed定位可被其中的子元素作为包含块进行绝对定位 */
  top: 0px;
  width: 100%;
  background-color: #317C77;
  height: 40px;
  display: flex;
  align-items: center;
  z-index: 2;
}

.nav_top>div {
  font-size: 17px;
  color: white;
  position: relative;
  /* left:12px; */
}

.nav_top .ren {
  font-weight: 800;
  position: relative;
  left: 40px;
}

.nav_top .aler {
  position: relative;
  left: 60px;
}

.nav_top .getnew {
  position: relative;
  left: 80px;
  bottom: 2px;
}

.nav_top>span {
  font-size: 10px;
  color: white;
  position: relative;
  left: 100px;
}

/* 侧边栏导航样式*/
.content>.left {
  display: inline-block;
  width: 151.15px;
  /* 显式地指定子元素的布局方式为垂直方向排布(block标签的默认排列方式) */
  vertical-align: top;
}

.content .el-col,
.content .el-col-12 {
  width: 151.15px;
}

/* 设置被选中的侧边导航栏中的元素的呈现的颜色 */
.el-menu-item.is-active {
  color: white;
  background-color: rgb(64, 203, 157);
}

/* 覆盖掉RouterLink标签的默认样式,需要注意是选择器选中的应该是发生转化后的标签对象 */
li.el-menu-item>a {
  text-decoration: none;
  color: white;
}

/* 将RouterView标签中呈现的内容的位置进行样式设计 */
.container1 {
  /* 此处需要注意的是在top_nav中使用width:100%的方式将视口的宽度用于提供给自身元素的方式会将原先的div#app标签进行不完全的撑开，
    并且需要注意的是.content标签的宽度容量是依据div#app的 */
  width: 1104.33px;
  display: inline-block;
  position: relative;
  height: 646px;
}

.container2 {
  width: 100%;
  height: 100%;
  display: flex;
  align-items: center;
  justify-content: center;
  /* 开启相对定位，用于后续的container的绝对定位的设置 */
  position: relative;
}

/* 需要注意的是样式中进行属性的赋值的时候如果需要使用连串的方式进行值的赋取必须使用特殊的表达式进行操作，而不能像：width:100vw - 40px;这样 */

/* 父元素容器清除浮动 */
.content {
  width: 100%;
  position: relative;
  top: 40px;
  clear: both;
  display: flex;
  justify-content: start;
}

/* 将正常溢出的文本中自动添加的滚动条进行撤销--原先这种自动添加的滚动条属于html中的滚动条，并且进行实际滚动的时候实际产生效果也仅发生在RouterView中 */

/*防止出现多余的滚动条*/
/* 确保页面整体的容器可以滚动-- */
html,
body {
  overflow: visible;
  margin: 0;
}

/* div.container {
    overflow: hidden;
  } */
div.nothing {
  width: 1204.33px;
  height: 7.19px;
  background-color: gray;
  position: relative;
  /* left:16px; */
  /* 自身在原先的基础上进行向上位移 */
}

.nothing2 {
  display: inline-block;
  width: 18px !important;
  /* 防止当前使用!important关键字设置的width被flex压缩 ,此处可得出结论flex布局的优先级大于被指定的!important的内容*/
  flex-shrink: 0;
  height: 653px;
  background-color: gray;
}

/* 将标签自带的右白色边框进行删除 */
.el-menu.el-menu--vertical.el-menu-vertical-demo {
  border: 0;
}

/* 对标签的内以及外进行样式设计 */
.register_outer,
.register_inner {
  height: 25px;
}

/* 需要注意的是在一个父容器被postuon:relative进行定位的时候，其中的子元素被同步进行定位 */
.register_outer {
  position: absolute;
  right: 100px;
}

/* 为列表中的内容进行标签进行居中设计 */
.el-menu-item {
  display: flex !important;
  justify-content: center;
}

/* 为错误表中的时间选择器布局  */
.error_date_time>.el-date-editor.el-date-editor--datetimerange.el-input__wrapper.el-range-editor.el-tooltip__trigger.el-tooltip__trigger {
  height: 24px !important;
}
</style>

<!-- 
提前配置好后端的package.json中的start的内容(node->nodemon)以及启动的type:module(和script同级),并且替换www.js中的require为import.
以及app.js文件中的require()为import
同时index.js中的数据库执行语句需要使用await进行异步处理
目前一个项目需要经历的过程有：使用Vue3项目文件夹快速创建(桌面工作目录下执行代码)的工具进行前端部分的内容的框架搭建，并且在创建的文件夹中创建前端，
并且在当前文件夹下执行npm i 先搭建node_modules框架并且之后下载上express框架，并且在当前文件作为工作目录的情况下执行express快速搭建Node应用对象
文件夹并且整体应当放置在后端文件夹中，并且在后端、前端文件夹中执行npm i (需要注意的是npm i 一键下载的package.json文件中记录的依赖)命令用于共同创建
node_modules文件夹(前端中需要提前下载好vue组件)，并且将原先位于外层文件夹中的vue框架文件全部转移到前端文件夹中，最终对应在前端文件夹中yarn add element-plus
等等，并且要注意Node.js的版本和Vue3本身的匹配的问题，需要20.8.0版本才能正常进行联系，否则别的版本会·在运行npm run dev指令时发生vite的隐藏错误；
同时还需要下载好vue-router包(用于RouterView、RouterLink标签的引入--前端路由组件);并且需要注意的是执行npm run dev、命令之前需要将所有主程序联
系上的vue文件中都提前构建好template、script、style标签框架,否则运行时报错;同时需要注意通过使用express -e的快速生成的后端的index.js文件中的应用对
象的创建语句并不是什么const route = express.Route()而是单纯的const route = express();同时还需要注意的是路由内容设计的时候res.send/res.end
中的内容只能为字符串否则无法在正常的npm run start语句中运行;同时还需要注意的是在www文件中const port = normalizePort(process.env.PORT || '(number)')中的number
设计为当前服务开启的端口号(并不是本地的端口号，本地默认固定为80)的设置;同时注意在app.js文件中的app.use('/', Router);语句的形参中第一个形参为进行url访问第二个路由器对象的时候的自动添加上的路由的内容--添加到了index.js文件中的路由匹配过程之前，
同时还需要注意在index.js文件中设置上的路由中的第一个形参路径为默认添加上了app.use()中的第一个形参作为目录的路由路径;
同时还需要注意的是在原先的index.js文本中调用对应的数据库连接函数(Config)的时候，由于本身为异步的函数，故需要立即执行函数
的格式对async语句以及await语句对Config函数进行封装;同时在indexNode.js文件中;同时需要注意的若对mysql对象调用的createConnection方法中的password键值对的值信息错误
则表明连接上的mysql数据库密码错误，则会导致数据库连接失败;同时配置数据库处理前的注意事项：
1、在package.json文件中添加上"type"："module"这一配置项
2、首先进行www.js文件名后缀的配置、进行原先www文件中的require()语句的被替换为import语句的操作，其余需要修改引入方式和暴露方式的文件有：index.js文件中的require以及index.js文件中的export default的修改，注意路由对象的暴露方式修改了则在app.js文件中进行路由器的导入则需要进行import 进行引入(由于为defalut)则不适用{};
3、在修改为import引入之后的app.js文件中的引入的path无法提供像require()引入的时候集成的__dirname属性，则在迎合app.js原生代码的层面则需要在当前app.js中添加上
4、配置__dirname属性的源程序：
import { fileURLToPath } from 'url';
const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);
在进行前端路由组件设计过程中还需要在vite.config.ts文件中添加上：
optimizeDeps: {
    exclude: ['send', 'etag', 'destroy', 'mime'] // 排除这些服务器端模块
  }这一配置项同时还需要添加上：
  alias: {
      '@': fileURLToPath(new URL('./src', import.meta.url)),
      fs: 'path-to-empty-module'
    },中fs模块的解释

同时还需要注意的是每次在前端进行对应请求发送的时候通过result变量内容(存储的是axiosResponse对象)进行不同情况的前端内容的设计--
具体根据后端的实际情况然后返回的该值进行综合的含义判断即可
同时还需要注意的是每次进行前端样式设计的时候需要提前将html、body标签的默认样式进行去除操作

在前后端代码整合阶段需要解决跨域请求问题：
1、首先向vite.config.ts文件中添加上：
server: {
    proxy: {
      '/api': {  // 所有 /api 开头的请求都会被代理
        target: 'http://127.0.0.1:9000',
        changeOrigin: true,
        rewrite: (path) => path.replace(/^\/api/, '') // 将 /api 前缀删除
      }
    }
键值对;
2、在前端中进行跨域请求发送的位置替换为：
前置为：
  // 定义状态变量
  const loading = ref(false);  // 添加 loading 状态
  const error = ref<string | null>(null);  // 添加 error 状态
  const databases_array = ref<DeviceItem[]>([]);
const fetchDeviceData = async () => {
  loading.value = true;
  error.value = null;
  
  try {
    // 注意这里必须加上 /api 前缀
    const result = await axios.get('/api/t_device/first');
   	//上述为前端发送请求的示例内容
  } catch (err) {
	//错误内容执行
  } finally {
    loading.value = false;
  }
};
的格式
-->


<!-- 需要注意的是整个vue项目最终的body、html标签都是在index.html文件中的body、html，并且针对在index.html文件中被main.ts文件中 
使用其它方式进行挂载组件的方式并不会将组件的style、script内容进行代入到当前index.html文件的操作、而在vue文件(组件文件)中则能够互相进行
代入(比如我们这个项目中的App.vue和t_device.vue、t_error_msg.vue文件则是后两者向前者直接进行挂载)，之所以会这样则需要注意的是vue文件
之间的引用方式以及index.html文件和vue文件之间的引用的方式之间的差异，前者为正常的标签中使用RouterLink标签和Router中提前设置好的其它vue文件
的路由进行直接的引入进行内容的直接添加(所以一般来说都是在代码层面的style是会相互影响的，则一般每个组件文件中都使用scoped关键字对当前的style进行封装),
而后者则是在index.html中直接使用script脚本标签对App.vue内容进行引入，仅为组件交互操作之后呈现的内容的渲染，并没有直接的style的引入 -->