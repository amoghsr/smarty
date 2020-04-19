import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

//Map<hid,curtenday>
//userProfile leaderboard
class CurrentDayProvider with ChangeNotifier {
  int _currentDay;
  String houseID;
  CurrentDayProvider(this._currentDay, this.houseID);
  getCurrentDay() => _currentDay;
  setCurrentDay(int currentDay) {
    FirebaseDatabase.instance
        .reference()
        .child("Points/" + houseID + "/")
        .update({"Currency": currentDay.toInt()});
  }
}
