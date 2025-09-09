var deleteAndEarn = function(nums){
  //首先检查长度
  if(nums.length===0){
    return 0;
  }
  else if(nums.length===1){
    return nums[0];
  }
  else if(nums.length===2){
    //查看是否相邻
    if(nums[0]+1===nums[1]||nums[0]-1===nums[1]) {//相邻取大的
      return nums[0]>nums[1]?nums[0]:nums[1];
    }else{
      return nums[0]+nums[1];
    }
  }
  //排列去重使得和打家劫舍模板贴切--重复部分使用字典进行频率记录
  nums.sort((a,b)=>a-b);
  //定义频率字典
  const map = {};
  //重复元素标志位变量
  let sign = nums[0];
  map[sign] = 0;
  nums.forEach((item,index)=>{
    if(item===sign){
      map[sign]++;
    }else{
      map[item] = 1;
      sign = item;
    }
  })
  //顺序去重
  nums = [...new Set(nums)];
  console.log("去重后的数组");
  console.dir(nums);
  console.log("哈希表");
  console.log(map);

  let dp = new Array(nums.length-1);
  dp[0] = nums[0]*map[`${nums[0]}`];
  //去除相同元素的方法
  function qu(arr,value){
    return arr.filter(item=>item!==value);
  }
  dp[1] = nums[1]-nums[0] > 1 ?  map[`${nums[0]}`]*nums[0] +  map[`${nums[1]}`]*nums[1] : Math.max( map[`${nums[0]}`]*nums[0], map[`${nums[1]}`]*nums[1]);

  //定义去除元素的动态长度变量
  let index_len = nums.length;

  //遍历对象完成值的查找
  for(let i=2;i<nums.length;i++){
    if(nums[i]-nums[i-1]>1){
      dp[i] = dp[i-1]+ map[`${nums[i]}`]*nums[i];
    }else{
      dp[i] = Math.max(dp[i-1],dp[i-2]+map[`${nums[i]}`]*nums[i]);
    }
    console.log("dp[i]:"+dp[i]);
    console.log("dp:");
    console.dir(dp);
  }
  console.log("退出循环");
  return dp.pop();
}

const test = [1,1,1,2,4,5,5,5,6];
console.log("test:"+deleteAndEarn(test));