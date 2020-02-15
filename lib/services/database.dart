import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String uid;

  DatabaseService({this.uid});

  // collection reference
  final CollectionReference userDataCollection =
      Firestore.instance.collection('UserData');

  Future<void> updateUserData(String name, String age) async {
    return await userDataCollection.document(uid).setData({
      'name': name,
      'age_group': age,
    });
  }

  Stream<QuerySnapshot> get userData {
    return userDataCollection.snapshots();
  }
}
