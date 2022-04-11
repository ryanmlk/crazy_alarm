import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  static final NotificationService _notificationService =
      NotificationService._internal();
  var location;

  factory NotificationService() {
    return _notificationService;
  }

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  NotificationService._internal();
  Future<void> initNotification() async {
    tz.initializeTimeZones();
    const AndroidInitializationSettings initializationSettingsAndroid =

    const AndroidInitializationSettings('@drawable/app_icon');
    const IOSInitializationSettings initializationSettingsIOS =
        IOSInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );

    const InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid,
            iOS: initializationSettingsIOS);

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  Future<void> showNotification(
      int id, String title, String body, String time) async {
    var timezone = await FlutterNativeTimezone.getLocalTimezone();
    var location = tz.getLocation(timezone);
    var tzDatetime = tz.TZDateTime.from(
      DateTime.parse(time),
      location,
    );
    print(tzDatetime.toString() + "" + location.toString());
    await flutterLocalNotificationsPlugin.zonedSchedule(
      id,
      title,
      body,
      tzDatetime,
      const NotificationDetails(
        android: AndroidNotificationDetails('main_channel', 'Main Channel',
            channelDescription: 'Main channel notifications',
            importance: Importance.max,
            priority: Priority.max,
            icon: '@drawable/app_icon'),
        iOS: IOSNotificationDetails(
          sound: 'default.wav',
          presentAlert: true,
          presentBadge: true,
          presentSound: true,
        ),
      ),
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      androidAllowWhileIdle: true,
    );
  }

  Future<void> CancelNotification(int id) async {
    await flutterLocalNotificationsPlugin.cancel(id);
  }
  Future<void> cancelAllNotifications() async {
    await flutterLocalNotificationsPlugin.cancelAll();
  }
}
