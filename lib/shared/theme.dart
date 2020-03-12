import 'package:flutter/material.dart';

ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  accentColor: Colors.lightGreenAccent,
  platform: TargetPlatform.iOS,
  fontFamily: 'Montserrat',
);

ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  backgroundColor: Color(0xff4BA38E),
  accentColor: Color(0xffA3BBAD),
  primaryColor: Color(0xfffffffF),
  platform: TargetPlatform.iOS,
  fontFamily: 'Montserrat',
);
