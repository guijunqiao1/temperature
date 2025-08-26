<template> 
  <ECharts :option="chartoption" />
</template>

<script setup lang="ts">
  import * as echarts from 'echarts/core';
  import {ref,onMounted} from "vue";
  import {
    TitleComponent,
    TooltipComponent,
    LegendComponent
  } from 'echarts/components';
  import { PieChart } from 'echarts/charts';
  import { LabelLayout } from 'echarts/features';
  import ECharts from "vue-echarts";
  import { CanvasRenderer } from 'echarts/renderers';

  echarts.use([
    TitleComponent,
    TooltipComponent,
    LegendComponent,
    PieChart,
    CanvasRenderer,
    LabelLayout
  ]);


  var chartoption = {
    title: {
      text: 'Referer of a Website',
      subtext: 'Fake Data',
      left: 'center'
    },
    tooltip: {
      trigger: 'item'
    },
    legend: {
      orient: 'vertical',
      left: 'left'
    },
    series: [
      {
        name: 'Access From',
        type: 'pie',
        radius: '50%',
        data: [
          { value: 1048, name: 'Search Engine' },
          { value: 735, name: 'Direct' },
          { value: 580, name: 'Email' },
          { value: 484, name: 'Union Ads' },
          { value: 300, name: 'Video Ads' }
        ],
        emphasis: {
          itemStyle: {
            shadowBlur: 10,
            shadowOffsetX: 0,
            shadowColor: 'rgba(0, 0, 0, 0.5)'
          }
        }
      }
    ]
  };



  



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