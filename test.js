/**
 * @param {string} s
 * @param {string} t
 * @return {string}
 */
 var minWindow = function(s, t) {
    let map = new Map();
    if(s.length<t.length) return "";
    else if(s.length===t.length){
        const map1 = {'a':0,'b':0,'c':0,'d':0,'e':0,'f':0,'g':0,'h':0,'i':0,'j':0,'k':0,'l':0,'m':0,'n':0,'o':0,'p':0,'q':0,'r':0,'s':0,'t':0,'u':0,'v':0,'w':0,'x':0,'y':0,'z':0,'A':0,'B':0,'C':0,'D':0,'E':0,'F':0,'G':0,'H':0,'I':0,'J':0,'K':0,'L':0,'M':0,'N':0,'O':0,'P':0,'Q':0,'R':0,'S':0,'T':0,'U':0,'V':0,'W':0,'X':0,'Y':0,'Z':0 };
        for(let i=0;i<s.length;i++){
            map1[s[i]]++;
            map1[t[i]]--;
        }
        for(let key in map1){
            if(map1[key]!==0) return '';
        }
        return s;
    }
    for(let i=0;i<t.length;i++){
        map.set(t[i],map.get(t[i])?map.get(t[i])+1:1)
    }
    console.log("参考数组：");
    console.dir(map);
    const result = [];
    //定义查看对象所有值是否都为0的方法
    function panduan_0(map){
        let sign = true;
        for(const [key,value] of map){
            if(value!==0) sign = false;
        }
        return sign;
    }

    for(let i=0;i<s.length;i++){
        if(map.get(s[i])){//开始减的话
            //第一次先观察是否存在第一项
            if(result.length===0){
                const map1 = new Map(map);
                map1.set(s[i],map.get(s[i])-1);
                result.push([i,map1]);
            }
            //遍历判断查看
            result.forEach((item,index)=>{
                if(panduan_0(item[1])&&item.length!==3){
                    console.log("11111111111111");
                    //记录下标了
                    item.push(i);
                }else if(!panduan_0(item[1])&&item.length!==3&&result.length!==1){//开减
                    //若已经是0则不减
                    if(item[1].get(s[i])!==0){
                        item[1].set(s[i],item[1].get(s[i])-1);
                        //减完再加一次判断
                        if(panduan_0(item[1])&&item.length!==3){
                            console.log("22222222");
                            //记录下标了
                            item.push(i);
                        }
                    }
                }
            })
            const map1 = new Map(map);
            map1.set(s[i],map.get(s[i])-1);
            result.push([i,map1]);
        }
    }
    //遍历结果array
    //定义最小值index
    let min_index;
    let min_value;
    console.log("result_array:");
    console.dir(result);
    if(result.length===0) return '';
    let sign = true;
    result.forEach((item,index)=>{
        if(!min_index&&item.length!==2){//只对结束的数组进行获取
            min_value = item[2]-item[0];
            min_index = index;
        }
        else if(min_index&&item.length-2){//有值并且已经赋值过了min_index
            if(item[2]-item[0]<min_value){
                min_value = item[2] - item[0];
                min_index = index;
            }
        }
        if(item.length===3) sign = false;
    })
    if(sign) return '';
    return s.slice(result[min_index][0],result[min_index][2]+1);
};

const s = "abbbb";
const t = "aa"
console.log("test:"+minWindow(s,t));