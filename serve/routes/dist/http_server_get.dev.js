"use strict";

Object.defineProperty(exports, "__esModule", {
  value: true
});
exports["default"] = void 0;

var Router = require('koa-router');

var multer = require('@koa/multer');

var path = require('path'); // 初始化 Koa 应用和路由


var router = new Router(); // 配置 Multer 的本地存储

var storage = multer.diskStorage({
  destination: function destination(req, file, cb) {
    // 设置文件存储目录为 uploads/
    cb(null, 'client/public/');
  },
  filename: function filename(req, file, cb) {
    // 使用时间戳和原始文件名生成唯一文件名
    var ext = path.extname(file.originalname);
    cb(null, "".concat(file.originalname.replace(ext, '')).concat(ext));
  }
}); // 初始化 Multer，设置存储和文件大小限制（100MB）

var upload = multer({
  storage: storage,
  limits: {
    fileSize: 100 * 1024 * 1024
  } // 限制文件大小为 100MB

}); // 路由：处理多文件上传到本地磁盘

router.post('/upload', upload.array('files', 2), function _callee(ctx) {
  var files, userId, filesInfo;
  return regeneratorRuntime.async(function _callee$(_context) {
    while (1) {
      switch (_context.prev = _context.next) {
        case 0:
          files = ctx.files; // 获取上传的文件数组

          userId = ctx.request.body.userId; // 获取请求体中的 userId
          // 检查是否有文件上传

          if (!(!files || files.length === 0)) {
            _context.next = 6;
            break;
          }

          ctx.status = 400;
          ctx.body = {
            error: '未上传任何文件'
          };
          return _context.abrupt("return");

        case 6:
          if (!(files.length > 2)) {
            _context.next = 10;
            break;
          }

          ctx.status = 400;
          ctx.body = {
            error: '最多允许上传 2 个文件'
          };
          return _context.abrupt("return");

        case 10:
          // 返回上传成功的文件信息
          filesInfo = files.map(function (file) {
            return {
              originalName: file.originalname,
              // 原始文件名
              fileName: file.filename,
              // 存储后的文件名
              path: file.path,
              // 文件存储路径
              mimeType: file.mimetype,
              // 文件 MIME 类型
              size: file.size,
              // 文件大小
              userId: userId // 关联的用户 ID

            };
          }); // 保存文件信息到数据库中

          _context.next = 13;
          return regeneratorRuntime.awrap(connection1.execute("\n  INSERT INTO t_behavior_data(d_no,field1,field2,c_time,is_saved)\n  VALUES (\"".concat(finalDNo, "\",\"").concat(filesInfo[0].originalName.split(".")[1] === "mp4" ? filesInfo[1].fileName : filesInfo[0].fileName, "\",\"").concat(filesInfo[0].originalName.split(".")[1] === "mp4" ? filesInfo[0].fileName : filesInfo[1].fileName, "\",\"").concat(time_base, "\",\"").concat(finalType, "\")\n  ")));

        case 13:
          ctx.body = {
            message: '文件上传成功',
            filesInfo: filesInfo
          };

        case 14:
        case "end":
          return _context.stop();
      }
    }
  });
});
var _default = router;
exports["default"] = _default;