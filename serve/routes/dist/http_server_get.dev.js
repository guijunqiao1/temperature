"use strict";

Object.defineProperty(exports, "__esModule", {
  value: true
});
exports.beifen = beifen;
exports["default"] = exports.active = void 0;

var _koa = _interopRequireDefault(require("koa"));

var _koaRouter = _interopRequireDefault(require("koa-router"));

var _koaBody = require("koa-body");

var _axios = _interopRequireDefault(require("axios"));

var _indexNode = _interopRequireDefault(require("../indexNode3.js"));

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { "default": obj }; }

function _slicedToArray(arr, i) { return _arrayWithHoles(arr) || _iterableToArrayLimit(arr, i) || _nonIterableRest(); }

function _nonIterableRest() { throw new TypeError("Invalid attempt to destructure non-iterable instance"); }

function _iterableToArrayLimit(arr, i) { if (!(Symbol.iterator in Object(arr) || Object.prototype.toString.call(arr) === "[object Arguments]")) { return; } var _arr = []; var _n = true; var _d = false; var _e = undefined; try { for (var _i = arr[Symbol.iterator](), _s; !(_n = (_s = _i.next()).done); _n = true) { _arr.push(_s.value); if (i && _arr.length === i) break; } } catch (err) { _d = true; _e = err; } finally { try { if (!_n && _i["return"] != null) _i["return"](); } finally { if (_d) throw _e; } } return _arr; }

function _arrayWithHoles(arr) { if (Array.isArray(arr)) return arr; }

var app = new _koa["default"]();
var router = new _koaRouter["default"]();
app.use((0, _koaBody.koaBody)({
  urlencoded: true,
  json: true
}));
var connection1;

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
})();

var active = false;
exports.active = active;
var zhiling_beifen_array = [];
var level = 0;
var now_ID = null;
var tem = 0;
var BASE_URL = 'http://127.0.0.1:9000';

function delay(ms) {
  return new Promise(function (resolve) {
    return setTimeout(resolve, ms);
  });
}

function getFormattedDate() {
  var now = new Date();
  var year = now.getFullYear();
  var month = String(now.getMonth() + 1).padStart(2, '0');
  var day = String(now.getDate()).padStart(2, '0');
  var hours = String(now.getHours()).padStart(2, '0');
  var minutes = String(now.getMinutes()).padStart(2, '0');
  var seconds = String(now.getSeconds()).padStart(2, '0');
  return "".concat(year, "-").concat(month, "-").concat(day, "-").concat(hours, "-").concat(minutes, "-").concat(seconds);
}

function getTongbu() {
  var now = new Date();
  var hours = String(now.getHours()).padStart(2, '0');
  var minutes = String(now.getMinutes()).padStart(2, '0');
  var seconds = String(now.getSeconds()).padStart(2, '0');
  return "".concat(hours, ":").concat(minutes, ":").concat(seconds);
} // 心跳检测器


setInterval(function _callee2() {
  return regeneratorRuntime.async(function _callee2$(_context2) {
    while (1) {
      switch (_context2.prev = _context2.next) {
        case 0:
          console.log("心跳正常发送");
          _context2.prev = 1;
          _context2.next = 4;
          return regeneratorRuntime.awrap(_axios["default"].post("".concat(BASE_URL, "/heartbeat/send"), {
            heartTest_client: "start"
          }));

        case 4:
          exports.active = active = false;
          console.log("成功发送心跳");
          _context2.next = 11;
          break;

        case 8:
          _context2.prev = 8;
          _context2.t0 = _context2["catch"](1);
          console.log("\u53D1\u9001\u5FC3\u8DF3\u5931\u8D25: ".concat(_context2.t0.message));

        case 11:
        case "end":
          return _context2.stop();
      }
    }
  }, null, null, [[1, 8]]);
}, 5000); // 重发函数

function reconnect_republish() {
  exports.active = active = true;
  republish();
}

