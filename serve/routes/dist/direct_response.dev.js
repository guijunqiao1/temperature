"use strict";

Object.defineProperty(exports, "__esModule", {
  value: true
});
exports["default"] = void 0;

var _express = _interopRequireDefault(require("express"));

var _indexNode = _interopRequireDefault(require("../indexNode2.js"));

var _mqtt_server_get = require("./mqtt_server_get.js");

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { "default": obj }; }

function _slicedToArray(arr, i) { return _arrayWithHoles(arr) || _iterableToArrayLimit(arr, i) || _nonIterableRest(); }

function _nonIterableRest() { throw new TypeError("Invalid attempt to destructure non-iterable instance"); }

function _iterableToArrayLimit(arr, i) { if (!(Symbol.iterator in Object(arr) || Object.prototype.toString.call(arr) === "[object Arguments]")) { return; } var _arr = []; var _n = true; var _d = false; var _e = undefined; try { for (var _i = arr[Symbol.iterator](), _s; !(_n = (_s = _i.next()).done); _n = true) { _arr.push(_s.value); if (i && _arr.length === i) break; } } catch (err) { _d = true; _e = err; } finally { try { if (!_n && _i["return"] != null) _i["return"](); } finally { if (_d) throw _e; } } return _arr; }

function _arrayWithHoles(arr) { if (Array.isArray(arr)) return arr; }

//此处获取到数据库链接配置对象
var connection; //定义数据库连接对象

var Router_direct_response = (0, _express["default"])(); //导入mqtt模块--用于指令的正确发送响应 

(function _callee() {
  return regeneratorRuntime.async(function _callee$(_context) {
    while (1) {
      switch (_context.prev = _context.next) {
        case 0:
          _context.prev = 0;
          _context.next = 3;
          return regeneratorRuntime.awrap((0, _indexNode["default"])());

        case 3:
          connection = _context.sent;
          console.log("数据库连接成功");
          _context.next = 10;
          break;

        case 7:
          _context.prev = 7;
          _context.t0 = _context["catch"](0);
          console.log("数据库连接失败");

        case 10:
        case "end":
          return _context.stop();
      }
    }
  }, null, null, [[0, 7]]);
})(); //定义全局标记变量，用于判断是否为第一次进行指令的发送


var all_sign = 0; //定义全局指令字段映射数组
// 进行具体内容执行之前将指令映射字段进行获取
//搭建监听指令的路由

