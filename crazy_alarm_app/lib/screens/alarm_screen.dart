import 'package:crazy_alarm_app/constants/themes.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AlarmScreen extends StatelessWidget {
  const AlarmScreen({ Key? key }) : super(key: key);
  static String routeName = '/alarm';

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final format = DateFormat('Hm');
    final snoozeTimes = [5, 10, 15, 20];

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Center(
          child: Container(
            width: 325,
            height: 325,
            decoration: ShapeDecoration(
                shape: CircleBorder(
                    side: BorderSide(
                        color: CustomColors.sdPrimaryBgLightColor,
                        style: BorderStyle.solid,
                        width: 10))),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Icon(
                  Icons.alarm,
                  color: CustomColors.sdPrimaryColor,
                  size: 32,
                ),
                Text(
                  format.format(now),
                  style: TextStyle(
                      fontSize: 52,
                      fontWeight: FontWeight.w900,
                      color: CustomColors.sdPrimaryColor),
                ),
                SizedBox(
                  width: 250,
                  child: Text(
                    "Alarm Name",
                    maxLines: 3,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: CustomColors.sdPrimaryColor, fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 45,
        ),
        GestureDetector(
          onTap: () async {
          },
          child: Text("Snooze", style: TextStyle(color: CustomColors.sdPrimaryColor)),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: snoozeTimes
              .map((minutes) => ElevatedButton(
                    child: const Text("minutes", style: TextStyle(fontSize: 24)),
                    onPressed: () async {
                    },
                  ))
              .toList(),
        ),
        const SizedBox(
          height: 45,
        ),
        ElevatedButton(
          onPressed: (){}, 
          child: const Text("Dismiss", style: TextStyle(fontSize: 45))
        ),
      ],
    );
  }
}