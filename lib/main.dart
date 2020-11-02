import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import './setAlarm.dart';
import './search.dart';
import './clock.dart';
import './weatherUI.dart';
import 'package:location/location.dart';

import 'models/alarmModel.dart';

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
  static var lat;
  static var lon;
  static var url;
  static var appid = "89345da8cd6055e7437aacbf24473e94";

  static var weatherData;
  var city;
  var weatherList;

  List<AlarmModel> alarmList = [];
  final alarmUrl = "https://alarm-4698.firebaseio.com/notify.json";
  static final List<int> colorsList = [
    0xff048A81,
    0xff3C6E71,
    0xff5BC0BE,
    0xff7692FF,
  ];
  int colorCount = 0;

  Future<void> getWeatherData(weatherUrl) {
    print("lat lon $lat, $lon");
    weatherList = {};
    var newWeather;
    return http.get(weatherUrl).then((value) {
      print("response from weather API ${json.decode(value.body)}");
      weatherData = json.decode(value.body);
      newWeather = {
        "description": weatherData['weather'][0]['description'],
        "temp": weatherData['main']['temp'],
        "feelsLike": weatherData['main']['feels_like'],
        "tempMax": weatherData['main']['temp_min'],
        "tempMin": weatherData['main']['temp_max'],
        "pressure": weatherData['main']['pressure'],
        "humidity": weatherData['main']['humidity'],
        "visibility": weatherData['visibility'],
        "sunrise": DateFormat.jm().format(DateTime.fromMillisecondsSinceEpoch(
            weatherData['sys']['sunrise'] * 1000)),
        "sunset": DateFormat.jm().format(DateTime.fromMillisecondsSinceEpoch(
            weatherData['sys']['sunset'] * 1000)),
        "timezone": weatherData['timezone'],
        "name": weatherData['name']
      };
      print("new weather $newWeather");
      setState(() {
        weatherList = newWeather;
        print("yes1 ${weatherList['main']}");
        if (weatherList != null && weatherList['name'] != null) {
          city = weatherList['name'];
        } else {
          city = "Hyderabad";
        }
      });
    }).catchError((err) {
      print("error occured $err");
      throw err;
    });
  }

  void getLatLan() {
    Location().requestPermission().then((res) {
      print("permission $res");
      if (res == PermissionStatus.granted) {
        return Location().getLocation().then((value) {
          print("locations ${value.latitude},${value.longitude}");
          lat = value.latitude;
          lon = value.longitude;
          url =
              "http://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=$appid";
          print("urll $url");
          getWeatherData(url);
          print("hello");
          return value;
        }).catchError((err) {
          return err;
        });
      } else {
        url =
            "http://api.openweathermap.org/data/2.5/weather?lat=0&lon=0&appid=$appid";
        print("urll $url");
        getWeatherData(url);
      }
    });
  }

  void initState() {
    super.initState();
    print("lat lon before $lat,$lon");
    print("url before $url");
    getLatLan();
    scheduleNotificationGet();
  }

  void getCity(String city) {
    print("city in main $city");
    var cityUrl =
        "http://api.openweathermap.org/data/2.5/weather?q=$city&appid=$appid";
    getWeatherData(cityUrl).catchError((error) {
      showDialog(
          context: context,
          child: AlertDialog(
            actions: [
              Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
                FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    "Okay",
                    style: TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                )
              ])
            ],
            title: Text("Search Result Not found.\nPlease enter properly..!"),
          ));
    });
  }

//alarm get data from firebase
  Future<void> scheduleNotificationGet() async {
    return http.get(alarmUrl).then((value) {
      var data = json.decode(value.body) as Map<String, dynamic>;
      List<AlarmModel> alarmBookedList = [];
      data.forEach((key, value) {
        print("key $key, value $value");
        print("time ${value['time']}");
        alarmBookedList.add(AlarmModel(
            key, (value['time']), value['title'], colorsList[colorCount]));
        print("color, ${colorCount++}");
        if (colorCount > 3) {
          print("exceeded");
          colorCount = 0;
        }
      });

      print("alarm list");
      setState(() {
        if (alarmBookedList.isNotEmpty) {
          alarmBookedList.map((value) {
            alarmList = alarmBookedList;
          }).toList();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    print("Weather Data $weatherData");
    return Scaffold(
        appBar: AppBar(
          title: Text("Weather"),
          backgroundColor: Color(0xff1F211D),
          actions: [
            FlatButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              SetAlarm(getAlarmsData: alarmList)));
                },
                child: Icon(
                  Icons.alarm,
                  color: Colors.white,
                ))
          ],
        ),
        backgroundColor: Colors.white,
        body: weatherData == null
            ? Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                    Card(
                      margin: EdgeInsets.all(15),
                      child: Text("Please wait..!\nSomething went wrong.",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 25)),
                    ),
                  ],
                ),
              )
            : SingleChildScrollView(
                child: Container(
                    child: Column(children: [
                  Search(getCity),
                  Clock(weatherList['temp'], city),
                  WeatherUI(weatherList)
                ])),
              ));
  }
}
