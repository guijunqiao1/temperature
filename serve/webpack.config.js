var { CleanWebpackPlugin } = require("clean-webpack-plugin");
const path = require("path");

module.exports = {
  // mode: "production",
  mode: "development",
  devtool:"source-map",
  target:"node",
  entry: {
    main:["./bin/www.js"],
  },
  output: {
    filename:"[name].[chunkhash:5].js",
    path: path.resolve(__dirname, 'dist'),  // 输出目录，确保路径是存在的    
  },
  watch:true,
  plugins:[
    new CleanWebpackPlugin(),
  ]
}