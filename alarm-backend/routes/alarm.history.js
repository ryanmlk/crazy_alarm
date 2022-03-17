const alarmHistoryApi = require('../api/alarm.history.api.js');
const Router = require('@koa/router');

const router = new Router({
    prefix: '/alarmHistory'
   });
   //Used to get alarmHistorys
   router.get('/',async ctx => {
    let user = ctx.request.query.user;
        ctx.body = await alarmHistoryApi.getAlarmHistory(user);
   });

   //Used to add a new alarmHistory
   router.post('/', async ctx => {
    let alarmHistory = ctx.request.body;
    alarmHistory = await alarmHistoryApi.addAlarmHistory( alarmHistory);
    ctx.response.status = 201;
    ctx.body = alarmHistory;
   });

   //Used to update an alarmHistory
   router.patch('/', async ctx => {
    let alarmHistory = ctx.request.body;
    alarmHistory = await alarmHistoryApi.updateAlarmHistory( alarmHistory);
    ctx.response.status = 201;
    ctx.body = alarmHistory;
    });

   //Used to delete an alarmHistory
   router.delete('/', async ctx => {
       let alarmHistory = ctx.request.body;
       ctx.body = await alarmHistoryApi.deleteAlarmHistory( alarmHistory.id);
   })

module.exports = router;