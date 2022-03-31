import 'package:crazy_alarm_app/components/alarm_repeat_dialog.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:crazy_alarm_app/constants/themes.dart';

class AlarmManageScreen extends StatefulWidget {
  const AlarmManageScreen({ Key? key }) : super(key: key);
  static String routeName = '/alarmmanage';

  @override
  State<AlarmManageScreen> createState() => _AlarmManageScreenState();
  
}

class _AlarmManageScreenState extends State<AlarmManageScreen> {
  TimeOfDay selectedTime = TimeOfDay.now();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: CustomColors.sdAppBackgroundColor,
        body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Alarm',
              style: GoogleFonts.poppins(
                textStyle: TextStyle(
                  color: CustomColors.primaryTextColor,fontSize: 45, fontWeight: FontWeight.w500
                )
              )
            ),
            const SizedBox(height: 40),
            SizedBox(
              height: 480,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                elevation: 10,
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Name',
                                style: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                    color: CustomColors.secondaryTextColor,fontSize: 15, fontWeight: FontWeight.w300
                                  )
                                )
                              ),
                              Text(
                                'Wake up for work',
                                style: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                    color: CustomColors.secondaryTextColor,fontSize: 25, fontWeight: FontWeight.w800
                                  )
                                )
                              ),
                            ],
                          ),
                          Icon(Icons.alarm, color: CustomColors.sdIconColor, size: 35)
                        ],
                      ),
                      Divider(thickness: 1, color: CustomColors.dividerColor, height: 40),
                      InkWell(
                        onTap: (){
                          _selectTime(context);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "${selectedTime.hour}:${selectedTime.minute}",
                              style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                  color: CustomColors.secondaryTextColor,fontSize: 50, fontWeight: FontWeight.w600
                                )
                              )
                            ),
                            Icon(Icons.arrow_forward_ios_rounded, color: CustomColors.sdIconColor, size: 35)
                          ],
                        ),
                      ),
                      Divider(thickness: 1, color: CustomColors.dividerColor, height: 40),
                      InkWell(
                        onTap: (){
                          showModalBottomSheet(context: context, builder: (context) {
                            return const AlarmRepeatDialog();
                          });
                        },
                        child: buildRepeatManager()
                      ),
                      Divider(thickness: 1, color: CustomColors.dividerColor, height: 40),
                      buildAlarmManager(),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: (){
                      Navigator.pop(context);
                    }, 
                    child: const Icon(Icons.close, size: 40,),
                    style: ElevatedButton.styleFrom(
                      shape: const CircleBorder(),
                      padding: const EdgeInsets.all(10),
                      primary: CustomColors.sdShadowDarkColor,
                      shadowColor: CustomColors.sdShadowDarkColor,
                      elevation: 10,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: (){
                      Navigator.pop(context);
                    }, 
                    child: const Icon(Icons.check, size: 40,),
                    style: ElevatedButton.styleFrom(
                      shape: const CircleBorder(),
                      padding: const EdgeInsets.all(10),
                      primary: CustomColors.sdPrimaryBgLightColor,
                      shadowColor: CustomColors.sdShadowDarkColor,
                      elevation: 10,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
          ),
      ),
    );
  }

  _selectTime(BuildContext context) async {
      final TimeOfDay? timeOfDay = await showTimePicker(
        context: context,
        initialTime: selectedTime,
        initialEntryMode: TimePickerEntryMode.dial,
      );
      if(timeOfDay != null && timeOfDay != selectedTime) {
        setState(() {
          selectedTime = timeOfDay;
        });
      }
  }

}

Widget buildRepeatManager() {
 return Row(
  mainAxisAlignment: MainAxisAlignment.spaceBetween,
  children: [
    Text(
      'Repeat',
      style: GoogleFonts.poppins(
        textStyle: TextStyle(
          color: CustomColors.secondaryTextColor,fontSize: 18, fontWeight: FontWeight.w600
        )
      )
    ),
    Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text(
          'Daily  ',
          style: GoogleFonts.poppins(
            textStyle: TextStyle(
              color: CustomColors.secondaryTextColor,fontSize: 15, fontWeight: FontWeight.w400
            )
          )
        ),
        Icon(Icons.arrow_forward_ios_rounded, color: CustomColors.secondaryTextColor, size: 18)
      ],
    ),
  ],
  );
}

Widget buildAlarmManager() {
 return Row(
  mainAxisAlignment: MainAxisAlignment.spaceBetween,
  children: [
    Text(
      'Alarm Ringtone',
      style: GoogleFonts.poppins(
        textStyle: TextStyle(
          color: CustomColors.secondaryTextColor,fontSize: 18, fontWeight: FontWeight.w600
        )
      )
    ),
    Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text(
          'Default  ',
          style: GoogleFonts.poppins(
            textStyle: TextStyle(
              color: CustomColors.secondaryTextColor,fontSize: 15, fontWeight: FontWeight.w400
            )
          )
        ),
        Icon(Icons.arrow_forward_ios_rounded, color: CustomColors.secondaryTextColor, size: 18)
      ],
    ),
  ],
  );
}