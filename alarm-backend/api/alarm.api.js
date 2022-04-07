const uuid = require('uuid');
const mongoose = require('mongoose');

var alarmSchema = mongoose.Schema({
    id: String,
    user: String,
    time: String,
    active: String,
    tone: String,
    type: String,
    days: [Number]
});

 var alarm = mongoose.model("alarm", alarmSchema); 

const addAlarm =  async obj => {
    var newItm = new alarm({
        id: uuid.v4(),
        time: obj.time,
        active: obj.active,
        tone: obj.tone,
        type: obj.type,
        days:obj.days,
        user:obj.user
    });

    let savedAlarm = await newItm.save();
    return savedAlarm
}


async function getAlarms(user) {
    let query = {user:user}
    let alarms = await alarm.find(query,function(err, response){
        if(err)
            console.log('Unable to retreive alarms');
        else{
            return response;
        }
     });
     return [...alarms.values()];
}

async function deleteAlarm(AlarmId) {
    var query = { id: alarmId };
    let alarm = await alarm.deleteOne(query,function(err, obj) {
        if (err) {
            console.log("errorrrrr")
        }
        console.log("1 document deleted");
      });
      console.log(Alarm)
     return alarm;
}

async function updateAlarm(alarm) {
    var filter = {id: alarm.id};
    let updatedAlarm = await alarm.findOneAndReplace(filter, alarm, {
        new: true,
    });
     return updatedAlarm;
}


module.exports = {addAlarm,getAlarms,updateAlarm,deleteAlarm};