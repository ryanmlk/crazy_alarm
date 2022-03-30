import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:crazy_alarm_app/constants/themes.dart';
import 'dart:math';
import 'dart:ui' as ui;

class ClockScreen extends StatefulWidget {
  const ClockScreen({ Key? key }) : super(key: key);

  @override
  State<ClockScreen> createState() => _ClockScreenState();
}

class _ClockScreenState extends State<ClockScreen> {

  @override
  void initState() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted){
        setState(() {
        
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final time = DateFormat('Hm');
    final day = DateFormat('MMMMEEEEd');

    return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Clock',
                style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                    color: CustomColors.primaryTextColor,fontSize: 45, fontWeight: FontWeight.w500
                  )
                )
              ),
              const SizedBox(height: 60),
              Center(
                child: SizedBox(
                  width: 350,
                  height: 350,
                  child: Transform.rotate(
                    angle: -pi/2,
                    child: CustomPaint(
                      painter: ClockPainter(),
                      child: Transform.rotate(
                        angle: pi/2,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget> [
                            Text(
                              time.format(now),
                              style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                  color: CustomColors.primaryTextColor,fontSize: 70, fontWeight: FontWeight.w500
                                )
                              ),
                            ),
                            Text(
                              day.format(now),
                              style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                  color: CustomColors.primaryTextColor,fontSize: 15, fontWeight: FontWeight.w300
                                )
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ]
          ),
        );
  }
}

class ClockPainter extends CustomPainter{

  var dateTime = DateTime.now();
  //60 sec - 360deg / 1 sec - 6deg

  @override
  void paint(Canvas canvas, Size size) {
    var centreX = size.width/2;
    var centreY = size.height/2;
    var centre = Offset(centreX, centreY);
    var radius = min(centreX, centreY);

    var outlineBrush = Paint()
    ..shader = ui.Gradient.linear(Offset(centreX + radius, 0), Offset(centreX - radius, 0), [CustomColors.sdPrimaryBgLightColor, CustomColors.sdSecondaryBgLightColor])
    ..style = PaintingStyle.stroke
    ..strokeWidth = 10;

    var dashBrush = Paint()
    ..color = Colors.grey
    ..style = PaintingStyle.stroke
    ..strokeCap = StrokeCap.round
    ..strokeWidth = 1;

    var currentDashBrush = Paint()
    ..shader = const RadialGradient(colors: [Color(0XFFEF224E), Color(0XFF8F0F4B)]).createShader(Rect.fromCircle(center: centre, radius: radius))
    ..style = PaintingStyle.stroke
    ..strokeCap = StrokeCap.round
    ..strokeWidth = 4;

    canvas.drawCircle(centre, radius - 40, outlineBrush);

    var outerCircleRadius = radius;
    var outerCircleRadiusShort = radius - 5;
    var innerCircleRadius = radius - 14;
    for (double i = 0; i < 360; i += 6) {
      var x2 = centreX + innerCircleRadius * cos(i * pi / 180);
      var y2 = centreX + innerCircleRadius * sin(i * pi / 180);

      if(i == dateTime.second * 6){
        var x1 = centreX + outerCircleRadius * cos(i * pi / 180);
        var y1 = centreX + outerCircleRadius * sin(i * pi / 180);
        canvas.drawLine(Offset(x1,y1), Offset(x2,y2), currentDashBrush);
      }
      else{
        var x1 = centreX + outerCircleRadiusShort * cos(i * pi / 180);
        var y1 = centreX + outerCircleRadiusShort * sin(i * pi / 180);
        canvas.drawLine(Offset(x1,y1), Offset(x2,y2), dashBrush);
      }
    }

  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
  
}