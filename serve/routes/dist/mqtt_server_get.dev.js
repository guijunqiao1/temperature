"use strict";

Object.defineProperty(exports, "__esModule", {
  value: true
});
exports.beifen = beifen;
exports.client = exports.active = exports.test_times = exports.gongwei = exports.test = void 0;

var _mqtt = _interopRequireDefault(require("mqtt"));

var _indexNode = _interopRequireDefault(require("../indexNode2.js"));

var _axios = _interopRequireDefault(require("axios"));

var _ws = _interopRequireDefault(require("ws"));

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { "default": obj }; }

function _slicedToArray(arr, i) { return _arrayWithHoles(arr) || _iterableToArrayLimit(arr, i) || _nonIterableRest(); }

function _nonIterableRest() { throw new TypeError("Invalid attempt to destructure non-iterable instance"); }

function _iterableToArrayLimit(arr, i) { if (!(Symbol.iterator in Object(arr) || Object.prototype.toString.call(arr) === "[object Arguments]")) { return; } var _arr = []; var _n = true; var _d = false; var _e = undefined; try { for (var _i = arr[Symbol.iterator](), _s; !(_n = (_s = _i.next()).done); _n = true) { _arr.push(_s.value); if (i && _arr.length === i) break; } } catch (err) { _d = true; _e = err; } finally { try { if (!_n && _i["return"] != null) _i["return"](); } finally { if (_d) throw _e; } } return _arr; }

function _arrayWithHoles(arr) { if (Array.isArray(arr)) return arr; }

//定义全局测试启动变量以及工位启动变量、测试次数变量
var test;
exports.test = test;
var gongwei;
exports.gongwei = gongwei;
var test_times = [];
exports.test_times = test_times;
var connection1; //定义数据库连接对象--project02

(function _callee() {
  var _ref, _ref2, rows, _ref3, _ref4, rows1, _ref5, _ref6, rows2;

  return regeneratorRuntime.async(function _callee$(_context) {
    while (1) {
      switch (_context.prev = _context.next) {
        case 0:
          _context.prev = 0;
          _context.next = 3;
          return regeneratorRuntime.awrap((0, _indexNode["default"])());

        case 3:
          connection1 = _context.sent;
          console.log("数据库333333连接成功");
          _context.next = 7;
          return regeneratorRuntime.awrap(connection1.execute("\n      SELECT times \n      FROM t_data\n      WHERE d_no = \"\u5DE5\u4F4D1\"\n      ORDER BY times DESC\n      LIMIT 1;\n    "));

        case 7:
          _ref = _context.sent;
          _ref2 = _slicedToArray(_ref, 1);
          rows = _ref2[0];
          console.log("成功了一次");
          test_times.push(rows[0]['times']);
          _context.next = 14;
          return regeneratorRuntime.awrap(connection1.execute("\n      SELECT times \n      FROM t_data\n      WHERE d_no = \"\u5DE5\u4F4D2\"\n      ORDER BY times DESC\n      LIMIT 1;\n    "));

        case 14:
          _ref3 = _context.sent;
          _ref4 = _slicedToArray(_ref3, 1);
          rows1 = _ref4[0];
          test_times.push(rows1[0]['times']);
          _context.next = 20;
          return regeneratorRuntime.awrap(connection1.execute("\n      SELECT times \n      FROM t_data\n      WHERE d_no = \"\u5DE5\u4F4D3\"\n      ORDER BY times DESC\n      LIMIT 1;\n    "));

        case 20:
          _ref5 = _context.sent;
          _ref6 = _slicedToArray(_ref5, 1);
          rows2 = _ref6[0];
          test_times.push(rows2[0]['times']);
          console.log("此时完成了test_times的赋值~~~~~~~~:" + test_times);
          _context.next = 30;
          break;

        case 27:
          _context.prev = 27;
          _context.t0 = _context["catch"](0);
          console.log("数据库3连接失败");

        case 30:
        case "end":
          return _context.stop();
      }
    }
  }, null, null, [[0, 27]]);
})(); //动态获取到多设备的总数，完成设备列表的填充
// const [rows1] = await connection1.execute(`
// SELECT d_no 
// FROM t_device
// WHERE device_name = "电动自行车"
// `);
//定义当前心跳是否正常的标志变量
// export let active_array = [[2021,false]];


