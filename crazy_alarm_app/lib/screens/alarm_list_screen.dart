import 'dart:async';

import 'package:crazy_alarm_app/components/alarm_card.dart';
import 'package:crazy_alarm_app/models/alarm.dart';
import 'package:crazy_alarm_app/services/alarm_data_service.dart';
import 'package:flutter/material.dart';
import 'package:crazy_alarm_app/constants/themes.dart';
import 'package:google_fonts/google_fonts.dart';

class AlarmListScreen extends StatefulWidget {
  const AlarmListScreen({ Key? key }) : super(key: key);

  @override
  State<AlarmListScreen> createState() => _AlarmListScreenState();
}

class _AlarmListScreenState extends State<AlarmListScreen> {
  late Future <List<AlarmConfig>> alarmData;
  final AlarmDataService _alarmService = new AlarmDataService();

  @override
  void initState() {
    super.initState();
    alarmData =  _alarmService.getAlarms();
  }

  

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Alarms',
            style: GoogleFonts.poppins(
              textStyle: TextStyle(
                color: CustomColors.primaryTextColor,fontSize: 45, fontWeight: FontWeight.w500
              )
            )
          ),
          const SizedBox(height: 40),
          SizedBox(
            height: 450,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: FutureBuilder <List<AlarmConfig>>(
                future: alarmData,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<AlarmConfig>?  data = snapshot.data;
                    return
                      ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: data!.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                              child: AlarmCard(
                                  alarm: snapshot.data![index]
                              ),
                              );
                          }
                      );
                  } else if (snapshot.hasError) {
                    return Text("${snapshot.error}");
                  }
                  // By default show a loading spinner.
                  return CircularProgressIndicator();
                },
              ),
            ),
          ),
          const SizedBox(height: 30),
          Center(
            child: ElevatedButton(
              onPressed: (){
                Navigator.pushNamed(context, '/alarmmanage');
              }, 
              child: const Icon(Icons.add, size: 40,),
              style: ElevatedButton.styleFrom(
                shape: const CircleBorder(),
                padding: const EdgeInsets.all(10),
                primary: CustomColors.sdPrimaryBgLightColor,
                shadowColor: CustomColors.sdShadowDarkColor,
                elevation: 10,
              ),
            ),
          )
        ],
      ),
    );
  }
}