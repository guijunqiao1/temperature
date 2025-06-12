"use strict";

Object.defineProperty(exports, "__esModule", {
  value: true
});
exports.beifen = beifen;
exports.client = exports.active = exports.active_array = void 0;

var _mqtt = _interopRequireDefault(require("mqtt"));

var _indexNode = _interopRequireDefault(require("../indexNode3.js"));

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { "default": obj }; }

function _slicedToArray(arr, i) { return _arrayWithHoles(arr) || _iterableToArrayLimit(arr, i) || _nonIterableRest(); }

function _nonIterableRest() { throw new TypeError("Invalid attempt to destructure non-iterable instance"); }

function _iterableToArrayLimit(arr, i) { if (!(Symbol.iterator in Object(arr) || Object.prototype.toString.call(arr) === "[object Arguments]")) { return; } var _arr = []; var _n = true; var _d = false; var _e = undefined; try { for (var _i = arr[Symbol.iterator](), _s; !(_n = (_s = _i.next()).done); _n = true) { _arr.push(_s.value); if (i && _arr.length === i) break; } } catch (err) { _d = true; _e = err; } finally { try { if (!_n && _i["return"] != null) _i["return"](); } finally { if (_d) throw _e; } } return _arr; }

function _arrayWithHoles(arr) { if (Array.isArray(arr)) return arr; }

//此处获取到数据库链接配置对象
var connection1; //定义数据库连接对象--project02

(function _callee() {
  return regeneratorRuntime.async(function _callee$(_context) {
    while (1) {
      switch (_context.prev = _context.next) {
        case 0:
          _context.prev = 0;
          _context.next = 3;
          return regeneratorRuntime.awrap((0, _indexNode["default"])());

        case 3:
          connection1 = _context.sent;
          console.log("数据库3连接成功");
          _context.next = 10;
          break;

        case 7:
          _context.prev = 7;
          _context.t0 = _context["catch"](0);
          console.log("数据库3连接失败");

        case 10:
        case "end":
          return _context.stop();
      }
    }
  }, null, null, [[0, 7]]);
})(); //动态获取到多设备的总数，完成设备列表的填充
// const [rows1] = await connection1.execute(`
// SELECT d_no 
// FROM t_device
// WHERE device_name = "电动自行车"
// `);


var active_array; // for(let i=0;i<rows1[0].length;i++){
//   active_array.push([Number(rows1[0][i]),false]);
// }
//定义当前心跳是否正常的标志变量
// export let active_array = [[2021,false]];

exports.active_array = active_array;
var active = false; //定义指令备份数组
// let zhiling_beifen_array = [];
// for(let i=0;i<rows1[0].length;i++){
//   zhiling_beifen_array.push([Number(rows1[0][i]),[]]);
// }

exports.active = active;
var zhiling_beifen_array = []; //定义全局阶段性变量

var level = 0; //定义准确的ID标识变量

var now_ID = null; //定义临时变量用于控制每次入库的次数进行准确的监听

var tem = 0; //设备存储
//指令备份数组的元素格式为：
// 设备编号,【主题，数据({payload,qos})，该设备所属的指令的类别】
// 方式：传感器直接支持MQTT
// 控制台客户端对象         192.168.218.141'

var client = _mqtt["default"].connect('mqtt://192.168.1.100', {
  clientId: "client_control" //唯一标识符

}); //定义延时函数


exports.client = client;

function delay(ms) {
  return new Promise(function (resolve) {
    return setTimeout(resolve, ms);
  });
} //定义获取当前时间并且为特定格式的方法


function getFormattedDate() {
  var now = new Date();
  var year = now.getFullYear();
  var month = String(now.getMonth() + 1).padStart(2, '0'); // 月份从0开始，需要加1

  var day = String(now.getDate()).padStart(2, '0');
  var hours = String(now.getHours()).padStart(2, '0');
  var minutes = String(now.getMinutes()).padStart(2, '0');
  var seconds = String(now.getSeconds()).padStart(2, '0');
  return "".concat(year, "-").concat(month, "-").concat(day, "-").concat(hours, "-").concat(minutes, "-").concat(seconds);
} //同步时间格式的方法


