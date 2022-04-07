import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AlarmConfig {
  late String id;
  String title;
  String time;
  bool active;
  List<dynamic> repeat;

  AlarmConfig(this.id,this.title, this.time,  this.active, this.repeat);

  AlarmConfig.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        time = json['time'],
        active = json['active'],
        repeat = json['repeat'];

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'time': time,
      'active': active,
      'repeat': repeat
    };
  }
}

String formatTimeOfDay(TimeOfDay tod) {
    final now = DateTime.now();
    final dt = DateTime(now.year, now.month, now.day, tod.hour, tod.minute);
    final format = DateFormat.jm();  //"6:00 AM"
    return format.format(dt);
}