import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:weather/alarm.dart';

class AlarmModel {
  String key;
  int time;
  String note;
  int color;
  AlarmModel(this.key, this.time, this.note, this.color);
}
