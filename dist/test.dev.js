"use strict";

var permute = function permute(nums) {
  //结果返回数组
  var result = []; //当前索引到的介质值

  var index_value;

  function digui(arr, value, length) {
    //参数分别为填充数组、填充值、递归索引长度
    if (arr.length < length) {
      arr.push(value);
      var remove = false; //用于标识是否去除过的标记变量
      //得到经过筛选后的数组--仅去除一个元素

      var newArray = nums.filter(function (item) {
        if (item === index_value && !remove) {
          removed = true;
          return false; // 移除第一个匹配元素
        }

        return true; // 保留其他元素
      });
      newArray.forEach(function (item, index) {
        //不同分支的递归进入
        index_value = item;
        digui(arr, index_value, length);
      });
    } else {
      return arr;
    }
  }

  for (var i = 0; i < nums.length; i++) {
    //介质空数组
    var index_arr = [];
    index_value = nums[i];
    var tem = digui(index_arr, index_value, nums.length);
    result.push(tem);
  }
};