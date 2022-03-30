import 'package:crazy_alarm_app/components/alarm_card.dart';
import 'package:crazy_alarm_app/components/notification_card.dart';
import 'package:crazy_alarm_app/components/notification_dialog.dart';
import 'package:crazy_alarm_app/models/notification.dart';
import 'package:crazy_alarm_app/services/notification_data_service.dart';
import 'package:flutter/material.dart';
import 'package:crazy_alarm_app/constants/themes.dart';
import 'package:google_fonts/google_fonts.dart';

class NotificationListScreen extends StatefulWidget {

  @override
  _NotificationListScreen createState() => _NotificationListScreen();
}


class _NotificationListScreen extends State<NotificationListScreen> {
  late Future <List<NotificationConfig>> notificationData;
  final NotificationDataService _notificationService = new NotificationDataService();

  @override
  void initState()  {
    super.initState();
    notificationData =  _notificationService.getNotifications();
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                  'Notifications',
                  style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                          color: CustomColors.primaryTextColor,fontSize: 45, fontWeight: FontWeight.w500
                      )
                  )
              ),
              Container(
                child: ElevatedButton(
                  onPressed: (){
                    Navigator.push(
                        context,
                        MaterialPageRoute<void>(
                        builder: (BuildContext context) => NotificationDialog(
                            'NEW',
                            NotificationConfig('','','',DateTime.now().toString())),
                    fullscreenDialog: true,
                    )
                    );
                    setState(() {
                      notificationData = _notificationService.getNotifications();
                    });
                  },
                  child: const Icon(Icons.add, size: 30,),
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
          const SizedBox(height: 20),
      Container(
        height: 450,
        child: FutureBuilder <List<NotificationConfig>>(
          future: notificationData,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<NotificationConfig>?  data = snapshot.data;
              return
                ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: data!.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        child: NotificationCard(
                            snapshot.data![index].title,
                            snapshot.data![index].message,
                            snapshot.data![index].datetime,
                            snapshot.data![index].id
                        ),
                        );
                    }
                );
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }
            // By default show a loading spinner.
            return CircularProgressIndicator();
          },
        ),
      ),
        ],
      ),
    );
  }
}
