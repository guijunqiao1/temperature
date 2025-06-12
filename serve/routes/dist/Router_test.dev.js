"use strict";

Object.defineProperty(exports, "__esModule", {
  value: true
});
exports["default"] = void 0;

var _koaRouter = _interopRequireDefault(require("koa-router"));

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { "default": obj }; }

//测试
var Routerx = new _koaRouter["default"]();
Routerx.get("/gui_test", function (ctx, next) {
  console.log("成功进入当前路由");
  ctx.body = "响应成功";
});
var _default = Routerx;
exports["default"] = _default;