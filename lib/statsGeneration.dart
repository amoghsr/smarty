import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    Generation(),
  );
}



class Generation extends StatelessWidget {

  void weekData(AsyncSnapshot<QuerySnapshot> snapshot, int month, String date) {

    for(int i = int.parse(date); i<int.parse(date)+7; i++) {
      averageDayData(snapshot, month, i.toString());
    }
  }
  
  Map<String, int> hourlyData(AsyncSnapshot<QuerySnapshot> snapshot, int month, String date) {
    return new Map<String, int>.from(snapshot.data.documents[month][date]);
  }

  int averageDayData(AsyncSnapshot<QuerySnapshot> snapshot, int month, String date) {
    Map<String, int> hours = hourlyData(snapshot, month, date);
    double sum = 0;
    hours.forEach((s, i) => sum += i);
    double avg = sum/hours.length;
    return avg.round();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Firestore.instance.collection('consumed_energy').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        return new Container(
            child: Text(
              averageDayData(snapshot, 0, '1').toString(),
              textAlign: TextAlign.center,
              textDirection: TextDirection.ltr,
            ),
          );
      }
    );
  }
}