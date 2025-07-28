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

const fs = require('fs');
const path = require('path');
const express = require("express");
const router = express();

import Config from "../indexNode2.js";
let connection1;
(async ()=>{
  try{
    connection1 = await Config();
    console.log("数据库连接成功");
  }
  catch(error){
    console.log("数据库连接失败");
  }
})();
 

// 处理上传请求
router.post('/insert_img', async (req, res) => {
  const { image, d_no } = req.body;

  // 判断场景
  d_no = d_no ? d_no : null;

  if (!image || !Array.isArray(image) || image.length === 0) {
    return res.status(400).json({ error: '未上传图片资源' });
  }

  //外部计数变量
  let sum = 0;
  let fileName1;
  let fileName2;


  try {
    for (const base64Image of image) {
      // 提取 Base64 编码的字符串中的数据部分
      const matches = base64Image.match(/^data:image\/(jpeg|png|jpg);base64,(.+)$/);
      if (!matches) {
        return res.status(400).json({ error: '无效的 Base64 编码' });
      }

      const extension = matches[1];  // 图片格式（jpeg, png, jpg）
      const base64Data = matches[2];  // 图片的 Base64 数据
      const buffer = Buffer.from(base64Data, 'base64');  // 转换为二进制数据

      // 为文件生成唯一的文件名
      if(sum===0){
        fileName1 = `${Date.now()}-${Math.random().toString(36).substr(2, 9)}.${extension}`;
        filePath = path.join(__dirname, 'public', fileName1);
        sum++;
      }else{
        fileName2 = `${Date.now()}-${Math.random().toString(36).substr(2, 9)}.${extension}`;
        filePath = path.join(__dirname, 'public', fileName2);
        // 将二进制数据保存为文件
        fs.writeFileSync(filePath, buffer);
      }
    }

    // 保存文件信息到数据库
    await connection1.execute(`
      INSERT INTO t_behavior_data(d_no, field1,field2, c_time, is_saved, file_type)
      VALUES ("${d_no}", "${fileName1}","${fileName2}", "${new Date()}", "实时数据", "picture")
    `);

    // 返回成功响应
    res.json({
      message: '文件上传成功'
    });
  } catch (error) {
    console.error(error);
    return res.status(500).json({ error: '保存文件信息失败' });
  }
});
export default router;
