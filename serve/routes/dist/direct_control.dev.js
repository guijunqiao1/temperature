"use strict";

Object.defineProperty(exports, "__esModule", {
  value: true
});
exports.t_direct_control = t_direct_control;

var _koaRouter = _interopRequireDefault(require("koa-router"));

var _indexNode = _interopRequireDefault(require("../indexNode2.js"));

var _mqtt_server_get = require("./mqtt_server_get.js");

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { "default": obj }; }

function _slicedToArray(arr, i) { return _arrayWithHoles(arr) || _iterableToArrayLimit(arr, i) || _nonIterableRest(); }

function _nonIterableRest() { throw new TypeError("Invalid attempt to destructure non-iterable instance"); }

function _iterableToArrayLimit(arr, i) { if (!(Symbol.iterator in Object(arr) || Object.prototype.toString.call(arr) === "[object Arguments]")) { return; } var _arr = []; var _n = true; var _d = false; var _e = undefined; try { for (var _i = arr[Symbol.iterator](), _s; !(_n = (_s = _i.next()).done); _n = true) { _arr.push(_s.value); if (i && _arr.length === i) break; } } catch (err) { _d = true; _e = err; } finally { try { if (!_n && _i["return"] != null) _i["return"](); } finally { if (_d) throw _e; } } return _arr; }

function _arrayWithHoles(arr) { if (Array.isArray(arr)) return arr; }

var Router_direct_response = new _koaRouter["default"]();
var connection;

// 获取格式化时间字符串
function getFormattedDate() {
  var now = new Date();
  var year = now.getFullYear();
  var month = String(now.getMonth() + 1).padStart(2, '0');
  var day = String(now.getDate()).padStart(2, '0');
  var hours = String(now.getHours()).padStart(2, '0');
  var minutes = String(now.getMinutes()).padStart(2, '0');
  var seconds = String(now.getSeconds()).padStart(2, '0');
  return "".concat(year, "-").concat(month, "-").concat(day, " ").concat(hours, ":").concat(minutes, ":").concat(seconds);
}

