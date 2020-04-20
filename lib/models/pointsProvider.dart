import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

//Map<Hid,PointsProvider>
class PointsProvider {
  String houseID;
  num balance;
  num currentDay;
  List<dynamic> donationBadges;

  PointsProvider(
      {this.houseID, this.balance, this.currentDay, this.donationBadges});

  factory PointsProvider.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data;
    var points = PointsProvider(
        houseID: doc.documentID,
        balance: data[doc.documentID]['Bolts'],
        currentDay: data[doc.documentID]['CurrentDay'],
        donationBadges: data[doc.documentID]['DonationBadges']);
    return points;
  }
  getBalance() => balance.toDouble();
  getBalanceAsInt() => balance.toInt();
  setBalance(String hID, double _balance) {
    FirebaseDatabase.instance
        .reference()
        .child("Points/" + hID + "/")
        .update({"Bolts": _balance.toInt()});
  }
}
