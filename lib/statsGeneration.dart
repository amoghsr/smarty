/*
This file creates the various averages needed for statistics. It receives data
from the Firestore database and returns averageDayData, monthData, weekData and hourlyData.
 */

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    Generation2(),
  );
}

class Generation2 extends StatelessWidget {
  // Returns the average generation data in a day.
  int averageDayData(
      AsyncSnapshot<QuerySnapshot> snapshot, int month, String date) {
    Map<String, int> hours = hourlyData(snapshot, month, date);
    double sum = 0;
    hours.forEach((s, i) => sum += i);
    double avg = sum / hours.length;
    return avg.round();
  }

  // Returns the average generation data in a month. It takes in the snapshot, month and the noOfDays in that month.
  int monthData(
      AsyncSnapshot<QuerySnapshot> snapshot, int month, int noOfDays) {
    List<int> days = new List<int>(noOfDays);
    double sum = 0;
    for (int i = 1; i <= noOfDays; i++) {
      days[i - 1] = averageDayData(snapshot, month, i.toString());
    }
    days.forEach((i) => sum += i);
    double avg = sum / days.length;
    return avg.round();
  }

  // Returns the average generation data in a week. It takes in the snapshot, month and the startdate in that week.
  List<int> weekData(
      AsyncSnapshot<QuerySnapshot> snapshot, int month, String startdate) {
    List<int> week = new List<int>(7);
    for (int i = int.parse(startdate); i < int.parse(startdate) + 7; i++) {
      week[i - 1] = averageDayData(snapshot, month, i.toString());
    }
    return week;
  }

  // Returns the average generation data in an hour.
  Map<String, int> hourlyData(
      AsyncSnapshot<QuerySnapshot> snapshot, int month, String date) {
    return new Map<String, int>.from(snapshot.data.documents[month][date]);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(

        // Creating a stream for the collection 'consumed_energy' in Firestore. StreamBuilder requires this.
        stream: Firestore.instance.collection('consumed_energy').snapshots(),

        // Build based on the stream
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          // To show a CircularProgressIndicator as the content loads.
          if (snapshot.data == null) return CircularProgressIndicator();

          // Return a text box containing monthData in the center.
          return Center(
            child: new Container(
              child: Text(
                monthData(snapshot, 5, 31).toString(),
                textAlign: TextAlign.center,
                textDirection: TextDirection.ltr,
              ),
            ),
          );
        });
  }
}
