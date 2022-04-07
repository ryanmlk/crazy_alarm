const mongoose = require('mongoose');

var alarmScheme = mongoose.Schema({
    id: String,
    title: String,
    time: String,
    active: Boolean,
    repeat: [{
        day: String,
        enabled: Boolean
    }]
 });

 module.exports = mongoose.model('alarm', alarmScheme);