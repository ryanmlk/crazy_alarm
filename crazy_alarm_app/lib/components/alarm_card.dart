import 'package:crazy_alarm_app/models/alarm.dart';
import 'package:crazy_alarm_app/screens/alarm_manage_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:crazy_alarm_app/constants/themes.dart';

class AlarmCard extends StatelessWidget {
  final AlarmConfig alarm;

  const AlarmCard({Key? key, required this.alarm}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (() {
        Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AlarmManageScreen(mode_new: false, alarm: alarm)),
        );
      }),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    alarm.title,
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                        color: CustomColors.secondaryTextColor,fontSize: 15, fontWeight: FontWeight.w300
                      )
                    )
                  ),
                  Text(
                    alarm.time,
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                        color: CustomColors.secondaryTextColor,fontSize: 25, fontWeight: FontWeight.w800
                      )
                    )
                  ),
                  Text(
                    _buildrepeatString(),
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                        color: CustomColors.secondaryTextColor,fontSize: 15, fontWeight: FontWeight.w300
                      )
                    )
                  ),
                ],
              ),
              Icon(Icons.alarm, color: CustomColors.sdIconColor, size: 35)
            ],
          ),
        ),
      ),
    );
  }

  String _buildrepeatString() {
    String repeatString = '';
    for(var day in alarm.repeat){
      if(day['enabled']){
        repeatString = repeatString + day['day'] + ' ';
      }
    }
    return repeatString;
  }
}