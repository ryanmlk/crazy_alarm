const uuid = require('uuid');
const mongoose = require('mongoose');
mongoose.set('useNewUrlParser', true);
mongoose.set('useUnifiedTopology', true);
mongoose.connect('mongodb://localhost/shoppingDb');

var alarmHistorySchema = mongoose.Schema({
    id: String,
    day:String,
    time: String
});

 var alarmHistory = mongoose.model("alarmHistory", alarmHistorySchema); 

const addAlarmHistory =  async obj => {
    var newItm = new alarmHistory({
        id: uuid.v4(),
        time: obj.time,
        day: obj.day
    });

    let savedAlarm = await newItm.save();
    return savedAlarm
}


async function getAlarmHistory(user) {
    let query = {user:user}
    let alarmHistorys = await alarmHistory.find(query,function(err, response){
        if(err)
            console.log('Unable to retreive alarmHistorys');
        else{
            return response;
        }
     });
     return [...alarmHistorys.values()];
}

async function deleteAlarmHistory(alarmHistoryId) {
    var query = { id: alarmHistoryId };
    let alarmHistory = await alarmHistory.deleteOne(query,function(err, obj) {
        if (err) {
            console.log("errorrrrr")
        }
        console.log("1 document deleted");
      });
     return alarmHistory;
}

async function updateAlarmHistory(alarmHistory) {
    var filter = {id: alarmHistory.id};
    let updatedAlarmHistory = await alarmHistory.findOneAndReplace(filter, alarmHistory, {
        new: true,
    });
     return updatedAlarmHistory;
}

async function deleteAlarmHistory(alarmHistoryId) {
    let deleteDetails = await alarmHistory.deleteOne({ id: alarmHistoryId }, function(err, response){
        if(err)
            console.log('Unable to delete alarmHistory');
        else{
            return response;
        }
     });
     return deleteDetails;
}

module.exports = {addAlarmHistory,getAlarmHistory,updateAlarmHistory,deleteAlarmHistory};