"use strict";

Object.defineProperty(exports, "__esModule", {
  value: true
});
exports["default"] = void 0;

var _express = _interopRequireDefault(require("express"));

var _multer = _interopRequireDefault(require("multer"));

var _path = _interopRequireDefault(require("path"));

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
var router = _express["default"].Router(); // 设置存储方式


var storage = _multer["default"].diskStorage({
  destination: function destination(req, file, cb) {
    cb(null, 'uploads/');
  },
  filename: function filename(req, file, cb) {
    var ext = _path["default"].extname(file.originalname);

    cb(null, "".concat(Date.now(), "-").concat(file.originalname.replace(ext, '')).concat(ext));
  }
}); // 初始化 multer


var upload = (0, _multer["default"])({
  storage: storage,
  limits: {
    fileSize: 100 * 1024 * 1024
  }
}); // 处理上传请求

router.post('/upload', upload.single('file'), function _callee(req, res) {
  var file, _req$body, userId, d_no, fileInfo;

  return regeneratorRuntime.async(function _callee$(_context) {
    while (1) {
      switch (_context.prev = _context.next) {
        case 0:
          file = req.file;
          _req$body = req.body, userId = _req$body.userId, d_no = _req$body.d_no; // 判断场景

          d_no = d_no ? d_no : null;

          if (file) {
            _context.next = 5;
            break;
          }

          return _context.abrupt("return", res.status(400).json({
            error: '未上传文件'
          }));

        case 5:
          fileInfo = {
            originalName: file.originalname,
            fileName: file.filename,
            path: file.path,
            mimeType: file.mimetype,
            size: file.size,
            userId: userId
          }; // 保存文件信息到数据库中

          _context.prev = 6;
          _context.next = 9;
          return regeneratorRuntime.awrap(connection1.execute("\n      INSERT INTO t_behavior_data(d_no, field1, c_time, is_saved, file_type)\n      VALUES (\"".concat(d_no, "\", \"").concat(file.filename, "\", \"").concat(new Date(), "\", \"\u5B9E\u65F6\u6570\u636E\", \"").concat(file.filename.split('.')[1] === 'mp4' ? 'video' : 'picture', "\")\n    ")));

        case 9:
          _context.next = 14;
          break;

        case 11:
          _context.prev = 11;
          _context.t0 = _context["catch"](6);
          return _context.abrupt("return", res.status(500).json({
            error: '保存文件信息失败'
          }));

        case 14:
          res.json({
            message: '文件上传成功',
            fileInfo: fileInfo
          });

        case 15:
        case "end":
          return _context.stop();
      }
    }
  }, null, null, [[6, 11]]);
});
var _default = router;
exports["default"] = _default;