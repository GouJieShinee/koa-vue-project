let cors = require('koa-cors');
let fs = require('fs');
let Router = require('koa-router');
const router = new Router();
console.log(router)

// 获取数据接口

router.get("/getGoodsLists", async ctx => {
    await cors();
    ctx.body = 'hello koa';
})

router.get("/getGoodsOrder", async ctx=>{
    await cors();
    ctx.body = 'request all';
})

module.exports = router;