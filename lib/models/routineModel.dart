import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/material.dart';

class Routine {
  Icon icon;
  String routineName;
  String routineDesc;
  Color routineColor;
  DateTime routineTime;

  Routine(
      {this.icon, this.routineName, this.routineDesc, this.routineColor, this.routineTime});
}

List<Routine> routines = [
  Routine(
    icon: Icon(
      FontAwesomeIcons.walking,
      color: Colors.blue[100],
    ),
    routineColor: Colors.blue,
    routineName: 'Exiting',
    routineDesc: 'On Tap',
    routineTime: new DateTime.now(),
  ),
  Routine(
    icon: Icon(
      FontAwesomeIcons.film,
      color: Colors.red[100],
    ),
    routineColor: Colors.red[600],
    routineName: 'Movie',
    routineDesc: 'On Tap',
    routineTime: new DateTime.now(),
  ),
  Routine(
    icon: Icon(
      FontAwesomeIcons.solidMoon,
      color: Colors.deepPurple[100],
    ),
    routineColor: Colors.deepPurpleAccent,
    routineName: 'Night Time',
    routineDesc: 'From 9:00 PM to 6:00 AM',
    routineTime: new DateTime.now(),
  ),
];