function getTongbu() {
  var now = new Date();
  var hours = String(now.getHours()).padStart(2, '0');
  var minutes = String(now.getMinutes()).padStart(2, '0');
  var seconds = String(now.getSeconds()).padStart(2, '0');
  return "".concat(hours, ":").concat(minutes, ":").concat(seconds);
} // 心跳检测器
// 制作一个定时器用于定期向设备层订阅的主题中发送消息，并且设备层在接受到消息之后则响应相同的消息到应用层，用于检测设备层和应用层是不是直接的连接


setInterval(function () {
  console.log("心跳正常发送");
  client.publish("direct", JSON.stringify({
    heartTest_client: "start"
  }), {
    qos: 1
  }); //多设备情况下考虑的文本内容得添加上设备的具体编号

  单设备;
  exports.active = active = false; //多设备
  //首先对整个beifen数组进行缓存，并且根据其中的首元素的个数进行对应的主题的发送
  // active_array.forEach((item,index)=>{
  //   //在当前的item(某个不同的设备)中完成心跳的发送的操作并且将此时对应上的active标记
  //   client.publish(`direct:${item[0]}`,JSON.stringify({heartTest_client:"start"}),{qos:1});//多设备情况下考虑的文本内容得添加上设备的具体编号
  //   // 多设备情况
  //   item[1] = false;
  //   console.log("成功发送消息到主题direct:"+item[0]);
  // })
}, 5000); //每5s进行一次心跳的检测
//定义重发函数--针对重连的重发函数，封装

function reconnect_republish(value) {
  //参数对应上了实际的响应的设备编号
  // 多设备
  // active_array.forEach((item,index)=>{
  //   if(item[0]===value){
  //     item[1] = true;//当接收到心跳重连的信息的时候进行备份数组的内容的重发布，并且后续在主动进行指令的配置的时候进行active的直接判断并且执行一次是否为active为false的情况并且将对应的指令的信息存入到beifen_array中
  //   }
  // });
  // 单设备
  exports.active = active = true; //主动调用一次重发

  republish();
}

; //定义重发函数--广义

function republish() {
  var length, i;
  return regeneratorRuntime.async(function republish$(_context2) {
    while (1) {
      switch (_context2.prev = _context2.next) {
        case 0:
          // 多设备
          // const length = zhiling_beifen_array.length;
          // for(let i=0;i<length;i++){
          //   for(let j=0;zhiling_beifen_array[i][1].length;j++){
          //     if(zhiling_beifen_array.length>0&&zhiling_beifen_array[0].length>0&&zhiling_beifen_array[0][1].length>0){
          //         beifen(zhiling_beifen_array[i][0],zhiling_beifen_array[i][1][j]);//参数1为设备编号，参数2为指令本身内容
          //         zhiling_beifen_array.shift();
          //     }
          //     else{}
          //     await delay(3000);//单位为ms
          //   }
          // }
          // 单设备
          //首先检查长度
          console.log("zhiling_beifen_array_length:" + zhiling_beifen_array.length);
          console.log("zhiling_beifen:");
          console.dir(zhiling_beifen_array);
          length = zhiling_beifen_array.length;
          console.log("length:" + length);
          i = 0;

        case 6:
          if (!(i < length)) {
            _context2.next = 14;
            break;
          }

          // client.publish(...zhiling_beifen_array[i],{qos:1});
          // client.publish(...zhiling_beifen_array[i],{qos:1});
          console.log(zhiling_beifen_array[0]);

          if (zhiling_beifen_array.length > 0 && zhiling_beifen_array[0].length > 0) {
            beifen(1, zhiling_beifen_array[0]);
            zhiling_beifen_array.shift();
          } else {}

          _context2.next = 11;
          return regeneratorRuntime.awrap(delay(3000));

        case 11:
          i++;
          _context2.next = 6;
          break;

        case 14:
        case "end":
          return _context2.stop();
      }
    }
  });
} //定义备份函数--value2中的topic必须带上d_no的信息


