
var permute = function(nums) {
    //结果返回数组
    const result = [];
    //当前索引到的介质值
    let index_value;
    function digui(arr,value,length){//参数分别为填充数组、填充值、递归索引长度
        if(arr.length<length){
            arr.push(value);
            let remove = false;//用于标识是否去除过的标记变量
            //得到经过筛选后的数组--仅去除一个元素
            const newArray = nums.filter(item => {
                if (item === index_value && !remove) {
                    removed = true;
                    return false; // 移除第一个匹配元素
                }
                return true; // 保留其他元素
            });
            newArray.forEach((item,index)=>{//不同分支的递归进入
                index_value = item;
                digui(arr,index_value,length);
            })
        }else{
            return arr;
        }
    }
    for(let i=0;i<nums.length;i++){
        //介质空数组
        const index_arr = [];
        index_value = nums[i];
        const tem = digui(index_arr,index_value,nums.length);
        result.push(tem);
    }
};
