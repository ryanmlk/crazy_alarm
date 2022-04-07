const uuid = require('uuid');
const mongoose = require('mongoose');

var userSchema = mongoose.Schema({
    id: String,
    email: String,
    password: String,
    type: String,
    contact: Number,
    address: String,
    name: String
 });

 var User = mongoose.model("Users", userSchema);

const userSignUp =  async obj => {
    var newUser = new User({
        id: uuid.v4(),
        password: obj.password,
        userName: obj.userName,
        name: obj.name
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
            "userName": user.userName,
            "password": user.password,
            "name": user.name,
            "logged": true 
         }
     }
     return res;
}

module.exports = {userSignUp,userLogin};