"use strict";

Object.defineProperty(exports, "__esModule", {
  value: true
});
exports["default"] = void 0;

var _indexNode = _interopRequireDefault(require("../indexNode2.js"));

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { "default": obj }; }

function _readOnlyError(name) { throw new Error("\"" + name + "\" is read-only"); }

// const Router = require('koa-router');
// const multer = require('@koa/multer');
// const path = require('path');
// const router = new Router();
// const storage = multer.diskStorage({
//   destination: (req, file, cb) => {
//     cb(null, 'uploads/');
//   },
//   filename: (req, file, cb) => {
//     const ext = path.extname(file.originalname);
//     cb(null, `${Date.now()}-${file.originalname.replace(ext, '')}${ext}`);
//   }
// });
// const upload = multer({
//   storage,
//   limits: { fileSize: 100 * 1024 * 1024 }
// });
// router.post('/upload', upload.single('file'), async (ctx) => {
//   const file = ctx.file;
//   let { userId,d_no } = ctx.request.body;
//   // 判断场景
//   d_no = d_no?d_no:null;
//   if (!file) {
//     ctx.status = 400;
//     ctx.body = { error: '未上传文件' };
//     return;
//   }
//   const fileInfo = {
//     originalName: file.originalname,
//     fileName: file.filename,
//     path: file.path,
//     mimeType: file.mimetype,
//     size: file.size,
//     userId
//   };
//   // 保存文件信息到数据库中
//   await connection1.execute(`
//   INSERT INTO t_behavior_data(d_no,field1,c_time,is_saved,file_type)
//   VALUES ("${d_no}","${fileName}","${new Date()}","实时数据","${fileName.split('.')[1]==='mp4'?'video':'picture'}")
//   `);
//   ctx.body = {
//     message: '文件上传成功',
//     fileInfo
//   };
// });
// export default router;
var fs = require('fs');

var path = require('path');

var express = require("express");

var router = express();
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
})(); // 处理上传请求


router.post('/insert_img', function _callee2(req, res) {
  var _req$body, image, d_no, sum, fileName1, fileName2, _iteratorNormalCompletion, _didIteratorError, _iteratorError, _iterator, _step, base64Image, matches, extension, base64Data, buffer;

  return regeneratorRuntime.async(function _callee2$(_context2) {
    while (1) {
      switch (_context2.prev = _context2.next) {
        case 0:
          _req$body = req.body, image = _req$body.image, d_no = _req$body.d_no; // 判断场景

          d_no = (_readOnlyError("d_no"), d_no ? d_no : null);

          if (!(!image || !Array.isArray(image) || image.length === 0)) {
            _context2.next = 4;
            break;
          }

          return _context2.abrupt("return", res.status(400).json({
            error: '未上传图片资源'
          }));

        case 4:
          //外部计数变量
          sum = 0;
          _context2.prev = 5;
          _iteratorNormalCompletion = true;
          _didIteratorError = false;
          _iteratorError = undefined;
          _context2.prev = 9;
          _iterator = image[Symbol.iterator]();

        case 11:
          if (_iteratorNormalCompletion = (_step = _iterator.next()).done) {
            _context2.next = 23;
            break;
          }

          base64Image = _step.value;
          // 提取 Base64 编码的字符串中的数据部分
          matches = base64Image.match(/^data:image\/(jpeg|png|jpg);base64,(.+)$/);

          if (matches) {
            _context2.next = 16;
            break;
          }

          return _context2.abrupt("return", res.status(400).json({
            error: '无效的 Base64 编码'
          }));

        case 16:
          extension = matches[1]; // 图片格式（jpeg, png, jpg）

          base64Data = matches[2]; // 图片的 Base64 数据

          buffer = Buffer.from(base64Data, 'base64'); // 转换为二进制数据
          // 为文件生成唯一的文件名

          if (sum === 0) {
            fileName1 = "".concat(Date.now(), "-").concat(Math.random().toString(36).substr(2, 9), ".").concat(extension);
            filePath = path.join(__dirname, 'public', fileName1);
            sum++;
          } else {
            fileName2 = "".concat(Date.now(), "-").concat(Math.random().toString(36).substr(2, 9), ".").concat(extension);
            filePath = path.join(__dirname, 'public', fileName2); // 将二进制数据保存为文件

            fs.writeFileSync(filePath, buffer);
          }

        case 20:
          _iteratorNormalCompletion = true;
          _context2.next = 11;
          break;

        case 23:
          _context2.next = 29;
          break;

        case 25:
          _context2.prev = 25;
          _context2.t0 = _context2["catch"](9);
          _didIteratorError = true;
          _iteratorError = _context2.t0;

        case 29:
          _context2.prev = 29;
          _context2.prev = 30;

          if (!_iteratorNormalCompletion && _iterator["return"] != null) {
            _iterator["return"]();
          }

        case 32:
          _context2.prev = 32;

          if (!_didIteratorError) {
            _context2.next = 35;
            break;
          }

          throw _iteratorError;

        case 35:
          return _context2.finish(32);

        case 36:
          return _context2.finish(29);

        case 37:
          _context2.next = 39;
          return regeneratorRuntime.awrap(connection1.execute("\n      INSERT INTO t_behavior_data(d_no, field1,field2, c_time, is_saved, file_type)\n      VALUES (\"".concat(d_no, "\", \"").concat(fileName1, "\",\"").concat(fileName2, "\", \"").concat(new Date(), "\", \"\u5B9E\u65F6\u6570\u636E\", \"picture\")\n    ")));

        case 39:
          // 返回成功响应
          res.json({
            message: '文件上传成功'
          });
          _context2.next = 46;
          break;

        case 42:
          _context2.prev = 42;
          _context2.t1 = _context2["catch"](5);
          console.error(_context2.t1);
          return _context2.abrupt("return", res.status(500).json({
            error: '保存文件信息失败'
          }));

        case 46:
        case "end":
          return _context2.stop();
      }
    }
  }, null, null, [[5, 42], [9, 25, 29, 37], [30,, 32, 36]]);
});
var _default = router;
exports["default"] = _default;