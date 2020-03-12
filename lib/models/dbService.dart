import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:smarty/models/devicesModel.dart';
import 'package:smarty/models/user.dart';

import 'roomModel.dart';

class DatabaseService1 {
  final Firestore _db = Firestore.instance;

  Stream<List<Room>> streamRooms(User user) {
    var ref = _db.collection('Homes').document("123").collection("1");
    return ref.snapshots().map(CreateRoomList);
  }

  Stream<List<String>> streamHomiIDs() {
//    List<String> x = [];
    var data = _db.collection('Homes');
    return data.snapshots().map(IDlist);
  }

//  final x = Provider.of<List<String>>.(context),
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
    var ref = _db.collection('Homes').document("123").collection("1");
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
}
