import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:smarty/models/user.dart';

import 'roomModel.dart';

class DatabaseService1 {
  final Firestore _db = Firestore.instance;

  Stream<List<Room>> streamRooms(User user) {
    var ref = _db
        .collection('homes')
        .document('123')
        .collection('123')
        .document('roomName');

    //TODO: Fix Provider
    // return ref.snapshots().map((list) => list.data.forEach((key, value) });
  }
}