function beifen(value1, value2) {
  return regeneratorRuntime.async(function beifen$(_context3) {
    while (1) {
      switch (_context3.prev = _context3.next) {
        case 0:
          //一号位参数用于确定发送的指令类对应的编号、二号位参数用于传递给具体的报文信息
          //首先进行指令发送 
          client.publish(value2[0], JSON.stringify(value2[1]), {
            qos: 1
          });
          _context3.next = 3;
          return regeneratorRuntime.awrap(delay(1000));

        case 3:
          //单位为ms 
          client.publish(value2[0], JSON.stringify(value2[1]), {
            qos: 1
          }); // 多设备指令备份
          // active_array.forEach((item,index)=>{
          //   if(item[0]===value1&&item[1]===false){
          //   // 备份数组的内容填充
          //   zhiling_beifen_array[index][1].push(value2);//其中value2的格式为：[topic,JSON.stringify({origin:"bujindianji",content})]
          //   }
          // })
          // 单设备指令备份

          if (active === false) {
            zhiling_beifen_array.push(value2);
            console.log("zhiling_beifen_array.length:" + zhiling_beifen_array.length);
          }

        case 5:
        case "end":
          return _context3.stop();
      }
    }
  });
} //控制台客户端对象连接设置


client.on('connect', function () {
  console.log("接收方连接成功"); //当客户端连接成功之后订阅对应的主题
  //用于检测传感器数据的主题

  client.subscribe('sensor/data', {
    qos: 1
  }, function (err) {
    if (err) {
      console.log("sensor/data主题订阅失败");
    } else {
      console.log("sensor/data主题订阅成功");
    }
  }); //用于检测告警信息发送过来的主题

  client.subscribe('sensor/alarm', {
    qos: 1
  }, function (err) {
    if (!err) {
      console.log('成功订阅 sensor/alarm');
    } else {
      console.log('失败订阅 sensor/alarm');
    }
  }); //主动订阅保存状态下的传感器数据主题

  client.subscribe('miss_data', {
    qos: 1
  }, function (err) {
    if (err) {
      console.log("miss_data主题订阅失败");
    } else {
      console.log("miss_data主题订阅成功");
    }
  }); //主动订阅心跳主题

  client.subscribe('heartbeat', {
    qos: 1
  }, function (err) {
    if (err) {
      console.log("订阅sensor/heartTest_device主题失败");
    } else {
      console.log("订阅sensor/heartTest_device主题成功");
    }
  }); //主动订阅自动模式下修改控件的监听主题
  // client.subscribe('veiw',{qos:1},(err)=>{
  //   if(err){
  //     console.log("订阅view主题失败");
  //   } 
  //   else{
  //     console.log("订阅view主题成功");
  //   }
  // });
  //主动订阅入库主题

  client.subscribe('direct1', {
    qos: 1
  }, function (err) {
    if (err) {
      console.log("订阅direct1主题失败");
    } else {
      console.log("订阅direct1主题成功");
    }
  });
  client.subscribe('alarm', {
    qos: 1
  }, function (err) {
    if (err) {
      console.log("订阅alarm主题失败");
    } else {
      console.log("订阅alarm主题成功");
    }
  });
  client.subscribe('alarm1', {
    qos: 1
  }, function (err) {
    if (err) {
      console.log("订阅alarm1主题失败");
    } else {
      console.log("订阅alarm1主题成功");
    }
  });
  client.subscribe('chonglian', {
    qos: 1
  }, function (err) {
    if (err) {
      console.log("订阅chonglian主题失败");
    } else {
      console.log("订阅chonglian主题成功");
    }
  });
});
client.on('disconnect', function () {
  console.log("断开连接");
}); //监听控制台客户端对象收到的消息--接收方完成即可

