var alarmScheme = mongoose.Schema({
    id: String,
    time: String,
    active: String,
    tone: String,
    type: String,
    days: [Number]
 });

 module.exports  = {alarmScheme};