Router_direct_response.get("/zhiling/control", function _callee2(req, res) {
  var _req$query, content, topic, d_no, _ref, _ref2, row, _ref3, _ref4, rows, _ref5, _ref6, _rows, _ref7, _ref8, _row, _ref9, _ref10, _rows2, _ref11, _ref12, _rows3;

  return regeneratorRuntime.async(function _callee2$(_context2) {
    while (1) {
      switch (_context2.prev = _context2.next) {
        case 0:
          _req$query = req.query, content = _req$query.content, topic = _req$query.topic, d_no = _req$query.d_no;

          if (!(content === "shoudong" || content === "zidong")) {
            _context2.next = 57;
            break;
          }

          if (!(d_no === "null")) {
            _context2.next = 30;
            break;
          }

          if (content === "shoudong") {
            if (all_sign < 6) {
              _mqtt_server_get.client.publish(topic, JSON.stringify({
                shodonmode: "start"
              }), {
                qos: 1
              });
            } else {
              _mqtt_server_get.client.publish(topic, JSON.stringify({
                shodonmode: "start"
              }), {
                qos: 1
              });

              (0, _mqtt_server_get.beifen)(0, [topic, JSON.stringify({
                shodonmode: "start"
              }), {
                qos: 1
              }]); //在实际场景像需要将payload包装成value进行直接的传递--后续则直接在publish方法中使用...展开运算符传值即可
            }
          } else if (content === "zidong") {
            if (all_sign < 6) {
              _mqtt_server_get.client.publish(topic, JSON.stringify({
                zidonmode: "start"
              }), {
                qos: 1
              });
            } else {
              _mqtt_server_get.client.publish(topic, JSON.stringify({
                zidonmode: "start"
              }), {
                qos: 1
              });

              (0, _mqtt_server_get.beifen)(0, [topic, JSON.stringify({
                zidonmode: "start"
              }), {
                qos: 1
              }]); //在实际场景像需要将payload包装成value进行直接的传递--后续则直接在publish方法中使用...展开运算符传值即可
            }
          } //指令发送完毕进行标记的修改


          all_sign++; //响应成功则进行数据库的动态数据更新--后续可能不需要这步操作

          if (content === "shoudong") {
            content = "手动";
          } else if (content === "zidong") {
            content = "自动";
          } //首先判断是否存在编号对应的内容


          _context2.next = 8;
          return regeneratorRuntime.awrap(connection.execute("\n        SELECT config_id \n        FROM t_direct\n        WHERE config_id = 0\n        "));

        case 8:
          _ref = _context2.sent;
          _ref2 = _slicedToArray(_ref, 1);
          row = _ref2[0];

          if (row) {
            _context2.next = 21;
            break;
          }

          _context2.next = 14;
          return regeneratorRuntime.awrap(connection.execute("\n        INSERT INTO t_direct(config_id,value,d_no)\n        VALUE(0,\"".concat(content, "\",\"").concat(d_no, "\")\n        ")));

        case 14:
          _ref3 = _context2.sent;
          _ref4 = _slicedToArray(_ref3, 1);
          rows = _ref4[0];
          res.send("ok");
          return _context2.abrupt("return");

        case 21:
          _context2.next = 23;
          return regeneratorRuntime.awrap(connection.execute("\n        UPDATE t_direct\n        SET value = \"".concat(content, "\"\n        WHERE config_id = 0\n        ")));

        case 23:
          _ref5 = _context2.sent;
          _ref6 = _slicedToArray(_ref5, 1);
          _rows = _ref6[0];
          res.send("ok");
          return _context2.abrupt("return");

        case 28:
          _context2.next = 55;
          break;

        case 30:
          if (content === "zidong") {
            if (all_sign < 6) {
              _mqtt_server_get.client.publish("direct:".concat(d_no), JSON.stringify({
                zidonmode: "start"
              }), {
                qos: 1
              });
            } else {
              _mqtt_server_get.client.publish("direct:".concat(d_no), JSON.stringify({
                zidonmode: "start"
              }), {
                qos: 1
              });

              (0, _mqtt_server_get.beifen)(0, ["direct:".concat(d_no), JSON.stringify({
                zidonmode: "start"
              }), {
                qos: 1
              }]); //在实际场景像需要将payload包装成value进行直接的传递--后续则直接在publish方法中使用...展开运算符传值即可
            }
          } else if (content === "shoudong") {
            if (all_sign < 6) {
              _mqtt_server_get.client.publish("direct:".concat(d_no), JSON.stringify({
                shodonmode: "start"
              }), {
                qos: 1
              });
            } else {
              _mqtt_server_get.client.publish("direct:".concat(d_no), JSON.stringify({
                shodonmode: "start"
              }), {
                qos: 1
              });

              (0, _mqtt_server_get.beifen)(0, ["direct:".concat(d_no), JSON.stringify({
                shodonmode: "start"
              }), {
                qos: 1
              }]); //在实际场景像需要将payload包装成value进行直接的传递--后续则直接在publish方法中使用...展开运算符传值即可
            }
          } //指令发送完毕标记修改


          all_sign++; //首先判断是否存在编号对应的内容

          if (content === "shoudong") {
            content = "手动";
          } else if (content === "zidong") {
            content = "自动";
          }

          _context2.next = 35;
          return regeneratorRuntime.awrap(connection.execute("\n        SELECT config_id \n        FROM t_direct\n        WHERE config_id = 19\n        AND d_no = \"".concat(d_no, "\"\n      ")));

        case 35:
          _ref7 = _context2.sent;
          _ref8 = _slicedToArray(_ref7, 1);
          _row = _ref8[0];

          if (_row) {
            _context2.next = 48;
            break;
          }

          _context2.next = 41;
          return regeneratorRuntime.awrap(connection.execute("\n        INSERT INTO t_direct(config_id,value,d_no)\n        VALUE(19,\"".concat(content, "\",\"").concat(d_no, "\")\n        ")));

        case 41:
          _ref9 = _context2.sent;
          _ref10 = _slicedToArray(_ref9, 1);
          _rows2 = _ref10[0];
          res.send("ok");
          return _context2.abrupt("return");

        case 48:
          _context2.next = 50;
          return regeneratorRuntime.awrap(connection.execute("\n        UPDATE t_direct\n        SET value = \"".concat(content, "\"\n        WHERE config_id = 19\n        AND d_no = \"").concat(d_no, "\"\n        ")));

        case 50:
          _ref11 = _context2.sent;
          _ref12 = _slicedToArray(_ref11, 1);
          _rows3 = _ref12[0];
          res.send("ok");
          return _context2.abrupt("return");

        case 55:
          _context2.next = 59;
          break;

        case 57:
          console.log("传递参数问题");
          res.send("false");

        case 59:
        case "end":
          return _context2.stop();
      }
    }
  });
});
Router_direct_response.get("/zhiling/fengshan1", function _callee3(req, res) {
  var _req$query2, content, topic, d_no, _ref13, _ref14, row, _ref15, _ref16, rows, _ref17, _ref18, _rows4, _ref19, _ref20, _row2, _ref21, _ref22, _rows5, _ref23, _ref24, _rows6;

  return regeneratorRuntime.async(function _callee3$(_context3) {
    while (1) {
      switch (_context3.prev = _context3.next) {
        case 0:
          _req$query2 = req.query, content = _req$query2.content, topic = _req$query2.topic, d_no = _req$query2.d_no;

          if (!(content === "start" || content === "stop")) {
            _context3.next = 57;
            break;
          }

          if (!(d_no === "null")) {
            _context3.next = 30;
            break;
          }

          if (all_sign < 6) {
            _mqtt_server_get.client.publish(topic, JSON.stringify({
              fengshan1: content
            }), {
              qos: 1
            });
          } else {
            _mqtt_server_get.client.publish(topic, JSON.stringify({
              fengshan1: content
            }), {
              qos: 1
            });

            (0, _mqtt_server_get.beifen)(0, [topic, JSON.stringify({
              fengshan1: content
            }), {
              qos: 1
            }]); //在实际场景像需要将payload包装成value进行直接的传递--后续则直接在publish方法中使用...展开运算符传值即可
          } //指令发送完毕，标记修改


          all_sign++; //响应成功则进行数据库的动态数据更新--后续可能不需要这步操作

          if (content === "start") {
            content = "开";
          } else if (content === "stop") {
            content = "关";
          } //首先判断是否存在编号对应的内容


          _context3.next = 8;
          return regeneratorRuntime.awrap(connection.execute("\n        SELECT config_id \n        FROM t_direct\n        WHERE config_id = 4\n        "));

        case 8:
          _ref13 = _context3.sent;
          _ref14 = _slicedToArray(_ref13, 1);
          row = _ref14[0];

          if (row) {
            _context3.next = 21;
            break;
          }

          _context3.next = 14;
          return regeneratorRuntime.awrap(connection.execute("\n        INSERT INTO t_direct(config_id,value,d_no)\n        VALUE(4,\"".concat(content, "\",\"").concat(d_no, "\")\n        ")));

        case 14:
          _ref15 = _context3.sent;
          _ref16 = _slicedToArray(_ref15, 1);
          rows = _ref16[0];
          res.send("ok");
          return _context3.abrupt("return");

        case 21:
          _context3.next = 23;
          return regeneratorRuntime.awrap(connection.execute("\n        UPDATE t_direct\n        SET value = \"".concat(content, "\"\n        WHERE config_id = 4\n        ")));

        case 23:
          _ref17 = _context3.sent;
          _ref18 = _slicedToArray(_ref17, 1);
          _rows4 = _ref18[0];
          res.send("ok");
          return _context3.abrupt("return");

        case 28:
          _context3.next = 55;
          break;

        case 30:
          //为订阅了topic:d_no主题的单独的设备进行对应消息发送
          if (all_sign < 6) {
            _mqtt_server_get.client.publish("".concat(topic, ":").concat(d_no), JSON.stringify({
              fengshan1: content
            }), {
              qos: 1
            });
          } else {
            _mqtt_server_get.client.publish("".concat(topic, ":").concat(d_no), JSON.stringify({
              fengshan1: content
            }), {
              qos: 1
            });

            (0, _mqtt_server_get.beifen)(0, ["".concat(topic, ":").concat(d_no), JSON.stringify({
              fengshan1: content
            }), {
              qos: 1
            }]); //在实际场景像需要将payload包装成value进行直接的传递--后续则直接在publish方法中使用...展开运算符传值即可
          } //指令发送完毕修改标记


          all_sign++; //首先判断是否存在编号对应的内容

          if (content === "start") {
            content = "开";
          } else if (content === "stop") {
            content = "关";
          }

          _context3.next = 35;
          return regeneratorRuntime.awrap(connection.execute("\n        SELECT config_id \n        FROM t_direct\n        WHERE config_id = 13\n        AND d_no = \"".concat(d_no, "\"\n      ")));

        case 35:
          _ref19 = _context3.sent;
          _ref20 = _slicedToArray(_ref19, 1);
          _row2 = _ref20[0];

          if (_row2) {
            _context3.next = 48;
            break;
          }

          _context3.next = 41;
          return regeneratorRuntime.awrap(connection.execute("\n        INSERT INTO t_direct(config_id,value,d_no)\n        VALUE(13,\"".concat(content, "\",\"").concat(d_no, "\")\n        ")));

        case 41:
          _ref21 = _context3.sent;
          _ref22 = _slicedToArray(_ref21, 1);
          _rows5 = _ref22[0];
          res.send("ok");
          return _context3.abrupt("return");

        case 48:
          _context3.next = 50;
          return regeneratorRuntime.awrap(connection.execute("\n        UPDATE t_direct\n        SET value = \"".concat(content, "\"\n        WHERE config_id = 13\n        AND d_no = \"").concat(d_no, "\"\n        ")));

        case 50:
          _ref23 = _context3.sent;
          _ref24 = _slicedToArray(_ref23, 1);
          _rows6 = _ref24[0];
          res.send("ok");
          return _context3.abrupt("return");

        case 55:
          _context3.next = 59;
          break;

        case 57:
          console.log("传递参数问题");
          res.send("false");

        case 59:
        case "end":
          return _context3.stop();
      }
    }
  });
});
Router_direct_response.get("/zhiling/fengshan2", function _callee4(req, res) {
  var _req$query3, content, d_no, topic, _ref25, _ref26, row, _ref27, _ref28, rows, _ref29, _ref30, _rows7, _ref31, _ref32, _row3, _ref33, _ref34, _rows8, _ref35, _ref36, _rows9;

  return regeneratorRuntime.async(function _callee4$(_context4) {
    while (1) {
      switch (_context4.prev = _context4.next) {
        case 0:
          _req$query3 = req.query, content = _req$query3.content, d_no = _req$query3.d_no, topic = _req$query3.topic;

          if (!(content === "start" || content === "stop")) {
            _context4.next = 57;
            break;
          }

          if (!(d_no === "null")) {
            _context4.next = 30;
            break;
          }

          if (all_sign < 6) {
            _mqtt_server_get.client.publish(topic, JSON.stringify({
              fengshan2: content
            }), {
              qos: 1
            });
          } else {
            _mqtt_server_get.client.publish(topic, JSON.stringify({
              fengshan2: content
            }), {
              qos: 1
            });

            (0, _mqtt_server_get.beifen)(0, [topic, JSON.stringify({
              fengshan2: content
            }), {
              qos: 1
            }]); //在实际场景像需要将payload包装成value进行直接的传递--后续则直接在publish方法中使用...展开运算符传值即可
          }

          all_sign++;

          if (content === "start") {
            content = "开";
          } else if (content === "stop") {
            content = "关";
          } //首先判断是否存在编号对应的内容


          _context4.next = 8;
          return regeneratorRuntime.awrap(connection.execute("\n        SELECT config_id \n        FROM t_direct\n        WHERE config_id = 5\n        "));

        case 8:
          _ref25 = _context4.sent;
          _ref26 = _slicedToArray(_ref25, 1);
          row = _ref26[0];

          if (row) {
            _context4.next = 21;
            break;
          }

          _context4.next = 14;
          return regeneratorRuntime.awrap(connection.execute("\n        INSERT INTO t_direct(config_id,value,d_no)\n        VALUE(5,\"".concat(content, "\",\"").concat(d_no, "\")\n        ")));

        case 14:
          _ref27 = _context4.sent;
          _ref28 = _slicedToArray(_ref27, 1);
          rows = _ref28[0];
          res.send("ok");
          return _context4.abrupt("return");

        case 21:
          _context4.next = 23;
          return regeneratorRuntime.awrap(connection.execute("\n        UPDATE t_direct\n        SET value = \"".concat(content, "\"\n        WHERE config_id = 5\n        ")));

        case 23:
          _ref29 = _context4.sent;
          _ref30 = _slicedToArray(_ref29, 1);
          _rows7 = _ref30[0];
          res.send("ok");
          return _context4.abrupt("return");

        case 28:
          _context4.next = 55;
          break;

        case 30:
          if (all_sign < 6) {
            _mqtt_server_get.client.publish("".concat(topic, ":").concat(d_no), JSON.stringify({
              fengshan2: content
            }), {
              qos: 1
            });
          } else {
            _mqtt_server_get.client.publish("".concat(topic, ":").concat(d_no), JSON.stringify({
              fengshan2: content
            }), {
              qos: 1
            });

            (0, _mqtt_server_get.beifen)(0, ["".concat(topic, ":").concat(d_no), JSON.stringify({
              fengshan2: content
            }), {
              qos: 1
            }]); //在实际场景像需要将payload包装成value进行直接的传递--后续则直接在publish方法中使用...展开运算符传值即可
          }

          all_sign++; //首先判断是否存在编号对应的内容

          if (content === "start") {
            content = "开";
          } else if (content === "stop") {
            content = "关";
          }

          _context4.next = 35;
          return regeneratorRuntime.awrap(connection.execute("\n        SELECT config_id \n        FROM t_direct\n        WHERE config_id = 14\n        AND d_no = \"".concat(d_no, "\"\n\n        ")));

        case 35:
          _ref31 = _context4.sent;
          _ref32 = _slicedToArray(_ref31, 1);
          _row3 = _ref32[0];

          if (_row3) {
            _context4.next = 48;
            break;
          }

          _context4.next = 41;
          return regeneratorRuntime.awrap(connection.execute("\n        INSERT INTO t_direct(config_id,value,d_no)\n        VALUE(14,\"".concat(content, "\",\"").concat(d_no, "\")\n        ")));

        case 41:
          _ref33 = _context4.sent;
          _ref34 = _slicedToArray(_ref33, 1);
          _rows8 = _ref34[0];
          res.send("ok");
          return _context4.abrupt("return");

        case 48:
          _context4.next = 50;
          return regeneratorRuntime.awrap(connection.execute("\n        UPDATE t_direct\n        SET value = \"".concat(content, "\"\n        WHERE config_id = 14\n        AND d_no = \"").concat(d_no, "\"\n\n        ")));

        case 50:
          _ref35 = _context4.sent;
          _ref36 = _slicedToArray(_ref35, 1);
          _rows9 = _ref36[0];
          res.send("ok");
          return _context4.abrupt("return");

        case 55:
          _context4.next = 59;
          break;

        case 57:
          console.log("传递参数问题");
          res.send("false");

        case 59:
        case "end":
          return _context4.stop();
      }
    }
  });
});
Router_direct_response.get("/zhiling/ketiaodeng", function _callee5(req, res) {
  var _req$query4, content, topic, d_no, _ref37, _ref38, row, _ref39, _ref40, rows, _ref41, _ref42, _rows10, _ref43, _ref44, _row4, _ref45, _ref46, _rows11, _ref47, _ref48, _rows12;

  return regeneratorRuntime.async(function _callee5$(_context5) {
    while (1) {
      switch (_context5.prev = _context5.next) {
        case 0:
          _req$query4 = req.query, content = _req$query4.content, topic = _req$query4.topic, d_no = _req$query4.d_no;

          if (!(content === "start" || content === "stop")) {
            _context5.next = 57;
            break;
          }

          if (!(d_no === "null")) {
            _context5.next = 30;
            break;
          }

          if (all_sign < 6) {
            _mqtt_server_get.client.publish(topic, JSON.stringify({
              deng: content
            }), {
              qos: 1
            });
          } else {
            _mqtt_server_get.client.publish(topic, JSON.stringify({
              deng: content
            }), {
              qos: 1
            });

            (0, _mqtt_server_get.beifen)(0, [topic, JSON.stringify({
              deng: content
            }), {
              qos: 1
            }]); //在实际场景像需要将payload包装成value进行直接的传递--后续则直接在publish方法中使用...展开运算符传值即可
          }

          all_sign++; //传递payload的格式：来源(即指令对象)、内容
          //首先判断是否存在编号对应的内容

          if (content === "start") {
            content = "开";
          } else if (content === "stop") {
            content = "关";
          }

          _context5.next = 8;
          return regeneratorRuntime.awrap(connection.execute("\n        SELECT config_id \n        FROM t_direct\n        WHERE config_id = 1\n        "));

        case 8:
          _ref37 = _context5.sent;
          _ref38 = _slicedToArray(_ref37, 1);
          row = _ref38[0];

          if (row) {
            _context5.next = 21;
            break;
          }

          _context5.next = 14;
          return regeneratorRuntime.awrap(connection.execute("\n        INSERT INTO t_direct(config_id,value,d_no)\n        VALUE(1,\"".concat(content, "\",\"").concat(d_no, "\")\n        ")));

        case 14:
          _ref39 = _context5.sent;
          _ref40 = _slicedToArray(_ref39, 1);
          rows = _ref40[0];
          res.send("ok");
          return _context5.abrupt("return");

        case 21:
          _context5.next = 23;
          return regeneratorRuntime.awrap(connection.execute("\n        UPDATE t_direct\n        SET value = \"".concat(content, "\"\n        WHERE config_id = 1\n        ")));

        case 23:
          _ref41 = _context5.sent;
          _ref42 = _slicedToArray(_ref41, 1);
          _rows10 = _ref42[0];
          res.send("ok");
          return _context5.abrupt("return");

        case 28:
          _context5.next = 55;
          break;

        case 30:
          if (all_sign < 6) {
            _mqtt_server_get.client.publish("".concat(topic, ":").concat(d_no), JSON.stringify({
              ketiaodeng: content
            }), {
              qos: 1
            });
          } else {
            _mqtt_server_get.client.publish("".concat(topic, ":").concat(d_no), JSON.stringify({
              ketiaodeng: content
            }), {
              qos: 1
            });

            (0, _mqtt_server_get.beifen)(0, ["".concat(topic, ":").concat(d_no), JSON.stringify({
              ketiaodeng: content
            }), {
              qos: 1
            }]); //在实际场景像需要将payload包装成value进行直接的传递--后续则直接在publish方法中使用...展开运算符传值即可
          }

          all_sign++; //传递payload的格式：来源(即指令对象)、内容
          //首先判断是否存在编号对应的内容

          if (content === "start") {
            content = "开";
          } else if (content === "stop") {
            content = "关";
          }

          _context5.next = 35;
          return regeneratorRuntime.awrap(connection.execute("\n        SELECT config_id \n        FROM t_direct\n        WHERE config_id = 10\n        AND d_no = \"".concat(d_no, "\"\n\n        ")));

        case 35:
          _ref43 = _context5.sent;
          _ref44 = _slicedToArray(_ref43, 1);
          _row4 = _ref44[0];

          if (_row4) {
            _context5.next = 48;
            break;
          }

          _context5.next = 41;
          return regeneratorRuntime.awrap(connection.execute("\n        INSERT INTO t_direct(config_id,value,d_no)\n        VALUE(10,\"".concat(content, "\",\"").concat(d_no, "\")\n        ")));

        case 41:
          _ref45 = _context5.sent;
          _ref46 = _slicedToArray(_ref45, 1);
          _rows11 = _ref46[0];
          res.send("ok");
          return _context5.abrupt("return");

        case 48:
          _context5.next = 50;
          return regeneratorRuntime.awrap(connection.execute("\n        UPDATE t_direct\n        SET value = \"".concat(content, "\"\n        WHERE config_id = 10\n        AND d_no = \"").concat(d_no, "\"\n\n        ")));

        case 50:
          _ref47 = _context5.sent;
          _ref48 = _slicedToArray(_ref47, 1);
          _rows12 = _ref48[0];
          res.send("ok");
          return _context5.abrupt("return");

        case 55:
          _context5.next = 59;
          break;

        case 57:
          console.log("传递参数问题");
          res.send("false");

        case 59:
        case "end":
          return _context5.stop();
      }
    }
  });
});
Router_direct_response.get("/zhiling/bujindianji", function _callee6(req, res) {
  var _req$query5, content, topic, d_no, dianji_model, _ref49, _ref50, row, _ref51, _ref52, rows, _ref53, _ref54, _rows13, _ref55, _ref56, _row5, _ref57, _ref58, _rows14, _ref59, _ref60, _rows15;

  return regeneratorRuntime.async(function _callee6$(_context6) {
    while (1) {
      switch (_context6.prev = _context6.next) {
        case 0:
          _req$query5 = req.query, content = _req$query5.content, topic = _req$query5.topic, d_no = _req$query5.d_no, dianji_model = _req$query5.dianji_model;

          if (!(content === "start" || content === "stop")) {
            _context6.next = 59;
            break;
          }

          if (!(d_no === "null")) {
            _context6.next = 32;
            break;
          }

          console.log("tpoic:" + topic);
          console.log("content:" + content); //传递payload的格式：来源(即指令对象)、内容

          if (content === "start") {
            if (dianji_model === "正转") {
              if (all_sign < 6) {
                _mqtt_server_get.client.publish(topic, JSON.stringify({
                  kaiqi: "start"
                }), {
                  qos: 1
                });

                _mqtt_server_get.client.publish(topic, JSON.stringify({
                  zhengzhuan: "start"
                }), {
                  qos: 1
                });
              } else {
                _mqtt_server_get.client.publish(topic, JSON.stringify({
                  kaiqi: "start"
                }), {
                  qos: 1
                });

                _mqtt_server_get.client.publish(topic, JSON.stringify({
                  zhengzhuan: "start"
                }), {
                  qos: 1
                });

                (0, _mqtt_server_get.beifen)(0, [topic, JSON.stringify({
                  zhengzhuan: "start"
                }), {
                  qos: 1
                }]);
                (0, _mqtt_server_get.beifen)(0, [topic, JSON.stringify({
                  kaiqi: "start"
                }), {
                  qos: 1
                }]);
              }
            } else if (dianji_model === "反转") {
              if (all_sign < 6) {
                _mqtt_server_get.client.publish(topic, JSON.stringify({
                  kaiqi: "start"
                }), {
                  qos: 1
                });

                _mqtt_server_get.client.publish(topic, JSON.stringify({
                  fanzhuan: "start"
                }), {
                  qos: 1
                });
              } else {
                _mqtt_server_get.client.publish(topic, JSON.stringify({
                  kaiqi: "start"
                }), {
                  qos: 1
                });

                _mqtt_server_get.client.publish(topic, JSON.stringify({
                  fanzhuan: "start"
                }), {
                  qos: 1
                });

                (0, _mqtt_server_get.beifen)(0, [topic, JSON.stringify({
                  zhengzhuan: "start"
                }), {
                  qos: 1
                }]);
                (0, _mqtt_server_get.beifen)(0, [topic, JSON.stringify({
                  kaiqi: "start"
                }), {
                  qos: 1
                }]);
              }
            }
          } else if (content === "stop") {
            if (all_sign < 6) {
              _mqtt_server_get.client.publish(topic, JSON.stringify({
                guanbi: "stop"
              }), {
                qos: 1
              });
            } else {
              _mqtt_server_get.client.publish(topic, JSON.stringify({
                guanbi: "stop"
              }), {
                qos: 1
              });

              (0, _mqtt_server_get.beifen)(0, [topic, JSON.stringify({
                guanbi: "stop"
              }), {
                qos: 1
              }]);
            }
          }

          all_sign++; //首先判断是否存在编号对应的内容

          if (content === "start") {
            content = "开";
          } else if (content === "stop") {
            content = "关";
          }

          _context6.next = 10;
          return regeneratorRuntime.awrap(connection.execute("\n        SELECT config_id \n        FROM t_direct\n        WHERE config_id = 2\n      "));

        case 10:
          _ref49 = _context6.sent;
          _ref50 = _slicedToArray(_ref49, 1);
          row = _ref50[0];

          if (row) {
            _context6.next = 23;
            break;
          }

          _context6.next = 16;
          return regeneratorRuntime.awrap(connection.execute("\n        INSERT INTO t_direct(config_id, value, d_no)\n        VALUE(2,\"".concat(content, "\",\"").concat(d_no, "\")\n        ")));

        case 16:
          _ref51 = _context6.sent;
          _ref52 = _slicedToArray(_ref51, 1);
          rows = _ref52[0];
          res.send("ok");
          return _context6.abrupt("return");

        case 23:
          _context6.next = 25;
          return regeneratorRuntime.awrap(connection.execute("\n        UPDATE t_direct\n        SET value = \"".concat(content, "\"\n        WHERE config_id = 2\n        ")));

        case 25:
          _ref53 = _context6.sent;
          _ref54 = _slicedToArray(_ref53, 1);
          _rows13 = _ref54[0];
          res.send("ok");
          return _context6.abrupt("return");

        case 30:
          _context6.next = 57;
          break;

        case 32:
          if (content === "start") {
            if (all_sign < 6) {
              _mqtt_server_get.client.publish("".concat(topic, ":").concat(d_no), JSON.stringify({
                kaiqi: "start"
              }), {
                qos: 1
              });
            } else {
              _mqtt_server_get.client.publish("".concat(topic, ":").concat(d_no), JSON.stringify({
                kaiqi: "start"
              }), {
                qos: 1
              });

              (0, _mqtt_server_get.beifen)(0, ["".concat(topic, ":").concat(d_no), JSON.stringify({
                kaiqi: "start"
              }), {
                qos: 1
              }]);
            } //传递payload的格式：来源(即指令对象)、内容

          } else if (content === "stop") {
            if (all_sign < 6) {
              _mqtt_server_get.client.publish("".concat(topic, ":").concat(d_no), JSON.stringify({
                guanbi: "stop"
              }), {
                qos: 1
              });
            } else {
              _mqtt_server_get.client.publish("".concat(topic, ":").concat(d_no), JSON.stringify({
                guanbi: "stop"
              }), {
                qos: 1
              });

              (0, _mqtt_server_get.beifen)(0, ["".concat(topic, ":").concat(d_no), JSON.stringify({
                guanbi: "stop"
              }), {
                qos: 1
              }]);
            } //传递payload的格式：来源(即指令对象)、内容

          }

          all_sign++; //首先判断是否存在编号对应的内容

          if (content === "start") {
            content = "开";
          } else if (content === "stop") {
            content = "关";
          }

          _context6.next = 37;
          return regeneratorRuntime.awrap(connection.execute("\n        SELECT config_id \n        FROM t_direct\n        WHERE config_id = 11\n        AND d_no = \"".concat(d_no, "\"\n      ")));

        case 37:
          _ref55 = _context6.sent;
          _ref56 = _slicedToArray(_ref55, 1);
          _row5 = _ref56[0];

          if (_row5) {
            _context6.next = 50;
            break;
          }

          _context6.next = 43;
          return regeneratorRuntime.awrap(connection.execute("\n        INSERT INTO t_direct(config_id, value, d_no)\n        VALUE(11,\"".concat(content, "\",\"").concat(d_no, "\")\n        ")));

        case 43:
          _ref57 = _context6.sent;
          _ref58 = _slicedToArray(_ref57, 1);
          _rows14 = _ref58[0];
          res.send("ok");
          return _context6.abrupt("return");

        case 50:
          _context6.next = 52;
          return regeneratorRuntime.awrap(connection.execute("\n        UPDATE t_direct\n        SET value = \"".concat(content, "\"\n        WHERE config_id = 11\n        AND d_no = \"").concat(d_no, "\"\n        ")));

        case 52:
          _ref59 = _context6.sent;
          _ref60 = _slicedToArray(_ref59, 1);
          _rows15 = _ref60[0];
          res.send("ok");
          return _context6.abrupt("return");

        case 57:
          _context6.next = 61;
          break;

        case 59:
          console.log("传递参数问题");
          res.send("false");

        case 61:
        case "end":
          return _context6.stop();
      }
    }
  });
});
Router_direct_response.get("/zhiling/dianji_model", function _callee7(req, res) {
  var _req$query6, content, topic, d_no, _ref61, _ref62, row, _ref63, _ref64, rows, _ref65, _ref66, _rows16, _ref67, _ref68, _row6, _ref69, _ref70, _rows17, _ref71, _ref72, _rows18;

  return regeneratorRuntime.async(function _callee7$(_context7) {
    while (1) {
      switch (_context7.prev = _context7.next) {
        case 0:
          _req$query6 = req.query, content = _req$query6.content, topic = _req$query6.topic, d_no = _req$query6.d_no;
          console.log("归俊俏");
          console.log("content:" + content);

          if (!(content === "zhengzhuan" || content === "fanzhuan")) {
            _context7.next = 59;
            break;
          }

          if (!(d_no === "null")) {
            _context7.next = 32;
            break;
          }

          //传递payload的格式：来源(即指令对象)、内容
          if (content === "zhengzhuan") {
            if (all_sign < 6) {
              _mqtt_server_get.client.publish(topic, JSON.stringify({
                zhengzhuan: "start"
              }), {
                qos: 1
              });
            } else {
              _mqtt_server_get.client.publish(topic, JSON.stringify({
                zhengzhuan: "start"
              }), {
                qos: 1
              });

              (0, _mqtt_server_get.beifen)(0, [topic, JSON.stringify({
                zhengzhuan: "start"
              }), {
                qos: 1
              }]);
            }
          } else if (content === "fanzhuan") {
            if (all_sign < 6) {
              _mqtt_server_get.client.publish(topic, JSON.stringify({
                fanzhuan: "start"
              }), {
                qos: 1
              });
            } else {
              _mqtt_server_get.client.publish(topic, JSON.stringify({
                fanzhuan: "start"
              }), {
                qos: 1
              });

              (0, _mqtt_server_get.beifen)(0, [topic, JSON.stringify({
                fanzhuan: "start"
              }), {
                qos: 1
              }]);
            }
          }

          all_sign++; //首先判断是否存在编号对应的内容

          if (content === "zhengzhuan") {
            content = "正转";
          } else if (content === "fanzhuan") {
            content = "反转";
          }

          _context7.next = 10;
          return regeneratorRuntime.awrap(connection.execute("\n        SELECT config_id \n        FROM t_direct\n        WHERE config_id = 3\n      "));

        case 10:
          _ref61 = _context7.sent;
          _ref62 = _slicedToArray(_ref61, 1);
          row = _ref62[0];

          if (row) {
            _context7.next = 23;
            break;
          }

          _context7.next = 16;
          return regeneratorRuntime.awrap(connection.execute("\n        INSERT INTO t_direct(config_id, value, d_no)\n        VALUE(3,\"".concat(content, "\",\"").concat(d_no, "\")\n        ")));

        case 16:
          _ref63 = _context7.sent;
          _ref64 = _slicedToArray(_ref63, 1);
          rows = _ref64[0];
          res.send("ok");
          return _context7.abrupt("return");

        case 23:
          _context7.next = 25;
          return regeneratorRuntime.awrap(connection.execute("\n        UPDATE t_direct\n        SET value = \"".concat(content, "\"\n        WHERE config_id = 3\n        ")));

        case 25:
          _ref65 = _context7.sent;
          _ref66 = _slicedToArray(_ref65, 1);
          _rows16 = _ref66[0];
          res.send("ok");
          return _context7.abrupt("return");

        case 30:
          _context7.next = 57;
          break;

        case 32:
          if (content === "zhengzhuan") {
            if (all_sign < 6) {
              _mqtt_server_get.client.publish("".concat(topic, ":").concat(d_no), JSON.stringify({
                zhengzhuan: "start"
              }), {
                qos: 1
              });
            } else {
              _mqtt_server_get.client.publish("".concat(topic, ":").concat(d_no), JSON.stringify({
                zhengzhuan: "start"
              }), {
                qos: 1
              });

              (0, _mqtt_server_get.beifen)(0, ["".concat(topic, ":").concat(d_no), JSON.stringify({
                zhengzhuan: "start"
              }), {
                qos: 1
              }]);
            } //传递payload的格式：来源(即指令对象)、内容

          } else if (content === "fanzhuan") {
            if (all_sign < 6) {
              _mqtt_server_get.client.publish("".concat(topic, ":").concat(d_no), JSON.stringify({
                fanzhuan: "start"
              }), {
                qos: 1
              });
            } else {
              _mqtt_server_get.client.publish("".concat(topic, ":").concat(d_no), JSON.stringify({
                fanzhuan: "start"
              }), {
                qos: 1
              });

              (0, _mqtt_server_get.beifen)(0, ["".concat(topic, ":").concat(d_no), JSON.stringify({
                fanzhuan: "start"
              }), {
                qos: 1
              }]);
            } //传递payload的格式：来源(即指令对象)、内容

          }

          all_sign++;

          if (content === "zhengzhuan") {
            content = "正转";
          } else if (content === "fanzhuan") {
            content = "反转";
          } //首先判断是否存在编号对应的内容


          _context7.next = 37;
          return regeneratorRuntime.awrap(connection.execute("\n        SELECT config_id \n        FROM t_direct\n        WHERE config_id = 12\n        AND d_no = \"".concat(d_no, "\"\n      ")));

        case 37:
          _ref67 = _context7.sent;
          _ref68 = _slicedToArray(_ref67, 1);
          _row6 = _ref68[0];

          if (_row6) {
            _context7.next = 50;
            break;
          }

          _context7.next = 43;
          return regeneratorRuntime.awrap(connection.execute("\n        INSERT INTO t_direct(config_id, value, d_no)\n        VALUE(12,\"".concat(content, "\",\"").concat(d_no, "\")\n        ")));

        case 43:
          _ref69 = _context7.sent;
          _ref70 = _slicedToArray(_ref69, 1);
          _rows17 = _ref70[0];
          res.send("ok");
          return _context7.abrupt("return");

        case 50:
          _context7.next = 52;
          return regeneratorRuntime.awrap(connection.execute("\n        UPDATE t_direct\n        SET value = \"".concat(content, "\"\n        WHERE config_id = 12\n        AND d_no = \"").concat(d_no, "\"\n        ")));

        case 52:
          _ref71 = _context7.sent;
          _ref72 = _slicedToArray(_ref71, 1);
          _rows18 = _ref72[0];
          res.send("ok");
          return _context7.abrupt("return");

        case 57:
          _context7.next = 62;
          break;

        case 59:
          console.log("传递参数问题");
          res.send("false");
          return _context7.abrupt("return");

        case 62:
        case "end":
          return _context7.stop();
      }
    }
  });
}); // temperature1