function republish() {
  var length, i;
  return regeneratorRuntime.async(function republish$(_context3) {
    while (1) {
      switch (_context3.prev = _context3.next) {
        case 0:
          console.log("zhiling_beifen_array_length:" + zhiling_beifen_array.length);
          console.log("zhiling_beifen:");
          console.dir(zhiling_beifen_array);
          length = zhiling_beifen_array.length;
          i = 0;

        case 5:
          if (!(i < length)) {
            _context3.next = 15;
            break;
          }

          if (!(zhiling_beifen_array.length > 0 && zhiling_beifen_array[0].length > 0)) {
            _context3.next = 10;
            break;
          }

          _context3.next = 9;
          return regeneratorRuntime.awrap(beifen(1, zhiling_beifen_array[0]));

        case 9:
          zhiling_beifen_array.shift();

        case 10:
          _context3.next = 12;
          return regeneratorRuntime.awrap(delay(3000));

        case 12:
          i++;
          _context3.next = 5;
          break;

        case 15:
        case "end":
          return _context3.stop();
      }
    }
  });
}

function beifen(value1, value2) {
  return regeneratorRuntime.async(function beifen$(_context4) {
    while (1) {
      switch (_context4.prev = _context4.next) {
        case 0:
          _context4.prev = 0;
          _context4.next = 3;
          return regeneratorRuntime.awrap(_axios["default"].post("".concat(BASE_URL, "/").concat(value2[0]), value2[1]));

        case 3:
          _context4.next = 5;
          return regeneratorRuntime.awrap(delay(1000));

        case 5:
          _context4.next = 7;
          return regeneratorRuntime.awrap(_axios["default"].post("".concat(BASE_URL, "/").concat(value2[0]), value2[1]));

        case 7:
          _context4.next = 12;
          break;

        case 9:
          _context4.prev = 9;
          _context4.t0 = _context4["catch"](0);
          console.log("\u53D1\u9001\u6307\u4EE4\u5931\u8D25: ".concat(_context4.t0.message));

        case 12:
          if (active === false) {
            zhiling_beifen_array.push(value2);
            console.log("zhiling_beifen_array.length:" + zhiling_beifen_array.length);
          }

        case 13:
        case "end":
          return _context4.stop();
      }
    }
  }, null, null, [[0, 9]]);
} // HTTP 服务器端点


