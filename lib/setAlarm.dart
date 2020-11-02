import 'dart:ui';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather/alarm.dart';
import 'package:weather/models/alarmModel.dart';

class SetAlarm extends StatefulWidget {
  final payload;
  final List<AlarmModel> getAlarmsData;
  SetAlarm({this.payload, this.getAlarmsData});
  @override
  SetAlarmState createState() => SetAlarmState();
}

class SetAlarmState extends State<SetAlarm> {
  static final List<int> colorsList = [
    0xff048A81,
    0xff3C6E71,
    0xff5BC0BE,
    0xff7692FF,
  ];
  int colorCount = 0;
  var deleteAlarmData;
  void setAlarm(context) {
    showDialog(
        context: context,
        child: Dialog(
          child: Alarm(deleteAlarmData),
        )).then((value) {
      print("alarm returns $value");
      // TODO : Can do better
      setState(() {
        if (value.isNotEmpty) {
          widget.getAlarmsData.add(AlarmModel(
              "0", value['time'], value['title'], colorsList[colorCount]));
        }
        if (colorCount > 3) {
          colorCount = 0;
        }
      });
    });
  }

  void showDeleteDialog(context, data) {
    this.deleteAlarmData = data;
    showDialog(
        context: context,
        child: AlertDialog(
          actions: [
            Column(
              children: [
                Text("Are you sure you want to delete?"),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    FlatButton(
                        onPressed: () => deleteAlarm(data),
                        child: Text(
                          "Delete",
                          style: TextStyle(color: Colors.red),
                        )),
                    FlatButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text("Cancel",
                            style: TextStyle(color: Colors.green)))
                  ],
                )
              ],
            )
          ],
        ));
  }

  Future<void> deleteAlarm(deleteData) async {
    String id = deleteData.key;
    final url = "https://alarm-4698.firebaseio.com/notify/$id.json";
    final index = widget.getAlarmsData.indexWhere((alarm) => alarm.key == id);
    final response = await http.delete(url);
    print("show delete response ${response.statusCode}");
    if (response.statusCode >= 400) {
      print("error occured");
      setState(() {
        widget.getAlarmsData.insert(index, deleteData);
      });
    } else {
      setState(() {
        widget.getAlarmsData.remove(deleteData);
      });
    }
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Alarm"),
        backgroundColor: Color(0xff1F211D),
      ),
      body: widget.getAlarmsData.isNotEmpty
          ? SingleChildScrollView(
              child: Column(
                  children: widget.getAlarmsData.map((alarm) {
                return Card(
                  child: Row(children: [
                    Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                      child: CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.white60,
                        foregroundColor: Colors.black,
                        child: Container(
                          padding: EdgeInsets.all(6),
                          child: FittedBox(
                            child:
                                (DateTime.fromMillisecondsSinceEpoch(alarm.time)
                                                .hour <=
                                            12 &&
                                        DateTime.fromMillisecondsSinceEpoch(
                                                    alarm.time)
                                                .minute <=
                                            59 &&
                                        DateTime.fromMillisecondsSinceEpoch(
                                                    alarm.time)
                                                .second <=
                                            59)
                                    ? Text(
                                        'AM',
                                        style: TextStyle(
                                            fontStyle: FontStyle.italic,
                                            fontWeight: FontWeight.bold),
                                      )
                                    : Text(
                                        'PM',
                                        style: TextStyle(
                                            fontStyle: FontStyle.italic,
                                            fontWeight: FontWeight.bold),
                                      ),
                          ),
                        ),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.all(5),
                          child: Text(
                            'Reason : ${alarm.note}',
                            style: GoogleFonts.teko(
                                letterSpacing: 1,
                                textStyle: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.white)),
                          ),
                        ),
                        Container(
                            padding: EdgeInsets.all(5),
                            child: Text(
                                'Time : ${DateTime.fromMillisecondsSinceEpoch(alarm.time).day}-${DateTime.fromMillisecondsSinceEpoch(alarm.time).month}-${DateTime.fromMillisecondsSinceEpoch(alarm.time).year}, ${DateTime.fromMillisecondsSinceEpoch(alarm.time).hour}:${DateTime.fromMillisecondsSinceEpoch(alarm.time).minute}',
                                style: TextStyle(color: Colors.black54))),
                      ],
                    ),
                    SizedBox(width: 50),
                    Container(
                      child: Expanded(
                        child: IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            showDeleteDialog(context, alarm);
                          },
                          color: Colors.black87,
                        ),
                      ),
                    ),
                  ]),
                  elevation: 10,
                  color: Color(alarm.color),
                );
              }).toList()),
            )
          : Container(child: Text("No Data Found")),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setAlarm(context);
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.black54,
      ),
    );
  }
}
