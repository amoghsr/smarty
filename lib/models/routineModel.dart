import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconpicker/Serialization/iconDataSerialization.dart';
//Current Routines

class Routine {
  Icon icon;
  String routineName;
  String routineDesc;
  Color routineColor;
  Map<String, String> devices;
  String Stime, Etime;
  Routine(
      {@required this.icon,
      this.routineName,
      this.routineDesc,
      this.routineColor,
      this.Stime,
      this.Etime,
      this.devices});

  factory Routine.fromFirestore(
      String STime,
      String ETime,
      String Name,
      Map<String, String> x,
      String desc,
      Map<String, dynamic> logo,
      String color) {
    return Routine(
      icon: Icon(
        mapToIconData(logo),
        color: Colors.white,
        size: 36.0,
      ),
      routineColor: getcolour(color),
      routineName: Name,
      routineDesc: desc,
      Stime: STime,
      Etime: ETime,
      devices: x,
    );
  }
}

Color getcolour(String x) {
  switch (x) {
    case 'blue':
      return Colors.blue;
    case 'green':
      return Colors.lightGreen;
    case 'orange':
      return Colors.deepOrange;
    case 'red':
      return Colors.red;
    case 'purple':
      return Colors.deepPurpleAccent;
  }
}
