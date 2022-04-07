import 'package:crazy_alarm_app/screens/alarm_manage_screen.dart';
import 'package:crazy_alarm_app/screens/alarm_screen.dart';
import 'package:crazy_alarm_app/screens/main_screen.dart';
import 'package:crazy_alarm_app/screens/question_screen.dart';
import 'package:crazy_alarm_app/services/notification_service.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  NotificationService().initNotification();


  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: MainScreen.routeName,
        routes: {
            MainScreen.routeName: (context) => const MainScreen(),
            AlarmManageScreen.routeName: (context) => const AlarmManageScreen(),
            QuestionScreen.routeName: (context) => const QuestionScreen(),
            AlarmScreen.routeName: (context) => const AlarmScreen()
        },
    );
  }
}