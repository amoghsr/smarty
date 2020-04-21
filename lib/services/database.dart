import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String uid;

  DatabaseService({this.uid});

  // collection reference
  final CollectionReference userDataCollection =
      Firestore.instance.collection('UserData');

  Future<void> updateUserData(
      String displayName, String homeId, String email) async {
    return await userDataCollection
        .document("house")
        .collection(homeId)
        .document(uid)
        .setData({
      'displayName': displayName,
      'homeId': homeId,
      'email': email,
    });
  }
}
