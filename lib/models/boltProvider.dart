import 'package:flutter/material.dart';

class BoltProvider with ChangeNotifier {
  double _balance;

  BoltProvider(this._balance);

  //TODO: Store bolts balance(user's ecash) house ID wise
//confirmation
  getBalance() => _balance;
  getBalanceAsInt() => _balance.toInt();
  setBalance(double balance) {
    _balance = balance;
    notifyListeners();
  }
}
