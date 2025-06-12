
// //此处定义导出内容的函数
// function loader(buffer){//sourceCode给的是buffer(用于处理二进制格式的资源)
//   console.log("文件数据大小(字节):"+buffer.byteLength);//需要注意此处使用的byteLength为buffer原型对象中绑定的函数，用于获取当前二进制数(buffer类型)的长度
//   var content = getBase64(buffer);
//   console.log(content);
//   return `module.exports=\`${content}\``;
// }
// //此处定义将buffer的二进制转化为字符串的方法
// function getBase64(buffer){
//   return "data:image/png;base64,"+buffer.toString("base64");//toString同样为buffer原型对象中的函数，其中的形参用于指定具体转化的字符串的格式--此处为base64
//   //但是需要注意的是转化的仅表示base64格式的字符串，但是整体的图片资源使用base64格式的字符串表示还不够，还需要在开头添加上资源类型的前缀
// }
// module.exports = loader;


// // loader.raw = true;//此处将内置加载器函数对象中的属性raw(格式)置为true，用于将原始格式的实参sourceCode内容转化为buffer进行处理


const path = require("path");
const crypto = require("crypto");

function loader(buffer) {
    console.log("文件数据大小：(字节)", buffer.byteLength);

    // ✅ 替换 loaderUtils.getOptions(this)
    const { limit = 1000, filename = "[contenthash].[ext]" } = this.getOptions();

    let content;
    if (buffer.byteLength >= limit) {
        content = getFilePath.call(this, buffer, filename);
    } else {
        content = getBase64(buffer);
    }

    return `module.exports = \`${content}\``;
}

loader.raw = true;
module.exports = loader;

// base64 编码
function getBase64(buffer) {
    return "data:image/png;base64," + buffer.toString("base64");
}

// 生成文件名 + emit 文件
function getFilePath(buffer, namePattern) {
    const ext = path.extname(this.resourcePath).slice(1); // 获取扩展名，如 'png'
    const hash = crypto.createHash("md5").update(buffer).digest("hex").slice(0, 8); // 模拟 contenthash
    const filename = namePattern
        .replace("[contenthash]", hash)
        .replace("[ext]", ext);

    this.emitFile(filename, buffer);
    return filename;
}
