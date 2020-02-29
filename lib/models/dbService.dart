import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smarty/models/devicesModel.dart';
import 'package:smarty/models/user.dart';
import 'package:smarty/models/user.dart';
import 'package:smarty/services/auth.dart';

import 'roomModel.dart';

class DatabaseService1 {
  final Firestore _db = Firestore.instance;

  Stream<List<Room>> streamRooms(User user) {
    var ref = _db.collection('Homes').document("123").collection("1");
    return ref.snapshots().map(CreateRoomList);
  }

  List<Room> CreateRoomList(QuerySnapshot data) {
    return data.documents.map((doc) {
      return Room.fromFirestore(doc);
    }).toList();
  }

  Stream<List<Device>> streamDevices(User user) {
    var ref = _db.collection('Homes').document("123").collection("1");
    return ref.snapshots().map(CreateDeviceList);
  }

  List<Device> CreateDeviceList(QuerySnapshot data) {
    List<Device> x = [];
//    print();
    data.documents.map((doc) {
      print("help me");
      Map data1 = doc.data;
      data1.forEach((key, value) {
        x.add(Device.fromFirestore(key, value, doc.documentID));
      });
    });
    return x;
  }
}
