import 'package:flutter/material.dart';
import 'package:crazy_alarm_app/constants/themes.dart';
import 'package:google_fonts/google_fonts.dart';

class AlarmRepeatDialog extends StatelessWidget {
  const AlarmRepeatDialog({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 230,
      color: CustomColors.sdTransparentColor,
      child: Column(
        children: [
          ListTile(
            tileColor: CustomColors.sdShadowColor,
            autofocus: true,
            title: Text(
              'Once',
              style: GoogleFonts.poppins(
                textStyle: TextStyle(
                  color: CustomColors.secondaryTextColor,fontSize: 18, fontWeight: FontWeight.w600
                )
              )
            ),
          ),
          ListTile(
            title: Text(
              'Daily',
              style: GoogleFonts.poppins(
                textStyle: TextStyle(
                  color: CustomColors.secondaryTextColor,fontSize: 18, fontWeight: FontWeight.w600
                )
              )
            ),
          ),
          ListTile(
            title: Text(
              'Weekdays',
              style: GoogleFonts.poppins(
                textStyle: TextStyle(
                  color: CustomColors.secondaryTextColor,fontSize: 18, fontWeight: FontWeight.w600
                )
              )
            ),
          ),
          ListTile(
            title: Text(
              'Custom',
              style: GoogleFonts.poppins(
                textStyle: TextStyle(
                  color: CustomColors.secondaryTextColor,fontSize: 18, fontWeight: FontWeight.w600
                )
              )
            ),
          ),
        ],
      ),
    );
  }
}