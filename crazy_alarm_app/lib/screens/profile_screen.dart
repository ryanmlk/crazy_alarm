import 'dart:io';

import 'package:crazy_alarm_app/util/user_preferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:crazy_alarm_app/constants/themes.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/user.dart';
import '../services/user_service.dart';
import 'main_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);
  static String routeName = '/profile';

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}


class _ProfileScreenState extends State<ProfileScreen> {
  bool isLoggedIn = false;
  late User userF = UserPreferences.myUser;

  updateLog() async {
    UserService userService = UserService(url: 'users/login');
    bool temp = await userService.checkLogin();
    setState(()  {
      isLoggedIn = temp;
    });

  }
  getUser() async {
    UserPreferences userPreferences = new UserPreferences();
    User temp = await userPreferences.getUser();
    setState(()  {
    userF = temp;
    });
  }
  @override
  void initState() {
    super.initState();
    updateLog();
    getUser();
  }
  @override
  Widget build(BuildContext context) {
      final user = userF;
      return ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          if (isLoggedIn) ...[
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 30),
              child: Center(
                child: Text('Profile',
                    style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                            color: CustomColors.primaryTextColor,
                            fontSize: 45,
                            fontWeight: FontWeight.w500))),
              ),
            ),
            Column(
              children: [
                const Padding(
                  padding: EdgeInsets.fromLTRB(0, 50, 0, 0),
                  child: SizedBox(
                    width: 300.0,
                    height: 10,
                    child: DecoratedBox(
                      decoration: BoxDecoration(color: Colors.deepPurpleAccent),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
                  child: Text(user.name,
                      style: GoogleFonts.actor(
                          textStyle: TextStyle(
                              color: CustomColors.primaryTextColor,
                              fontSize: 30,
                              fontWeight: FontWeight.bold))),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                  child: Text(user.email,
                      style: GoogleFonts.actor(
                          textStyle: TextStyle(
                              color: CustomColors.primaryTextColor,
                              fontSize: 10,
                              fontWeight: FontWeight.bold))),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 15),
                  child: Text(user.phoneNumber,
                      style: GoogleFonts.actor(
                          textStyle: TextStyle(
                              color: CustomColors.primaryTextColor,
                              fontSize: 10,
                              fontWeight: FontWeight.bold))),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 15),
                  child: Text(calculateAge(user.dob),
                      style: GoogleFonts.actor(
                          textStyle: TextStyle(
                              color: CustomColors.primaryTextColor,
                              fontSize: 10,
                              fontWeight: FontWeight.bold))),
                ),
                const SizedBox(
                  width: 300.0,
                  height: 10,
                  child: DecoratedBox(
                    decoration: BoxDecoration(color: Colors.deepPurpleAccent),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(40, 40, 40, 10),
                  child: Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                            onPressed: () {
                            },
                            icon: const Icon(Icons.update),
                            label: const Text('Update'),
                            style: ElevatedButton.styleFrom(
                                primary: Colors.deepPurpleAccent,
                                padding: const EdgeInsets.all(10))),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(40, 10, 40, 10),
                  child: Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => MainScreen()));
                            },
                            icon: const Icon(Icons.delete_forever),
                            label: const Text('Delete'),
                            style: ElevatedButton.styleFrom(
                                primary: CustomColors.sdShadowDarkColor,
                                padding: const EdgeInsets.all(10))),
                      )
                    ],
                  ),
                )
              ],
            )
          ] else...[
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 100),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Profile',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                              color: CustomColors.primaryTextColor,
                              fontSize: 45,
                              fontWeight: FontWeight.w500))),
                ],
              ),
            ),
            ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset('resources/images/alarm.jpg')),
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 100, 30, 3),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                        onPressed: () {
                          Navigator.pushNamed(context, '/login');
                        },
                        icon: const Icon(Icons.login),
                        label: const Text('Login'),
                        style: ElevatedButton.styleFrom(
                            primary: CustomColors.sdIconColor,
                            padding: const EdgeInsets.all(10))),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 0, 30, 3),
              child: Row(
                children: [
                  Expanded(
                      child: ElevatedButton.icon(
                          onPressed: () {
                            Navigator.pushNamed(context, '/signup');
                          },
                          icon: const Icon(Icons.app_registration),
                          label: const Text('Sign Up'),
                          style: ElevatedButton.styleFrom(
                              primary: CustomColors.sdIconColor,
                              padding: const EdgeInsets.all(10))))
                ],
              ),
            )
          ],

        ],
      );
  }

  String calculateAge(String birthDate1) {
    List<String> listVal = birthDate1.split('/');
    int year = int.parse(listVal.elementAt(0));
    int month = int.parse(listVal.elementAt(1));
    int day = int.parse(listVal.elementAt(2));
    DateTime birthDate = DateTime.utc(year, month, day);
    DateTime currentDate = DateTime.now();
    int age = currentDate.year - birthDate.year;
    int month1 = currentDate.month;
    int month2 = birthDate.month;
    if (month2 > month1) {
      age--;
    } else if (month1 == month2) {
      int day1 = currentDate.day;
      int day2 = birthDate.day;
      if (day2 > day1) {
        age--;
      }
    }
    return 'Age : ' + age.toString();
  }
}
