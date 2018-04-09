/**
 * koa路由配置文件
 */
let Koa = require('koa');
const app = new Koa();

let goods = require('./server/routes/goods');

// 将koa和两个中间件连起来
app.use(goods.routes()).use(goods.allowedMethods());

// 监听3000端口
app.listen(3000);