function t_direct_control() {
  var result, rowx;
  return regeneratorRuntime.async(function t_direct_control$(_context2) {
    while (1) {
      switch (_context2.prev = _context2.next) {
        case 0:
          _context2.prev = 0;
          _context2.next = 3;
          return regeneratorRuntime.awrap((0, _indexNode["default"])());

        case 3:
          connection = _context2.sent;
          console.log("数据库连接成功");
          _context2.next = 7;
          return regeneratorRuntime.awrap(connection.execute("\n      SELECT c.id,c.f_type,c.mode,c.f_value,c.t_name,c.max,c.min,c.topic,c.header,c.luyou\n      FROM t_direct_config c\n      WHERE ok in (\"yes\",\"yes1\") \n      ORDER BY CASE f_type\n          WHEN '1' THEN 1\n          ELSE 2\n        END;\n    "));

        case 7:
          result = _context2.sent;
          rowx = result[0];
          console.log("成功进入外层");
          console.dir(rowx);
          rowx.forEach(function (item, index) {
            console.log("item:" + item.luyou);
            Router_direct_response.get("/zhiling/" + item.luyou, function _callee(ctx) {
              var _ctx$query, content, d_no, obj1, tem1, tem11, topic, C1, C2, E1, E2, N1, N2, formatTime, _ref, _ref2, rowsx, template, _ref3, _ref4, row;

              return regeneratorRuntime.async(function _callee$(_context) {
                while (1) {
                  switch (_context.prev = _context.next) {
                    case 0:
                      _ctx$query = ctx.query, content = _ctx$query.content, d_no = _ctx$query.d_no;
                      console.log("当前总neriong:");
                      console.dir(item);
                      console.log("content:" + content);
                      obj1 = {};

                      if (!(item.f_type !== '2' && item.f_type !== '3' && item.f_type !== '4')) {
                        _context.next = 20;
                        break;
                      }

                      //开关或单选框的情况
                      C1 = item.f_value.split("|")[0].split(":")[0];
                      C2 = item.f_value.split("|")[1].split(":")[0];
                      E1 = item.f_value.split("|")[0].split(":")[1];
                      E2 = item.f_value.split("|")[1].split(":")[1];
                      N1 = item.header.split("|")[0];
                      N2 = item.header.split("|")[1];
                      tem1 = content === C1 ? E1 : E2;
                      tem11 = content === C1 ? N1 : N2;
                      topic = item.topic;

                      if (item.id === 12) {
                        tem11 = 'on' + d_no.split("工位")[1] + '_' + (content === "开" ? '4' : '0');
                      }

                      obj1[tem1] = tem11;
                      content = content === C1 ? C1 : C2;
                      _context.next = 37;
                      break;

                    case 20:
                      formatTime = function formatTime(timeStr) {
                        return new Date(timeStr).toISOString().slice(0, 19).replace('T', ' ');
                      };

                      console.log("成功进入时间判断");
                      tem1 = item.f_value.split("|")[0];

                      if (!content) {
                        _context.next = 27;
                        break;
                      }

                      if (item.f_type === "4") {
                        content = formatTime(content);
                        console.log("时间值格式:" + content);
                        tem11 = content.split(" ")[1];
                        console.log("time:" + tem11);
                      } else {
                        tem11 = content;
                      }

                      _context.next = 33;
                      break;

                    case 27:
                      _context.next = 29;
                      return regeneratorRuntime.awrap(connection.execute("\n              SELECT t_direct.value\n              FROM t_direct,t_direct_config\n              WHERE t_direct_config.id = t_direct.config_id\n              AND t_direct_config.id = ".concat(item.id, "\n              AND d_no = \"").concat(d_no === "null" ? "null" : "".concat(d_no), "\"\n            ")));

                    case 29:
                      _ref = _context.sent;
                      _ref2 = _slicedToArray(_ref, 1);
                      rowsx = _ref2[0];

                      if (item.f_type === "4") {
                        tem11 = rowsx[0].value.split(" ")[1];
                        console.log("time:" + tem11);
                      } else {
                        tem11 = content;
                      }

                    case 33:
                      topic = item.topic;
                      console.log("item.id:" + item.id);

                      if (item.id === 12) {
                        //  "开:deng": "on工位1_2"
                        console.log("最终进入的是此处");
                        console.log("最终进入的是此处");
                        console.log("最终进入的是此处");
                        console.log("最终进入的是此处");
                        tem1 = item.f_value.split("|")[0].split(":")[1]; //临时content转化

                        content = content === '开' ? 4 : 0;
                        tem11 = 'on' + d_no.split("工位")[1] + '_' + content;
                      }

                      obj1[tem1] = tem11;

                    case 37:
                      if (!d_no) {
                        _context.next = 58;
                        break;
                      }

                      console.log("即将更新:" + d_no);
                      template = topic;
                      console.log("tem:" + template);
                      (0, _mqtt_server_get.beifen)(d_no, [template, obj1]);
                      console.log("注册的一次路由");
                      _context.next = 45;
                      return regeneratorRuntime.awrap(connection.execute("\n            INSERT INTO operate_history(place,device,operate,ctime)\n            VALUES('".concat(d_no, "','").concat(item.t_name, "','\u4FEE\u6539\u4E3A").concat(content, "','").concat(getFormattedDate(), "')\n          ")));

                    case 45:
                      _context.next = 47;
                      return regeneratorRuntime.awrap(connection.execute("\n            SELECT config_id\n            FROM t_direct,t_direct_config\n            WHERE t_direct_config.id = t_direct.config_id\n            AND t_direct_config.id = ".concat(item.id, "\n            AND d_no = \"").concat(d_no, "\"\n          ")));

                    case 47:
                      _ref3 = _context.sent;
                      _ref4 = _slicedToArray(_ref3, 1);
                      row = _ref4[0];

                      if (row[0]) {
                        _context.next = 55;
                        break;
                      }

                      _context.next = 53;
                      return regeneratorRuntime.awrap(connection.execute("\n              INSERT INTO t_direct(config_id,value,d_no)\n              VALUE(".concat(item.id, ",\"").concat(content, "\",\"").concat(d_no, "\")\n            ")));

                    case 53:
                      _context.next = 57;
                      break;

                    case 55:
                      _context.next = 57;
                      return regeneratorRuntime.awrap(connection.execute("\n              UPDATE t_direct\n              SET value = \"".concat(content, "\"\n              WHERE config_id = ").concat(item.id, "\n            ")));

                    case 57:
                      //指令更新完毕后进行全局变量的阈值的赋值
                      if (item.f_type === '2') {
                        //针对阈值情况进行单独全局变量的修改
                        console.log("检查后发现的内容为,item:");
                        console.dir(item);
                        console.log("检查后发现的内容为,obj1:");
                        console.dir(obj1);
                        (0, _mqtt_server_get.beifen)(d_no, ['change_yuzhi', obj1]);
                      }

                    case 58:
                      ctx.body = "ok";

                    case 59:
                    case "end":
                      return _context.stop();
                  }
                }
              });
            }); //测试路由

            Router_direct_response.get('/test111', function (ctx) {
              ctx.body = 'ok';
            }); //检测情况下的操作设备接口

            Router_direct_response.get('/operate_device', function (ctx) {
              var d_no = ctx.query.d_no;
              console.log("-----------------------------------------------"); //定义纯净数组

              var pure_array = []; //定义纯净数组的检查方法

              function pure_panduan(value) {
                //定义标记变量
                var sign = false;
                pure_array.forEach(function (item, index) {
                  if (item.type === value.type) sign = true;
                });
                return sign;
              } //浅拷贝只读数组
              //模拟情况


              var error = [[{
                type: '温度',
                how: '偏小'
              }, {
                type: '温度',
                how: '偏大'
              }], [{
                type: '湿度',
                how: '偏大'
              }, {
                type: '湿度',
                how: '偏小'
              }], [{
                type: '光照',
                how: '偏小'
              }, {
                type: '光照',
                how: '偏大'
              }]]; // const qian_array = [...error_quene];

              var qian_array = [].concat(error);
              console.log("查看当前数组：");
              console.dir(qian_array); //定义错误队列的相同维度下优先取得后续维度情况下的how的取值的处理去重方法

              function qu_quene(value) {
                for (var i = qian_array[value].length - 1; i >= 0; i--) {
                  console.log("进入一次遍历");

                  if (qian_array[value][i].type === '温度' && !pure_panduan(qian_array[value][i])) {
                    pure_array.push(qian_array[value][i]);
                  } else if (qian_array[value][i].type === '湿度' && !pure_panduan(qian_array[value][i])) {
                    pure_array.push(qian_array[value][i]);
                  } else if (qian_array[value][i].type === '光照' && !pure_panduan(qian_array[value][i])) {
                    pure_array.push(qian_array[value][i]);
                  }

                  if (pure_array.length === 3) {
                    break;
                  }
                }
              } //定义主题变量


              var topic = 'send';

              if (d_no === '工位1') {
                console.log("当前成功进入指令自动push接口"); //遍历前进行error_quene的去重

                qu_quene(0);
                console.log("去重后的只读数组:");
                console.dir(pure_array);
                pure_array.forEach(function (item, index) {
                  if (item.type === '温度') {
                    var obj1 = {};
                    var obj2 = {};

                    if (item.how === '偏大') {
                      //发送指定指令
                      (0, _mqtt_server_get.beifen)(d_no, [topic, obj1]);
                    } else {
                      (0, _mqtt_server_get.beifen)(d_no, [topic, obj2]);
                    }
                  } else if (item.type === '湿度') {
                    var _obj = {};
                    var _obj2 = {};

                    if (item.how === '偏大') {
                      //发送指定指令
                      (0, _mqtt_server_get.beifen)(d_no, [topic, _obj]);
                    } else {
                      (0, _mqtt_server_get.beifen)(d_no, [topic, _obj2]);
                    }
                  } else if (item.type === '光照') {
                    var _obj3 = {
                      "deng": "on1_0"
                    };
                    var _obj4 = {
                      "deng": 'on1_4'
                    };

                    if (item.how === '偏大') {
                      //发送指定指令
                      (0, _mqtt_server_get.beifen)(d_no, [topic, _obj3]);
                    } else {
                      (0, _mqtt_server_get.beifen)(d_no, [topic, _obj4]);
                    }
                  }
                }); //静止之后进行总数组的清空

                for (var i = 0; i < qian_array[0].length; i++) {
                  qian_array[0].shift();

                  _mqtt_server_get.error_quene[0].shift();
                }
              } else if (d_no === '工位2') {
                //遍历前进行error_quene的去重
                qu_quene(1);
                qian_array[1].forEach(function (item, index) {
                  if (item.type === '温度') {
                    var obj1 = {};
                    var obj2 = {};

                    if (item.how === '偏大') {
                      //发送指定指令
                      (0, _mqtt_server_get.beifen)(d_no, [topic, obj1]);
                    } else {
                      (0, _mqtt_server_get.beifen)(d_no, [topic, obj2]);
                    }
                  } else if (item.type === '湿度') {
                    var _obj5 = {};
                    var _obj6 = {};

                    if (item.how === '偏大') {
                      //发送指定指令
                      (0, _mqtt_server_get.beifen)(d_no, [topic, _obj5]);
                    } else {
                      (0, _mqtt_server_get.beifen)(d_no, [topic, _obj6]);
                    }
                  } else if (item.type === '光照') {
                    var _obj7 = {};
                    var _obj8 = {};

                    if (item.how === '偏大') {
                      //发送指定指令
                      (0, _mqtt_server_get.beifen)(d_no, [topic, _obj7]);
                    } else {
                      (0, _mqtt_server_get.beifen)(d_no, [topic, _obj8]);
                    }
                  }
                }); //静止之后进行总数组的清空

                for (var _i2 = 0; _i2 < qian_array[1].length; _i2++) {
                  qian_array[1].shift();

                  _mqtt_server_get.error_quene[1].shift();
                }
              } else if (d_no === '工位3') {
                //遍历前进行error_quene的去重
                qu_quene(2);
                qian_array[2].forEach(function (item, index) {
                  if (item.type === '温度') {
                    var obj1 = {};
                    var obj2 = {};

                    if (item.how === '偏大') {
                      //发送指定指令
                      (0, _mqtt_server_get.beifen)(d_no, [topic, obj1]);
                    } else {
                      (0, _mqtt_server_get.beifen)(d_no, [topic, obj2]);
                    }
                  } else if (item.type === '湿度') {
                    var _obj9 = {};
                    var _obj10 = {};

                    if (item.how === '偏大') {
                      //发送指定指令
                      (0, _mqtt_server_get.beifen)(d_no, [topic, _obj9]);
                    } else {
                      (0, _mqtt_server_get.beifen)(d_no, [topic, _obj10]);
                    }
                  } else if (item.type === '光照') {
                    var _obj11 = {};
                    var _obj12 = {};

                    if (item.how === '偏大') {
                      //发送指定指令
                      (0, _mqtt_server_get.beifen)(d_no, [topic, _obj11]);
                    } else {
                      (0, _mqtt_server_get.beifen)(d_no, [topic, _obj12]);
                    }
                  }
                }); //静止之后进行总数组的清空

                for (var _i3 = 0; _i3 < qian_array[2].length; _i3++) {
                  qian_array[2].shift();

                  _mqtt_server_get.error_quene[2].shift();
                }
              }

              ctx.body = 'ok';
            });
          });
          return _context2.abrupt("return", Router_direct_response);

        case 15:
          _context2.prev = 15;
          _context2.t0 = _context2["catch"](0);
          console.log(_context2.t0);
          console.log("数据库连接失败");

        case 19:
        case "end":
          return _context2.stop();
      }
    }
  }, null, null, [[0, 15]]);
}

;