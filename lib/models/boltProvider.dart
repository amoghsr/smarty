import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

//Map<Hid,boltProvider>
class BoltProvider with ChangeNotifier {
  double _balance;
  String houseID;
  BoltProvider(this._balance, this.houseID);
  getBalance() => _balance;
  getBalanceAsInt() => _balance.toInt();
  setBalance(double balance) {
    FirebaseDatabase.instance
        .reference()
        .child("Points/" + houseID + "/")
        .update({"Bolts": balance.toInt()});
  }

  notifyListeners();
}
