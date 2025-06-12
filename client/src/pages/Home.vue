<template>
  <span>首页</span>

  <!-- 实验部分内容：--响应式template中的{{}}赋值的时候只有在多层的响应式关系中的中间需要.value索引的地方是自己需要去添加的，其余首位自动添加.value索引 -->
  <!-- <h2>{{ x }}</h2>------------------
  <h2>{{ y[0] }}</h2>--------------
  <h2>{{ z[0].value[0] }}</h2> -->

  <!-- <button @click="add">点击此处</button> -->
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
span {
  font-size: 80px;
  font-weight: 800;
}
</style>