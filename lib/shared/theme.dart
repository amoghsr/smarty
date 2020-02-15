import 'package:flutter/material.dart';

ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  accentColor: Colors.lightGreenAccent,
  platform: TargetPlatform.iOS,
  fontFamily: 'Montserrat',
);

ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  backgroundColor: Colors.grey,
  accentColor: Colors.green,
  primaryColor: Colors.green,
  platform: TargetPlatform.iOS,
  fontFamily: 'Montserrat',
);
