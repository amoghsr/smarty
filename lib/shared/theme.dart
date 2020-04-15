import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  accentColor: Colors.lightGreenAccent,
  fontFamily: 'Montserrat',
    appBarTheme: AppBarTheme(
      elevation: 0.0
    ),
);

ThemeData lightTheme = ThemeData(
//  brightness: Brightness.light,
  backgroundColor: Color(0xff78ab8a),
  accentColor: Color(0xff06d755),
  primaryColor: Color(0xfffffffF),
  primaryColorLight: Color(0xff69e799),
  fontFamily: 'Montserrat',
  appBarTheme: AppBarTheme(
    elevation: 0,
  )
);