router.post('/sensor/data', function _callee3(ctx) {
  var _ctx$request$body, d_no, string, png, mp4, type, _ref, _ref2, rows1, time_base, obj, finalType, finalDNo;

  return regeneratorRuntime.async(function _callee3$(_context5) {
    while (1) {
      switch (_context5.prev = _context5.next) {
        case 0:
          _ctx$request$body = ctx.request.body, d_no = _ctx$request$body.d_no, string = _ctx$request$body.string, png = _ctx$request$body.png, mp4 = _ctx$request$body.mp4, type = _ctx$request$body.type;
          console.log("接收到传感器数据", ctx.request.body);

          if (!(string > 0 && png > 0 && mp4 > 0)) {
            _context5.next = 15;
            break;
          }

          _context5.next = 5;
          return regeneratorRuntime.awrap(connection1.execute("SELECT p_name FROM t_field_mapper"));

        case 5:
          _ref = _context5.sent;
          _ref2 = _slicedToArray(_ref, 1);
          rows1 = _ref2[0];
          time_base = getFormattedDate();
          obj = {};
          rows1.forEach(function (item, index) {
            if (index === 0) obj[item.p_name] = png;else if (index === 1) obj[item.p_name] = string;else if (index === 2) obj[item.p_name] = mp4;
          });
          finalType = type || "实时数据";
          finalDNo = d_no || null;
          _context5.next = 15;
          return regeneratorRuntime.awrap(connection1.execute("\n      INSERT INTO t_data(d_no,field1,field2,field3,field4,c_time,type)\n      VALUES (\"".concat(finalDNo, "\",\"").concat(obj.TI, "\",\"").concat(obj.TO, "\",\"").concat(obj.L, "\",\"1\",\"").concat(time_base, "\",\"").concat(finalType, "\")\n    ")));

        case 15:
          ctx.status = 200;
          ctx.body = 'OK';

        case 17:
        case "end":
          return _context5.stop();
      }
    }
  });
});
router.post('/miss_data', function _callee4(ctx) {
  var _ctx$request$body2, d_no, png, string, mp4, type, hour, minute, second, _ref3, _ref4, rows1, time_base, obj, finalType, finalDNo, time;

  return regeneratorRuntime.async(function _callee4$(_context6) {
    while (1) {
      switch (_context6.prev = _context6.next) {
        case 0:
          _ctx$request$body2 = ctx.request.body, d_no = _ctx$request$body2.d_no, png = _ctx$request$body2.png, string = _ctx$request$body2.string, mp4 = _ctx$request$body2.mp4, type = _ctx$request$body2.type, hour = _ctx$request$body2.hour, minute = _ctx$request$body2.minute, second = _ctx$request$body2.second;
          console.log("接收到保存数据", ctx.request.body);

          if (!(png > 0 && png > 0 && mp4 > 0)) {
            _context6.next = 16;
            break;
          }

          _context6.next = 5;
          return regeneratorRuntime.awrap(connection1.execute("SELECT p_name FROM t_field_mapper"));

        case 5:
          _ref3 = _context6.sent;
          _ref4 = _slicedToArray(_ref3, 1);
          rows1 = _ref4[0];
          time_base = getFormattedDate();
          obj = {};
          rows1.forEach(function (item, index) {
            if (index === 0) obj[item.p_name] = png;else if (index === 1) obj[item.p_name] = string;else if (index === 2) obj[item.p_name] = mp4;
          });
          finalType = type || "保存数据";
          finalDNo = d_no || null;
          time = "".concat(time_base.split("-")[0], "-").concat(time_base.split("-")[1], "-").concat(time_base.split("-")[2], " ").concat(hour, ":").concat(minute, ":").concat(second);
          _context6.next = 16;
          return regeneratorRuntime.awrap(connection1.execute("\n      INSERT INTO t_data(d_no,field1,field2,field3,field4,c_time,type)\n      VALUES (\"".concat(finalDNo, "\",\"").concat(obj.TI, "\",\"").concat(obj.TO, "\",\"").concat(obj.L, "\",\"1\",\"").concat(time, "\",\"").concat(finalType, "\")\n    ")));

        case 16:
          ctx.status = 200;
          ctx.body = 'OK';

        case 18:
        case "end":
          return _context6.stop();
      }
    }
  });
});
router.post('/heartbeat', function _callee5(ctx) {
  return regeneratorRuntime.async(function _callee5$(_context7) {
    while (1) {
      switch (_context7.prev = _context7.next) {
        case 0:
          console.log("收到设备心跳");
          reconnect_republish();
          ctx.status = 200;
          ctx.body = 'OK';

        case 4:
        case "end":
          return _context7.stop();
      }
    }
  });
}); // 暂时闭嘴报错
// router.post("/heartbeat/send",async(ctx)=>{
//   console.log("成功接收");
//   ctx.body = '当前成功响应';
// })

