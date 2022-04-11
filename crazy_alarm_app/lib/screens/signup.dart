import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../constants/themes.dart';
import '../services/user_service.dart';
import 'main_screen.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);
  static String routeName = '/signup';

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    TextEditingController confirmPasswordController = TextEditingController();
    TextEditingController fullNameController = TextEditingController();
    TextEditingController contactNumberController = TextEditingController();
    TextEditingController dateOfBirthController = TextEditingController();

    Map user = {
      'name': '',
      'email': '',
      'password': '',
      'contactNumber': '',
      'dateOfBirth': ''
    };

    @override
    void dispose() {
      // Clean up the controller when the widget is disposed.
      emailController.dispose();
      passwordController.dispose();
      confirmPasswordController.dispose();
      fullNameController.dispose();
      contactNumberController.dispose();
      dateOfBirthController.dispose();
      super.dispose();
    }
    registerUser() async {
      final SnackBar snackBar;

      bool incFormat = false;
      try{
        DateFormat format = DateFormat("yyyy/MM/dd");
        DateTime dayOfBirthDate = format.parseStrict(dateOfBirthController.text);
      } on Exception catch (exception) {
        incFormat=true;
      } catch (error) {
        incFormat=true;
      }

      if (fullNameController.text == "") {
        snackBar = const SnackBar(
          content: Text('Name is required'),
          backgroundColor: Colors.red,
        );
      } else if (emailController.text == "") {
        snackBar = const SnackBar(
          content: Text('Email is required'),
          backgroundColor: Colors.red,
        );
      }
      else if (dateOfBirthController.text == "") {
        snackBar = const SnackBar(
          content: Text('Date of Birth is required'),
          backgroundColor: Colors.red,
        );
      }
      else if (incFormat) {
        snackBar = const SnackBar(
          content: Text('Incorrect Date of Birth'),
          backgroundColor: Colors.red,
        );
      }
      else if (contactNumberController.text == "") {
        snackBar = const SnackBar(
          content: Text('Contact Number is required'),
          backgroundColor: Colors.red,
        );
      }
      else if (confirmPasswordController.text != passwordController.text) {
        snackBar = const SnackBar(
          content: Text("Passwords don't match"),
          backgroundColor: Colors.red,
        );
      }

      else {
        setState(() {
          user["name"] = fullNameController.text;
          user["email"] = emailController.text;
          user["password"] = passwordController.text;
          user["contactNumber"] = contactNumberController.text;
          user["dateOfBirth"] = dateOfBirthController.text;
        });
        UserService userService = UserService(url: 'user');
        Map response = await userService.userSignUp(user);
        if (response['name'] == user['name']) {
          snackBar = const SnackBar(
            content: Text("Signed Up Successfully"),
            backgroundColor: Colors.green,
          );
          Navigator.pushNamed(context, '/signup');Navigator.pushNamed(context, '/signup');
        }
        else {
          snackBar = const SnackBar(
            content: Text("Failed to sign Up"),
            backgroundColor: Colors.red,
          );
        }
      }
    }

    final ButtonStyle style =
    ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20), primary: CustomColors.sdIconColor,
        padding: const EdgeInsets.all(10));
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
              child: Text('Sign Up',
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
                style: TextStyle(color: Colors.white),
                controller: fullNameController,
                decoration: const InputDecoration(
                  enabledBorder: const OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.deepPurpleAccent, width: 2.0),
                  ),
                  labelText: 'Full Name',
                  labelStyle: TextStyle(fontSize: 15.0, color: Colors.deepOrangeAccent),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 30),
              child: TextField(
                style: TextStyle(color: Colors.white),
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
                controller: contactNumberController,
                style: TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  enabledBorder: const OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.deepPurpleAccent, width: 2.0),
                  ),
                  labelText: 'Contact Number',
                  labelStyle: TextStyle(fontSize: 15.0, color: Colors.deepOrangeAccent),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 30),
              child: TextField(
                controller: dateOfBirthController,
                style: TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  enabledBorder: const OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.deepPurpleAccent, width: 2.0),
                  ),
                  labelText: 'Date Of Birth | Year/Month/Day',
                  labelStyle: TextStyle(fontSize: 15.0, color: Colors.deepOrangeAccent),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 30),
              child: TextField(
                obscureText: true,
                style: TextStyle(color: Colors.white),
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
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 30),
              child: TextField(
                obscureText: true,
                controller: confirmPasswordController,
                style: TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  enabledBorder: const OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.deepPurpleAccent, width: 2.0),
                  ),
                  labelText: 'Confirm Password',
                  labelStyle: TextStyle(fontSize: 15.0, color: Colors.deepOrangeAccent),
                ),
              ),
            ),
            Container(
              height: 50,
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: ElevatedButton(
                child: const Text('Sign Up'),
                style: style,
                onPressed: () {
                  registerUser();
                },
              ),

            ),

          ],
        ),
      ),
    );
  }

}
