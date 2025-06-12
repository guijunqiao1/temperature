"use strict";

Object.defineProperty(exports, "__esModule", {
  value: true
});
exports["default"] = void 0;

var _koaRouter = _interopRequireDefault(require("koa-router"));

var _indexNode = _interopRequireDefault(require("../indexNode2.js"));

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { "default": obj }; }

function _slicedToArray(arr, i) { return _arrayWithHoles(arr) || _iterableToArrayLimit(arr, i) || _nonIterableRest(); }

function _nonIterableRest() { throw new TypeError("Invalid attempt to destructure non-iterable instance"); }

function _iterableToArrayLimit(arr, i) { if (!(Symbol.iterator in Object(arr) || Object.prototype.toString.call(arr) === "[object Arguments]")) { return; } var _arr = []; var _n = true; var _d = false; var _e = undefined; try { for (var _i = arr[Symbol.iterator](), _s; !(_n = (_s = _i.next()).done); _n = true) { _arr.push(_s.value); if (i && _arr.length === i) break; } } catch (err) { _d = true; _e = err; } finally { try { if (!_n && _i["return"] != null) _i["return"](); } finally { if (_d) throw _e; } } return _arr; }

function _arrayWithHoles(arr) { if (Array.isArray(arr)) return arr; }

function _typeof(obj) { if (typeof Symbol === "function" && typeof Symbol.iterator === "symbol") { _typeof = function _typeof(obj) { return typeof obj; }; } else { _typeof = function _typeof(obj) { return obj && typeof Symbol === "function" && obj.constructor === Symbol && obj !== Symbol.prototype ? "symbol" : typeof obj; }; } return _typeof(obj); }

var Router_direct = new _koaRouter["default"](); //在当前需要对Mysql数据库进行操作的文件中提前引入Mysql数据库的配置文件--需要注意的是indexNode文件中的其他引入的组件文件只是对indexNode本身编写的时候进行约束的文件

//此处获取到数据库链接配置对象
var connection; //定义数据库连接对象

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
          console.log("数据库2连接成功");
          _context.next = 10;
          break;

        case 7:
          _context.prev = 7;
          _context.t0 = _context["catch"](0);
          console.log("数据库2连接失败");

        case 10:
        case "end":
          return _context.stop();
      }
    }
  }, null, null, [[0, 7]]);
})(); //额外绑定获取所有数据的路由


Router_direct.get("/zhiling", function _callee2(ctx) {
  var mode, result, rowx;
  return regeneratorRuntime.async(function _callee2$(_context2) {
    while (1) {
      switch (_context2.prev = _context2.next) {
        case 0:
          mode = ctx.query.mode;
          _context2.next = 3;
          return regeneratorRuntime.awrap(connection.execute("\n  SELECT c.id,c.f_type,c.mode,c.f_value,c.t_name,c.max,c.min,c.topic,c.header,c.luyou,t.value,c.label_boolean,c.label\n  FROM t_direct t,t_direct_config c\n  WHERE c.id = t.config_id\n  AND ok in (\"yes\",\"yes1\")\n  AND c.mode = \"".concat(mode, "\"\n  ORDER BY CASE f_type\n      WHEN '1' THEN 1\n      WHEN '5' THEN 2\n      WHEN '3' THEN 3\n      ELSE 4\n    END;\n  ")));

        case 3:
          result = _context2.sent;
          rowx = result[0]; //时间格式化方法
          // const formatTime = (timeStr) => new Date(timeStr).toISOString().slice(0, 19).replace('T', ' ');

          rowx.forEach(function (item, index) {
            if (item.value.split(" ")[1]) {//若为时间值
              // item.value = formatTime(item.value);
              // console.log("成功转化时间值" + item.value);
            } else if (Number.isNaN(Number(item.value))) {//若为中文值
              // console.log("item.value:"+item.value);
              // console.log(new Date(item.value));
            } else {
              // console.log("进入成功");
              item.value = Number(item.value);
            }
          });
          ctx.body = rowx;
          return _context2.abrupt("return");

        case 8:
        case "end":
          return _context2.stop();
      }
    }
  });
}); //修改关联boolean的路由

Router_direct.get("/label_boolean", function _callee3(ctx) {
  var _ctx$query, content, id, _ref, _ref2, result0, _ref3, _ref4, result, _ref5, _ref6, _result;

  return regeneratorRuntime.async(function _callee3$(_context3) {
    while (1) {
      switch (_context3.prev = _context3.next) {
        case 0:
          console.log("成功进入路由");
          _ctx$query = ctx.query, content = _ctx$query.content, id = _ctx$query.id;
          id = Number(id);
          console.log("TYPE:id" + _typeof(id));
          _context3.next = 6;
          return regeneratorRuntime.awrap(connection.execute("\n  SELECT label\n  FROM t_direct_config\n  WHERE id = ".concat(id, "\n  ")));

        case 6:
          _ref = _context3.sent;
          _ref2 = _slicedToArray(_ref, 1);
          result0 = _ref2[0];
          console.log("result0:");
          console.dir(result0[0]);
          console.log(result0[0].label + "_label");

          if (!(content === "开" || content === "关")) {
            _context3.next = 20;
            break;
          }

          _context3.next = 15;
          return regeneratorRuntime.awrap(connection.execute("\n    UPDATE t_direct_config\n    SET label_boolean = ".concat(content === "开" ? "1" : null, "\n    WHERE label = \"").concat(result0[0].label + "_label", "\";\n  ")));

        case 15:
          _ref3 = _context3.sent;
          _ref4 = _slicedToArray(_ref3, 1);
          result = _ref4[0];
          _context3.next = 25;
          break;

        case 20:
          _context3.next = 22;
          return regeneratorRuntime.awrap(connection.execute("\n    UPDATE t_direct_config\n    SET label_boolean = ".concat(content === "手动" ? "1" : null, "\n    WHERE ok = \"yes\"; \n  ")));

        case 22:
          _ref5 = _context3.sent;
          _ref6 = _slicedToArray(_ref5, 1);
          _result = _ref6[0];

        case 25:
          ctx.body = "ok";

        case 26:
        case "end":
          return _context3.stop();
      }
    }
  });
});
var _default = Router_direct;
exports["default"] = _default;