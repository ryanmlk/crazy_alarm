import 'package:flutter/material.dart';
import 'package:crazy_alarm_app/constants/themes.dart';
import 'package:google_fonts/google_fonts.dart';

class AlarmListScreen extends StatelessWidget {
  const AlarmListScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Text(
        'Alarm List',
        style: GoogleFonts.poppins(
          textStyle: TextStyle(
            color: CustomColors.primaryTextColor,fontSize: 45, fontWeight: FontWeight.w500
          )
        )
      ),
    );
  }
}