Router_direct_response.get("/zhiling/temperature1", function _callee8(req, res) {
  var _req$query7, content, topic, d_no, _ref73, _ref74, row, _ref75, _ref76, rows, _ref77, _ref78, _rows19, _ref79, _ref80, _row7, _ref81, _ref82, _rows20, _ref83, _ref84, _rows21;

  return regeneratorRuntime.async(function _callee8$(_context8) {
    while (1) {
      switch (_context8.prev = _context8.next) {
        case 0:
          _req$query7 = req.query, content = _req$query7.content, topic = _req$query7.topic, d_no = _req$query7.d_no;

          if (!(d_no === "null")) {
            _context8.next = 28;
            break;
          }

          //传递payload的格式：来源(即指令对象)、内容
          _mqtt_server_get.client.publish(topic, JSON.stringify({
            "temperature1": content
          }), {
            qos: 1
          });

          (0, _mqtt_server_get.beifen)(0, [topic, JSON.stringify({
            "temperature1": content
          }), {
            qos: 1
          }]);
          _context8.next = 6;
          return regeneratorRuntime.awrap(connection.execute("\n      SELECT config_id\n      FROM t_direct\n      WHERE config_id = 7\n    "));

        case 6:
          _ref73 = _context8.sent;
          _ref74 = _slicedToArray(_ref73, 1);
          row = _ref74[0];

          if (row) {
            _context8.next = 19;
            break;
          }

          _context8.next = 12;
          return regeneratorRuntime.awrap(connection.execute("\n        INSERT INTO t_direct(config_id, value, d_no)\n        VALUE(7,\"".concat(content, "\",\"").concat(d_no, "\")\n      ")));

        case 12:
          _ref75 = _context8.sent;
          _ref76 = _slicedToArray(_ref75, 1);
          rows = _ref76[0];
          res.send("ok");
          return _context8.abrupt("return");

        case 19:
          _context8.next = 21;
          return regeneratorRuntime.awrap(connection.execute("\n        UPDATE t_direct\n        SET value = \"".concat(content, "\"\n        WHERE config_id = 7\n      ")));

        case 21:
          _ref77 = _context8.sent;
          _ref78 = _slicedToArray(_ref77, 1);
          _rows19 = _ref78[0];
          res.send("ok");
          return _context8.abrupt("return");

        case 26:
          _context8.next = 52;
          break;

        case 28:
          //传递payload的格式：来源(即指令对象)、内容
          _mqtt_server_get.client.publish("".concat(topic, ":").concat(d_no), JSON.stringify({
            "temperature1": content
          }), {
            qos: 1
          });

          (0, _mqtt_server_get.beifen)(0, ["".concat(topic, ":").concat(d_no), JSON.stringify({
            "temperature1": content
          }), {
            qos: 1
          }]);
          _context8.next = 32;
          return regeneratorRuntime.awrap(connection.execute("\n      SELECT config_id \n      FROM t_direct\n      WHERE config_id = 16\n    "));

        case 32:
          _ref79 = _context8.sent;
          _ref80 = _slicedToArray(_ref79, 1);
          _row7 = _ref80[0];

          if (_row7) {
            _context8.next = 45;
            break;
          }

          _context8.next = 38;
          return regeneratorRuntime.awrap(connection.execute("\n        INSERT INTO t_direct(config_id, value, d_no)\n        VALUE(16,\"".concat(content, "\",\"").concat(d_no, "\")\n      ")));

        case 38:
          _ref81 = _context8.sent;
          _ref82 = _slicedToArray(_ref81, 1);
          _rows20 = _ref82[0];
          res.send("ok");
          return _context8.abrupt("return");

        case 45:
          _context8.next = 47;
          return regeneratorRuntime.awrap(connection.execute("\n        UPDATE t_direct\n        SET value = \"".concat(content, "\"\n        WHERE config_id = 16\n      ")));

        case 47:
          _ref83 = _context8.sent;
          _ref84 = _slicedToArray(_ref83, 1);
          _rows21 = _ref84[0];
          res.send("ok");
          return _context8.abrupt("return");

        case 52:
        case "end":
          return _context8.stop();
      }
    }
  });
}); // temperature2

