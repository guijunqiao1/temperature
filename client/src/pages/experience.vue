  <template> 
    <div class="experience-container">
      <div class="experience-header">
        <h1 class="page-title">实时监控</h1>
        <p class="page-description">智能检测系统实时监控和人员识别</p>
      </div>
      
      <div class="video-section">
        <div class="video-container">
          <img id="videoCanvas" :src="src0" alt="实时视频" class="video-stream">
          <button class="detect-btn" @click="jiance">
            <span class="btn-icon">🔍</span>
            开始检测
          </button>
        </div>
      </div>

      <div class="results-section">
        <h2 class="section-title">检测结果</h2>
        <div class="results-content">
          <div class="result-info">
            <div class="info-item">
              <span class="info-label">检测时间:</span>
              <span class="info-value">{{ moment(time).format('YYYY-MM-DD HH:mm:ss') }}</span>
            </div>
            <div class="info-item">
              <span class="info-label">检测结果:</span>
              <span class="result-status" :class="{ 'status-person': REF==='1', 'status-no-person': REF!=='1' }">
                {{ REF==='1'?'有人':'没人' }}
              </span>
            </div>
            <div class="info-item">
              <span class="info-label">可信度:</span>
              <span class="confidence-value">{{ REF_confidence }}</span>
            </div>
          </div>
          
          <div class="images-comparison">
            <div class="image-card">
              <h3 class="image-title">原图片</h3>
              <img :src="src1" alt="原图片" class="result-image">
            </div>
            <div class="image-card">
              <h3 class="image-title">检测结果图片</h3>
              <img :src="src2" alt="检测结果图片" class="result-image">
            </div>
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
.experience-container {
  width: 100%;
  min-height: 100vh;
  padding: 30px;
  background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
  font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
}

.experience-header {
  text-align: center;
  margin-bottom: 40px;
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

.video-section {
  margin-bottom: 40px;
}

.video-container {
  text-align: center;
  background: rgba(255, 255, 255, 0.9);
  border-radius: 20px;
  padding: 30px;
  box-shadow: 0 8px 25px rgba(0, 0, 0, 0.1);
  backdrop-filter: blur(10px);
  border: 1px solid rgba(255, 255, 255, 0.2);
}

.video-stream {
  width: 80%;
  height: auto;
  max-width: 80%;
  max-height: 80%;
  border-radius: 15px;
  box-shadow: 0 8px 25px rgba(0, 0, 0, 0.1);
  margin-bottom: 30px;
}

.detect-btn {
  padding: 15px 30px;
  background: linear-gradient(135deg, #f39c12, #e67e22);
  color: white;
  border: none;
  border-radius: 25px;
  font-size: 1.1rem;
  font-weight: 600;
  cursor: pointer;
  transition: all 0.3s ease;
  box-shadow: 0 4px 15px rgba(243, 156, 18, 0.3);
  display: flex;
  align-items: center;
  gap: 10px;
  margin: 0 auto;
}

.detect-btn:hover {
  transform: translateY(-2px);
  box-shadow: 0 6px 20px rgba(243, 156, 18, 0.4);
}

.btn-icon {
  font-size: 1.2rem;
}

.results-section {
  background: rgba(255, 255, 255, 0.9);
  border-radius: 20px;
  padding: 30px;
  box-shadow: 0 8px 25px rgba(0, 0, 0, 0.1);
  backdrop-filter: blur(10px);
  border: 1px solid rgba(255, 255, 255, 0.2);
}

.section-title {
  font-size: 1.8rem;
  color: #2c3e50;
  margin-bottom: 25px;
  padding-bottom: 15px;
  border-bottom: 3px solid #3498db;
  font-weight: 700;
  text-align: center;
}

.results-content {
  display: flex;
  flex-direction: column;
  gap: 30px;
}

.result-info {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
  gap: 20px;
  padding: 20px;
  background: linear-gradient(135deg, #f8f9fa, #e9ecef);
  border-radius: 15px;
  border: 1px solid rgba(0, 0, 0, 0.05);
}

.info-item {
  display: flex;
  flex-direction: column;
  gap: 8px;
}

.info-label {
  font-size: 1rem;
  color: #666;
  font-weight: 500;
}

.info-value {
  font-size: 1.1rem;
  color: #2c3e50;
  font-weight: 600;
}

.result-status {
  padding: 8px 16px;
  border-radius: 20px;
  font-size: 1rem;
  font-weight: 600;
  text-align: center;
  text-transform: uppercase;
  letter-spacing: 0.5px;
}

.status-person {
  background: linear-gradient(135deg, #27ae60, #2ecc71);
  color: white;
}

.status-no-person {
  background: linear-gradient(135deg, #e74c3c, #c0392b);
  color: white;
}

.confidence-value {
  font-size: 1.1rem;
  color: #3498db;
  font-weight: 600;
}

.images-comparison {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
  gap: 30px;
}

.image-card {
  text-align: center;
  padding: 20px;
  background: linear-gradient(135deg, #f8f9fa, #e9ecef);
  border-radius: 15px;
  border: 1px solid rgba(0, 0, 0, 0.05);
  transition: all 0.3s ease;
}

.image-card:hover {
  transform: translateY(-5px);
  box-shadow: 0 8px 25px rgba(0, 0, 0, 0.1);
}

.image-title {
  font-size: 1.2rem;
  color: #2c3e50;
  margin-bottom: 20px;
  font-weight: 600;
}

.result-image {
  width: 100%;
  max-width: 300px;
  height: auto;
  border-radius: 10px;
  box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
  transition: all 0.3s ease;
}

.result-image:hover {
  transform: scale(1.05);
  box-shadow: 0 8px 25px rgba(0, 0, 0, 0.15);
}

/* 响应式设计 */
@media (max-width: 1200px) {
  .experience-container {
    padding: 20px;
  }
  
  .experience-header,
  .video-container,
  .results-section {
    padding: 25px;
  }
}

@media (max-width: 768px) {
  .experience-container {
    padding: 15px;
  }
  
  .experience-header {
    padding: 30px 20px;
    margin-bottom: 30px;
  }
  
  .page-title {
    font-size: 2rem;
  }
  
  .page-description {
    font-size: 1rem;
  }
  
  .video-stream {
    width: 90%;
    max-width: 90%;
  }
  
  .result-info {
    grid-template-columns: 1fr;
    gap: 15px;
  }
  
  .images-comparison {
    grid-template-columns: 1fr;
    gap: 20px;
  }
}

@media (max-width: 480px) {
  .experience-container {
    padding: 10px;
  }
  
  .experience-header,
  .video-container,
  .results-section {
    padding: 20px;
  }
  
  .page-title {
    font-size: 1.8rem;
  }
  
  .section-title {
    font-size: 1.5rem;
  }
  
  .detect-btn {
    padding: 12px 24px;
    font-size: 1rem;
  }
}
</style>