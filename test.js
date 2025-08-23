var threeSum = function(nums) {
    //删除指定位置的重复元素的方法
    function delete1(nums,index){
      //先判断下标位置
      if(index!==0&&index!==nums.length-1){
        return [...nums.slice(0,index),...nums.slice(index+1,nums.length)];
      }else{
        if(index===0){
          return [...nums.slice(1,nums.length-1)];
        }else{
          return [...nums.slice(0,nums.length-2)];
        }
      }
    }
    //数组去重
    //1、优先排序
    nums.sort();
    //2、直接比对前后元素
    for(let i=0;i<nums.length-1;i++){
      if(i!==nums.length-1){//不是最后一个元素
        if(nums[i]===nums[i+1]){
          nums = delete1(i); 
        }
      }
    }
    //结果数组
    const result_array = [];
    //开始遍历
    for(let i=0;i<nums.length-2;i++){
      for(let j=i+1;j<nums.length-1;j++){
        for(let k=j+1;k<nums.length;k++){
          if((nums[i]+nums[j]+nums[k])===0) result_array.push([nums[i],nums[j],nums[k]]);
        }
      }
    } 
    return result_array;
};

const test_array = [-1,0,2,3,4,1];
console.log("result:"+threeSum(test_array));

//slice实现
Array.prototype.slice1 = (index1,index2)=>{
  let result_array = [];
  for(let k=index1;k<index2;k++){
    result_array.push(this[k]);
  }
  this = result_array;
}