<template>
  <el-time-picker v-model="value1" placeholder="Arbitrary time" @blur="submit(value1)" />

</template>

<script setup lang="ts">
import { ref, watch } from 'vue'

const nowTime = new Date();

const value1 = ref(nowTime);
const value2 = ref();
const label_boolean = "";
console.log("Bboolean:" + Boolean(label_boolean));
console.log("!Bboolean:" + !Boolean(label_boolean));


function submit(value) {
  console.log("value1:" + value1.value);
}


</script>


<style scoped></style>