var active = false; // for(let i=0;i<rows1[0].length;i++){
//   active_array.push([Number(rows1[0][i]),false]);
// }
//定义指令备份数组
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
} //定义获取当前时间并且为特定格式的方法


function getFormattedDate1() {
  var now = new Date();
  var year = now.getFullYear();
  var month = String(now.getMonth() + 1).padStart(2, '0'); // 月份从0开始，需要加1

  var day = String(now.getDate()).padStart(2, '0');
  var hours = String(now.getHours()).padStart(2, '0');
  var minutes = String(now.getMinutes()).padStart(2, '0');
  var seconds = String(now.getSeconds()).padStart(2, '0');
  return "".concat(year, "-").concat(month, "-").concat(day, " ").concat(hours, ":").concat(minutes, ":").concat(seconds);
} // 心跳检测器
// 制作一个定时器用于定期向设备层订阅的主题中发送消息，并且设备层在接受到消息之后则响应相同的消息到应用层，用于检测设备层和应用层是不是直接的连接
// setInterval(()=>{
//   console.log("心跳正常发送");
//   // 单设备
//   active = false;
//   client.publish(`direct`,JSON.stringify({heartTest_client:"start"}),{qos:1});//多设备情况下考虑的文本内容得添加上设备的具体编号
//   //多设备
//   //首先对整个beifen数组进行缓存，并且根据其中的首元素的个数进行对应的主题的发送
//   // active_array.forEach((item,index)=>{
//   //   //在当前的item(某个不同的设备)中完成心跳的发送的操作并且将此时对应上的active标记
//   //   client.publish(`direct:${item[0]}`,JSON.stringify({heartTest_client:"start"}),{qos:1});//多设备情况下考虑的文本内容得添加上设备的具体编号
//   //   item[1] = false;
//   //   console.log("成功发送消息到主题direct:"+item[0]);
//   // })
// },5000);//每5s进行一次心跳的检测
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
} //主题订阅数组(硬转软)


var topic_array = ['sensorData', 'state']; //控制台客户端对象连接设置

client.on('connect', function () {
  console.log("接收方连接成功"); //当客户端连接成功之后订阅对应的主题
  //用于检测传感器数据的主题

  topic_array.forEach(function (item, index) {
    client.subscribe(item, {
      qos: 1
    }, function (err) {
      if (err) {
        console.log(item + "主题订阅失败");
      } else {
        console.log(item + "主题订阅成功");
      }
    });
  });
});
client.on('disconnect', function () {
  console.log("断开连接");
}); //创建websocket服务器用于实时的告警内容的填充

var wss = new _ws["default"].Server({
  port: 8081
});
console.log('WebSocket 服务器启动，端口：8081'); // 存储所有WebSocket客户端

var clients = []; // WebSocket连接处理

wss.on('connection', function (ws, req) {
  console.log('新客户端连接');
  clients.push(ws); // 发送欢迎消息

  ws.send(JSON.stringify({
    type: 'welcome',
    message: '告警系统连接成功'
  })); // 监听客户端发送的消息

  ws.on('message', function (message) {
    // 这里的 message 是客户端发送的数据
    console.log('接收到客户端消息:', message); // 你可以在这里对消息进行处理，比如解析 JSON 或其他逻辑

    var data = JSON.parse(message);
    console.log("message:" + message);
    console.log("data:" + data);

    if (data['gongwei']) {
      exports.gongwei = gongwei = data['gongwei'];
    } else if (data['test'] || data['test'] === false) {
      exports.test = test = data['test'];
    } else if (data['test_times'] || data['test_times'] === 0) {
      console.log("应当完成自增");
      if (data['test_times'] === 0) test_times[0]++;else if (data['test_times'] === 1) test_times[1]++;else if (data['test_times'] === 2) test_times[2]++;
    } else {
      console.log("没有v匹配上/");
    }
  }); // 监听客户端断开

  ws.on('close', function () {
    console.log('客户端断开连接');
    var index = clients.indexOf(ws);

    if (index > -1) {
      clients.splice(index, 1);
    }
  });
}); // 向所有客户端发送消息的函数

