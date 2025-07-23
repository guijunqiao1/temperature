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


import express from 'express';
import multer from 'multer';
import path from 'path';

const router = express.Router();

// 设置存储方式
const storage = multer.diskStorage({
  destination: (req, file, cb) => {
    cb(null, 'uploads/');
  },
  filename: (req, file, cb) => {
    const ext = path.extname(file.originalname);
    cb(null, `${Date.now()}-${file.originalname.replace(ext, '')}${ext}`);
  }
});

// 初始化 multer
const upload = multer({
  storage,
  limits: { fileSize: 100 * 1024 * 1024 }
});

// 处理上传请求
router.post('/upload', upload.single('file'), async (req, res) => {
  const file = req.file;
  let { userId, d_no } = req.body;

  // 判断场景
  d_no = d_no ? d_no : null;

  if (!file) {
    return res.status(400).json({ error: '未上传文件' });
  }

  const fileInfo = {
    originalName: file.originalname,
    fileName: file.filename,
    path: file.path,
    mimeType: file.mimetype,
    size: file.size,
    userId
  };
  
  // 保存文件信息到数据库中
  try {
    await connection1.execute(`
      INSERT INTO t_behavior_data(d_no, field1, c_time, is_saved, file_type)
      VALUES ("${d_no}", "${file.filename}", "${new Date()}", "实时数据", "${file.filename.split('.')[1] === 'mp4' ? 'video' : 'picture'}")
    `);
  } catch (error) {
    return res.status(500).json({ error: '保存文件信息失败' });
  }

  res.json({
    message: '文件上传成功',
    fileInfo
  });
});

export default router;
