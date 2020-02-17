import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String uid;

  DatabaseService({this.uid});

  // collection reference
  final CollectionReference userDataCollection =
      Firestore.instance.collection('UserData');

  Future<void> updateUserData(String displayName, String age, String email) async {
    return await userDataCollection.document(uid).setData({
      'displayName': displayName,
      'age': age,
      'email': email,
    });
  }

  Stream<QuerySnapshot> get userData {
    return userDataCollection.snapshots();
  }
}
