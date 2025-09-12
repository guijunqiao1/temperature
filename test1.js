var minWindow = function(s,t){
  let result ='';
  const map_s = {'a':[],'b':[],'c':[],'d':[],'e':[],'f':[],'g':[],'h':[],'i':[],'j':[],'k':[],'l':[],'m':[],'n':[],'o':[],'p':[],'q':[],'r':[],'s':[],'t':[],'u':[],'v':[],'w':[],'x':[],'y':[],'z':[],'A':[],'B':[],'C':[],'D':[],'E':[],'F':[],'G':[],'H':[],'I':[],'J':[],'K':[],'L':[],'M':[],'N':[],'O':[],'P':[],'Q':[],'R':[],'S':[],'T':[],'U':[],'V':[],'W':[],'X':[],'Y':[],'Z':[] };
  const map_t = {'a':0,'b':0,'c':0,'d':0,'e':0,'f':0,'g':0,'h':0,'i':0,'j':0,'k':0,'l':0,'m':0,'n':0,'o':0,'p':0,'q':0,'r':0,'s':0,'t':0,'u':0,'v':0,'w':0,'x':0,'y':0,'z':0 };
  for(let i=0;i<s.length;i++){
    map_s[`${s[i]}`].push(i);//存放下标
    if(i<t.length) map_t[`${t[i]}`]++;
  }
  //筛选出有值的map_t
  for(let key in map_t){
    if(map_t[key]===0){
      //删除该键值对
      delete map_t[key];
    }
  }
  
  //定义方法用于计算连线索引的总长度--元素数量
  function calcu_len(arr){
    arr.sort((a,b)=>a-b);
    return arr[arr.length-1]-arr[0];
  }
  //定义数值与元素混合的方法--得到一次组合数组--一维数组情况
  function mix(arr, n) {
    const result = [];
  
    // 辅助函数：生成组合
    function backtrack(start, temp) {
      // 如果当前组合长度达到 n，加入结果
      if (temp.length === n) {
        result.push([...temp]);
        return;
      }
  
      // 从 start 开始遍历，避免重复组合
      for (let i = start; i < arr.length; i++) {
        // 选择当前元素
        temp.push(arr[i]);
        // 递归，从 i+1 开始，避免使用之前的元素
        backtrack(i + 1, temp);
        // 回溯：撤销选择
        temp.pop();
      }
    }
  
    // 输入检查
    if (!arr || n <= 0 || n > arr.length) return [];
  
    // 初始化
    backtrack(0, []);
    return result;
  }
  //定义存储混合数组的对象
  let mix_array = [];
  for(let key in map_t){
    mix_array.push(mix(map_s[key],map_t[key]));
  }
  //定义最小值变量
  let min = {};
  //全排列所有数组元素--二维数组情况
  function combineArraysUnique(arr) {
    const result = [];
    const seen = new Set();
  
    function backtrack(temp, index) {
      // 当组合长度等于 arr.length 时，处理结果
      if (temp.length === arr.length) {
        // 排序并转为字符串去重
        const sortedKey = [...temp].sort().join(",");
        if (!seen.has(sortedKey)) {
          seen.add(sortedKey);
          result.push([...temp]);
        }
        return;
      }
  
      // 从当前子数组中选择一个元素
      for (let i = 0; i < arr[index].length; i++) {
        temp.push(arr[index][i]);
        backtrack(temp, index + 1);
        temp.pop();
      }
    }
  
    // 输入检查
    if (!arr || arr.length === 0 || arr.some(subArr => subArr.length === 0)) {
      return [];
    }
  
    backtrack([], 0);
    return result;
  }
  const xxx = combineArraysUnique(mix_array);
  for(let i=0;i<xxx.length;i++){
    let kk = xxx[i].flat();
    if(Object.keys(min).length===0){//没元素
      min[calcu_len(kk)] = kk;
    }else{
      let jisuan = calcu_len(kk);
      if(Number(Object.keys(min)[0])>jisuan) {
        min = {jisuan:kk};
      }
    }
  }
  //得到排序结果进行return
  const key1 = Object.keys(min)[0];
  const result_array = min[key1].sort((a,b)=>a-b);
  result_array.forEach(element => {
    result += s[element];
  });
  return result;
}

const s = "ADOBECODEBANC";
const t = "ABC"
console.log("test:"+minWindow(s,t));