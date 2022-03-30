import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:crazy_alarm_app/constants/themes.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:app_launcher/app_launcher.dart';

class AlarmScreen extends StatelessWidget {
  const AlarmScreen({ Key? key }) : super(key: key);
  static String routeName = '/alarm';

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final format = DateFormat('Hm');

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Center(
          child: Container(
            width: 300,
            height: 300,
            decoration: BoxDecoration(
              color: CustomColors.sdAppBackgroundColor,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: CustomColors.sdPrimaryBgLightColor,
                  blurRadius: 8.0,
                  spreadRadius: 10.0
                ),
              ]
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Icon(
                  Icons.alarm,
                  color: CustomColors.primaryTextColor,
                  size: 40,
                ),
                Text(
                  format.format(now),
                  style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                      color: CustomColors.primaryTextColor,fontSize: 70, fontWeight: FontWeight.w500
                    )
                  ),
                ),
                SizedBox(
                  width: 250,
                  child: Text(
                    "Alarm Name",
                    maxLines: 3,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                        color: CustomColors.primaryTextColor,fontSize: 20, fontWeight: FontWeight.w500
                      )
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        RaisedButton(
          child: Text("Snooze Alarm", style: TextStyle(fontSize: 20),),
          onPressed: () async {
          await AndroidAlarmManager.periodic(const Duration(seconds: 10), 1, setAlarm);

            Navigator.pushNamed(context, '/question');
          },
          color: CustomColors.sdPrimaryBgLightColor,
          textColor: CustomColors.sdShadowColor,
          padding: EdgeInsets.all(20.0),
          splashColor: Colors.grey,
        )
      ],
    );
  }

}

void setAlarm() async {
  print('trwelk');
  await AppLauncher.openApp(
    androidApplicationId: "com.example.crazy_alarm_app",
  );
}