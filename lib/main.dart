import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rxdart/rxdart.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyWeatherApp(),
    );
  }
}

class MyWeatherApp extends StatefulWidget {
  @override
  _MyWeatherAppState createState() => _MyWeatherAppState();
}

class _MyWeatherAppState extends State<MyWeatherApp> {
  void initState() {
    super.initState();
    getWeatherData();
  }

  static var lat = "17.398376";
  static var lon = "78.558266";
  static var appid = "89345da8cd6055e7437aacbf24473e94";
  final url =
      "http://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=$appid";
  var weatherData;
  Future<void> getWeatherData() {
    return http.get(url).then((value) {
      print("response from weather API ${json.decode(value.body)}");
      setState(() {
        weatherData = json.decode(value.body)['main']['temp'];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    print("temperature $weatherData");
    return Scaffold(
        appBar: AppBar(
          title: Text("Weather"),
        ),
        body: Container(
          child: SingleChildScrollView(
            child: Column(children: [
              Text("weather data $weatherData"),
              Center(
                  child: RaisedButton(
                onPressed: getWeatherData,
                child: Text(
                  "Press",
                  style: TextStyle(color: Colors.white),
                ),
              )),
            ]),
          ),
        ));
  }
}
