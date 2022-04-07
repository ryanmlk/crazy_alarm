import 'package:flutter/material.dart';
import 'package:crazy_alarm_app/constants/themes.dart';
import 'package:google_fonts/google_fonts.dart';

class AlarmRepeatDialog extends StatefulWidget {
  final Function selectRepeatOption;

  const AlarmRepeatDialog({ Key? key, required this.selectRepeatOption }) : super(key: key);

  @override
  State<AlarmRepeatDialog> createState() => _AlarmRepeatDialogState();
}

class _AlarmRepeatDialogState extends State<AlarmRepeatDialog> {

  final repeatOptions = [
    "Once",
    "Daily",
    "Weekdays",
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180,
      color: CustomColors.sdTransparentColor,
      child: Column(
        children: repeatOptions.map((option) => repeatTile(option)).toList(),
      ),
    );
  }

  Widget repeatTile (String option) {
    return ListTile(
      autofocus: true,
      title: Text(
        option,
        style: GoogleFonts.poppins(
          textStyle: TextStyle(
            color: CustomColors.secondaryTextColor,fontSize: 18, fontWeight: FontWeight.w600
          )
        )
      ),
      onTap: () {
        widget.selectRepeatOption(option);
      },
    );
  }
}