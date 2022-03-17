import 'package:crazy_alarm_app/components/alarm_card.dart';
import 'package:flutter/material.dart';
import 'package:crazy_alarm_app/constants/themes.dart';
import 'package:google_fonts/google_fonts.dart';

class AlarmListScreen extends StatelessWidget {
  const AlarmListScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final alarms = [
      1,
      2,
      3,
      4,
      5
    ];

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Alarms',
            style: GoogleFonts.poppins(
              textStyle: TextStyle(
                color: CustomColors.primaryTextColor,fontSize: 45, fontWeight: FontWeight.w500
              )
            )
          ),
          const SizedBox(height: 40),
          SizedBox(
            height: 450,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Container(
                child: Column(
                  children: alarms.map((e) => const AlarmCard()).toList(),
                ),
              ),
            ),
          ),
          const SizedBox(height: 30),
          Center(
            child: ElevatedButton(
              onPressed: (){}, 
              child: const Icon(Icons.add, size: 40,),
              style: ElevatedButton.styleFrom(
                shape: const CircleBorder(),
                padding: const EdgeInsets.all(10),
                primary: CustomColors.sdPrimaryBgLightColor,
                shadowColor: CustomColors.sdShadowDarkColor,
                elevation: 10,
              ),
            ),
          )
        ],
      ),
    );
  }
}