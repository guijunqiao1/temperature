"use strict";

Object.defineProperty(exports, "__esModule", {
  value: true
});
exports["default"] = void 0;

var _mqtt = _interopRequireDefault(require("mqtt"));

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { "default": obj }; }

// 模拟设备层客户端对象
var device_mqtt = _mqtt["default"].connect("mqtt://127.0.0.1", {
  clientId: "device_mqtt"
});

device_mqtt.on("connect", function () {
  device_mqtt.subscribe('sensor/heartTest_client', {
    qos: 1
  }, function (err) {
    if (err) {
      console.log("订阅sensor/heartTest_client主题失败");
    } else {
      console.log("订阅sensor/heartTest_client主题成功");
    }
  });
}); // 为设备层添加上响应心跳的事件

device_mqtt.on("message", function (topic, message) {
  if (topic === "sensor/heartTest_client") {
    device_mqtt.publish("heartTest_device", {
      a: "a"
    }, {
      qos: 1
    }); //仅响应结果

    console.log("设备层成功响应心跳");
  }
});
var _default = device_mqtt;
exports["default"] = _default;