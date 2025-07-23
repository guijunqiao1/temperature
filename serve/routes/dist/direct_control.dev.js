"use strict";

Object.defineProperty(exports, "__esModule", {
  value: true
});
exports["default"] = void 0;

var _express = _interopRequireDefault(require("express"));

var _indexNode = _interopRequireDefault(require("../indexNode3.js"));

var _mqtt_server_get = require("./mqtt_server_get.js");

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { "default": obj }; }

function _slicedToArray(arr, i) { return _arrayWithHoles(arr) || _iterableToArrayLimit(arr, i) || _nonIterableRest(); }

function _nonIterableRest() { throw new TypeError("Invalid attempt to destructure non-iterable instance"); }

function _iterableToArrayLimit(arr, i) { if (!(Symbol.iterator in Object(arr) || Object.prototype.toString.call(arr) === "[object Arguments]")) { return; } var _arr = []; var _n = true; var _d = false; var _e = undefined; try { for (var _i = arr[Symbol.iterator](), _s; !(_n = (_s = _i.next()).done); _n = true) { _arr.push(_s.value); if (i && _arr.length === i) break; } } catch (err) { _d = true; _e = err; } finally { try { if (!_n && _i["return"] != null) _i["return"](); } finally { if (_d) throw _e; } } return _arr; }

function _arrayWithHoles(arr) { if (Array.isArray(arr)) return arr; }

var Router_direct_response = (0, _express["default"])(); //在当前需要对Mysql数据库进行操作的文件中提前引入Mysql数据库的配置文件--需要注意的是indexNode文件中的其他引入的组件文件只是对indexNode本身编写的时候进行约束的文件
// import Config from "../indexNode2.js";//此处获取到数据库链接配置对象

//此处获取到数据库链接配置对象
var connection; //定义数据库连接对象
//导入mqtt模块--用于指令的正确发送响应 

