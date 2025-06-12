var { CleanWebpackPlugin } = require("clean-webpack-plugin");
var HtmlWebpackPlugin  = require("html-webpack-plugin");
var CopyPlugin = require("copy-webpack-plugin");
var { VueLoaderPlugin } = require('vue-loader');
const MiniCssExtractPlugin = require("mini-css-extract-plugin"); // 打包css文件
const path = require("path");//需要注意是webpack配置文件本身的依赖引入是受到package.json中的type配置项的限制的,在clinet中的
//其它内容中依赖使用import并不会报错，而纯后端文件中则会

module.exports = {
  // mode: "production",
  mode: "development",
  devtool:"source-map",
  target:"web",//需要注意该配置项默认为web
  entry: {
    main:["./src/main.ts"],
  },
  module:{
    rules:[
      {
        test:/\.vue$/,
        use:[{
          loader:"vue-loader"
        }]
      },{
        test:/\.(png)|(jpg)|gif$/,
        use:[{
          loader:"./loaders/img-loader",
           options: {
            limit: 3000, //3000字节以上使用图片，3000字节以内使用base64
            filename: "img-[contenthash].[ext]"
          }
        }]
      },{
        test:/\.css$/,
        use:[MiniCssExtractPlugin.loader,"css-loader"]
      },{
        test:/\.html$/,
        use:[{
          loader:"html-loader"
        }]
      },{
        test: /\.ts$/,
        exclude: /node_modules/,
        use: [
          {
            loader: "babel-loader",
          },
        ],
      }
    ]
  },
  output:{
    filename:"[name].[chunkhash:5].js",
    path: path.resolve(__dirname, 'dist'),  // 输出目录，确保路径是存在的
  },
  resolve: {
    extensions: ['.ts', '.js', '.vue', '.json']
  },
  plugins:[
    new VueLoaderPlugin(),
    new CleanWebpackPlugin(),
    new HtmlWebpackPlugin({
      template:"./index.html"
    }),
    new CopyPlugin({
      patterns:[
        {
          from: './public',
          to: './',
        },
      ]
    }),
    new MiniCssExtractPlugin({
      // 打包 css 代码 到文件中
      filename: "css/[name].css",
      chunkFilename: "css/common.[hash:5].css", // 针对公共样式的文件名
    })
  ]
}

// 所以使用了vue-loader对vue项目打包后的main.js中的内容对应的本质其实是dom操作添加元素到根html，而多次切换单页面应用中的所谓的
//单页面的效果的实现是利用js中的dom替换操作直接达到实际的多个html的切换的效果