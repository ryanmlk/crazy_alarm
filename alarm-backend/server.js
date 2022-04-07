const Koa = require('koa');
const bodyParser = require('koa-bodyparser')
const cors = require('@koa/cors');
const mongoose = require('mongoose');
mongoose.set('useNewUrlParser', true);
mongoose.set('useUnifiedTopology', true);
mongoose.connect('mongodb+srv://ifsapp:ifsapp@cluster0.cc6tj.mongodb.net/crazy-alarm?retryWrites=true&w=majority');

const corsOptions ={
    origin:'http://localhost:3000', 
    credentials:true,            //access-control-allow-credentials:true
    optionSuccessStatus:200
}
const AlarmRoutes = require('./routes/alarm.routes.js')
const UserRoutes = require('./routes/user.routes.js')
const AlarmHistoryRoutes = require('./routes/alarm.history.js')
const NotificationRoutes = require('./routes/notification.routes.js')

const app = new Koa();
app.use(bodyParser());
app.use(cors(corsOptions));

 app.use(AlarmRoutes.routes())
 .use(AlarmRoutes.allowedMethods());

 app.use(UserRoutes.routes())
 .use(UserRoutes.allowedMethods());

 app.use(AlarmHistoryRoutes.routes())
 .use(AlarmHistoryRoutes.allowedMethods());

 
 app.use(NotificationRoutes.routes())
 .use(NotificationRoutes.allowedMethods());

app.listen(process.env.PORT || 9090)
console.log('Application is running on port 9090');