import 'package:crazy_alarm_app/constants/themes.dart';
import 'package:crazy_alarm_app/screens/alarm_list_screen.dart';
import 'package:crazy_alarm_app/screens/chart_screen.dart';
import 'package:crazy_alarm_app/screens/clock_screen.dart';
import 'package:crazy_alarm_app/screens/notification_list.dart';
import 'package:crazy_alarm_app/screens/profile_screen.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);
  static String routeName = '/';

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    final items = <Widget>[
      const Icon(Icons.access_time, size: 24),
      const Icon(Icons.alarm, size: 24),
      const Icon(Icons.person, size: 24),
      const Icon(Icons.bar_chart, size: 24),
      const Icon(Icons.notifications, size: 24)
    ];
    final screens = [
      const ClockScreen(),
      const AlarmListScreen(),
      ProfileScreen(),
      ChartScreen(),
      NotificationListScreen()
    ];

    return SafeArea(
      child: Scaffold(
          backgroundColor: CustomColors.sdAppBackgroundColor,
          body: screens[index],
          bottomNavigationBar: CurvedNavigationBar(
            index: index,
            backgroundColor: Colors.transparent,
            height: 55,
            items: items,
            onTap: (index) => setState(() => this.index = index),
          )),
    );
  }
}
