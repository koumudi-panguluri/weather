import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/percent_indicator.dart';

class Clock extends StatelessWidget {
  final temperature;
  final city;
  Clock(this.temperature, this.city);
  @override
  Widget build(BuildContext context) {
    final date = DateTime.now();
    var totalTime;
    double minutePercent = 0.0;

    final clock =
        Stream<DateTime>.periodic(const Duration(seconds: 1), (count) {
      totalTime = date.add(Duration(seconds: count));
      minutePercent = (double.parse(DateFormat('mm').format(totalTime))) / 60;
      print(
          "actual time ${double.parse(DateFormat('mm').format(totalTime)) / 60}");
      return totalTime;
    });
    return StreamBuilder<DateTime>(
        stream: clock,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Container(
              margin: EdgeInsets.all(5),
              child: Stack(
                children: [
                  Container(
                      margin: EdgeInsets.all(75.0),
                      child: Center(
                        child: Text(
                          DateFormat('HH:mm:ss').format(snapshot.data),
                          style: GoogleFonts.teko(
                              fontSize: 60.0,
                              textStyle: TextStyle(color: Color(0xff004346)),
                              fontWeight: FontWeight.normal),
                        ),
                      )),
                  Center(
                    child: CircularPercentIndicator(
                      radius: 280.0,
                      lineWidth: 6.0,
                      animation: true,
                      percent: minutePercent,
                      circularStrokeCap: CircularStrokeCap.round,
                      backgroundColor: Color(0xffEAD7D7),
                      progressColor: Color(0xff331E38),
                    ),
                  ),
                  Container(
                      padding: EdgeInsets.symmetric(vertical: 160.2),
                      child: Column(children: [
                        Center(
                          child: Text(
                              "${temperature != null ? (temperature - 273.15).toStringAsFixed(2) : 0.00}°C",
                              style: GoogleFonts.teko(
                                  textStyle: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      fontSize: 28,
                                      color: Color(0xff125E8A)))),
                        ),
                        Center(
                          child: Text("$city",
                              style: GoogleFonts.teko(
                                  textStyle: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      fontSize: 28,
                                      color: Color(0xff125E8A)))),
                        )
                      ]))
                ],
              ),
            );
          } else {
            return Text(DateTime.now().toIso8601String());
          }
        });
  }
}
