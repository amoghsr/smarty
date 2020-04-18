import 'package:flutter/material.dart';

class CurrentDayProvider with ChangeNotifier {
  int _currentDay;

  CurrentDayProvider(this._currentDay);

  //TODO: Store current Streak Day house ID wise

  getCurrentDay() => _currentDay;
  setCurrentDay(int currentDay) => _currentDay = currentDay;
}