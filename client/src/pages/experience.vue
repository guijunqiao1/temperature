  <template> 
    <div class="containerxxx">
      <h1 class="h1_one">实时监控</h1>
      <canvas id="videoCanvas"></canvas>
      <button class="function">检测</button>

      <h1 class="h1_two">检测结果：</h1>
      <div class="result">
        检测时间:{{ moment(time).format('YYYY-MM-DD HH:mm:ss') }}
        <div class="container_child">
          <div class="img1">
            原图片：
            <img :src="src1" alt="图片1">
          </div>
          <div class="img2">
            检测结果图片:
            <img :src="src2" alt="图片2">
          </div>
        </div>
      </div>
    </div>


  </template>

  <script setup lang="ts">
    import { onMounted} from "vue";
    import { ref } from "vue";
    import { useUserStore } from "../store/curt";
    import axios from "axios";
    import moment from "moment";
    
    const Pinia = useUserStore();

    //定义响应式资源变量
    const src1 = ref();
    const src2 = ref();
    const time = ref();

    //定义检测方法
    async function jiance(value){
      const canvas = document.getElementById('videoCanvas') as HTMLCanvasElement;
      const ctx = canvas.getContext('2d');
      // 从 Canvas 获取图像数据，转为 base64 编码的图片数据
      const imageData = canvas.toDataURL('image/jpeg');

      //发出检测请求
      const result = await axios.post('http://localhost:3000/api/upload', {
        image: imageData,  // 发送 Base64 编码的图像
      });
      //存到数据库中--原图和结果图
      const result_insert = await axios.post('/api/insert_img',{
        image: [ImageData,result.data],
        d_no: Pinia.signzhi
      })
      //获取库中最新记录
      const result_newest = await axios.get(`/api/recent/img?d_no=${Pinia.signzhi}`);
      //实时更新图片内容--在当前机房的情况下
      src1.value = "../../public/" + result_newest.data.field1;
      src2.value = "../../public/" + result_newest.data.field2;
      //实时更新最新检测时间
      time.value = result_newest.data.c_time;//最后元素规定为时间值的情况
    }

    onMounted(async()=>{
      // 画布初始化监控内容
      const canvas = document.getElementById('videoCanvas');
      const ctx = canvas.getContext('2d');
      const socket = new WebSocket('ws://localhost:3000');  // 连接到 WebSocket 服务器
      socket.onmessage = (event) => {
        const img = new Image();
        img.src = URL.createObjectURL(event.data);
        img.onload = () => {
          const canvasWidth = canvas.width;
          const canvasHeight = canvas.height;

          // 启用高质量的图像缩放
          ctx.imageSmoothingEnabled = true;
          ctx.imageSmoothingQuality = 'high';


          const scale = Math.min(canvasWidth / img.width, canvasHeight / img.height);
          const width = img.width * scale;
          const height = img.height * scale;

          ctx.clearRect(0, 0, canvasWidth, canvasHeight);  // 清空画布
          ctx.drawImage(img, 0, 0, width, height);  // 绘制图像
        };
      };

      //初始化对照资源src1、src2、time
      //获取库中最新记录
      const result_newest = await axios.get(`/api/recent/img?d_no=${Pinia.signzhi}`);
      //实时更新图片内容--在当前机房的情况下
      src1.value = "../../public/" + result_newest.data.field1;
      src2.value = "../../public/" + result_newest.data.field2;
      console.log("src1:"+src1.value);
      console.log("src2:"+src2.value);
      //实时更新最新检测时间
      time.value = result_newest.data.c_time;//最后元素规定为时间值的情况
    })


  </script>


<style scoped>
#videoCanvas{
  width: 80%;
  height: auto;
  max-width: 80%;
  max-height: 80%;
}
.containerxxx {
  width: 100%;
  height: 100%;
  display: flex;
  flex-direction: column;
}
.h1_one {
  margin-left: 44%;
}
.function {
  font-size: 14px;
  margin-top: 50px;
  margin-left: 30%;
  width:30%;
  background-color: yellow;
}
.function:hover {
  cursor:pointer;
  box-shadow: 1px 1px 1px 1px black;
}

.container_child {
  width: 100%;
  display: flex;
  flex-direction: row;
  justify-content: space-around;
}
/* 控制图片大小 */
.img1>img,
.img2>img {
  margin-top: 50px;
  width: 200px;
  height: 150px;
  max-width: 200px;
  max-height: 150px;
}
</style>