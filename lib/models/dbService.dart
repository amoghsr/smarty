import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:smarty/models/devicesModel.dart';
import 'package:smarty/models/routineModel.dart';
import 'package:smarty/models/user.dart';
import 'dbRoutines.dart';
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

//suggested
  Stream<List<dbRoutine>> getSuggestedRoutines(User user) {
    var ref = _db
        .collection('Routines')
        .document(user.houseId)
        .collection("Suggested Routines");
    return ref.snapshots().map(CreatedbRoutineList);
  }

  List<dbRoutine> CreatedbRoutineList(QuerySnapshot data) {
    List<dbRoutine> w = [];
    data.documents.forEach((element) {
      Map<String, String> x = {};
      element.data.forEach((key, value) {
        if (key != "STime" && key != "ETime") {
          x[key] = value;
        }
      });
      w.add(dbRoutine.fromFirestore(element.data["STime"],
          element.data["ETime"], element.documentID.toUpperCase(), x));
    });
    return w;
  }

//Current Routines
  Stream<List<Routine>> getCurrentRoutines(User user) {
    var ref = _db
        .collection('Routines')
        .document(user.houseId)
        .collection("Current Routines");
    return ref.snapshots().map(CreateRoutineList);
  }

  List<Routine> CreateRoutineList(QuerySnapshot data) {
    List<Routine> w = [];
    data.documents.forEach((element) {
      Map<String, String> x = {};
      element.data.forEach((key, value) {
        if (key != "STime" &&
            key != "ETime" &&
            key != "color" &&
            key != "Description" &&
            key != "logo") {
          x[key] = value;
        }
      });
      Map<dynamic, dynamic> we = element.data["logo"];
      Map<String, dynamic> wet = {};
      we.forEach((key, value) {
        wet[key.toString()] = value;
      });
      w.add(Routine.fromFirestore(
        element.data["STime"],
        element.data["ETime"],
        element.documentID,
        x,
        element.data["Description"],
        wet,
        element.data["color"],
      ));
    });
    return w;
  }
}
