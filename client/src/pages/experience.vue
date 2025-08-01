  <template> 
    <div class="containerxxx">
      <h1 class="h1_one">实时监控</h1>
      <img id="videoCanvas" :src="src0" alt="实时视频"></img> 
      <button class="function" @click="jiance">检测</button>

      <h1 class="h1_two">检测结果：</h1>
      <div class="result">
        检测时间:{{ moment(time).format('YYYY-MM-DD HH:mm:ss') }}
        <div class="result_person">实际检测结果:{{ REF==='1'?'有人':'没人' }}</div>
        <div class="confidence_person">可信度:{{ REF_confidence }}</div>
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
    const src0 = ref();
    const src1 = ref();
    const src2 = ref();
    const REF = ref();
    const REF_confidence = ref();
    const time = ref();
    const result_person = ref();

    //定义检测方法
    async function jiance(value){
      console.log("触发检测事件");
      let waibu;
      if(Pinia.signzhi==='机房1'){
        waibu = "0";
      }
      else if(Pinia.signzhi==='机房2'){
        waibu = "1";
      }
      else{
        waibu = "2";
      }
      //截图
      const result1 = await axios.get('http://192.168.1.102:5000/api/screenshot/'+waibu);
      console.log('最终jieguo:'+result1.data['screenshot']);
      const imageData = result1.data['screenshot'];
      //发出检测请求
      const result = await axios.post('http://192.168.1.102:5000/infer', {
        image: imageData,  // 发送 Base64 编码的图像
      });
      console.log("confidence:"+result.data['inference_results']['confidence']);
      //存到数据库中--原图和结果图
      const result_insert = await axios.post('/api/insert_img',{
        image: [imageData,result.data['processed_image']],
        d_no: Pinia.signzhi,
        person: result.data['inference_results']['class'],
        confidence: result.data['inference_results']['confidence']
      }) 
      //获取库中最新记录
      const result_newest = await axios.get(`/api/recent/img?d_no=${Pinia.signzhi}`);
      //实时更新图片内容--在当前机房的情况下
      src1.value = "../../public/" + result_newest.data.field1;
      src2.value = "../../public/" + result_newest.data.field2;
      console.log("src1:"+src1.value);
      console.log("src2:"+src2.value);
      //实时更新最新检测时间
      time.value = result_newest.data.c_time;//最后元素规定为时间值的情况
      REF.value = result_newest.data.result;
      REF_confidence.value = result_newest.data.confidence;
    }

    onMounted(async()=>{

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


.result_person {
}
</style>