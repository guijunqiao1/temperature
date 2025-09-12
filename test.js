/**
 * @param {number[]} nums
 * @param {number} k
 * @return {number[]}
 */
class MyQueue {
    constructor(que) {
        //字面量化队列变量，使得自定义pop、push方法和数组原型提供的push、pop方法进行区分
        this.que = que || [];
    }
    top() {
        if (this.que.length) {
            return this.que[0];
        } 
        else {
            return undefined;
        }
    }
    push(number) {
        if (this.que.length) {
            while (number > this.que[this.que.length - 1]) {
                //直接删除数组最后一项
                this.que.pop();
            }
            //队列添加最大项到相应位置
            this.que.push(number);
        } 
        else {
            //队列添加最大项到相应位置
            this.que[0] = number;
        }
    }
    pop(number) {
        if (this.top() === number) {//得到顶部最大值，观察和需要越界处理的队列的值的大小关系
            // 若为和最大值相等的情况则去除该值否则该老元素的索引保留在队列中
            return this.que.shift();
        }
        //即使越界也不会对队列中的该值进行操作同时保留其本身的原因在于在此次的pop之后会有一次队列的push
        //方法调用，故可能会自动清除掉该元素；同时本质结果数组存放的内容只会是队列的顶部的元素，需要pop的元素
        //如果不在顶部就一直不会result访问到，除非后续顶部元素被清除，但是由于每次循环的第一件事就是pop，故此次越界
        //元素如果将要被访问也会被去除
        return undefined;
    }
}
var maxSlidingWindow = function (nums, k) {
    const result = [];
    const window = new MyQueue();
    // 先遍历nums前k个元素，初始化window
    for (let i = 0; i < k; i++) {
        window.push(nums[i]);
    }
    // 记得把第一个窗口的最大值存入result
    result.push(window.top());
    // 开始滑动窗口
    for (let i = k; i < nums.length; i++) {
        //尝试去除老元素--仅在该老元素为队列中的最大值索引的情况下才去除
        window.pop(nums[i - k]);
        //尝试添加新的最大值元素
        window.push(nums[i]);
        //添加最大项
        result.push(window.top());
    }
    return result;
};

const nums = [1,3,-1,-3,5,3,6,7];
const k = 3;
console.log("result:" + maxSlidingWindow(nums,k));