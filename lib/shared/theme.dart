import 'package:flutter/material.dart';

ThemeData darkTheme = ThemeData.dark().copyWith(
  brightness: Brightness.dark,
  accentColor: Colors.lightGreenAccent,
  platform: TargetPlatform.iOS,
  appBarTheme: AppBarTheme(
  ),
);

ThemeData lightTheme = ThemeData.light().copyWith(
  brightness: Brightness.light,
//  accentColor: Color(0xff40bf7a),
  backgroundColor: Colors.grey,
  platform: TargetPlatform.iOS,

);
