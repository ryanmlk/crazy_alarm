const notificationApi = require('../api/notification.api.js');
const Router = require('@koa/router');

const router = new Router({
    prefix: '/notifications'
   });
   //Used to get notifications
   router.get('/',async ctx => {
    let user = ctx.request.query.user;
        ctx.body = await notificationApi.getNotification(user);
   });

   //Used to add a new notification
   router.post('/', async ctx => {
    let notification = ctx.request.body;
    notification = await notificationApi.addNotification( notification );
    console.log(notification)
    ctx.response.status = 201;
    ctx.body = notification;
   });

   //Used to update an notification
   router.patch('/', async ctx => {
    let notification = ctx.request.body;
    notification = await notificationApi.updateNotification( notification );
    ctx.response.status = 201;
    ctx.body = notification;
    });

   //Used to delete an notification
   router.delete('/', async ctx => {
       let notification = ctx.request.body;
       ctx.body = await notificationApi.deleteNotification( notification.id);
   })

module.exports = router;