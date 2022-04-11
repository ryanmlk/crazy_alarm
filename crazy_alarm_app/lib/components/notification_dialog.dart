import 'dart:async';
import 'dart:math';

import 'package:crazy_alarm_app/constants/themes.dart';
import 'package:crazy_alarm_app/models/notification.dart';
import 'package:crazy_alarm_app/services/notification_data_service.dart';
import 'package:crazy_alarm_app/services/notification_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

class NotificationDialog extends StatefulWidget {
  final String mode;
  final NotificationConfig notificationConfig;

  const NotificationDialog(this.mode, this.notificationConfig);

  @override
  _NotificationDialogState createState() => _NotificationDialogState();
}

class _NotificationDialogState extends State<NotificationDialog> {
  //Initialized
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
  var error = null;
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
        print('trrwweewew' + datetime.toString());
        _timeValue.text = datetime.toString();
      });
      print('change $datetime');
    }, onConfirm: (date) {
      print('confirm $date');
    }, currentTime: DateTime.now(), locale: LocaleType.en);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset:false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: CustomColors.sdAppBackgroundColor,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text('New Notification',
                style: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                        color: Colors.black,
                        fontSize: 45,
                        fontWeight: FontWeight.w500))),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 40, 0, 0),
              child: Card(
                color: CustomColors.sdTransparentColor,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: 300,
                      height: 100,
                      child: TextFormField(
                        cursorColor: Theme.of(context).cursorColor,
                        controller: titleController,
                        style: TextStyle(color: Colors.white),
                        decoration: const InputDecoration(
                          labelText: 'Notification Title',
                          labelStyle: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.w300),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      width: 50,
                      height: 50,
                      child: IconButton(
                        onPressed: () => () {},
                        icon: const Icon(Icons.title),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Card(
              color: CustomColors.sdTransparentColor,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: 300,
                    height: 100,
                    child: TextFormField(
                      cursorColor: Theme.of(context).cursorColor,
                      controller: messageController,
                      style: TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                        labelText: 'Message',
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        labelStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.w300),
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
            ),
            Card(
              color: CustomColors.sdTransparentColor,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: 300,
                    height: 100,
                    child: TextFormField(
                      enabled: true,
                      readOnly: true,
                      cursorColor: Theme.of(context).cursorColor,
                      controller: _timeValue,
                      style: TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                        labelText: 'Set Time',
                        labelStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.w300),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
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
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (widget.mode == 'NEW')
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0,20,0,0),
                    child: Row(
                      children: [
                        ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            primary: CustomColors.sdAppBackgroundColor,
                              minimumSize: Size(50,
                                  70) // put the width and height you want
                              ),
                          icon: Icon(Icons.save),
                          label: Text('Create'),
                          onPressed: _addNotification,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                              primary: CustomColors.sdAppBackgroundColor,
                              minimumSize: Size(50,
                                  70) // put the width and height you want
                          ),
                          icon: Icon(Icons.save),
                          label: Text('Cancel'),
                          onPressed: () {
                            Navigator.of(context, rootNavigator: true)
                                .pop(context);
                          },
                        )
                      ],
                    ),
                  )
                else
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0,20,0,0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                              primary: CustomColors.sdAppBackgroundColor,
                              minimumSize: Size(50,
                                  70) // put the width and height you want
                          ),
                          icon: Icon(Icons.update),
                          label: Text('Modify'),
                          onPressed: updateNotification,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                              primary: CustomColors.sdAppBackgroundColor,
                              minimumSize: Size(50,
                                  70) // put the width and height you want
                          ),
                          icon: Icon(Icons.delete),
                          label: Text('Delete'),
                          onPressed: deleteNotification,
                        )
                      ],
                    ),
                  )
              ],
            ),
            SizedBox(
              height: 30,
            ),
            if (error != null)
              Text(
                error,
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 18
                ),
              )
          ],
        ),
      ),
    );
  }

  _addNotification() async {
    var id = random.nextInt(1073741824);
    print('trrr' + _timeValue.text);
    var response = await _notificationDataService.save(NotificationConfig(
        id.toString(),
        messageController.text,
        titleController.text,
        _timeValue.text));
    print('trrererer' + response.toString());

    if(response != 201) {
      setState(() {
        error = "[ERROR]: Please fill in all the fields";
      });
      var timer = new Timer(const Duration(seconds: 3), () {
        setState(() {
          error = null;
        });
      });
    }
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
    int response = await _notificationDataService
        .delete(int.parse(widget.notificationConfig.id));
    if (response == 200) {
      NotificationService()
          .CancelNotification(int.parse(widget.notificationConfig.id));
      Navigator.of(context).pop();
    }
  }

  Future<void> updateNotification() async {
    int response = await _notificationDataService.update(NotificationConfig(
        widget.notificationConfig.id,
        messageController.text,
        titleController.text,
        _timeValue.text));
    print('updddd' + response.toString());
    if(response == 500) {
      setState(() {
        error = "[ERROR]: Please fill in all the fields";
      });
      var timer = new Timer(const Duration(seconds: 3), () {
        setState(() {
          error = null;
        });
      });
    }
    if (response != 500) {
      NotificationService()
          .CancelNotification(int.parse(widget.notificationConfig.id));
      NotificationService().showNotification(
        int.parse(widget.notificationConfig.id),
        titleController.text,
        messageController.text,
        _timeValue.text,
      );
      Navigator.of(context).pop();
    }
  }
}
