import 'package:crazy_alarm_app/components/date_chart.dart';
import 'package:crazy_alarm_app/models/alarm_history.dart';
import 'package:crazy_alarm_app/services/alarm_history_service.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants/themes.dart';

class ChartScreen extends StatefulWidget {
  @override
  _ChartScreen createState() => _ChartScreen();
}

class _ChartScreen extends State<ChartScreen> {
  late Future<List<AlarmHistory>> alarmHistoryData;
  final AlarmHistoryService _alarmHistoryService = new AlarmHistoryService();

  @override
  void initState() {
    super.initState();
    try {
      alarmHistoryData = _alarmHistoryService.getAlarmHistory();
    } on Exception catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("ERROR: Can not contact server"),
        backgroundColor: Colors.red,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 10,
        ),
        Text(
            'Sleep History',
            style: GoogleFonts.poppins(
                textStyle: TextStyle(
                    color: CustomColors.primaryTextColor,fontSize: 45, fontWeight: FontWeight.w500
                )
            )
        ),
        SizedBox(
          height: 90,
        ),
        Align(
          alignment: Alignment.center,
          child: Container(
            height: 320,
            width: 380,
            child: FutureBuilder<List<AlarmHistory>>(
              future: alarmHistoryData,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return DateChart(snapshot.data!);
                } else if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                }
                // By default show a loading spinner.
                return const SizedBox(
                  height: 100.0,
                  width: 100.0,
                  child: CircularProgressIndicator(
                    color: Colors.red,
                  ),
                );
              },
            ),
          ),
        )
      ],
    );
  }
}
