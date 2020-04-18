import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

class Generation {
  int dailyTotal;
  Map<String, int> monthly;
  Map<String, int> weekly;
  Map<String ,int> daily;

  Generation({this.dailyTotal, this.monthly, this.weekly, this.daily});

  factory Generation.fromFirestore(List<DocumentSnapshot> doc) {
    var now = new DateTime.now();
    var date = new DateFormat('dd');
    String formattedDate = date.format(now);
    var month = new DateFormat('MMMM');
    String formattedMonth = month.format(now);

    int dailyTotal = 0;
    Map<String, int> monthly = new Map<String, int>();
    Map<String, int> weekly = new Map<String, int>();
    Map<String, int> daily = new Map<String,  int>();
    doc.forEach((element) {
      element.data.forEach((key, value) {
        if (element.documentID == formattedMonth &&
            key.toString() == formattedDate) {
          dailyTotal = int.parse(value["total_day"].toString());
          value.forEach((key1, value1) {
            if (key1 != "total_day") {
              daily[key1] = int.parse(value1);
            }
          });
        }
      });

      monthly[element.documentID] = element.data["total_month"];
    });
    var room = Generation(
      dailyTotal: dailyTotal,
      daily: daily,
      monthly: monthly,
    );
    return room;
  }
}
