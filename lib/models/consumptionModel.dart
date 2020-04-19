import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:smarty/models/devicesModel.dart';

class Consumption {
  int dailyTotal;
  Map<String, int> monthly;
  Map<String, int> weekly;
  Map<String, int> daily;
  Map<String, Map<String, double>> devicesDaily;

  Consumption(
      {this.dailyTotal,
      this.monthly,
      this.weekly,
      this.daily,
      this.devicesDaily});

  factory Consumption.fromFirestore(List<DocumentSnapshot> doc) {
    var now = new DateTime.now();
    var date = new DateFormat('dd');
    String formattedDate = date.format(now);
    var month = new DateFormat('MMMM');
    String formattedMonth = month.format(now);

    int dailyTotal = 0;
    Map<String, Map<String, double>> devicesDaily =
        new Map<String, Map<String, double>>();
    Map<String, int> monthly = new Map<String, int>();
    Map<String, int> weekly = new Map<String, int>();
    Map<String, int> daily = new Map<String, int>();
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
    Map<String, double> Devicess;
    doc.forEach((element) {
      Devicess = new Map<String, double>();
      element.data.forEach((key, value) {
        if (element.documentID == "Total_House_Daily") {
          monthly[key] = value["Monthly_Total"];
          value.forEach((key1, value1) {
            if (key == formattedMonth && key1.toString() == formattedDate) {
              value1.forEach((key2, value2) {
                if (key2 != "Daily_Total") {
                  daily[key2.toString()] = value2;
                } else {
                  dailyTotal = value2;
                  weekly[key1] = value2;
                }
              });
            }
            if (awd.values.contains(key) && awd.containsKey(key1)) {
              value1.forEach((key2, value2) {
                if (key2.toString() == "Daily_Total") {
                  weekly[key1] = value2;
                }
              });
            }
          });
        } else {
          value.forEach((key1, value1) {
            Devicess[key] = num.parse(
                value1[formattedDate]["Total_Daily"].toStringAsFixed(2));
          });
        }
      });
      if (element.documentID != "Total_House_Daily") {
        devicesDaily[element.documentID] = Devicess;
      }
    });
    var room = Consumption(
      dailyTotal: dailyTotal,
      daily: daily,
      monthly: monthly,
      weekly: weekly,
      devicesDaily: devicesDaily,
    );
    return room;
  }
}
