var maxSlidingWindow = function(nums, k) {
    //定义判断k者最大值的方法
    function get_max(index,k){//从index开始的k个元素之间的最大值
      //定义标记变量用于显示当前最值出现的位置
      let location = index;
      let max = nums[index];
      //定义标记变量用于判断窗口最大值出现的次数--用于直接判断赋值迭代
      let sign = 0;
      for(let i=index;i<index+k;i++){
        if(nums[i]>max){
          location = i;
          max = nums[i];
        }
      } 
      for(let i=index;i<index+k;i++){
        if(nums[i]===max) sign++;
      }
      return [max,location,sign];
    }
    const result = [];
    //定义临时的最大值变量
    let tem_max;
    //开始遍历
    for(let i=0;i<nums.length-k+1;i++){
      if(i===0) {
        tem_max = get_max(i,k);
        result.push(tem_max[0]);
      }else{
        //直接拿最大值和最新值比较的情况
        if(tem_max[1]!==i-1){
          if(nums[i+2]>tem_max[0]){//发现新的最大值
            tem_max = [nums[i+2],i+2,1];
            result.push(nums[i+2]);
          }else if(nums[i+2]===tem_max[0]){//旧的最值
            tem_max = [tem_max[0],,tem_max[2]];
          }
        }
        else if(tem_max[1]===i-1&&tem_max[2]>1){//发现最大值出现在开头但是最大值数量不止一个

        }
        else{

        }
      }
    }
    return result;
};

const nums = [1,3,-1,-3,5,3,6,7];
const k = 3;
console.log("result:" + maxSlidingWindow(nums,k));