router.post('/alarm', function _callee6(ctx) {
  var Vstatus, msg;
  return regeneratorRuntime.async(function _callee6$(_context8) {
    while (1) {
      switch (_context8.prev = _context8.next) {
        case 0:
          Vstatus = ctx.request.body.Vstatus;
          msg = Vstatus === "1" ? "空调故障" : Vstatus === "2" ? "风扇故障" : Vstatus === "3" ? "危险气体浓度超标" : Vstatus === "4" ? "湿度超标" : "储运箱断电时间过长";
          _context8.next = 4;
          return regeneratorRuntime.awrap(connection1.execute("\n    UPDATE t_error_msg\n    SET e_msg = \"".concat(msg, "\", c_time = \"").concat(getFormattedDate(), "\"\n    WHERE id = ").concat(Number(Vstatus), ";\n  ")));

        case 4:
          _context8.next = 6;
          return regeneratorRuntime.awrap(connection1.execute("UPDATE t_error_msg SET VStatus = \"1\";"));

        case 6:
          _context8.next = 8;
          return regeneratorRuntime.awrap(connection1.execute("\n    INSERT INTO t_error_history(e_msg,c_time)\n    VALUES (\"".concat(msg, "\",\"").concat(getFormattedDate(), "\")\n  ")));

        case 8:
          ctx.status = 200;
          ctx.body = 'OK';

        case 10:
        case "end":
          return _context8.stop();
      }
    }
  });
});
router.post('/alarm1', function _callee7(ctx) {
  var OK, _ref5, _ref6, rows1, sum, i;

  return regeneratorRuntime.async(function _callee7$(_context9) {
    while (1) {
      switch (_context9.prev = _context9.next) {
        case 0:
          console.log("alarm1成功触发");
          OK = ctx.request.body.OK;
          _context9.next = 4;
          return regeneratorRuntime.awrap(connection1.execute("\n    UPDATE t_error_msg\n    SET e_msg = \"\u672A\u53D1\u751F\u544A\u8B66\", c_time = \"".concat(getFormattedDate(), "\"\n    WHERE id = ").concat(Number(OK), ";\n  ")));

        case 4:
          _context9.next = 6;
          return regeneratorRuntime.awrap(connection1.execute("SELECT e_msg FROM t_error_msg"));

        case 6:
          _ref5 = _context9.sent;
          _ref6 = _slicedToArray(_ref5, 1);
          rows1 = _ref6[0];
          sum = 0;
          i = 0;

        case 11:
          if (!(i < 5)) {
            _context9.next = 20;
            break;
          }

          if (!(rows1[i].e_msg === "未发生告警")) {
            _context9.next = 16;
            break;
          }

          sum++;
          _context9.next = 17;
          break;

        case 16:
          return _context9.abrupt("break", 20);

        case 17:
          i++;
          _context9.next = 11;
          break;

        case 20:
          if (!(sum === 5)) {
            _context9.next = 23;
            break;
          }

          _context9.next = 23;
          return regeneratorRuntime.awrap(connection1.execute("UPDATE t_error_msg SET VStatus = \"0\";"));

        case 23:
          ctx.status = 200;
          ctx.body = 'OK';

        case 25:
        case "end":
          return _context9.stop();
      }
    }
  });
});
router.post('/chonglian', function _callee9(ctx) {
  return regeneratorRuntime.async(function _callee9$(_context11) {
    while (1) {
      switch (_context11.prev = _context11.next) {
        case 0:
          console.log("接收到重连消息");
          setTimeout(function _callee8() {
            return regeneratorRuntime.async(function _callee8$(_context10) {
              while (1) {
                switch (_context10.prev = _context10.next) {
                  case 0:
                    _context10.next = 2;
                    return regeneratorRuntime.awrap(beifen(0, ["chonglian1", {
                      time: getTongbu()
                    }]));

                  case 2:
                  case "end":
                    return _context10.stop();
                }
              }
            });
          }, 10000);
          ctx.status = 200;
          ctx.body = 'OK';

        case 4:
        case "end":
          return _context11.stop();
      }
    }
  });
});
router.post('/direct1', function _callee10(ctx) {
  var _ctx$request$body3, PID, VID;

  return regeneratorRuntime.async(function _callee10$(_context12) {
    while (1) {
      switch (_context12.prev = _context12.next) {
        case 0:
          _ctx$request$body3 = ctx.request.body, PID = _ctx$request$body3.PID, VID = _ctx$request$body3.VID;
          _context12.next = 3;
          return regeneratorRuntime.awrap(connection1.execute("\n    INSERT INTO t_container(VID,ctime,PID)\n    VALUES (\"".concat(VID, "\",\"").concat(getFormattedDate(), "\",\"").concat(PID, "\")\n  ")));

        case 3:
          ctx.status = 200;
          ctx.body = 'OK';

        case 5:
        case "end":
          return _context12.stop();
      }
    }
  });
}); // 模拟 MQTT 订阅的轮询
// async function startPolling() {
//   const endpoints = ['sensor/data', 'miss_data', 'heartbeat', 'alarm', 'alarm1', 'chonglian', 'direct1'];
//   while (true) {
//     for (const endpoint of endpoints) { 
//       try {
//         await axios.get(`${BASE_URL}/${endpoint}/poll`);
//       } catch (err) {
//         console.log(`轮询 ${endpoint} 失败: ${err.message}`);
//       }
//     }
//     await delay(5000);
//   }
// }

var _default = router; // startPolling();

exports["default"] = _default;