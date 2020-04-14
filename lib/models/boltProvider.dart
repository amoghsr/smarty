import 'package:flutter/material.dart';

class BoltProvider with ChangeNotifier {
  double _balance;

  BoltProvider(this._balance);

  getBalance() => _balance;
  getBalanceAsInt() => _balance.toInt();
  setBalance(double balance) => _balance = balance;
}