Router_direct_response.get("/zhiling/temperature2", function _callee9(req, res) {
  var _req$query8, content, topic, d_no, _ref85, _ref86, row, _ref87, _ref88, rows, _ref89, _ref90, _rows22, _ref91, _ref92, _row8, _ref93, _ref94, _rows23, _ref95, _ref96, _rows24;

  return regeneratorRuntime.async(function _callee9$(_context9) {
    while (1) {
      switch (_context9.prev = _context9.next) {
        case 0:
          _req$query8 = req.query, content = _req$query8.content, topic = _req$query8.topic, d_no = _req$query8.d_no;

          if (!(d_no === "null")) {
            _context9.next = 28;
            break;
          }

          //传递payload的格式：来源(即指令对象)、内容
          _mqtt_server_get.client.publish(topic, JSON.stringify({
            "temperature2": content
          }), {
            qos: 1
          });

          (0, _mqtt_server_get.beifen)(0, [topic, JSON.stringify({
            "temperature2": content
          }), {
            qos: 1
          }]);
          _context9.next = 6;
          return regeneratorRuntime.awrap(connection.execute("\n      SELECT config_id\n      FROM t_direct\n      WHERE config_id = 6\n    "));

        case 6:
          _ref85 = _context9.sent;
          _ref86 = _slicedToArray(_ref85, 1);
          row = _ref86[0];

          if (row) {
            _context9.next = 19;
            break;
          }

          _context9.next = 12;
          return regeneratorRuntime.awrap(connection.execute("\n        INSERT INTO t_direct(config_id, value, d_no)\n        VALUE(6,\"".concat(content, "\",\"").concat(d_no, "\")\n      ")));

        case 12:
          _ref87 = _context9.sent;
          _ref88 = _slicedToArray(_ref87, 1);
          rows = _ref88[0];
          res.send("ok");
          return _context9.abrupt("return");

        case 19:
          _context9.next = 21;
          return regeneratorRuntime.awrap(connection.execute("\n        UPDATE t_direct\n        SET value = \"".concat(content, "\"\n        WHERE config_id = 6\n      ")));

        case 21:
          _ref89 = _context9.sent;
          _ref90 = _slicedToArray(_ref89, 1);
          _rows22 = _ref90[0];
          res.send("ok");
          return _context9.abrupt("return");

        case 26:
          _context9.next = 52;
          break;

        case 28:
          //传递payload的格式：来源(即指令对象)、内容
          _mqtt_server_get.client.publish("".concat(topic, ":").concat(d_no), JSON.stringify({
            "temperature2": content
          }), {
            qos: 1
          });

          (0, _mqtt_server_get.beifen)(0, ["".concat(topic, ":").concat(d_no), JSON.stringify({
            "temperature2": content
          }), {
            qos: 1
          }]);
          _context9.next = 32;
          return regeneratorRuntime.awrap(connection.execute("\n      SELECT config_id \n      FROM t_direct\n      WHERE config_id = 15\n      AND d_no = \"".concat(d_no, "\"\n    ")));

        case 32:
          _ref91 = _context9.sent;
          _ref92 = _slicedToArray(_ref91, 1);
          _row8 = _ref92[0];

          if (_row8) {
            _context9.next = 45;
            break;
          }

          _context9.next = 38;
          return regeneratorRuntime.awrap(connection.execute("\n        INSERT INTO t_direct(config_id, value, d_no)\n        VALUE(15,\"".concat(content, "\",\"").concat(d_no, "\")\n      ")));

        case 38:
          _ref93 = _context9.sent;
          _ref94 = _slicedToArray(_ref93, 1);
          _rows23 = _ref94[0];
          res.send("ok");
          return _context9.abrupt("return");

        case 45:
          _context9.next = 47;
          return regeneratorRuntime.awrap(connection.execute("\n        UPDATE t_direct\n        SET value = \"".concat(content, "\"\n        WHERE config_id = 15\n        AND d_no = \"").concat(d_no, "\"\n      ")));

        case 47:
          _ref95 = _context9.sent;
          _ref96 = _slicedToArray(_ref95, 1);
          _rows24 = _ref96[0];
          res.send("ok");
          return _context9.abrupt("return");

        case 52:
        case "end":
          return _context9.stop();
      }
    }
  });
}); // light_warning

