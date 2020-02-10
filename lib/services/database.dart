import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String uid;

  DatabaseService({this.uid});

  // collection reference
  final CollectionReference userDataCollection =
      Firestore.instance.collection('UserData');

  Future<void> updateUserData(
      String ageGroup, String name, String juice) async {
    return await userDataCollection.document(uid).setData({
      'name': name,
      'age_group': ageGroup,
      'juice': juice,
    });
  }

  // get brews stream
  Stream<QuerySnapshot> get userData {
    return userDataCollection.snapshots();
  }
}
