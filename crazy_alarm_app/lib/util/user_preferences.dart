import 'package:crazy_alarm_app/model/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../services/user_service.dart';

class UserPreferences{
  static const myUser = User(phoneNumber: '+94778458794', email: 'janedoe666@gmail.com', imagePath: 'https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8cHJvZmlsZXxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=700&q=60', name: 'Jane Doe', dob: '1997/07/01');

  Future<User> getUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String dob=prefs.getString("dateOfBirth").toString();
    String name=prefs.getString("name").toString();
    String email=prefs.getString("email").toString();
    String phoneNumber=prefs.getString("contactNumber").toString();
    User user =  User(phoneNumber: phoneNumber, email: email, imagePath: 'https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8cHJvZmlsZXxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=700&q=60', name: name, dob: dob);
    return user;
  }

}