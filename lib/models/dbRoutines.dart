import 'package:flutter/material.dart';

class dbRoutine {
  String STime;
  String ETime;
  String Name;
  Color color;
  Map<String, String> devices;
  dbRoutine({this.STime, this.ETime, this.Name, this.devices, this.color});

  factory dbRoutine.fromFirestore(
      String STime, String ETime, String Name, Map<String, String> devices) {
    return dbRoutine(
      STime: STime,
      ETime: ETime,
      Name: Name,
      devices: devices,
      color: Colors.blue,
    );
  }
}
