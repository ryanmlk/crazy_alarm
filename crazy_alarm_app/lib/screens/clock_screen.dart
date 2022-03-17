import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:crazy_alarm_app/constants/themes.dart';

class ClockScreen extends StatelessWidget {
  const ClockScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final time = DateFormat('Hm');
    final day = DateFormat('MMMMEEEEd');

    return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Clock',
                style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                    color: CustomColors.primaryTextColor,fontSize: 45, fontWeight: FontWeight.w500
                  )
                )
              ),
              const SizedBox(height: 60),
              Center(
                child: Container(
                  height: 300,
                  width: 300,
                  decoration: BoxDecoration(
                    color: CustomColors.sdAppBackgroundColor,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: CustomColors.sdPrimaryBgLightColor,
                        blurRadius: 5.0,
                        spreadRadius: 5.0
                      ),
                    ]
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget> [
                      Text(
                        time.format(now),
                        style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                            color: CustomColors.primaryTextColor,fontSize: 80, fontWeight: FontWeight.w500
                          )
                        ),
                      ),
                      Text(
                        day.format(now),
                        style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                            color: CustomColors.primaryTextColor,fontSize: 20, fontWeight: FontWeight.w300
                          )
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ]
          ),
        );
  }
}