<template>
  <div class="sensor-container">
    <div class="sensor-header">
      <h1 class="page-title">传感器设置</h1>
      <p class="page-description">配置和管理设备传感器的参数和状态</p>
    </div>
    
    <div class="sensor-grid">
      <div v-for="item in sensor_array" :key="item.id" class="sensor-card">
        <div class="sensor-info">
          <h3 class="sensor-name">传感器：{{ item["name"] }}</h3>
          <div class="sensor-status">
            <span class="status-label">可用状态：</span>
            <div class="status-indicator" :class="{ 'status-ok': item['cable'] === 'ok', 'status-error': item['cable'] !== 'ok' }">
              {{ item['cable'] === 'ok' ? '正常' : '异常' }}
            </div>
          </div>
        </div>
        
        <div class="sensor-controls">
          <div class="input-group">
            <label class="input-label">传感器名称</label>
            <input type="text" class="sensor-input" placeholder="输入传感器名称">
          </div>
          
          <div class="checkbox-group">
            <label class="checkbox-label">
              <input type="checkbox" :checked="item['cable'] === 'ok'" class="sensor-checkbox">
              <span class="checkmark"></span>
              启用传感器
            </label>
          </div>
          
          <button @click="submit(item)" class="submit-btn">提交设置</button>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts" name="sensor_set">
  import { useUserStore } from "../store/curt";
  import axios from "axios";
  import { ref,onMounted } from "vue";

  const sensor_array = ref([]);
  const Pinia = useUserStore();
  let src1 = ref();


  //首先获取到总可选的传感器数组--封装上状态
  onMounted(async()=>{
    const result = await axios.get(`/api/sensor_get?d_no=${Pinia.signzhi}`);
    sensor_array.value = result.data;

    //定义得到匹配下标的方法
    function match_index(value){
      sensor_array.value.forEach((item,index)=>{
        if(item.name===value){
          return index;
        }
      })
    }


    //定义提交方法
    async function submit(value){
      const sum = match_index(value) + 1;
      const text_input = document.querySelector(`.sensor_set_container>div:nth-child(${sum}) input['type:text']`);
      const checkbox_input = document.querySelector(`.sensor_set_container>div:nth-child(${sum}) input['type:checkbox']`);
      await axios.get(`/api/sensor_change?name=${text_input.value}&cable=${checkbox_input.value}&id=${value.id}&d_no=${Pinia.signzhi}`);
      //完成传感器渲染数组内容的重获取
      const result1 = await axios.get(`/api/sensor_get?d_no=${Pinia.signzhi}`);
      //刷新元素值样式
      sensor_array.value = result1.data;
    }
  })

</script>

<style scoped>
.sensor-container {
  width: 100%;
  min-height: 100vh;
  padding: 30px;
  background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
  font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
}

.sensor-header {
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

.sensor-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(400px, 1fr));
  gap: 30px;
  margin-top: 30px;
}

.sensor-card {
  background: rgba(255, 255, 255, 0.9);
  border-radius: 20px;
  padding: 30px;
  box-shadow: 0 8px 25px rgba(0, 0, 0, 0.1);
  backdrop-filter: blur(10px);
  border: 1px solid rgba(255, 255, 255, 0.2);
  transition: all 0.3s ease;
}

.sensor-card:hover {
  transform: translateY(-5px);
  box-shadow: 0 15px 35px rgba(0, 0, 0, 0.15);
}

.sensor-info {
  margin-bottom: 25px;
  padding-bottom: 20px;
  border-bottom: 2px solid #e9ecef;
}

.sensor-name {
  font-size: 1.4rem;
  color: #2c3e50;
  margin-bottom: 15px;
  font-weight: 600;
}

.sensor-status {
  display: flex;
  align-items: center;
  gap: 15px;
}

.status-label {
  font-size: 1rem;
  color: #666;
  font-weight: 500;
}

.status-indicator {
  padding: 6px 12px;
  border-radius: 20px;
  font-size: 0.9rem;
  font-weight: 600;
  text-transform: uppercase;
  letter-spacing: 0.5px;
}

.status-ok {
  background: linear-gradient(135deg, #27ae60, #2ecc71);
  color: white;
}

.status-error {
  background: linear-gradient(135deg, #e74c3c, #c0392b);
  color: white;
}

.sensor-controls {
  display: flex;
  flex-direction: column;
  gap: 20px;
}

.input-group {
  display: flex;
  flex-direction: column;
  gap: 8px;
}

.input-label {
  font-size: 1rem;
  color: #2c3e50;
  font-weight: 600;
}

.sensor-input {
  padding: 12px 16px;
  border: 2px solid #e1e8ed;
  border-radius: 10px;
  font-size: 1rem;
  transition: all 0.3s ease;
  background: white;
}

.sensor-input:focus {
  outline: none;
  border-color: #3498db;
  box-shadow: 0 0 0 3px rgba(52, 152, 219, 0.1);
}

.checkbox-group {
  display: flex;
  align-items: center;
  gap: 10px;
}

.checkbox-label {
  display: flex;
  align-items: center;
  gap: 10px;
  cursor: pointer;
  font-size: 1rem;
  color: #2c3e50;
  font-weight: 500;
}

.sensor-checkbox {
  width: 18px;
  height: 18px;
  accent-color: #3498db;
  cursor: pointer;
}

.submit-btn {
  padding: 12px 24px;
  background: linear-gradient(135deg, #3498db, #2980b9);
  color: white;
  border: none;
  border-radius: 10px;
  font-weight: 600;
  cursor: pointer;
  transition: all 0.3s ease;
  box-shadow: 0 4px 15px rgba(52, 152, 219, 0.3);
  font-size: 1rem;
  margin-top: 10px;
}

.submit-btn:hover {
  transform: translateY(-2px);
  box-shadow: 0 6px 20px rgba(52, 152, 219, 0.4);
}

/* 响应式设计 */
@media (max-width: 1200px) {
  .sensor-container {
    padding: 20px;
  }
  
  .sensor-grid {
    grid-template-columns: repeat(auto-fit, minmax(350px, 1fr));
    gap: 25px;
  }
}

@media (max-width: 768px) {
  .sensor-container {
    padding: 15px;
  }
  
  .sensor-header {
    padding: 30px 20px;
    margin-bottom: 30px;
  }
  
  .page-title {
    font-size: 2rem;
  }
  
  .page-description {
    font-size: 1rem;
  }
  
  .sensor-grid {
    grid-template-columns: 1fr;
    gap: 20px;
  }
  
  .sensor-card {
    padding: 25px;
  }
}

@media (max-width: 480px) {
  .sensor-container {
    padding: 10px;
  }
  
  .sensor-header {
    padding: 25px 15px;
  }
  
  .page-title {
    font-size: 1.8rem;
  }
  
  .sensor-card {
    padding: 20px;
  }
  
  .sensor-name {
    font-size: 1.2rem;
  }
}
</style>