"use strict";

var _this = void 0;

function _toConsumableArray(arr) { return _arrayWithoutHoles(arr) || _iterableToArray(arr) || _nonIterableSpread(); }

function _nonIterableSpread() { throw new TypeError("Invalid attempt to spread non-iterable instance"); }

function _iterableToArray(iter) { if (Symbol.iterator in Object(iter) || Object.prototype.toString.call(iter) === "[object Arguments]") return Array.from(iter); }

function _arrayWithoutHoles(arr) { if (Array.isArray(arr)) { for (var i = 0, arr2 = new Array(arr.length); i < arr.length; i++) { arr2[i] = arr[i]; } return arr2; } }

var threeSum = function threeSum(nums) {
  //删除指定位置的重复元素的方法
  function delete1(nums, index) {
    //先判断下标位置
    if (index !== 0 && index !== nums.length - 1) {
      return [].concat(_toConsumableArray(nums.slice(0, index)), _toConsumableArray(nums.slice(index + 1, nums.length)));
    } else {
      if (index === 0) {
        return _toConsumableArray(nums.slice(1, nums.length - 1));
      } else {
        return _toConsumableArray(nums.slice(0, nums.length - 2));
      }
    }
  } //数组去重
  //1、优先排序


  nums.sort(); //2、直接比对前后元素

  for (var i = 0; i < nums.length - 1; i++) {
    if (i !== nums.length - 1) {
      //不是最后一个元素
      if (nums[i] === nums[i + 1]) {
        nums = delete1(i);
      }
    }
  } //结果数组


  var result_array = []; //开始遍历

  for (var _i = 0; _i < nums.length - 2; _i++) {
    for (var j = _i + 1; j < nums.length - 1; j++) {
      for (var k = j + 1; k < nums.length; k++) {
        if (nums[_i] + nums[j] + nums[k] === 0) result_array.push([nums[_i], nums[j], nums[k]]);
      }
    }
  }

  return result_array;
};

var test_array = [-1, 0, 2, 3, 4, 1];
console.log("result:" + threeSum(test_array)); //slice实现

Arrat.prototype.slice1 = function (index1, index2) {
  var result_array = [];

  for (var k = index1; k < index2; k++) {
    result_array.push(_this[k]);
  }

  return;
};