const uuid = require('uuid');
const mongoose = require('mongoose');
mongoose.set('useNewUrlParser', true);
mongoose.set('useUnifiedTopology', true);
mongoose.connect('mongodb://localhost/shoppingDb');
const alarmSchema = require('../models/alarmModel')

const addAlarm =  async obj => {
    var newItm = new alarmSchema({
        id: uuid.v4(),
        title: obj.title,
        time: obj.time,
        active: obj.active,
        repeat:obj.repeat,
        user:obj.user
    });

    let savedAlarm = await newItm.save();
    return savedAlarm
}


async function getAlarms(user) {
    let query = {user:user}
    let alarms = await alarmSchema.find(query,function(err, response){
        if(err)
            console.log('Unable to retreive alarms');
        else{
            return response;
        }
     });
     return [...alarms.values()];
}

async function deleteAlarm(alarmId) {
    var query = { id: alarmId };
    let alarm = await alarmSchema.deleteOne(query,function(err, obj) {
        if (err) {
            console.log("Failed to delete alarm")
        }
        console.log("1 document deleted");
    });
    console.log(alarm)
    return alarm;
}

async function updateAlarm(alarm) {
    var filter = {id: alarm.id};
    let updatedAlarm = await alarmSchema.findOneAndReplace(filter, alarm, {
        new: true,
    });
     return updatedAlarm;
}


module.exports = {addAlarm,getAlarms,updateAlarm,deleteAlarm};