Router_direct_response.get("/zhiling/light_min", function _callee10(req, res) {
  var _req$query9, content, topic, d_no, _ref97, _ref98, row, _ref99, _ref100, rows, _ref101, _ref102, _rows25, _ref103, _ref104, _row9, _ref105, _ref106, _rows26, _ref107, _ref108, _rows27;

  return regeneratorRuntime.async(function _callee10$(_context10) {
    while (1) {
      switch (_context10.prev = _context10.next) {
        case 0:
          _req$query9 = req.query, content = _req$query9.content, topic = _req$query9.topic, d_no = _req$query9.d_no;

          if (!(d_no === "null")) {
            _context10.next = 38;
            break;
          }

          //传递payload的格式：来源(即指令对象)、内容
          console.log("content:" + content);
          console.log("content_length:" + content.length);
          console.log("content:" + content);
          console.log("content_length:" + content.length);
          console.log("content:" + content);
          console.log("content_length:" + content.length);
          console.log("content:" + content);
          console.log("content_length:" + content.length);
          console.log("content:" + content);
          console.log("content_length:" + content.length);

          _mqtt_server_get.client.publish(topic, JSON.stringify({
            "light_warning": content
          }), {
            qos: 1
          });

          (0, _mqtt_server_get.beifen)(0, [topic, JSON.stringify({
            "light_warning": content
          }), {
            qos: 1
          }]);
          _context10.next = 16;
          return regeneratorRuntime.awrap(connection.execute("\n      SELECT config_id\n      FROM t_direct\n      WHERE config_id = 9\n    "));

        case 16:
          _ref97 = _context10.sent;
          _ref98 = _slicedToArray(_ref97, 1);
          row = _ref98[0];

          if (row) {
            _context10.next = 29;
            break;
          }

          _context10.next = 22;
          return regeneratorRuntime.awrap(connection.execute("\n        INSERT INTO t_direct(config_id, value, d_no)\n        VALUE(9,\"".concat(content, "\",\"").concat(d_no, "\")\n      ")));

        case 22:
          _ref99 = _context10.sent;
          _ref100 = _slicedToArray(_ref99, 1);
          rows = _ref100[0];
          res.send("ok");
          return _context10.abrupt("return");

        case 29:
          _context10.next = 31;
          return regeneratorRuntime.awrap(connection.execute("\n        UPDATE t_direct\n        SET value = \"".concat(content, "\"\n        WHERE config_id = 9\n      ")));

        case 31:
          _ref101 = _context10.sent;
          _ref102 = _slicedToArray(_ref101, 1);
          _rows25 = _ref102[0];
          res.send("ok");
          return _context10.abrupt("return");

        case 36:
          _context10.next = 62;
          break;

        case 38:
          //传递payload的格式：来源(即指令对象)、内容
          _mqtt_server_get.client.publish("".concat(topic, ":").concat(d_no), JSON.stringify({
            "light_warning": content
          }), {
            qos: 1
          });

          (0, _mqtt_server_get.beifen)(0, ["".concat(topic, ":").concat(d_no), JSON.stringify({
            "light_warning": content
          }), {
            qos: 1
          }]);
          _context10.next = 42;
          return regeneratorRuntime.awrap(connection.execute("\n      SELECT config_id \n      FROM t_direct\n      WHERE config_id = 18\n      AND d_no = \"".concat(d_no, "\"\n    ")));

        case 42:
          _ref103 = _context10.sent;
          _ref104 = _slicedToArray(_ref103, 1);
          _row9 = _ref104[0];

          if (_row9) {
            _context10.next = 55;
            break;
          }

          _context10.next = 48;
          return regeneratorRuntime.awrap(connection.execute("\n        INSERT INTO t_direct(config_id, value, d_no)\n        VALUE(18,\"".concat(content, "\",\"").concat(d_no, "\")\n      ")));

        case 48:
          _ref105 = _context10.sent;
          _ref106 = _slicedToArray(_ref105, 1);
          _rows26 = _ref106[0];
          res.send("ok");
          return _context10.abrupt("return");

        case 55:
          _context10.next = 57;
          return regeneratorRuntime.awrap(connection.execute("\n        UPDATE t_direct\n        SET value = \"".concat(content, "\"\n        WHERE config_id = 18\n        AND d_no = \"").concat(d_no, "\"\n      ")));

        case 57:
          _ref107 = _context10.sent;
          _ref108 = _slicedToArray(_ref107, 1);
          _rows27 = _ref108[0];
          res.send("ok");
          return _context10.abrupt("return");

        case 62:
        case "end":
          return _context10.stop();
      }
    }
  });
}); //添加和对应的数据库操作的修改以及指令发送过程中为d_no不为null的情况的topic的修改,考虑为输入框进行提交而不是单纯的sign值的修改导致当前的请求的发送

var _default = Router_direct_response;
exports["default"] = _default;