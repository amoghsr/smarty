//import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:smarty/models/user.dart';
import 'auth.dart';

class DatabaseService {
  final String uid;

  DatabaseService({this.uid});

  // collection reference
  final CollectionReference homeDataCollection =
      Firestore.instance.collection('HouseID');
  final Firestore userDataCollection = Firestore.instance;

  Future<void> updateUserData(
      String displayName, String homeId, String email) async {
    homeDataCollection
        .document(homeId)
        .collection(uid)
        .document('Living Room Test')
        .setData({
      'userID': uid,
    });
    return await userDataCollection.document(uid).setData({
      'displayName': displayName,
      'homeId': homeId,
      'email': email,
    });
  }

  Stream<User> get userData {
    Stream<User> stream = AuthService().user;
    String uidd;
    stream.listen((data) {
      uidd = data.uid;
      return userDataCollection
          .collection("UserData")
          .document(uidd)
          .snapshots()
          .map((snap) => User.fromMap(snap.data, uidd));
    });
  }
}
