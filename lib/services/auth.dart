import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:smarty/models/user.dart';
import 'package:smarty/services/database.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseAuth _auth2 = FirebaseAuth.instance;

  Future resetPasswordEmail(String email) async {
    try {
      return await _auth.sendPasswordResetEmail(email: email);
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  // Create user obj based on Firebase user
  User _userFromFirebaseUser(FirebaseUser user) {
    String x = user.photoUrl;
    String y = x.split("-")[0];
    String w = x.split("-")[1];
    return user != null ? User(uid: user.uid, houseId: y, type: w) : null;
  }

  // Auth change user stream
  Stream<User> get user {
    return _auth.onAuthStateChanged.map(_userFromFirebaseUser);
  }

  // Sign in anon
  Future signInAnon() async {
    try {
      AuthResult result = await _auth.signInAnonymously();
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // Sign in with email and password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;
      return user;
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

//
//  Future<AuthResult> register(String email, String password, String name,
//      String homeId, String userType) async {
//    Future<AuthResult> d;
//    FirebaseApp app = await FirebaseApp.configure(
//        name: 'Secondary', options: await FirebaseApp.instance.options);
//    d = FirebaseAuth.fromApp(app)
//        .createUserWithEmailAndPassword(email: email, password: password);
//    UserUpdateInfo userUpdateInfo = UserUpdateInfo();
//    FirebaseUser user1 = await FirebaseAuth.fromApp(app).currentUser();
//    userUpdateInfo.photoUrl = homeId + userType;
//    await user1.updateProfile(userUpdateInfo);
////    print(user1.photoUrl + 'user type');
//    return d;
//  }

  moveData(String email, String uid, String hid) {
    Stream<QuerySnapshot> z = Firestore.instance
        .collection('waitingHomes')
        .document(email)
        .collection("layout")
        .getDocuments()
        .asStream();
    z.forEach((element) {
      element.documents.forEach((element) {
        element.data.forEach((key, value) {
          Firestore.instance
              .collection('Homes')
              .document(hid)
              .collection(uid)
              .document(element.documentID)
              .setData({key: value}, merge: true);
        });
      });
    });
  }

  // Register with email, password, name and age.
  Future registerWithEmailAndPassword(String email, String password,
      String name, String homeId, String userType) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      UserUpdateInfo userUpdateInfo = UserUpdateInfo();
      FirebaseUser user1 = await _auth.currentUser();
      userUpdateInfo.photoUrl = homeId + userType;

      await user1.updateProfile(userUpdateInfo);
      FirebaseUser user = result.user;
      // create a new document for the user with the uid
      await DatabaseService(uid: user.uid).updateUserData(name, homeId, email);
      moveData(email, user.uid, homeId);
      return _userFromFirebaseUser(user);
    } catch (error) {
      print(error.toString() + " this error here");
      return null;
    }
  }

  // Sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (error) {
      print(error.toString());
      return null;
    }
  }
}
