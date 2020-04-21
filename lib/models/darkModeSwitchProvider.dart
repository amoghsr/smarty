import 'package:flutter/material.dart';

class AppThemeProvider with ChangeNotifier {
  bool darkTheme;

  AppThemeProvider({this.darkTheme});

  getTheme() => darkTheme;

  void toggleTheme() {
    darkTheme = !darkTheme;

    notifyListeners();
  }
}
