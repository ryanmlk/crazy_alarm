const alarmApi = require('../api/alarm.api.js');
const Router = require('@koa/router');

const router = new Router({
    prefix: '/alarms'
   });
   //Used to get alarms
   router.get('/',async ctx => {
    let user = ctx.request.query.user;
        ctx.body = await alarmApi.getAlarms(user);
   });

   //Used to add a new alarm
   router.post('/', async ctx => {
    let alarm = ctx.request.body;
    alarm = await alarmApi.addAlarm( alarm);
    ctx.response.status = 201;
    ctx.body = alarm;
   });

   //Used to update an alarm
   router.patch('/', async ctx => {
    let alarm = ctx.request.body;
    alarm = await alarmApi.updateAlarm( alarm);
    ctx.response.status = 201;
    ctx.body = alarm;
    });

   //Used to delete an alarm
   router.delete('/', async ctx => {
       let alarm = ctx.request.body;
       ctx.body = await alarmApi.deleteAlarm( alarm.id);
   })

module.exports = router;