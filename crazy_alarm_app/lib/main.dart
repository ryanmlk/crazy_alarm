import 'package:crazy_alarm_app/screens/alarm_manage_screen.dart';
import 'package:crazy_alarm_app/screens/main_screen.dart';
import 'package:flutter/material.dart';

void main() {
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
        },
    );
  }
}