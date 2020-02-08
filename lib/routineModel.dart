import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Routine {
  Icon icon;
  String routineName;
  String routineDesc;

  Routine({
    this.icon,
    this.routineName,
    this.routineDesc
  });
}

List<Routine> routines = [
  Routine(
    icon: Icon(
      FontAwesomeIcons.walking,
      color: Color(0xFFf8931f),
    ),
    routineName: 'I\'m Leaving',
    routineDesc: 'On Tap',
  ),
  Routine(
    icon: Icon(
      FontAwesomeIcons.film,
      color: Color(0xFFf8931f),
    ),
    routineName: 'Movie Mode',
    routineDesc: 'On Tap',
  ),
  Routine(
    icon: Icon(
      FontAwesomeIcons.solidMoon,
      color: Color(0xFFf8931f),
    ),
    routineName: 'Night Time',
    routineDesc: 'From 9:00 PM to 6:00 AM',
  ),
];
