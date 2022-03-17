import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:crazy_alarm_app/constants/themes.dart';

class AlarmCard extends StatelessWidget {
  const AlarmCard({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Alarm Name',
                  style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                      color: CustomColors.secondaryTextColor,fontSize: 15, fontWeight: FontWeight.w300
                    )
                  )
                ),
                Text(
                  '6:00 AM',
                  style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                      color: CustomColors.secondaryTextColor,fontSize: 25, fontWeight: FontWeight.w800
                    )
                  )
                ),
                Text(
                  'M T W T F S S',
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
}