(function _callee3() {
  var result, rowx;
  return regeneratorRuntime.async(function _callee3$(_context3) {
    while (1) {
      switch (_context3.prev = _context3.next) {
        case 0:
          _context3.prev = 0;
          _context3.next = 3;
          return regeneratorRuntime.awrap((0, _indexNode["default"])());

        case 3:
          connection = _context3.sent;
          console.log("数据库连接成功"); // const result = await connection.execute(`
          //   SELECT c.id,c.f_type,c.mode,c.f_value,c.t_name,c.max,c.min,c.topic,c.header,c.luyou,t.value
          //   FROM t_direct t,t_direct_config c
          //   WHERE c.id = t.config_id
          //   AND ok in ("yes","yes1") 
          //   ORDER BY CASE f_type
          //       WHEN '1' THEN 1
          //       WHEN '5' THEN 2
          //       WHEN '3' THEN 3
          //       ELSE 4
          //     END;
          // `);

          _context3.next = 7;
          return regeneratorRuntime.awrap(connection.execute("\n      SELECT c.id,c.f_type,c.mode,c.f_value,c.t_name,c.max,c.min,c.topic,c.header,c.luyou\n      FROM t_direct_config c\n      WHERE ok in (\"yes\",\"yes1\") \n      ORDER BY CASE f_type\n          WHEN '1' THEN 1\n          ELSE 2\n        END;\n    "));

        case 7:
          result = _context3.sent;
          rowx = result[0];
          console.log("成功进入外层");
          console.dir(rowx); //遍历完成全局路由绑定 

          rowx.forEach(function _callee2(item, index) {
            return regeneratorRuntime.async(function _callee2$(_context2) {
              while (1) {
                switch (_context2.prev = _context2.next) {
                  case 0:
                    console.log("item:" + item.luyou); //需要注意content控制存入库中的值，tem11为指令值

                    Router_direct_response.get("/zhiling/" + item.luyou, function _callee(req, res) {
                      var _req$query, content, d_no, obj1, tem1, tem11, topic, C1, C2, E1, E2, N1, N2, formatTime, _ref, _ref2, rowsx, template, _ref3, _ref4, row, _ref5, _ref6, rows;

                      return regeneratorRuntime.async(function _callee$(_context) {
                        while (1) {
                          switch (_context.prev = _context.next) {
                            case 0:
                              console.log("成功进入32行阶段");
                              _req$query = req.query, content = _req$query.content, d_no = _req$query.d_no; //备份内容的封装

                              obj1 = {};

                              if (!(item.f_type !== '2' && item.f_type !== '3' && item.f_type !== '4')) {
                                _context.next = 17;
                                break;
                              }

                              //定义区块变量--用于替代切割后的各个维度的内容
                              C1 = item.f_value.split("|")[0].split(":")[0]; //中文第一个维度

                              C2 = item.f_value.split("|")[1].split(":")[0]; //中文第二个维度

                              E1 = item.f_value.split("|")[0].split(":")[1]; //英文第一个维度

                              E2 = item.f_value.split("|")[1].split(":")[1]; //英文第二个维度
                              //定义指令收尾变量--用于存储切割后的各个维度的内容

                              N1 = item.header.split("|")[0]; //结尾第一个维度

                              N2 = item.header.split("|")[1]; //结尾第二个维度

                              tem1 = content === C1 ? E1 : E2;
                              tem11 = content === C1 ? N1 : N2;
                              topic = item.topic;
                              obj1[tem1] = tem11; //中文更新

                              content = content === C1 ? C1 : C2;
                              _context.next = 33;
                              break;

                            case 17:
                              //输入框情况
                              //定义时间格式化方法
                              formatTime = function formatTime(timeStr) {
                                return new Date(timeStr).toISOString().slice(0, 19).replace('T', ' ');
                              };

                              console.log("成功进入时间判断");
                              tem1 = item.f_value.split("|")[0];

                              if (!content) {
                                _context.next = 24;
                                break;
                              }

                              //当不为单独值查询路由的情况
                              if (item.f_type === "4") {
                                //为时间值的情况下将content、tem11进行转化
                                content = formatTime(content);
                                console.log("时间值格式:" + content);
                                tem11 = content.split(" ")[1];
                                console.log("time:" + tem11);
                              } else {
                                tem11 = content;
                              }

                              _context.next = 30;
                              break;

                            case 24:
                              _context.next = 26;
                              return regeneratorRuntime.awrap(connection.execute("\n              SELECT t_direct.value\n              FROM t_direct,t_direct_config\n              WHERE t_direct_config.id = t_direct.config_id\n              AND t_direct_config.id = ".concat(item.id, "\n              AND d_no = \"").concat(d_no === "null" ? "null" : "".concat(d_no), "\"\n              ")));

                            case 26:
                              _ref = _context.sent;
                              _ref2 = _slicedToArray(_ref, 1);
                              rowsx = _ref2[0];

                              if (item.f_type === "4") {
                                //为时间值的情况下将
                                tem11 = rowsx[0].value.split(" ")[1];
                                console.log("time:" + tem11);
                              } else {
                                tem11 = content;
                              }

                            case 30:
                              topic = item.topic;

                              if (item.id === 12) {
                                tem11 = 'on' + d_no + '_' + content;
                              }

                              obj1[tem1] = tem11;

                            case 33:
                              if (!d_no) {
                                _context.next = 55;
                                break;
                              }

                              console.log("即将更新:" + d_no);
                              template = topic;
                              console.log("tem:" + template);
                              (0, _mqtt_server_get.beifen)(d_no, [template, obj1]); //在实际场景像需要将payload包装成value进行直接的传递--后续则直接在publish方法中使用...展开运算符传值即可
                              //首先判断是否存在编号对应的内容

                              _context.next = 40;
                              return regeneratorRuntime.awrap(connection.execute("\n          SELECT config_id\n          FROM t_direct,t_direct_config\n          WHERE t_direct_config.id = t_direct.config_id\n          AND t_direct_config.id = ".concat(item.id, "\n          AND d_no = \"").concat(d_no, "\"\n          ")));

                            case 40:
                              _ref3 = _context.sent;
                              _ref4 = _slicedToArray(_ref3, 1);
                              row = _ref4[0];

                              if (row[0]) {
                                _context.next = 49;
                                break;
                              }

                              _context.next = 46;
                              return regeneratorRuntime.awrap(connection.execute("\n          INSERT INTO t_direct(config_id,value,d_no)\n          VALUE(".concat(item.id, ",\"").concat(content, "\",\"").concat(d_no, "\")\n          ")));

                            case 46:
                              _context.t0 = _context.sent;
                              _context.next = 52;
                              break;

                            case 49:
                              _context.next = 51;
                              return regeneratorRuntime.awrap(connection.execute("\n          UPDATE t_direct\n          SET value = \"".concat(content, "\"\n          WHERE config_id = ").concat(item.id, "\n          ")));

                            case 51:
                              _context.t0 = _context.sent;

                            case 52:
                              _ref5 = _context.t0;
                              _ref6 = _slicedToArray(_ref5, 1);
                              rows = _ref6[0];

                            case 55:
                              // res.send(!d_no ? item : "ok");
                              res.send("ok");
                              return _context.abrupt("return");

                            case 57:
                            case "end":
                              return _context.stop();
                          }
                        }
                      });
                    });
                    Router_direct_response.get('/test111', function (req, res) {
                      res.send('ok');
                    });

                  case 3:
                  case "end":
                    return _context2.stop();
                }
              }
            });
          });
          _context3.next = 18;
          break;

        case 14:
          _context3.prev = 14;
          _context3.t0 = _context3["catch"](0);
          console.log(_context3.t0);
          console.log("数据库连接失败");

        case 18:
        case "end":
          return _context3.stop();
      }
    }
  }, null, null, [[0, 14]]);
})(); //添加和对应的数据库操作的修改以及指令发送过程中为d_no不为null的情况的topic的修改,考虑为输入框进行提交而不是单纯的sign值的修改导致当前的请求的发送


var _default = Router_direct_response;
exports["default"] = _default;