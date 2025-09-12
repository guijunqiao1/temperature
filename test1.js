var minWindow = function(s,t){
  let result ='';
  const map_s = {'a':[],'b':[],'c':[],'d':[],'e':[],'f':[],'g':[],'h':[],'i':[],'j':[],'k':[],'l':[],'m':[],'n':[],'o':[],'p':[],'q':[],'r':[],'s':[],'t':[],'u':[],'v':[],'w':[],'x':[],'y':[],'z':[],'A':[],'B':[],'C':[],'D':[],'E':[],'F':[],'G':[],'H':[],'I':[],'J':[],'K':[],'L':[],'M':[],'N':[],'O':[],'P':[],'Q':[],'R':[],'S':[],'T':[],'U':[],'V':[],'W':[],'X':[],'Y':[],'Z':[] };
  const map_t = {'a':0,'b':0,'c':0,'d':0,'e':0,'f':0,'g':0,'h':0,'i':0,'j':0,'k':0,'l':0,'m':0,'n':0,'o':0,'p':0,'q':0,'r':0,'s':0,'t':0,'u':0,'v':0,'w':0,'x':0,'y':0,'z':0,'A':0,'B':0,'C':0,'D':0,'E':0,'F':0,'G':0,'H':0,'I':0,'J':0,'K':0,'L':0,'M':0,'N':0,'O':0,'P':0,'Q':0,'R':0,'S':0,'T':0,'U':0,'V':0,'W':0,'X':0,'Y':0,'Z':0 };

  //优先进行长度判断
  if(s.length<t.length){
    return "";
  }
  //优先查看是否
  for(let i=0;i<s.length;i++){
    map_s[`${s[i]}`].push(i);//存放下标
    if(i<t.length) {
      map_t[`${t[i]}`]+=1;
      console.log("t[i]:"+`${t[i]}`);
      console.log("map_t[`${t[i]}`]:"+map_t[`${t[i]}`]);
    }
  }
  //筛选出有值的map_t
  for(let key in map_t){
    if(map_t[key]===0){
      //删除该键值对
      delete map_t[key];
    }
  }
  //定义方法用于计算连线索引的总长度--元素数量
  function calcu_len(arr) {
    // 避免修改原数组，创建副本再排序
    const sortedArr = [...arr].sort((a, b) => a - b);
    // 直接用解构获取最大最小值
    const min = sortedArr[0];
    const max = sortedArr[sortedArr.length - 1];
    return max - min;
  }
  //定义数值与元素混合的方法--得到一次组合数组--一维数组情况
  function mix(arr, n) {
    // 输入检查前置，避免不必要的函数初始化
    if (!arr || !Array.isArray(arr) || n <= 0 || n > arr.length) return [];
    
    const result = [];
    
    function backtrack(start, temp) {
      // 基本情况优化
      if (temp.length === n) {
        result.push([...temp]);
        return;
      }
      
      // 剪枝优化：如果剩余元素不足以填满组合，直接返回
      if (arr.length - start < n - temp.length) return;
      
      for (let i = start; i < arr.length; i++) {
        temp.push(arr[i]);
        backtrack(i + 1, temp);
        temp.pop();
      }
    }
    
    backtrack(0, []);
    return result;
  }
  //定义存储混合数组的对象
  let mix_array = [];
  console.log("map_t");
  console.dir(map_t);
  console.log("map_s");
  console.dir(map_s);
  for(let key in map_t) {
    mix_array.push(mix(map_s[key],map_t[key]));
  }
  console.log("mix_array:");
  console.dir(mix_array);
  //定义最小值变量
  let min = {};
  //全排列所有数组元素--二维数组情况
  function combineArraysUnique(arr) {
    // 输入验证
    if (!arr || !Array.isArray(arr) || arr.length === 0) return [];
    
    // 检查是否有空子数组
    for (let i = 0; i < arr.length; i++) {
      if (!arr[i] || arr[i].length === 0) return [];
    }
    
    // 优化：对特殊情况进行快速处理
    if (arr.length === 1) return arr[0].map(item => [item]);
    
    const result = [];
    const seen = new Set();
    
    function backtrack(index, current) {
      if (index === arr.length) {
        // 使用更高效的方法生成键
        const key = current.join(',');
        if (!seen.has(key)) {
          seen.add(key);
          result.push([...current]);
        }
        return;
      }
      
      const subArr = arr[index];
      for (let i = 0; i < subArr.length; i++) {
        current.push(subArr[i]);
        backtrack(index + 1, current);
        current.pop();
      }
    }
    backtrack(0, []);
    return result;
  }
  const xxx = combineArraysUnique(mix_array);
  console.log("xxx:");
  console.dir(xxx);
  for(let i=0;i<xxx.length;i++){
    let kk = xxx[i].flat();
    if(i===0){//没元素
      console.log("添加元素成功");
      min[calcu_len(kk)] = kk;
    }else{
      let jisuan = calcu_len(kk);
      if(Number(Object.keys(min)[0])>jisuan) {
        min = {jisuan:kk};
      }
    }
  }
  //得到排序结果进行return
  console.log("key1:");
  console.dir(Object.keys(min));
  const key1 = Object.keys(min)[0];
  const result_array = min[key1].sort((a,b)=>a-b);
  for(let i=result_array[0];i<result_array[result_array.length-1]+1;i++){
    result += s[i];
  }
  return result;
}

const s = "a";
const t = "b"
console.log("test:"+minWindow(s,t));