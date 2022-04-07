import 'package:crazy_alarm_app/constants/themes.dart';
import 'package:crazy_alarm_app/models/alarm_history.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class DateChart extends StatelessWidget {
  List<ChartData> chartData = <ChartData>[];

  DateChart(List<AlarmHistory> data, {Key? key}) : super(key: key) {
    //The data for the chart should be passed through the constructor
    for (var element in data) {
      chartData.add(ChartData(
          x: DateTime.parse(element.day), yValue: double.parse(element.time)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      //The chart widget should be intiliazied here
      child: Container(
          height: 320,
          width: 400,
          child: SfCartesianChart(
              backgroundColor: CustomColors.sdAppBackgroundColor,
              isTransposed: true,
              primaryXAxis: DateTimeAxis(
                  majorGridLines: MajorGridLines(width: 0),
                  edgeLabelPlacement: EdgeLabelPlacement.shift,
                  intervalType: DateTimeIntervalType.days),
              series: <ChartSeries<ChartData, DateTime>>[
                BarSeries<ChartData, DateTime>(
                  dataSource: chartData,
                  xValueMapper: (ChartData alarm, _) => alarm.x,
                  yValueMapper: (ChartData alarm, _) => alarm.yValue,
                  name: 'Time',
                )
              ])),
    ));
  }
}

class ChartData {
  ChartData({this.x, this.yValue});
  final DateTime? x;
  final double? yValue;
}