function sendToAllClients(data) {
  console.log("11111111111111111111111111111111");
  clients.forEach(function (client) {
    console.log("222222222222222222222222222222");

    if (client.readyState === _ws["default"].OPEN) {
      try {
        console.log("查看一次总data:");
        console.dir(data);
        client.send(data);
      } catch (error) {
        console.error('发送消息失败:', error);
      }
    }
  });
} //监听控制台客户端对象收到的消息--接收方完成即可


client.on('message', function _callee2(topic, message) {
  var temperature_panduan, smoke_panduan, shuiwei_panduan, toV, toI, getP, getQ, getW, gong_right, gong_tem, gong_smo, gong_wat, _ref7, _ref8, rows1, _JSON$parse, d_no, temperature1, temperature2, temperature3, humility1, humility2, humility3, light1, light2, light3, I1, I2, I3, V1, V2, V3, type, reflect, _JSON$parse2, _d_no, _JSON$parse3, current, _ref11, _ref12, rows, _ref13, _ref14, _rows;

  return regeneratorRuntime.async(function _callee2$(_context8) {
    while (1) {
      switch (_context8.prev = _context8.next) {
        case 0:
          shuiwei_panduan = function _ref17(value) {
            if (value >= 0 && value <= 100) return true;else return false;
          };

          smoke_panduan = function _ref16(value) {
            if (value >= 0 && value <= 100) return true;else return false;
          };

          temperature_panduan = function _ref15(value) {
            if (value >= 0 && value <= 100) return true;else return false;
          };

          console.log("成功接收到消息"); //告警

          if (!(topic === "sensorData")) {
            _context8.next = 47;
            break;
          }

          //封装电维度的公式
          toV = function toV(V) {
            return Math.round(V * 100) / 100 / 1000;
          };

          toI = function toI(I) {
            return Math.round(I * 100) / 100 / 1000;
          };

          getP = function getP(I, V) {
            return I * V;
          };

          getQ = function getQ(I) {
            return I * 1;
          };

          getW = function getW(P) {
            return P * 1;
          }; //公共块封装


          gong_right = function gong_right(value) {
            var time_base, obj, _ref9, _ref10, rows;

            return regeneratorRuntime.async(function gong_right$(_context4) {
              while (1) {
                switch (_context4.prev = _context4.next) {
                  case 0:
                    //基础时间值获取
                    time_base = getFormattedDate1(); //数据库中映射字段的使用

                    obj = {};
                    rows1.forEach(function (item, index) {
                      if (index === 0) {
                        obj[item.p_name] = reflect['temperature' + value]; //由于为对象的最新属性进行初始化故无法直接使用.运算符进行属性的索引赋值而应该使用的是[]进行属性名的直接获取
                      } else if (index === 1) {
                        obj[item.p_name] = reflect['humility' + value];
                      } else if (index === 2) {
                        obj[item.p_name] = reflect['light' + value];
                      } else if (index === 3) {
                        obj[item.p_name] = toV(reflect['V' + value]);
                      } else if (index === 4) {
                        obj[item.p_name] = toI(reflect['I' + value]);
                      } else if (index === 5) {
                        obj[item.p_name] = getP(toV(reflect['V' + value]), toI(reflect['I' + value]));
                      } else if (index === 6) {
                        obj[item.p_name] = getQ(toI(reflect['I' + value]));
                      } else if (index === 7) {
                        obj[item.p_name] = getW(getP(toV(reflect['V' + value]), toI(reflect['I' + value])));
                      }
                    }); // 将传感器数据存入到t_data中

                    if (!type) {
                      type = "实时数据";
                    } // 当d_no不存在时：


                    if (!d_no) {
                      d_no = null;
                    } // const time = `${time_base.split("-")[0]}-${time_base.split("-")[1]}-${time_base.split("-")[2]} ${hour}:${minute}:${second}`;


                    _context4.next = 7;
                    return regeneratorRuntime.awrap(connection1.execute("\n      INSERT INTO t_data(d_no,field1,field2,field3,field4,field5,field6,field7,field8,c_time,type,times)\n      VALUES (\"\u5DE5\u4F4D".concat(value, "\",\"").concat(obj.T, "\",\"").concat(obj.S, "\",\"").concat(obj.L, "\",\"").concat(obj.U, "\",\"").concat(obj.I, "\",\"").concat(obj.P, "\",\"").concat(obj.Q, "\",\"").concat(obj.W, "\",\"").concat(time_base, "\",\"").concat(type, "\",\"").concat(test_times[value - 1], "\")\n      ")));

                  case 7:
                    _ref9 = _context4.sent;
                    _ref10 = _slicedToArray(_ref9, 1);
                    rows = _ref10[0];
                    //插入成功则发送动态数据
                    // 发送消息
                    sendToAllClients(JSON.stringify({
                      type: 'data',
                      data: ['工位' + value, obj.T, obj.S, obj.L, obj.U, obj.I, obj.P, obj.Q, obj.W, time_base, type, test_times[value - 1]]
                    }));

                  case 11:
                  case "end":
                    return _context4.stop();
                }
              }
            });
          };

          gong_tem = function gong_tem(value) {
            return regeneratorRuntime.async(function gong_tem$(_context5) {
              while (1) {
                switch (_context5.prev = _context5.next) {
                  case 0:
                    _context5.next = 2;
                    return regeneratorRuntime.awrap(connection1.execute("\n        INSERT INTO t_error_msg(d_no,e_msg,c_time)\n        VALUES(\"\u5DE5\u4F4D".concat(value, "\",'\u6E29\u5EA6\u8D8A\u754C',\"").concat(getFormattedDate1(), "\");\n        ")));

                  case 2:
                    console.log("--------------------------"); // 发送消息

                    sendToAllClients(JSON.stringify({
                      type: 'welcome',
                      message: "\u5DE5\u4F4D".concat(value, "\u7684\u6E29\u5EA6\u8D8A\u754C")
                    }));

                  case 4:
                  case "end":
                    return _context5.stop();
                }
              }
            });
          };

          gong_smo = function gong_smo(value) {
            return regeneratorRuntime.async(function gong_smo$(_context6) {
              while (1) {
                switch (_context6.prev = _context6.next) {
                  case 0:
                    _context6.next = 2;
                    return regeneratorRuntime.awrap(connection1.execute("\n        INSERT INTO t_error_msg(d_no,e_msg,c_time)\n        VALUES(\"\u5DE5\u4F4D".concat(value, "\",'\u70DF\u96FE\u8D8A\u754C',\"").concat(getFormattedDate1(), "\");\n        ")));

                  case 2:
                    // 发送消息
                    sendToAllClients(JSON.stringify({
                      type: 'welcome',
                      message: "\u5DE5\u4F4D".concat(value, "\u7684\u70DF\u96FE\u8D8A\u754C")
                    }));

                  case 3:
                  case "end":
                    return _context6.stop();
                }
              }
            });
          };

          gong_wat = function gong_wat(value) {
            return regeneratorRuntime.async(function gong_wat$(_context7) {
              while (1) {
                switch (_context7.prev = _context7.next) {
                  case 0:
                    _context7.next = 2;
                    return regeneratorRuntime.awrap(connection1.execute("\n        INSERT INTO t_error_msg(d_no,e_msg,c_time)\n        VALUES(\"\u5DE5\u4F4D".concat(value, "\",'\u6C34\u4F4D\u8D8A\u754C',\"").concat(getFormattedDate1(), "\");\n        ")));

                  case 2:
                    // 发送消息
                    sendToAllClients(JSON.stringify({
                      type: 'welcome',
                      message: "\u5DE5\u4F4D".concat(value, "\u7684\u6C34\u4F4D\u8D8A\u754C")
                    }));

                  case 3:
                  case "end":
                    return _context7.stop();
                }
              }
            });
          };

          console.log("成功接收到消息"); //需要注意使用await使得promise对象的值被解析进而允许使用[x]= 的方式完成数组顺序赋值

          _context8.next = 17;
          return regeneratorRuntime.awrap(connection1.execute("\n      SELECT p_name\n      FROM t_field_mapper\n      "));

        case 17:
          _ref7 = _context8.sent;
          _ref8 = _slicedToArray(_ref7, 1);
          rows1 = _ref8[0];
          //为{ p_name:TI,p_name:TO,p_name:L}的结构
          // 首先获取到指标变量的内容
          console.log("接收到传感器数据");
          console.log(JSON.parse(message));
          _JSON$parse = JSON.parse(message), d_no = _JSON$parse.d_no, temperature1 = _JSON$parse.temperature1, temperature2 = _JSON$parse.temperature2, temperature3 = _JSON$parse.temperature3, humility1 = _JSON$parse.humility1, humility2 = _JSON$parse.humility2, humility3 = _JSON$parse.humility3, light1 = _JSON$parse.light1, light2 = _JSON$parse.light2, light3 = _JSON$parse.light3, I1 = _JSON$parse.I1, I2 = _JSON$parse.I2, I3 = _JSON$parse.I3, V1 = _JSON$parse.V1, V2 = _JSON$parse.V2, V3 = _JSON$parse.V3, type = _JSON$parse.type; //定义对象名称映射变量

          reflect = {};
          reflect['temperature1'] = temperature1;
          reflect['temperature2'] = temperature2;
          reflect['temperature3'] = temperature3;
          reflect['humility1'] = humility1;
          reflect['humility2'] = humility2;
          reflect['humility3'] = humility3;
          reflect['light1'] = light1;
          reflect['light2'] = light2;
          reflect['light3'] = light3;
          reflect['I1'] = I1;
          reflect['I2'] = I2;
          reflect['I3'] = I3;
          reflect['V1'] = V1;
          reflect['V2'] = V2;
          reflect['V3'] = V3;
          console.log("条件就差一点点:");
          console.log("gongwei:" + gongwei);
          console.log("test:" + test); //首先判断值是否合法后进行插入

          if (test && gongwei === '工位1') {
            console.log("进入啦啦啦啦"); //当处于test的过程的情况下

            if (temperature_panduan(temperature1) && smoke_panduan(humility1) && shuiwei_panduan(light1)) {
              gong_right(1);
            } else {
              //插入告警表，最后发送错误消息到前端监听的路由中
              if (!temperature_panduan(temperature1)) {
                //温度出错
                gong_tem(1);
              }

              if (!smoke_panduan(humility1)) {
                //烟雾出错
                gong_smo(1);
              }

              if (!shuiwei_panduan(light1)) {
                //水位出错
                gong_wat(1);
              }
            }
          }

          if (test && gongwei === '工位2') {
            if (temperature_panduan(temperature2) && smoke_panduan(humility2) && shuiwei_panduan(light2)) {
              gong_right(2);
            } else {
              //插入告警表，最后发送错误消息到前端监听的路由中
              if (!temperature_panduan(temperature2)) {
                //温度出错
                gong_tem(2);
              }

              if (!smoke_panduan(humility2)) {
                //烟雾出错
                gong_smo(2);
              }

              if (!shuiwei_panduan(light2)) {
                //水位出错
                gong_wat(2);
              }
            }
          }

          if (test && gongwei === '工位3') {
            if (temperature_panduan(temperature3) && smoke_panduan(humility3) && shuiwei_panduan(light3)) {
              gong_right(3);
            } else {
              //插入告警表，最后发送错误消息到前端监听的路由中
              if (!temperature_panduan(temperature3)) {
                //温度出错
                gong_tem(3);
              }

              if (!smoke_panduan(humility3)) {
                //烟雾出错
                gong_smo(3);
              }

              if (!shuiwei_panduan(light3)) {
                //水位出错
                gong_wat(3);
              }
            }
          }

          _context8.next = 67;
          break;

        case 47:
          if (!(topic === "heartbeat")) {
            _context8.next = 53;
            break;
          }

          //当发送的心跳消息得到响应的时候的主题消息的内容的执行 --心跳信息中应当存在设备编号的信息
          console.log("收到底层心跳"); // 单设备
          // reconnect_republish();//完成对应设备的心跳置true
          // 多设备
          //获取到d_no信息

          _JSON$parse2 = JSON.parse(message), _d_no = _JSON$parse2.d_no;
          reconnect_republish(_d_no); //完成对应设备的心跳置true

          _context8.next = 67;
          break;

        case 53:
          if (!(topic === "state")) {
            _context8.next = 67;
            break;
          }

          console.log("chenggo进入cichu"); //解构赋值获取参数--需要设计参数名和路由名称一致完成遍历的条件设计

          _JSON$parse3 = JSON.parse(message), current = _JSON$parse3.current; // for (let key in obj) {
          //   //首先将中文值进行转化
          //   if(Number.isNaN(Number(obj.key))){//若为中文值
          //     if(obj.key==="start"||obj.key==="stop"){
          //       obj.key = obj.key==="start"?"开":"关";
          //     }
          //     else if(obj.key==="hot"||obj.key==="cold"){
          //       obj.key = obj.key==="hot"?"制热":"制冷";
          //     }
          //   }
          //   const [rows] = await connection1.execute(`
          //   UPDATE t_direct
          //   SET value = '${obj.key}'
          //   WHERE config_id IN (
          //       SELECT id
          //       FROM t_direct_config
          //       WHERE luyou = ${key}
          //   );
          //   `);
          // }

          console.log("current:" + current);
          _context8.next = 59;
          return regeneratorRuntime.awrap(connection1.execute("\n    UPDATE t_direct\n    SET value = '".concat(current.split('_')[1] === '0' ? '关' : '开', "'\n    WHERE d_no = '\u5DE5\u4F4D").concat(current.split("n")[1][0], "';\n    ")));

        case 59:
          _ref11 = _context8.sent;
          _ref12 = _slicedToArray(_ref11, 1);
          rows = _ref12[0];
          _context8.next = 64;
          return regeneratorRuntime.awrap(connection1.execute("\n    INSERT INTO operate_history(place,operate,ctime,device)\n    VALUES ('\u5DE5\u4F4D".concat(current.split("n")[1][0], "','\u4FEE\u6539\u4E3A").concat(current.split('_')[1] === '0' ? '关' : '开', "','").concat(getFormattedDate1(), "','\u7535\u78C1\u9600\u5F00\u5173')\n    ")));

        case 64:
          _ref13 = _context8.sent;
          _ref14 = _slicedToArray(_ref13, 1);
          _rows = _ref14[0];

        case 67:
        case "end":
          return _context8.stop();
      }
    }
  });
}); //模拟发送传感器数据的客户端
// setInterval(async()=>{
//   client.publish("sensorData",JSON.stringify({ temperature1:1,temperature2:2,temperature3:3,humility1:1,humility2:2,humility3:3,light1:1,light2:2,light3:3,I:1,V:2,type:"实时数据"}),{qos:1});
// },1000);