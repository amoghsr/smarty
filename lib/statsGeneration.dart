import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    Generation(),
  );
}

class Generation extends StatelessWidget {

  int averageDayData(AsyncSnapshot<QuerySnapshot> snapshot, int month, String date) {
    Map<String, int> hours = hourlyData(snapshot, month, date);
    double sum = 0;
    hours.forEach((s, i) => sum += i);
    double avg = sum/hours.length;
    return avg.round();
  }

  int monthData(AsyncSnapshot<QuerySnapshot> snapshot, int month, int noOfDays) {
    List<int> days = new List<int>(noOfDays);
    double sum = 0;
    for(int i = 1; i<=noOfDays; i++) {
      days[i-1] = averageDayData(snapshot, month, i.toString());
    }
    days.forEach((i) => sum += i);
    double avg = sum/days.length;
    return avg.round();
  }
  
  List<int> weekData(AsyncSnapshot<QuerySnapshot> snapshot, int month, String startdate) {    
    List<int> week = new List<int>(7);
    for(int i = int.parse(startdate); i<int.parse(startdate)+7; i++) {
      week[i-1] = averageDayData(snapshot, month, i.toString());
    }
    return week;
  }
  
  Map<String, int> hourlyData(AsyncSnapshot<QuerySnapshot> snapshot, int month, String date) {
    return new Map<String, int>.from(snapshot.data.documents[month][date]);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Firestore.instance.collection('consumed_energy').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if(snapshot.data == null) return CircularProgressIndicator();
        return Center(
          child: new Container(
              child: Text(
                monthData(snapshot, 5, 31).toString(),
                textAlign: TextAlign.center,
                textDirection: TextDirection.ltr,
              ),
            ),
        );
      }
    );
  }
}