import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:crazy_alarm_app/constants/themes.dart';

class AlarmCard extends StatelessWidget {
  final String time;
  final bool active;
  final List repeat;
  final String id;
  final String title;

  const AlarmCard(this.id, this.title, this.time, this.active, this.repeat);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                      color: CustomColors.secondaryTextColor,fontSize: 15, fontWeight: FontWeight.w300
                    )
                  )
                ),
                Text(
                  time,
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
    );
  }

  String _buildrepeatString() {
    String repeatString = '';
    for(var day in repeat){
      if(day['enabled']){
        repeatString = repeatString + day['day'] + ' ';
      }
    }
    return repeatString;
  }
}