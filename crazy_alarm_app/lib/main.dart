import 'package:crazy_alarm_app/screens/alarm_manage_screen.dart';
import 'package:crazy_alarm_app/screens/alarm_screen.dart';
import 'package:crazy_alarm_app/screens/login.dart';
import 'package:crazy_alarm_app/screens/main_screen.dart';
import 'package:crazy_alarm_app/screens/profile_screen.dart';
import 'package:crazy_alarm_app/screens/question_screen.dart';
import 'package:crazy_alarm_app/screens/signup.dart';
import 'package:crazy_alarm_app/services/notification_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'models/alarm.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
final GlobalKey<NavigatorState> navigatorKey = GlobalKey(debugLabel: "Main Navigator");

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  var initializationSettingsAndroid = AndroidInitializationSettings('app_icon');
  var initializationSettings = InitializationSettings(android: initializationSettingsAndroid);

  Future selectNotification(String? payload) async {
      navigatorKey.currentState?.pushNamed('/alarm');
  }

  await flutterLocalNotificationsPlugin.initialize(initializationSettings, onSelectNotification: selectNotification);

  NotificationService().initNotification();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        navigatorKey: navigatorKey,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: MainScreen.routeName,
        routes: {
            MainScreen.routeName: (context) => const MainScreen(),
            AlarmManageScreen.routeName: (context) => AlarmManageScreen(mode_new: true, alarm: AlarmConfig('','','',false,[])),
            QuestionScreen.routeName: (context) => const QuestionScreen(),
            AlarmScreen.routeName: (context) => const AlarmScreen(),
            Login.routeName: (context) => const Login(),
            SignUpPage.routeName: (context) => const SignUpPage(),
            ProfileScreen.routeName: (context) => const ProfileScreen()
        },
    );
  }
}