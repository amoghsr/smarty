import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/material.dart';

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

  factory Routine.fromFirestore(String STime, String ETime, String Name,
      Map<String, String> x, String desc, String logo, String color) {
    return Routine(
      icon: Icon(
        FontAwesomeIcons.walking,
        color: Colors.blue[100],
      ),
      routineColor: Colors.blue,
      routineName: Name,
      routineDesc: desc,
      Stime: STime,
      Etime: ETime,
      devices: x,
    );
  }
}
//
//List<Routine> routines = [
//  Routine(
//    icon: Icon(
//      FontAwesomeIcons.walking,
//      color: Colors.blue[100],
//    ),
//    routineColor: Colors.blue,
//    routineName: 'Exiting',
//    routineDesc: 'On Tap',
////    routineTime: new DateTime.now(),
//  ),
//  Routine(
//    icon: Icon(
//      FontAwesomeIcons.film,
//      color: Colors.red[100],
//    ),
//    routineColor: Colors.red[600],
//    routineName: 'Movie',
//    routineDesc: 'On Tap',
////    routineTime: new DateTime.now(),
//  ),
//  Routine(
//    icon: Icon(
//      FontAwesomeIcons.solidMoon,
//      color: Colors.deepPurple[100],
//    ),
//    routineColor: Colors.deepPurpleAccent,
//    routineName: 'Night Time',
//    routineDesc: 'From 9:00 PM to 6:00 AM',
////    routineTime: new DateTime.now(),
//  ),
//];
