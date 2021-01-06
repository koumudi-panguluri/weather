import 'dart:ui';

import 'package:flutter/material.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import './setAlarm.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';

class Alarm extends StatefulWidget {
  final cancelAlarmData;
  Alarm(this.cancelAlarmData);
  @override
  AlarmState createState() => AlarmState();
}

class AlarmState extends State<Alarm> {
  final reasonController = TextEditingController();
  var reason;
  final url = "https://alarm-4698.firebaseio.com/notify.json";
  var dateTime;
  var timeDiff;
  var actualSetTime;
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  // void firebase() {
  //   final fcm = FirebaseMessaging();
  //   fcm.requestNotificationPermissions();
  //   fcm.configure(
  //     onMessage: (message) {
  //       print("message in onMessage $message");
  //       return;
  //     },
  //     onLaunch: (message) {
  //       print("message in onLaunch $message");
  //       return;
  //     },
  //     onResume: (message) {
  //       print("message in onResumre $message");
  //       return;
  //     },
  //   );
  //   fcm.subscribeToTopic('alarm');
  // }

  void initState() {
    // firebase();
    super.initState();
    //flutter local notification settings
    AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    IOSInitializationSettings initializationSettingsIOs =
        IOSInitializationSettings();
    var initSetttings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOs);

    flutterLocalNotificationsPlugin.initialize(initSetttings);
  }

  Future onSelectNotification(String payload) async {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) {
      return SetAlarm(
        payload: payload,
      );
    }));
  }

  void flutterAlarm() {
    flutterLocalNotificationsPlugin.zonedSchedule(
        0,
        reason,
        'The alarm from Koumi-App has been set to ${DateTime.fromMillisecondsSinceEpoch(dateTime)}',
        tz.TZDateTime.now(tz.local).add(Duration(milliseconds: timeDiff)),
        const NotificationDetails(
            android: AndroidNotificationDetails('your channel id',
                'your channel name', 'your channel description')),
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime);
  }

  // void AlarmCancel() {
  //   flutterLocalNotificationsPlugin
  //       .cancel(widget.cancelAlarmData.key)
  //       .then((value) {
  //     print("alarm got cancelled");
  //   });
  // }

  Future<void> scheduleNotificationPost(setTime) async {
    submit();
    tz.initializeTimeZones();
    print("time stamp $setTime");
    return http
        .post(url, body: json.encode({'title': reason, 'time': setTime}))
        .then((value) {
      var data = json.decode(value.body)['name'];
      print("response after post from firebase $data");
      flutterAlarm();
    });
  }

  void submit() {
    reason = reasonController.text;
    print("reason for reminder $reason");
    if (reason.isNotEmpty) {
      reason = reason;
    } else {
      reason = "Koumi Alarm-Remainder";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 400,
        margin: EdgeInsets.all(10),
        child:
            Column(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          Text(
            "Time",
            style: TextStyle(fontSize: 20),
          ),
          TimePickerSpinner(
            is24HourMode: false,
            normalTextStyle: TextStyle(fontSize: 24, color: Colors.deepOrange),
            highlightedTextStyle: TextStyle(fontSize: 24, color: Colors.black),
            spacing: 45,
            itemHeight: 80,
            itemWidth: 55,
            isForce2Digits: true,
            onTimeChange: (time) {
              setState(() {
                actualSetTime = time;
                dateTime = time.millisecondsSinceEpoch;
                timeDiff = (dateTime - (DateTime.now().millisecondsSinceEpoch));
                print("time set $dateTime");
                print("time now ${DateTime.now().millisecondsSinceEpoch}");
              });
            },
          ),
          Center(
              child: TextField(
            controller: reasonController,
            decoration: InputDecoration(
              labelText: "Remainder Text",
            ),
            onSubmitted: (_) => submit(),
          )),
          SizedBox(height: 20),
          Center(
              child: FlatButton(
                  color: Colors.black87,
                  minWidth: 100,
                  height: 50,
                  onPressed: () {
                    print("set time difference in seconds ${timeDiff / 1000}");
                    scheduleNotificationPost(dateTime);
                    Navigator.pop(context, {'title': reason, 'time': dateTime});
                  },
                  child: Text(
                    "Set",
                    style: TextStyle(color: Colors.white),
                  )))
        ]));
  }
}
