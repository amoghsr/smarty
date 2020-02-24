import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:smarty/models/user.dart';
import 'package:smarty/models/user.dart';
import 'package:smarty/services/auth.dart';

import 'roomModel.dart';

class DatabaseService1 {
  final Firestore _db = Firestore.instance;
  Stream<List<Room>> streamRooms(User user) {
    var ref = _db.collection('Homes').document("123").collection("1");
    return ref.snapshots().map(CreateList);
  }

  List<Room> CreateList(QuerySnapshot data) {
    return data.documents.map((doc) {
      return Room.fromFirestore(doc);
    }).toList();
  }
}
