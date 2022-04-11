import 'package:crazy_alarm_app/model/user.dart';

import '../services/user_service.dart';

class UserPreferences{
  static const myUser = User(phoneNumber: '+94778458794', email: 'janedoe666@gmail.com', imagePath: 'https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8cHJvZmlsZXxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=700&q=60', name: 'Jane Doe', dob: '1997/07/01');

  User getUser(){
    UserService userService = UserService(url: 'users/login');
    User user =  User(phoneNumber: '+94778458794', email: 'janedoe666@gmail.com', imagePath: 'https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8cHJvZmlsZXxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=700&q=60', name: 'Jane Doe', dob: '1997/07/01');
    return user;
  }

}