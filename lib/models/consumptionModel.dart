import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class Consumption {
  int dailyTotal = 0;
  Map<String, int> monthly = new Map<String, int>();
  Map<String, int> weekly = new Map<String, int>();
  Map<String, int> daily = new Map<String, int>();
  Map<String, Map<String, int>> devicesDaily =
      new Map<String, Map<String, int>>();
    
  Consumption({this.dailyTotal, this.monthly, this.weekly, this.daily, this.devicesDaily});

  factory Consumption.fromFirestore(List<DocumentSnapshot> doc) {
    var now = new DateTime.now();
    var date = new DateFormat('dd');
    String formattedDate = date.format(now);
    var month = new DateFormat('MMMM');
    String formattedMonth = month.format(now);

    int dailyTotal = 0;
    Map<String, int> monthly = new Map<String, int>();
    Map<String, int> weekly = new Map<String, int>();
    Map<String, int> daily = new Map<String, int>();
    doc.forEach((element) {
      element.data.forEach((key, value) {
        if (element.documentID == formattedMonth &&
            key.toString() == formattedDate) {
          dailyTotal = int.parse(value["total_day"].toString());
          value.forEach((key1, value1) {
            if (key1.toString() != "total_day") {
              daily[key1.toString()] = value1;
            }
          });
        }
      });
      monthly[element.documentID] = element.data["total_month"];
    });
    var room = Consumption(
      dailyTotal: dailyTotal,
      daily: daily,
      monthly: monthly,
      weekly: new Map<String, int>(),
    );
    return room;
  }
}
