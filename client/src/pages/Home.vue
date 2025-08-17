<template>
  <div class="home-container">
    <div class="home-content">
      <h1 class="home-title">首页</h1>
      <div class="home-description">
        <p>欢迎来到桂军桥的项目管理系统</p>
        <p>这是一个现代化的温度监控和管理平台</p>
      </div>
      <div class="home-features">
        <div class="feature-card">
          <div class="feature-icon">🌡️</div>
          <h3>温度监控</h3>
          <p>实时监控设备温度状态</p>
        </div>
        <div class="feature-card">
          <div class="feature-icon">📊</div>
          <h3>数据管理</h3>
          <p>历史数据查询和分析</p>
        </div>
        <div class="feature-card">
          <div class="feature-icon">⚙️</div>
          <h3>设备控制</h3>
          <p>远程设备指令控制</p>
        </div>
      </div>
    </div>

    <!-- 实验部分内容：--响应式template中的{{}}赋值的时候只有在多层的响应式关系中的中间需要.value索引的地方是自己需要去添加的，其余首位自动添加.value索引 -->
    <!-- <h2>{{ x }}</h2>------------------
    <h2>{{ y[0] }}</h2>--------------
    <h2>{{ z[0].value[0] }}</h2> -->

    <!-- <button @click="add">点击此处</button> -->
  </div>
</template>

<script lang="ts" setup>

import { ref } from "vue";


// const x = ref(10);
// const y = ref([x]);
// const z = ref([y]);

// function add(value) {
//   x.value += 10;
//   console.log("x:" + x.value);
//   console.log("y:" + y.value[0].value);
//   console.log("z:" + z.value[0].value[0].value);
// }


</script>

<style scoped>
.home-container {
  min-height: 100vh;
  display: flex;
  align-items: center;
  justify-content: center;
  padding: 20px;
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
}

.home-content {
  text-align: center;
  max-width: 800px;
  background: rgba(255, 255, 255, 0.95);
  padding: 60px 40px;
  border-radius: 30px;
  box-shadow: 0 20px 60px rgba(0, 0, 0, 0.1);
  backdrop-filter: blur(20px);
  border: 1px solid rgba(255, 255, 255, 0.2);
}

.home-title {
  font-size: 4rem;
  font-weight: 800;
  background: linear-gradient(45deg, #3498db, #e74c3c);
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
  background-clip: text;
  margin-bottom: 30px;
  text-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
}

.home-description {
  margin-bottom: 50px;
}

.home-description p {
  font-size: 1.2rem;
  color: #555;
  margin: 10px 0;
  line-height: 1.6;
}

.home-features {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
  gap: 30px;
  margin-top: 40px;
}

.feature-card {
  background: linear-gradient(135deg, #f8f9fa, #e9ecef);
  padding: 30px 20px;
  border-radius: 20px;
  box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
  transition: all 0.3s ease;
  border: 1px solid rgba(255, 255, 255, 0.3);
}

.feature-card:hover {
  transform: translateY(-10px);
  box-shadow: 0 20px 40px rgba(0, 0, 0, 0.15);
  background: linear-gradient(135deg, #ffffff, #f8f9fa);
}

.feature-icon {
  font-size: 3rem;
  margin-bottom: 20px;
  display: block;
}

.feature-card h3 {
  font-size: 1.5rem;
  color: #2c3e50;
  margin-bottom: 15px;
  font-weight: 600;
}

.feature-card p {
  color: #666;
  line-height: 1.5;
  font-size: 1rem;
}

/* 响应式设计 */
@media (max-width: 768px) {
  .home-content {
    padding: 40px 20px;
    margin: 20px;
  }
  
  .home-title {
    font-size: 3rem;
  }
  
  .home-features {
    grid-template-columns: 1fr;
    gap: 20px;
  }
  
  .feature-card {
    padding: 25px 15px;
  }
}

@media (max-width: 480px) {
  .home-title {
    font-size: 2.5rem;
  }
  
  .home-description p {
    font-size: 1rem;
  }
  
  .feature-card h3 {
    font-size: 1.3rem;
  }
}
</style>