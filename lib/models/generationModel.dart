import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

class Generation {
  int dailyTotal;
  Map<String, int> monthly;
  Map<String, int> weekly;
  Map<String, int> daily;

  Generation({this.dailyTotal, this.monthly, this.weekly, this.daily});

  factory Generation.fromFirestore(List<DocumentSnapshot> doc) {
    var now = new DateTime.now();
    var date = new DateFormat('dd');
    String formattedDate = date.format(now);
    var month = new DateFormat('MMMM');
    String formattedMonth = month.format(now);
    Map<String, String> awd = {};
    for (int i = 0; i < now.weekday; i++) {
      DateTime x = now.subtract(new Duration(days: i + 1));
      var date1 = new DateFormat('dd');
      String formattedDate1 =
          date1.format(now.subtract(new Duration(days: i + 1)));
      var month1 = new DateFormat('MMMM');
      String formattedMonth1 = month1.format(x);
      awd[formattedDate1] = formattedMonth1;
    }
    int dailyTotal = 0;
    Map<String, int> monthly = new Map<String, int>();
    Map<String, int> weekly = new Map<String, int>();
    Map<String, int> daily = new Map<String, int>();
    doc.forEach((element) {
      element.data.forEach((key, value) {
        if (element.documentID == formattedMonth &&
            key.toString() == formattedDate) {
          dailyTotal = int.parse(value["total_day"].ceil().toString());
          weekly[key] = int.parse(value["total_day"].ceil().toString());
          value.forEach((key1, value1) {
            if (key1.toString() != "total_day") {
              daily[key1.toString()] = value1.ceil();
            }
          });
        }
        if (awd.values.contains(element.documentID) &&
            awd.containsKey(key.toString())) {
          value.forEach((key1, value1) {
            if (key1.toString() == "total_day") {
              weekly[key] = value1.ceil();
            }
          });
        }
      });
      monthly[element.documentID] = element.data["total_month"].ceil();
    });

    var room = Generation(
      dailyTotal: dailyTotal,
      daily: daily,
      monthly: monthly,
      weekly: weekly,
    );
    return room;
  }
}
