import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Routine {
  Icon icon;
  String title;

  Routine({
    this.icon,
    this.title,
  });
}

List<Routine> routines = [
  Routine(
    icon: Icon(
      FontAwesomeIcons.walking,
      color: Color(0xFFf8931f),
    ),
    title: 'I\'m Leaving',
  ),
  Routine(
    icon: Icon(
      FontAwesomeIcons.film,
      color: Color(0xFFf8931f),
    ),
    title: 'Movie Mode',
  ),
  Routine(
    icon: Icon(
      FontAwesomeIcons.solidMoon,
      color: Color(0xFFf8931f),
    ),
    title: 'Night Time',
  ),
];
