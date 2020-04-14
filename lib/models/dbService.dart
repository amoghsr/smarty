import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:smarty/models/devicesModel.dart';
import 'package:smarty/models/user.dart';
import 'roomModel.dart';

class DatabaseService1 {
  final Firestore _db = Firestore.instance;

  Stream<List<String>> StreamUserlist(String houseId) {
    CollectionReference ref =
        _db.collection('UserData').document("house").collection(houseId);
    return ref.snapshots().map(Userlist);
  }

  List<String> Userlist(QuerySnapshot doc) {
    List<String> x = [];
    doc.documents.forEach((element) {
      x.add(element["displayName"] + "-" + element["email"]);
    });
    return x;
  }

  Stream<List<Room>> streamRooms(User user) {
    var ref =
        _db.collection('Homes').document(user.houseId).collection(user.uid);
    return ref.snapshots().map(CreateRoomList);
  }

  Stream<List<int>> streamHomiIDs() {
    var data = _db.collection('Homes');
    return data.snapshots().map(IDlist);
  }

// provider all of HomeIDs
  List<int> IDlist(QuerySnapshot doc) {
    List<int> x = [];
    doc.documents.forEach((element) {
      x.add(int.parse(element.documentID));
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

  Stream<DocumentSnapshot> getUserDetails(String uid, User user) {
    return Firestore.instance
        .collection("UserData")
        .document("house")
        .collection(user.houseId)
        .document(user.uid)
        .snapshots();
  }
}
