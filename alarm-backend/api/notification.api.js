const uuid = require('uuid');
const mongoose = require('mongoose');

var notificationSchema = mongoose.Schema({
    id: String,
    datetime:String,
    title:String,
    message:String,
    type:String
});

 var notification = mongoose.model("notification", notificationSchema); 

const addNotification =  async obj => {
    var newItm = new notification({
        id: obj.id,
        title: obj.title,
        datetime: obj.datetime,
        message: obj.message,
        type: obj.type
    });

    let savedNotification = await newItm.save();
    return savedNotification
}


async function getNotification(user) {
    let query = {user:user}
    let notifications = await notification.find(query,function(err, response){
        if(err)
            console.log('Unable to retreive notifications');
        else{
            return response;
        }
     });
     return [...notifications.values()];
}

async function deleteNotification(NotificationId) {
    var query = { id: notificationId };
    let notification = await notification.deleteOne(query,function(err, obj) {
        if (err) {
            console.log("errorrrrr")
        }
        console.log("1 document deleted");
      });
     return notification;
}

async function updateNotification(updatedNotification) {
    var filter = {id: updatedNotification.id};
    let responseNotification = await notification.findOneAndReplace(filter, updatedNotification, {
        new: true,
    });
     return responseNotification;
}

async function deleteNotification(notificationId) {
    let deleteDetails = await notification.deleteOne({ id: notificationId }, function(err, response){
        if(err)
            console.log('Unable to delete notification');
        else{
            return response;
        }
     });
     return deleteDetails;
}

module.exports = {addNotification,getNotification,updateNotification,deleteNotification};