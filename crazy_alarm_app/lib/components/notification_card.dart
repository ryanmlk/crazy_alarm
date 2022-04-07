import 'package:crazy_alarm_app/constants/themes.dart';
import 'package:crazy_alarm_app/models/notification.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import 'notification_dialog.dart';

class NotificationCard extends StatelessWidget {
  final String title;
  final String message;
  final String datetime;
  final String id;

  const NotificationCard(this.title, this.message, this.datetime, this.id);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute<void>(
              builder: (BuildContext context) => NotificationDialog(
                  'MODIFY', NotificationConfig(id, message, title, datetime)),
              fullscreenDialog: true,
            ));
      },
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                      DateFormat("yyyy-MM-dd hh:mm")
                          .format(DateTime.parse(datetime)),
                      style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                              color: CustomColors.secondaryTextColor,
                              fontSize: 15,
                              fontWeight: FontWeight.w300))),
                  Text(title,
                      style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                              color: CustomColors.secondaryTextColor,
                              fontSize: 25,
                              fontWeight: FontWeight.w800))),
                  Text(message,
                      style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                              color: CustomColors.secondaryTextColor,
                              fontSize: 15,
                              fontWeight: FontWeight.w300))),
                ],
              ),
              Icon(Icons.notifications,
                  color: CustomColors.sdIconColor, size: 35)
            ],
          ),
        ),
      ),
    );
  }
}
