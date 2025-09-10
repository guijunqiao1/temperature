var deleteAndEarn = function(nums,k){
  //提前找出所有能够使得总和为k的下标区间集合
  let result=0;
  let j=0;
  while(j<nums.length){
    let temp_sum=0;
    for(let i=j;i<nums.length;i++){
      temp_sum += nums[i];
      if(temp_sum===k){
        result++;
        if(i!==j){
          //清空
          temp_sum=0;
        }
      }
    }
    j++;
  }
    return result;
}

const nums = [1,2,1,2,1]
const k = 3;
console.log("test:"+deleteAndEarn(nums,k));