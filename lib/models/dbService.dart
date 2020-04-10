import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:smarty/models/devicesModel.dart';
import 'package:smarty/models/user.dart';
import 'roomModel.dart';
import 'package:async/async.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:smarty/models/user.dart';
import 'package:smarty/services/database.dart';
import 'package:firebase_core/firebase_core.dart';

class DatabaseService1 {
  final Firestore _db = Firestore.instance;

  Stream<List<Room>> streamRooms(User user) {
    var ref =
        _db.collection('Homes').document(user.houseId).collection(user.uid);
    return ref.snapshots().map(CreateRoomList);
  }

  Stream<List<String>> streamHomiIDs() {
    var data = _db.collection('Homes');
    return data.snapshots().map(IDlist);
  }

// provider all of HomeIDs
  List<String> IDlist(QuerySnapshot doc) {
    List<String> x = [];
    doc.documents.forEach((element) {
      x.add(element.documentID);
    });
    return x;
  }

  List<Room> CreateRoomList(QuerySnapshot data) {
    return data.documents.map((doc) {
      return Room.fromFirestore(doc);
    }).toList();
  }

  Stream<List<Device>> streamDevices(User user) {
    var ref =
        _db.collection('Homes').document(user.houseId).collection(user.uid);
    return ref.snapshots().map(CreateDeviceList);
  }

  List<Device> CreateDeviceList(QuerySnapshot data) {
    List<Device> x = [];
    data.documents.forEach((element) {
      element.data.forEach((key, value) {
        x.add(Device.fromFirestore(key, value, element.documentID));
      });
    });
    return x;
  }

  Stream<DocumentSnapshot> getUserDetails(String uid) {
    return _db.collection("UserData").document(uid).get().asStream();
  }
}
