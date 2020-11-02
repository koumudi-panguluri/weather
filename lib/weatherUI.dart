import 'dart:ui';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
// import 'cloud.dart';

class WeatherUI extends StatelessWidget {
  final weatherDetails;
  WeatherUI(this.weatherDetails);
  @override
  Widget build(BuildContext context) {
    return weatherDetails != null
        ? Container(
            child: Column(mainAxisAlignment: MainAxisAlignment.end, children: [
            // Cloud(weatherDetails['description']),
            Row(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 5),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      gradient: LinearGradient(
                          begin: Alignment.bottomRight,
                          stops: [
                            0.1,
                            0.9
                          ],
                          colors: [
                            Color(0xff6610F2).withOpacity(.3),
                            Color(0xff6610F2).withOpacity(.6)
                          ])),
                  height: 100,
                  width: 150,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          "Visibility",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.lemonada(
                            letterSpacing: 2,
                            textStyle: TextStyle(
                              fontWeight: FontWeight.normal,
                              // fontStyle: FontStyle.italic,
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Icon(
                          Icons.visibility,
                          color: Colors.white54,
                          size: 35,
                        ),
                        Text("${weatherDetails['visibility']} Units",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.deepPurple))
                      ]),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 5),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      gradient: LinearGradient(
                          begin: Alignment.bottomRight,
                          stops: [
                            0.1,
                            0.9
                          ],
                          colors: [
                            Color(0xffF17105).withOpacity(.3),
                            Color(0xffF17105).withOpacity(.7)
                          ])),
                  height: 100,
                  width: 150,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          "Sun Rise",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.lemonada(
                            letterSpacing: 2,
                            textStyle: TextStyle(
                              fontWeight: FontWeight.normal,
                              // fontStyle: FontStyle.italic,
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Icon(
                          Icons.wb_sunny,
                          color: Colors.white54,
                          size: 35,
                        ),
                        Text("${(weatherDetails['sunrise'])}",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.deepOrange))
                      ]),
                ),
                Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: 5,
                  ),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      gradient: LinearGradient(
                          begin: Alignment.bottomRight,
                          stops: [
                            0.1,
                            0.9
                          ],
                          colors: [
                            Color(0xff454ADE).withOpacity(.3),
                            Color(0xff454ADE).withOpacity(.7)
                          ])),
                  height: 100,
                  width: 150,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          "Sun Set",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.lemonada(
                            letterSpacing: 2,
                            textStyle: TextStyle(
                              fontWeight: FontWeight.normal,
                              // fontStyle: FontStyle.italic,
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Icon(
                          Icons.nights_stay,
                          color: Colors.white54,
                          size: 35,
                        ),
                        Text("${(weatherDetails['sunset'])}",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.blue))
                      ]),
                ),
              ],
            ),
            Row(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      gradient: LinearGradient(
                          begin: Alignment.bottomRight,
                          stops: [
                            0.1,
                            0.9
                          ],
                          colors: [
                            Color(0xff210124).withOpacity(.5),
                            Color(0xff210124).withOpacity(.7)
                          ])),
                  height: 100,
                  width: 150,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          "Pressure",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.lemonada(
                            letterSpacing: 2,
                            textStyle: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Icon(
                          Icons.thermostat_outlined,
                          color: Colors.white54,
                          size: 35,
                        ),
                        Text("${(weatherDetails['pressure'])} Atm",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.deepPurple))
                      ]),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      gradient: LinearGradient(
                          begin: Alignment.bottomRight,
                          stops: [
                            0.1,
                            0.9
                          ],
                          colors: [
                            Color(0xff041F1E).withOpacity(.5),
                            Color(0xff041F1E).withOpacity(.7)
                          ])),
                  height: 100,
                  width: 150,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          "Condition",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.lemonada(
                            letterSpacing: 2,
                            textStyle: TextStyle(
                              fontWeight: FontWeight.normal,
                              // fontStyle: FontStyle.italic,
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Icon(
                          Icons.ac_unit,
                          color: Colors.white54,
                          size: 35,
                        ),
                        Text("${(weatherDetails['feelsLike'])} Units",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color(0xff1E2D24)))
                      ]),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      gradient: LinearGradient(
                          begin: Alignment.bottomRight,
                          stops: [
                            0.1,
                            0.9
                          ],
                          colors: [
                            Color(0xff820933).withOpacity(.3),
                            Color(0xff820933).withOpacity(.7)
                          ])),
                  height: 100,
                  width: 150,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          "Humidity",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.lemonada(
                            letterSpacing: 2,
                            textStyle: TextStyle(
                              fontWeight: FontWeight.normal,
                              // fontStyle: FontStyle.italic,
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Icon(
                          Icons.cloud,
                          color: Colors.white54,
                          size: 35,
                        ),
                        Text("${(weatherDetails['humidity'])} %",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.pink))
                      ]),
                ),
              ],
            ),
          ]))
        : Container(child: Text("No Data found yet."));
  }
}
