const Koa = require('koa');
const bodyParser = require('koa-bodyparser')
const cors = require('@koa/cors');
const corsOptions ={
    origin:'http://localhost:3000', 
    credentials:true,            //access-control-allow-credentials:true
    optionSuccessStatus:200
}
const AlarmRoutes = require('./routes/alarm.routes.js')
const UserRoutes = require('./routes/user.routes.js')
const AlarmHistoryRoutes = require('./routes/alarm.history.js')

const app = new Koa();
app.use(bodyParser());
app.use(cors(corsOptions));

 app.use(AlarmRoutes.routes())
 .use(AlarmRoutes.allowedMethods());

 app.use(UserRoutes.routes())
 .use(UserRoutes.allowedMethods());

 app.use(AlarmHistoryRoutes.routes())
 .use(AlarmHistoryRoutes.allowedMethods());

app.listen(9090);

console.log('Application is running on port 9090');