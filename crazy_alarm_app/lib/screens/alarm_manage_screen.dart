import 'package:crazy_alarm_app/components/alarm_repeat_dialog.dart';
import 'package:crazy_alarm_app/models/alarm.dart';
import 'package:crazy_alarm_app/screens/alarm_screen.dart';
import 'package:crazy_alarm_app/services/alarm_data_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:crazy_alarm_app/constants/themes.dart';
import 'package:intl/intl.dart';

import '../main.dart';

class AlarmManageScreen extends StatefulWidget {
  bool mode_new;
  AlarmConfig alarm;
  AlarmManageScreen({required this.mode_new,required this.alarm, Key? key}) : super(key: key);
  static String routeName = '/alarmmanage';

  @override
  State<AlarmManageScreen> createState() => _AlarmManageScreenState();
  
}

class _AlarmManageScreenState extends State<AlarmManageScreen> {
  TimeOfDay selectedTime = TimeOfDay.now();
  String repeatOption = "Daily";
  final alarmTitleController = TextEditingController();

  TimeOfDay stringToTimeOfDay(String tod) {
    final format = DateFormat.jm(); //"6:00 AM"
    return TimeOfDay.fromDateTime(format.parse(tod));
  }

  @override
  void dispose() {
    alarmTitleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    if(!widget.mode_new){
      alarmTitleController.text = widget.alarm.title;
      setState(() {
        selectedTime = stringToTimeOfDay(widget.alarm.time);
      });
    }
    
    return SafeArea(
      child: Scaffold(
        backgroundColor: CustomColors.sdAppBackgroundColor,
        body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Alarm',
              style: GoogleFonts.poppins(
                textStyle: TextStyle(
                  color: CustomColors.primaryTextColor,fontSize: 45, fontWeight: FontWeight.w500
                )
              )
            ),
            const SizedBox(height: 40),
            SizedBox(
              height: 480,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                elevation: 10,
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Name',
                                style: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                    color: CustomColors.secondaryTextColor,fontSize: 15, fontWeight: FontWeight.w300
                                  )
                                )
                              ),
                              SizedBox(
                                width: 260,
                                child: TextField(
                                  controller: alarmTitleController,
                                  style: GoogleFonts.poppins(
                                    textStyle: TextStyle(
                                      color: CustomColors.secondaryTextColor,fontSize: 25, fontWeight: FontWeight.w800
                                    )
                                  ),
                                  decoration: const InputDecoration(
                                    border: UnderlineInputBorder(),
                                    hintText: 'Enter Alarm Name',
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Icon(Icons.alarm, color: CustomColors.sdIconColor, size: 35)
                        ],
                      ),
                      Divider(thickness: 1, color: CustomColors.dividerColor, height: 40),
                      InkWell(
                        onTap: (){
                          _selectTime(context);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "${selectedTime.hour}:${selectedTime.minute}",
                              style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                  color: CustomColors.secondaryTextColor,fontSize: 50, fontWeight: FontWeight.w600
                                )
                              )
                            ),
                            Icon(Icons.arrow_forward_ios_rounded, color: CustomColors.sdIconColor, size: 35)
                          ],
                        ),
                      ),
                      Divider(thickness: 1, color: CustomColors.dividerColor, height: 40),
                      InkWell(
                        onTap: (){
                          showModalBottomSheet(context: context, builder: (context) {
                            return AlarmRepeatDialog(selectRepeatOption: _selectRepeatOption,);
                          });
                        },
                        child: buildRepeatManager()
                      ),
                      Divider(thickness: 1, color: CustomColors.dividerColor, height: 40),
                      buildAlarmManager(),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: (){
                      Navigator.pop(context);
                    }, 
                    child: const Icon(Icons.close, size: 40,),
                    style: ElevatedButton.styleFrom(
                      shape: const CircleBorder(),
                      padding: const EdgeInsets.all(10),
                      primary: CustomColors.sdShadowDarkColor,
                      shadowColor: CustomColors.sdShadowDarkColor,
                      elevation: 10,
                    ),
                  ),
                  widget.mode_new? Container(): ElevatedButton(
                    onPressed: (){
                      deleteAlarm();
                    }, 
                    child: const Icon(Icons.delete, size: 40,),
                    style: ElevatedButton.styleFrom(
                      shape: const CircleBorder(),
                      padding: const EdgeInsets.all(10),
                      primary: CustomColors.sdPrimaryBgLightColor,
                      shadowColor: CustomColors.sdShadowDarkColor,
                      elevation: 10,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: (){
                      if(widget.mode_new){
                        saveAlarm();
                      } else {
                        updateAlarm();
                      } 
                    }, 
                    child: const Icon(Icons.check, size: 40,),
                    style: ElevatedButton.styleFrom(
                      shape: const CircleBorder(),
                      padding: const EdgeInsets.all(10),
                      primary: CustomColors.sdPrimaryBgLightColor,
                      shadowColor: CustomColors.sdShadowDarkColor,
                      elevation: 10,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
          ),
      ),
    );
  }

  _selectTime(BuildContext context) async {
      final TimeOfDay? timeOfDay = await showTimePicker(
        context: context,
        initialTime: selectedTime,
        initialEntryMode: TimePickerEntryMode.dial,
      );
      if(timeOfDay != null && timeOfDay != selectedTime) {
        setState(() {
          selectedTime = timeOfDay;
        });
      }
  }

  _selectRepeatOption(String option) {
    setState(() {
      repeatOption = option;
    });
    Navigator.of(context).pop();
  }

  Widget buildRepeatManager() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Repeat',
          style: GoogleFonts.poppins(
            textStyle: TextStyle(
              color: CustomColors.secondaryTextColor,fontSize: 18, fontWeight: FontWeight.w600
            )
          )
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              repeatOption,
              style: GoogleFonts.poppins(
                textStyle: TextStyle(
                  color: CustomColors.secondaryTextColor,fontSize: 15, fontWeight: FontWeight.w400
                )
              )
            ),
            Icon(Icons.arrow_forward_ios_rounded, color: CustomColors.secondaryTextColor, size: 18)
          ],
        ),
      ],
    );
  }

  Widget buildAlarmManager() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Alarm Ringtone',
          style: GoogleFonts.poppins(
            textStyle: TextStyle(
              color: CustomColors.secondaryTextColor,fontSize: 18, fontWeight: FontWeight.w600
            )
          )
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              'Default  ',
              style: GoogleFonts.poppins(
                textStyle: TextStyle(
                  color: CustomColors.secondaryTextColor,fontSize: 15, fontWeight: FontWeight.w400
                )
              )
            ),
            Icon(Icons.arrow_forward_ios_rounded, color: CustomColors.secondaryTextColor, size: 18)
          ],
        ),
      ],
    );
  }

  saveAlarm() async {
    final SnackBar snackBar;

    if(alarmTitleController.text == ""){
      snackBar = const SnackBar(
        content: Text('Alarm Title is required'),
        backgroundColor: Colors.black45,
      );
    }
    else {
      AlarmConfig alarm = AlarmConfig(
        '',
        alarmTitleController.text,
        formatTimeOfDay(selectedTime),
        true,
        [
          {"day": "Mo", "enabled": true},
          {"day": "Tu", "enabled": true},
          {"day": "We", "enabled": true},
          {"day": "Th", "enabled": true},
          {"day": "Fr", "enabled": true},
          {"day": "Sa", "enabled": true},
          {"day": "Su", "enabled": true}
        ]
      );
      final AlarmDataService _alarmService = new AlarmDataService();
      int responseCode = await _alarmService.save(alarm);
      scheduleAlarm(alarm);
      if(responseCode == 201)
        Navigator.of(context).pop();
    }
  }

  updateAlarm() async {
    final SnackBar snackBar;

    if(alarmTitleController.text == ""){
      snackBar = const SnackBar(
        content: Text('Alarm Title is required'),
        backgroundColor: Colors.black45,
      );
    }
    else {
      AlarmConfig alarm = AlarmConfig(
        widget.alarm.id,
        alarmTitleController.text,
        formatTimeOfDay(selectedTime),
        true,
        [
          {"day": "Mo", "enabled": true},
          {"day": "Tu", "enabled": true},
          {"day": "We", "enabled": true},
          {"day": "Th", "enabled": true},
          {"day": "Fr", "enabled": true},
          {"day": "Sa", "enabled": false},
          {"day": "Su", "enabled": false}
        ]
      );
      final AlarmDataService _alarmService = new AlarmDataService();
      int responseCode = await _alarmService.update(alarm);
      if(responseCode == 201)
        Navigator.of(context).pop();
    }
  }

  deleteAlarm() async {
      final AlarmDataService _alarmService = new AlarmDataService();
      int resposneCode = await _alarmService.delete(widget.alarm.id);
      if(resposneCode == 200)
        Navigator.of(context).pop();
  }

  // Refered from https://github.com/afzalali15/flutter_alarm_clock/blob/master/lib/views/alarm_page.dart
  void scheduleAlarm(AlarmConfig alarm) async {
    TimeOfDay time = stringToTimeOfDay(alarm.time);
    final now = DateTime.now();
    DateTime scheduledNotificationDateTime = DateTime(now.year, now.month, now.day, time.hour, time.minute);
    var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
      'alarm_notif',
      'alarm_notif',
      sound: RawResourceAndroidNotificationSound('ringtone'),
      icon: 'app_icon',
      largeIcon: DrawableResourceAndroidBitmap('app_icon'),
    );
    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.schedule(0, alarm.title, alarm.time,
        scheduledNotificationDateTime, platformChannelSpecifics, payload: "Test");
  }

}

void triggerAlarm() {
  return runApp(const AlarmScreen());
}