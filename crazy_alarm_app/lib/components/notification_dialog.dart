import 'dart:math';

import 'package:crazy_alarm_app/constants/themes.dart';
import 'package:crazy_alarm_app/models/notification.dart';
import 'package:crazy_alarm_app/services/notification_data_service.dart';
import 'package:crazy_alarm_app/services/notification_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

class NotificationDialog extends StatefulWidget {
  final String mode;
  final NotificationConfig notificationConfig;

  NotificationDialog(this.mode, this.notificationConfig);

  @override
  _NotificationDialogState createState() => _NotificationDialogState();
}

class _NotificationDialogState extends State<NotificationDialog> {
  @override
  void initState() {
    super.initState();
    tz.initializeTimeZones();
    _timeValue.text = DateFormat("yyyy-MM-dd hh:mm")
        .format(DateTime.parse(widget.notificationConfig.datetime));
    titleController.text = widget.notificationConfig.title;
    messageController.text = widget.notificationConfig.message;
  }

  final random = Random();
  final _timeValue = TextEditingController();
  final titleController = TextEditingController();
  final messageController = TextEditingController();
  final NotificationDataService _notificationDataService =
      const NotificationDataService();

  void showSnackBar(BuildContext context, String text) {
    final snackBar = SnackBar(
      content: Text(text),
      duration: Duration(seconds: 1), //default is 4s
    );
    // Find the Scaffold in the widget tree and use it to show a SnackBar.
    Scaffold.of(context).showSnackBar(snackBar);
  }

  void _selectDateTime() async {
    DatePicker.showDateTimePicker(context,
        showTitleActions: true,
        minTime: DateTime.now(),
        maxTime: DateTime(2025, 6, 7), onChanged: (datetime) {
      setState(() {
        _timeValue.text = DateFormat("yyyy-MM-dd hh:mm").format(datetime);
      });
      print('change $datetime');
    }, onConfirm: (date) {
      print('confirm $date');
    }, currentTime: DateTime.now(), locale: LocaleType.en);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CustomColors.sdAppBackgroundColor,
        title: Text('Set Notification'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: 300,
                  child: TextFormField(
                    cursorColor: Theme.of(context).cursorColor,
                    controller: titleController,
                    decoration: const InputDecoration(
                      labelText: 'Notification Title',
                      labelStyle: TextStyle(),
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Container(
                  width: 50,
                  child: IconButton(
                    onPressed: () => () {},
                    icon: const Icon(Icons.title),
                  ),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: 300,
                  child: TextFormField(
                    enabled: false,
                    cursorColor: Theme.of(context).cursorColor,
                    controller: _timeValue,
                    decoration: const InputDecoration(
                      labelText: 'Set Time',
                      labelStyle: TextStyle(),
                    ),
                  ),
                ),
                Container(
                  width: 50,
                  child: IconButton(
                    onPressed: () => _selectDateTime(),
                    icon: const Icon(Icons.alarm),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: 300,
                  child: TextFormField(
                    cursorColor: Theme.of(context).cursorColor,
                    controller: messageController,
                    decoration: const InputDecoration(
                      labelText: 'Message',
                      labelStyle: TextStyle(),
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Container(
                  width: 50,
                  child: IconButton(
                    onPressed: () => {},
                    icon: const Icon(Icons.message),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                if (widget.mode == 'NEW')
                  ElevatedButton(
                    onPressed: _addNotification,
                    child: const Icon(
                      Icons.input,
                      size: 30,
                    ),
                    style: ElevatedButton.styleFrom(
                      shape: const CircleBorder(),
                      padding: const EdgeInsets.all(10),
                      primary: CustomColors.sdPrimaryBgLightColor,
                      shadowColor: CustomColors.sdShadowDarkColor,
                      elevation: 10,
                    ),
                  ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ElevatedButton.icon(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(CustomColors.sdAppBackgroundColor),
                    ),
                    icon: Icon(Icons.update),
                    label: Text('Modify'),
                    onPressed: updateNotification,
                  ),
                    ElevatedButton.icon(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(CustomColors.sdAppBackgroundColor),
                      ),
                      icon: Icon(Icons.delete),
                      label: Text('Delete'),
                      onPressed: deleteNotification,
                    )
                  ],
                )

              ],
            )
          ],
        ),
      ),
    );
  }

  _addNotification() async {
    var id = random.nextInt(1073741824);
    var response = await _notificationDataService.save(NotificationConfig(
        id.toString(),
        messageController.text,
        titleController.text,
        _timeValue.text));
    NotificationService().showNotification(
      id,
      titleController.text,
      messageController.text,
      _timeValue.text,
    );
    if (response == 201) {
      Navigator.of(context).pop();
    }
  }

  Future<void> deleteNotification() async {
    int response = await _notificationDataService.delete(int.parse(widget.notificationConfig.id));
    if (response == 200) {
      Navigator.of(context).pop();
    }
  }

  Future<void> updateNotification() async {
    int response =  await _notificationDataService.update(NotificationConfig(
        widget.notificationConfig.id,
        messageController.text,
        titleController.text,
        _timeValue.text));
    if (response != 500) {
      Navigator.of(context).pop();
    }
  }
}
