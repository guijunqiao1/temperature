var trap = function (height) {
  let i = 0;
  let j = height.length - 1;

  //左右值标记变量
  let left: number;
  let right: number;

  //定义介质变量
  let jiezhi: number;

  //定义取最小值的方法
  function get_min(value1: number, value2: number): number {
    if (value1 < value2) return value1;
    else return value2;
  }

  let sum_water = 0;//总水量变量
  while (i < j) {
    if (sum_water === 0) {//初始雨水
      if (height[i] !== 0 && height[j] !== 0) {
        sum_water += (j - i - 1) * get_min(height[i], height[j]);
        console.log("增量：" + (j - i - 1) * get_min(height[i], height[j]));
        jiezhi = get_min(height[i], height[j]);
        left = i;
        right = j;
        //整体迭代--前提宽度足够
        if (height.length > 3) {
          i++;
          j--;
        } else {
          i++;
        }
      } else {
        //迭代
        if (height[i] === 0) {
          i++;
        }
        if (height[j] === 0) {
          j--;
        }
      }
    } else {//后续减去雨水的情况
      if (height[i] <= height[left] && i !== left) {
        sum_water -= get_min(height[i], jiezhi);
        console.log("减少量1：" + get_min(height[i], jiezhi));
      } else {
        if (i !== left) {
          sum_water -= height[left];
          //迭代标志位
          left = i;
          if (height[right] < height[left]) {//获取到最新增加的水量
            sum_water += (right - left - 1) * height[left];
            //后续增加一次原先重叠部分需要减去
            sum_water -= (right - left + 1) * jiezhi;
            jiezhi = height[left];
          }
        }
      }
      if (height[j] <= height[right] && j !== right) {
        sum_water -= get_min(jiezhi, height[j]);
        console.log("减少量2：" + get_min(height[j], jiezhi));
      } else {
        if (j !== right) {
          sum_water -= height[right];
          //迭代标志位
          right = j;
          if (height[left] < height[right]) {//获取到最新增加的水量
            sum_water += (right - left - 1) * height[right];
            //后续增加一次原先重叠部分需要减去
            sum_water -= (right - left + 1) * jiezhi;
            jiezhi = height[right];
          }
        }
      }
      i++;
      j--;
    }
  }
  return sum_water;
};

const test_array = [5, 5, 1, 7, 1, 1, 5, 2, 7, 6];
console.log("result:" + trap(test_array));