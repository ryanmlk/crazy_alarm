import 'dart:math';
import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:crazy_alarm_app/constants/themes.dart';
import 'package:crazy_alarm_app/models/alarm_history.dart';
import 'package:crazy_alarm_app/services/alarm_history_service.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class QuestionScreen extends StatefulWidget {
  const QuestionScreen({Key? key}) : super(key: key);
  static String routeName = '/question';
  final AlarmHistoryService _alarmHistoryService = const AlarmHistoryService();
  @override
  _QuestionFormState createState() => _QuestionFormState();
}

class _QuestionFormState extends State<QuestionScreen> {
  final myController = TextEditingController();
  int num1 = Random().nextInt(100);
  int num2 = Random().nextInt(100);
  int operator = Random().nextInt(3);
  String operatorString = 'ss';
  late int answer;

  @override
  void initState() {
    super.initState();
    switch (operator) {
      case 0:
        answer = (num1 - num2);
        operatorString = '$num1 - $num2';
        break;
      case 1:
        answer = (num1 * num2);
        operatorString = '$num1 * $num2';
        break;
      case 2:
        answer = (num1 + num2);
        operatorString = '$num1 + $num2';
        break;
      case 3:
        answer = (num1 - num2);
        operatorString = '$num1 - $num2';
        break;
    }
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Center(
          child: Container(
            width: 300,
            height: 300,
            decoration: BoxDecoration(
                color: CustomColors.sdAppBackgroundColor,
                shape: BoxShape.rectangle,
                boxShadow: [
                  BoxShadow(
                      color: CustomColors.sdPrimaryBgLightColor,
                      blurRadius: 8.0,
                      spreadRadius: 10.0),
                ]),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  operatorString,
                  style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                          decoration: TextDecoration.none,
                          color: CustomColors.primaryTextColor,
                          fontSize: 70,
                          fontWeight: FontWeight.w500)),
                )
              ],
            ),
          ),
        ),
        Container(
          width: 100,
          height: 50,
          decoration: BoxDecoration(
            color: CustomColors.sdAppBackgroundColor,
          ),
          child: Scaffold(
            body: TextField(
              controller: myController,
            ),
          ),
        ),
        RaisedButton(
          child: const Text(
            "Submit Answer",
            style: TextStyle(fontSize: 20),
          ),
          onPressed: onAnswerSubmit,
          color: CustomColors.sdPrimaryBgLightColor,
          textColor: CustomColors.sdShadowColor,
          padding: EdgeInsets.all(20.0),
          splashColor: Colors.grey,
        )
      ],
    );
  }

  void onAnswerSubmit() {
    if (!_isNumeric(myController.text)){
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("ERROR: Please fill in all the fields"),
        backgroundColor: Colors.red,
      ));
    }
    setState(() {
      if (answer == int.parse(myController.text)) {
        final random = Random();
        var id = random.nextInt(1073741824);
        double time = DateTime.now().hour + (DateTime.now().second / 60);
        widget._alarmHistoryService.save(AlarmHistory(
            id.toString(), DateTime.now().toString(), time.toString()));
        Navigator.pushNamed(context, '/');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("ERROR: Please fill in all the fields"),
          backgroundColor: Colors.red,
        ));
      }
    });
  }
  bool _isNumeric(String str) {
    if(str == null) {
      return false;
    }
    return double.tryParse(str) != null;
  }
}
