var userSchema = mongoose.Schema({
    id: String,
    name: String,
    password: String,
    email: String,
    dateOfBirth: String,
    contactNumber: String
 });

 module.exports = {userSchema};