import fs from "fs";
import path from "path";
import express from "express";
import { fileURLToPath } from 'url';
import Config from "../indexNode2.js";

const router = express.Router();
const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

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

// 确保 public 目录存在
const publicDir = path.join('D:','temperature','project01','client', 'public');

// 处理上传请求
router.post('/insert_img', async (req, res) => {
  let { image, d_no,person,confidence } = req.body;

  // 判断场景
  d_no = d_no ? d_no : null;
  console.log("成功进入插入路由");

  if (!image || !Array.isArray(image) || image.length !== 2) {
    return res.status(400).json({ error: '需要上传2个图片资源' });
  }

  let fileName1 = null;
  let fileName2 = null;

  try {
    // 处理第一个图片
    const matches1 = image[0].match(/^data:image\/(jpeg|png|jpg);base64,(.+)$/);
    if (!matches1) {
      return res.status(400).json({ error: '第一个图片的Base64编码无效' });
    }

    const extension1 = matches1[1];
    const base64Data1 = matches1[2];
    const buffer1 = Buffer.from(base64Data1, 'base64');
    
    // 使用 slice() 替代 substr()
    fileName1 = `${Date.now()}-1-${Math.random().toString(36).slice(2, 11)}.${extension1}`;
    const filePath1 = path.join(publicDir, fileName1);
    fs.writeFileSync(filePath1, buffer1);
    console.log(`第一个文件保存成功: ${fileName1}`);

    // 处理第二个图片
    const matches2 = image[1].match(/^data:image\/(jpeg|png|jpg);base64,(.+)$/);
    if (!matches2) {
      return res.status(400).json({ error: '第二个图片的Base64编码无效' });
    }

    const extension2 = matches2[1];
    const base64Data2 = matches2[2];
    const buffer2 = Buffer.from(base64Data2, 'base64');
    
    // 使用 slice() 替代 substr()
    fileName2 = `${Date.now()}-2-${Math.random().toString(36).slice(2, 11)}.${extension2}`;
    const filePath2 = path.join(publicDir, fileName2);
    fs.writeFileSync(filePath2, buffer2);
    console.log(`第二个文件保存成功: ${fileName2}`);

    // 格式化时间
    const now = new Date();
    const formattedTime = now.getFullYear() + '-' +
                         String(now.getMonth() + 1).padStart(2, '0') + '-' + 
                         String(now.getDate()).padStart(2, '0') + ' ' + 
                         String(now.getHours()).padStart(2, '0') + ':' + 
                         String(now.getMinutes()).padStart(2, '0') + ':' + 
                         String(now.getSeconds()).padStart(2, '0');

    // 保存文件信息到数据库
    await connection1.execute(`
      INSERT INTO t_behavior_data(d_no, field1, field2, c_time, is_saved, file_type , result, confidence)
      VALUES ('${d_no}', '${fileName1}', '${fileName2}', '${formattedTime}', "实时数据", "picture",'${(person==='0'?1:0)}','${confidence}')
    `);

    console.log('数据库插入成功');

    // 返回成功响应
    res.json({
      message: '文件上传成功',
      files: {
        file1: fileName1,
        file2: fileName2
      },
      savedPath: publicDir
    });

  } catch (error) {
    console.error('处理文件失败:', error);
    
    // 清理已创建的文件
    if (fileName1) {
      const filePath1 = path.join(publicDir, fileName1);
      if (fs.existsSync(filePath1)) {
        fs.unlinkSync(filePath1);
      }
    }
    if (fileName2) {
      const filePath2 = path.join(publicDir, fileName2);
      if (fs.existsSync(filePath2)) {
        fs.unlinkSync(filePath2);
      }
    }

    return res.status(500).json({ error: '保存文件失败: ' + error.message });
  }
});

router.get('/sssss', async (req, res) => {
  res.send('1');
});

export default router;
