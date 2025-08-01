"use strict";

Object.defineProperty(exports, "__esModule", {
  value: true
});
exports["default"] = void 0;

var _fs = _interopRequireDefault(require("fs"));

var _path = _interopRequireDefault(require("path"));

var _express = _interopRequireDefault(require("express"));

var _indexNode = _interopRequireDefault(require("../indexNode2.js"));

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { "default": obj }; }

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
var router = (0, _express["default"])();
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
  var _req$body, image, d_no, sum, fileName1, fileName2, filePath, _iteratorNormalCompletion, _didIteratorError, _iteratorError, _iterator, _step, base64Image, matches, extension, base64Data, buffer;

  return regeneratorRuntime.async(function _callee2$(_context2) {
    while (1) {
      switch (_context2.prev = _context2.next) {
        case 0:
          _req$body = req.body, image = _req$body.image, d_no = _req$body.d_no; //image数组第二个元素包含检测结果
          // 判断场景

          d_no = d_no ? d_no : null;
          console.log("成功进入插入路由");

          if (!(!image || !Array.isArray(image) || image.length === 0)) {
            _context2.next = 5;
            break;
          }

          return _context2.abrupt("return", res.status(400).json({
            error: '未上传图片资源'
          }));

        case 5:
          //外部计数变量
          sum = 0;
          _context2.prev = 6;
          _iteratorNormalCompletion = true;
          _didIteratorError = false;
          _iteratorError = undefined;
          _context2.prev = 10;
          _iterator = image[Symbol.iterator]();

        case 12:
          if (_iteratorNormalCompletion = (_step = _iterator.next()).done) {
            _context2.next = 24;
            break;
          }

          base64Image = _step.value;
          // 提取 Base64 编码的字符串中的数据部分
          matches = base64Image.match(/^data:image\/(jpeg|png|jpg);base64,(.+)$/);

          if (matches) {
            _context2.next = 17;
            break;
          }

          return _context2.abrupt("return", res.status(400).json({
            error: '无效的 Base64 编码'
          }));

        case 17:
          extension = matches[1]; // 图片格式（jpeg, png, jpg）

          base64Data = matches[2]; // 图片的 Base64 数据

          buffer = Buffer.from(base64Data, 'base64'); // 转换为二进制数据
          // 为文件生成唯一的文件名

          if (sum === 0) {
            fileName1 = "".concat(Date.now(), "-").concat(Math.random().toString(36).substr(2, 9), ".").concat(extension);
            filePath = _path["default"].join('D:', 'temperature', 'project01', 'serve', 'public', fileName1);
            sum++;
          } else {
            fileName2 = "".concat(Date.now(), "-").concat(Math.random().toString(36).substr(2, 9), ".").concat(extension);
            filePath = _path["default"].join('D:', 'temperature', 'project01', 'serve', 'public', fileName2); // 将二进制数据保存为文件

            _fs["default"].writeFileSync(filePath, buffer);
          }

        case 21:
          _iteratorNormalCompletion = true;
          _context2.next = 12;
          break;

        case 24:
          _context2.next = 30;
          break;

        case 26:
          _context2.prev = 26;
          _context2.t0 = _context2["catch"](10);
          _didIteratorError = true;
          _iteratorError = _context2.t0;

        case 30:
          _context2.prev = 30;
          _context2.prev = 31;

          if (!_iteratorNormalCompletion && _iterator["return"] != null) {
            _iterator["return"]();
          }

        case 33:
          _context2.prev = 33;

          if (!_didIteratorError) {
            _context2.next = 36;
            break;
          }

          throw _iteratorError;

        case 36:
          return _context2.finish(33);

        case 37:
          return _context2.finish(30);

        case 38:
          _context2.next = 40;
          return regeneratorRuntime.awrap(connection1.execute("\n      INSERT INTO t_behavior_data(d_no, field1,field2, c_time, is_saved, file_type)\n      VALUES (\"".concat(d_no, "\", \"").concat(fileName1, "\",\"").concat(fileName2, "\", \"").concat(new Date(), "\", \"\u5B9E\u65F6\u6570\u636E\", \"picture\")\n    ")));

        case 40:
          // 返回成功响应
          res.json({
            message: '文件上传成功'
          });
          _context2.next = 47;
          break;

        case 43:
          _context2.prev = 43;
          _context2.t1 = _context2["catch"](6);
          console.error(_context2.t1);
          return _context2.abrupt("return", res.status(500).json({
            error: '保存文件信息失败'
          }));

        case 47:
        case "end":
          return _context2.stop();
      }
    }
  }, null, null, [[6, 43], [10, 26, 30, 38], [31,, 33, 37]]);
});
router.get('/sssss', function _callee3(req, res) {
  return regeneratorRuntime.async(function _callee3$(_context3) {
    while (1) {
      switch (_context3.prev = _context3.next) {
        case 0:
          res.send('1');

        case 1:
        case "end":
          return _context3.stop();
      }
    }
  });
});
var _default = router;
exports["default"] = _default;