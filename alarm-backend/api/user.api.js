const uuid = require('uuid');
const mongoose = require('mongoose');
mongoose.set('useNewUrlParser', true);
mongoose.set('useUnifiedTopology', true);
mongoose.connect('mongodb+srv://ifsapp:ifsapp@cluster0.cc6tj.mongodb.net/crazy-alarm?retryWrites=true&w=majority');

var userSchema = mongoose.Schema({
    id: String,
    name: String,
    password: String,
    email: String,
    dateOfBirth: String,
    contactNumber: String
 });

 var User = mongoose.model("Users", userSchema);

const userSignUp =  async obj => {
    var newUser = new User({
        id: uuid.v4(),
        name: obj.name,
        password: obj.password,
        email: obj.email,
        dateOfBirth: obj.dateOfBirth,
        contactNumber: obj.contactNumber
    });

    let savedUser = await newUser.save();

    return savedUser;
}

async function userLogin(userEmail,userPassword) {
    let user = await User.findOne({ email: userEmail, password: userPassword }, function(err, response){
        if(err)
            console.log("Invalid User Details");
        else{
            return response
        }
     });

     let res = {
        "logged": false
    }

     if(typeof(user) != "undefined"){
         res = {
            "id": user.id,
            "email": user.email,
            "password": user.password,
            "name": user.name,
            "dateOfBirth": user.dateOfBirth,
            "contactNumber": user.dateOfBirth,
            "logged": true 
         }
     }
     return res;
}

module.exports = {userSignUp,userLogin};