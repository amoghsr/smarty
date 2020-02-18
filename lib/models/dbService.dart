import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:smarty/models/user.dart';
import 'package:smarty/models/user.dart';
import 'package:smarty/services/auth.dart';

import 'roomModel.dart';

class DatabaseService1 {
  final Firestore _db = Firestore.instance;
  Stream<List<Room>> streamRooms(User user) {
    var ref =
        _db.collection('HouseID').document(user.houseId).collection(user.uid);
    return ref.snapshots().map((list) =>
        list.documents.map((snap) => Room.fromFirestore(snap)).toList());
  }
}
