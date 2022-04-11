import 'package:crazy_alarm_app/screens/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants/themes.dart';
import '../services/user_service.dart';
import 'dart:convert';
import 'main_screen.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);
  static String routeName = '/login';

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    Map user = {
      'email': '',
      'password': '',
    };
    String _decodeBase64(String str) {
      String output = str.replaceAll('-', '+').replaceAll('_', '/');

      switch (output.length % 4) {
        case 0:
          break;
        case 2:
          output += '==';
          break;
        case 3:
          output += '=';
          break;
        default:
          throw Exception('Illegal base64url string!"');
      }

      return utf8.decode(base64Url.decode(output));
    }
    Map<String, dynamic> parseJwt(String token) {
      final parts = token.split('.');
      if (parts.length != 3) {
        throw Exception('invalid token');
      }

      final payload = _decodeBase64(parts[1]);
      final payloadMap = json.decode(payload);
      if (payloadMap is! Map<String, dynamic>) {
        throw Exception('invalid payload');
      }

      return payloadMap;
    }
    final ButtonStyle style =
    ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20), primary: CustomColors.sdIconColor,
        padding: const EdgeInsets.all(10));
    loginUser() async{
      final SnackBar snackBar;

      if(emailController.text == "") {
        snackBar = const SnackBar(
          content: Text('Email is required'),
          backgroundColor: Colors.red,
        );
      } else if(passwordController.text == "") {
        snackBar = const SnackBar(
          content: Text("Password is required"),
          backgroundColor: Colors.red,
        );
      }
      else {
        setState(() {
          user["email"] = emailController.text;
          user["password"] = passwordController.text;
        });
        UserService userService = UserService(url: 'user/login');
        Map response = await userService.userLogin(user);
        Map data = parseJwt(response['token']);
        if(data.isNotEmpty) {
          snackBar = const SnackBar(
            content: Text("Logged in Successfully"),
            backgroundColor: Colors.green,
          );
          await Future.delayed(const Duration(seconds: 2));
          Navigator.push(context, MaterialPageRoute(builder: (context) => MainScreen()));
        }
        else {
          snackBar = const SnackBar(
            content: Text("Invalid Login details"),
            backgroundColor: Colors.red,
          );
        }
      }
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }


    return Scaffold(
        backgroundColor: CustomColors.sdAppBackgroundColor,
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: ListView(
            children: <Widget>[
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10),
                child: Text('Crazy Alarm',
                    style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                            color: CustomColors.primaryTextColor,
                            fontSize: 45,
                            fontWeight: FontWeight.w500))),
              ),
              const SizedBox(height: 100.0),
              Container(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                child: const SizedBox(
                  width: 300.0,
                  height: 10,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                        color: Colors.deepPurpleAccent
                    ),
                  ),
                ),
              ),
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                child: Text('Login',
                    style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                            color: CustomColors.hourHandEndColor,
                            fontSize: 30,
                            fontWeight: FontWeight.w500))),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 30),
                child: const SizedBox(
                  width: 300.0,
                  height: 10,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                        color: Colors.deepPurpleAccent
                    ),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 30),
                child: TextField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    enabledBorder: const OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.deepPurpleAccent, width: 2.0),
                    ),
                    labelText: 'Email',
                    labelStyle: TextStyle(fontSize: 15.0, color: Colors.deepOrangeAccent)

                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 30),
                child: TextField(
                  obscureText: true,
                  controller: passwordController,
                  decoration: const InputDecoration(
                    enabledBorder: const OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.deepPurpleAccent, width: 2.0),
                    ),
                    labelText: 'Password',
                    labelStyle: TextStyle(fontSize: 15.0, color: Colors.deepOrangeAccent),
                  ),
                ),
              ),
              Container(
                  height: 50,
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: ElevatedButton(
                    child: const Text('Login'),
                    style: style,
                      onPressed: () {
                        loginUser();
                      },
                  ),

              ),

            ],
          ),
        ));
  }
}
