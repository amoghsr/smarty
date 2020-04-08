class User {
  final String uid;
  final String houseId;
  final String type;

  User({this.uid, this.houseId, this.type});

//  factory User.fromMap(Map data, String id) {
//    var w = User(
//      uid: id,
//      houseId: data['homeId'] ?? '',
//    );
//    //  print(w.houseId);
//    //  print(w.uid);
//    return w;
//  }

  factory User.initialData() {
    return User(
      uid: '',
      houseId: '',
//      type: '',
    );
  }
}