client.on('message', function _callee2(topic, message) {
  var _ref, _ref2, rows1, _JSON$parse, d_no, waibuwendu, neibuwendu, guangzhao, type, time_base, obj, _ref3, _ref4, rows, _JSON$parse2, _d_no, _neibuwendu, _waibuwendu, _guangzhao, _type, hour, minute, second, _ref5, _ref6, _rows, _time_base, _obj, time, _ref7, _ref8, _rows2, _JSON$parse3, Vstatus, _ref9, _ref10, _rows3, _ref11, _ref12, rows0, _ref13, _ref14, _rows4, _JSON$parse4, OK, _ref15, _ref16, _rows5, _ref17, _ref18, _rows6, sum, i, _ref19, _ref20, rows2, _JSON$parse5, PID, VID, _ref21, _ref22, _rows7;

  return regeneratorRuntime.async(function _callee2$(_context4) {
    while (1) {
      switch (_context4.prev = _context4.next) {
        case 0:
          if (!(topic === "sensor/data")) {
            _context4.next = 23;
            break;
          }

          _context4.next = 3;
          return regeneratorRuntime.awrap(connection1.execute("\n      SELECT p_name \n      FROM t_field_mapper\n      "));

        case 3:
          _ref = _context4.sent;
          _ref2 = _slicedToArray(_ref, 1);
          rows1 = _ref2[0];
          //为{ p_name:TI,p_name:TO,p_name:L}的结构
          // 首先获取到指标变量的内容 
          console.log("接收到传感器数据");
          console.log(JSON.parse(message));
          _JSON$parse = JSON.parse(message), d_no = _JSON$parse.d_no, waibuwendu = _JSON$parse.waibuwendu, neibuwendu = _JSON$parse.neibuwendu, guangzhao = _JSON$parse.guangzhao, type = _JSON$parse.type; //首先判断值是否合法后进行插入

          if (!(waibuwendu > 0 && neibuwendu > 0 && guangzhao > 0)) {
            _context4.next = 21;
            break;
          }

          //基础时间值获取
          time_base = getFormattedDate(); //数据库中映射字段的使用

          obj = {};
          rows1.forEach(function (item, index) {
            if (index === 0) {
              obj[item.p_name] = neibuwendu; //由于为对象的最新属性进行初始化故无法直接使用.运算符进行属性的索引赋值而应该使用的是[]进行属性名的直接获取
            } else if (index === 1) {
              obj[item.p_name] = waibuwendu;
            } else if (index === 2) {
              obj[item.p_name] = guangzhao;
            }
          }); // 将传感器数据存入到t_data中

          if (!type) {
            type = "实时数据";
          } // 当d_no不存在时：


          if (!d_no) {
            d_no = null;
          }

          console.log("T1:" + obj.TI); // const time = `${time_base.split("-")[0]}-${time_base.split("-")[1]}-${time_base.split("-")[2]} ${hour}:${minute}:${second}`;

          _context4.next = 18;
          return regeneratorRuntime.awrap(connection1.execute("\n      INSERT INTO t_data(d_no,field1,field2,field3,field4,c_time,type)\n      VALUES (\"".concat(d_no, "\",\"").concat(obj.TI, "\",\"").concat(obj.TO, "\",\"").concat(obj.L, "\",\"1\",\"").concat(time_base, "\",\"").concat(type, "\")\n      ")));

        case 18:
          _ref3 = _context4.sent;
          _ref4 = _slicedToArray(_ref3, 1);
          rows = _ref4[0];

        case 21:
          _context4.next = 116;
          break;

        case 23:
          if (!(topic === "miss_data")) {
            _context4.next = 47;
            break;
          }

          console.log("接收到了");
          _JSON$parse2 = JSON.parse(message), _d_no = _JSON$parse2.d_no, _neibuwendu = _JSON$parse2.neibuwendu, _waibuwendu = _JSON$parse2.waibuwendu, _guangzhao = _JSON$parse2.guangzhao, _type = _JSON$parse2.type, hour = _JSON$parse2.hour, minute = _JSON$parse2.minute, second = _JSON$parse2.second;

          if (!(_neibuwendu > 0 && _waibuwendu > 0 && _guangzhao > 0)) {
            _context4.next = 45;
            break;
          }

          _context4.next = 29;
          return regeneratorRuntime.awrap(connection1.execute("\n      SELECT p_name\n      FROM t_field_mapper\n      "));

        case 29:
          _ref5 = _context4.sent;
          _ref6 = _slicedToArray(_ref5, 1);
          _rows = _ref6[0];
          //为{ p_name:S1,p_name:S2,p_name:I}的结构
          // 首先获取到指标变量的内容
          console.log("接收到传感器数据");
          console.log(JSON.parse(message)); //基础时间值获取

          _time_base = getFormattedDate(); //数据库中映射字段的使用

          _obj = {};

          _rows.forEach(function (item, index) {
            if (index === 0) {
              _obj[item.p_name] = _neibuwendu; //由于为对象的最新属性进行初始化故无法直接使用.运算符进行属性的索引赋值而应该使用的是[]进行属性名的直接获取
            } else if (index === 1) {
              _obj[item.p_name] = _waibuwendu;
            } else if (index === 2) {
              _obj[item.p_name] = _guangzhao;
            }
          }); // //将传感器数据存入到t_data中


          if (!_type) {
            _type = "保存数据";
          }

          if (!_d_no) {
            _d_no = null;
          }

          time = "".concat(_time_base.split("-")[0], "-").concat(_time_base.split("-")[1], "-").concat(_time_base.split("-")[2], " ").concat(hour, ":").concat(minute, ":").concat(second);
          _context4.next = 42;
          return regeneratorRuntime.awrap(connection1.execute("\n      INSERT INTO t_data(d_no,field1,field2,field3,field4,c_time,type)\n      VALUES (\"".concat(_d_no, "\",\"").concat(_obj.TI, "\",\"").concat(_obj.TO, "\",\"").concat(_obj.L, "\",\"1\",\"").concat(time, "\",\"").concat(_type, "\")\n      ")));

        case 42:
          _ref7 = _context4.sent;
          _ref8 = _slicedToArray(_ref7, 1);
          _rows2 = _ref8[0];

        case 45:
          _context4.next = 116;
          break;

        case 47:
          if (!(topic === "heartbeat")) {
            _context4.next = 52;
            break;
          }

          //当发送的心跳消息得到响应的时候的主题消息的内容的执行 --心跳信息中应当存在设备编号的信息
          console.log("收到底层心跳"); // 单设备

          reconnect_republish(); //完成对应设备的心跳置true
          // 多设备
          //获取到d_no信息
          // const {d_no} = JSON.parse(message);
          // reconnect_republish(d_no);//完成对应设备的心跳置true

          _context4.next = 116;
          break;

        case 52:
          if (!(topic === "alarm")) {
            _context4.next = 71;
            break;
          }

          _JSON$parse3 = JSON.parse(message), Vstatus = _JSON$parse3.Vstatus;
          _context4.next = 56;
          return regeneratorRuntime.awrap(connection1.execute("\n      UPDATE t_error_msg\n      SET e_msg = \"".concat(Vstatus === "1" ? "空调故障" : Vstatus === "2" ? "风扇故障" : Vstatus === "3" ? "危险气体浓度超标" : Vstatus === "4" ? "湿度超标" : "储运箱断电时间过长", "\", c_time = \"").concat(getFormattedDate(), "\"\n      WHERE id = ").concat(Number(Vstatus), ";\n    ")));

        case 56:
          _ref9 = _context4.sent;
          _ref10 = _slicedToArray(_ref9, 1);
          _rows3 = _ref10[0];
          _context4.next = 61;
          return regeneratorRuntime.awrap(connection1.execute("\n      UPDATE t_error_msg\n      SET VStatus = \"1\"; \n    "));

        case 61:
          _ref11 = _context4.sent;
          _ref12 = _slicedToArray(_ref11, 1);
          rows0 = _ref12[0];
          _context4.next = 66;
          return regeneratorRuntime.awrap(connection1.execute("\n    INSERT INTO t_error_history(e_msg,c_time)\n    VALUES (\"".concat(Vstatus === "1" ? "空调故障" : Vstatus === "2" ? "风扇故障" : Vstatus === "3" ? "危险气体浓度超标" : Vstatus === "4" ? "湿度超标" : "储运箱断电时间过长", "\",\"").concat(getFormattedDate(), "\")\n    ")));

        case 66:
          _ref13 = _context4.sent;
          _ref14 = _slicedToArray(_ref13, 1);
          _rows4 = _ref14[0];
          _context4.next = 116;
          break;

        case 71:
          if (!(topic === "alarm1")) {
            _context4.next = 104;
            break;
          }

          console.log("alarm1成功触发");
          _JSON$parse4 = JSON.parse(message), OK = _JSON$parse4.OK;
          _context4.next = 76;
          return regeneratorRuntime.awrap(connection1.execute("\n      UPDATE t_error_msg\n      SET e_msg = \"\u672A\u53D1\u751F\u544A\u8B66\", c_time = \"".concat(getFormattedDate(), "\" \n      WHERE id = ").concat(Number(OK), ";\n    ")));

        case 76:
          _ref15 = _context4.sent;
          _ref16 = _slicedToArray(_ref15, 1);
          _rows5 = _ref16[0];
          _context4.next = 81;
          return regeneratorRuntime.awrap(connection1.execute("\n      SELECT e_msg\n      FROM t_error_msg \n    "));

        case 81:
          _ref17 = _context4.sent;
          _ref18 = _slicedToArray(_ref17, 1);
          _rows6 = _ref18[0];
          console.dir("rows1:" + _rows6); //遍历判断e_msg值

          sum = 0;
          i = 0;

        case 87:
          if (!(i < 5)) {
            _context4.next = 96;
            break;
          }

          if (!(_rows6[i].e_msg === "未发生告警")) {
            _context4.next = 92;
            break;
          }

          sum++;
          _context4.next = 93;
          break;

        case 92:
          return _context4.abrupt("break", 96);

        case 93:
          i++;
          _context4.next = 87;
          break;

        case 96:
          if (!(sum === 5)) {
            _context4.next = 102;
            break;
          }

          _context4.next = 99;
          return regeneratorRuntime.awrap(connection1.execute("\n      UPDATE t_error_msg\n      SET VStatus = \"0\";\n    "));

        case 99:
          _ref19 = _context4.sent;
          _ref20 = _slicedToArray(_ref19, 1);
          rows2 = _ref20[0];

        case 102:
          _context4.next = 116;
          break;

        case 104:
          if (!(topic === "chonglian")) {
            _context4.next = 109;
            break;
          }

          // 同步系统时间到设备层 now_time NowTime:...
          console.log("当前接收到重连消息");
          setTimeout(function () {
            beifen(0, ["chonglian1", {
              time: "".concat(getTongbu())
            }]); //发布当前时间信息到同步时间相关的主题中
          }, 10000);
          _context4.next = 116;
          break;

        case 109:
          if (!(topic === "direct1")) {
            _context4.next = 116;
            break;
          }

          _JSON$parse5 = JSON.parse(message), PID = _JSON$parse5.PID, VID = _JSON$parse5.VID;
          _context4.next = 113;
          return regeneratorRuntime.awrap(connection1.execute("\n    INSERT INTO t_container(VID,ctime,PID)\n    VALUES (\"".concat(VID, "\",\"").concat(getFormattedDate(), "\",\"").concat(PID, "\")\n    ")));

        case 113:
          _ref21 = _context4.sent;
          _ref22 = _slicedToArray(_ref21, 1);
          _rows7 = _ref22[0];

        case 116:
        case "end":
          return _context4.stop();
      }
    }
  });
}); // //模拟发送传感器数据的客户端
// setInterval(async()=>{
//   const min = 10;
//   const max = 30
//   const randomDecimal1 = Math.random() * (max - min) + min;
//   const randomDecimal2 = Math.random() * (max - min) + min;
//   const randomDecimal3 = Math.random()>0.5? 1:0 ;
//   client.publish("sensor/data",JSON.stringify({yanwu1:randomDecimal1.toFixed(2),yanwu2:randomDecimal2.toFixed(2),warning_flag:randomDecimal3}),{qos:1});
// },2000);