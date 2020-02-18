import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String uid;

  DatabaseService({this.uid});

  // collection reference
  final CollectionReference homeDataCollection =
      Firestore.instance.collection('HouseID');
  final CollectionReference userDataCollection =
      Firestore.instance.collection('UserData');

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
}
