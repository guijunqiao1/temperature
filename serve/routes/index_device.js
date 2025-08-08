//KOA2
import Router from 'koa-router';
import Config1 from "../indexNode2.js"; // 获取数据库链接配置对象
import Config2 from "../indexNode1.js"; // 获取数据库链接配置对象

let connection2; // 定义数据库连接对象
let connection1; // 定义数据库连接对象

const Router2 = new Router();

(async () => {
  try {
    // 异步执行 Config，用于连接数据库，后续可对 connection 数据库链接对象进行数据库操作
    connection2 = await Config1();
    connection1 = await Config2();
    console.log("数据库2连接成功");
    console.log("数据库1连接成功");
  } catch (error) {
    console.log("数据库2连接失败");
    console.log("数据库1连接失败");
  }
})();

// 机房导航使用

// 不需要分页的路由
Router2.get("/t_device/first", async (ctx) => {
  try {
    let query;
    // 处理 undefined 情况
    query = "SELECT * FROM t_container ORDER BY ctime DESC";
    // 使用 `await` 进行查询
    const [results] = await connection2.execute(query);
    // 格式化数据
    const formattedResults = results.map((row) => [
      row.PID,
      row.VID,
      row.ctime,
    ]);
    console.log("rows:" + results);
    ctx.set("Content-Type", "application/json");
    ctx.body = JSON.stringify(formattedResults);
  } catch (error) {
    console.error("查询失败:", error);
    ctx.status = 500;
    ctx.body = { error: "数据库查询失败" };
  }
});

// 不需要分页的路由 -- 多设备表格
Router2.get("/t_device", async (ctx) => {
  try {
    console.log("成功进入当前路由");
    let query;
    // 处理 undefined 情况
    query = "SELECT * FROM t_device";
    // 使用 `await` 进行查询
    const [results] = await connection2.execute(query);
    // 格式化数据
    console.log("rows:" + results);
    ctx.set("Content-Type", "application/json");
    const formattedResults = results.map((row) => [
      row.place,
      row.number,
    ]);
    ctx.body = JSON.stringify(formattedResults);
  } catch (error) {
    console.error("查询失败:", error);
    ctx.status = 500;
    ctx.body = { error: "数据库查询失败" };
  }
});


// 设备列表使用

// 不需要分页的路由 -- 多设备表格
Router2.get("/DEVICE", async (ctx) => {
  try {
    const { d_no } = ctx.query;
    console.log("成功进入当前路由");
    let query;
    // 处理 undefined 情况
    query = `SELECT * FROM t_device WHERE place = "${d_no}"`;
    // 使用 `await` 进行查询
    const [results] = await connection2.execute(query);
    // 格式化数据
    console.log("rows:" + results);
    ctx.set("Content-Type", "application/json");
    const formattedResults = results.map((row) => [
      row.device_name,
      row.number,
      row.ctime,
      row.place,
    ]);
    ctx.body = JSON.stringify(formattedResults);
  } catch (error) {
    console.error("查询失败:", error);
    ctx.status = 500;
    ctx.body = { error: "数据库查询失败" };
  }
});

export default Router2;
