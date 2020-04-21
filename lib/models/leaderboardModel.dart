import 'package:smarty/models/dbService.dart';

class LeaderboardModel {
  String houseID;
  String userImage;
  String userName;
  String house; //house id
  int points; //house current day consumption
  int currDay;
  int bolts;
  List<dynamic> donationBadges;

  LeaderboardModel({
    this.houseID,
    this.userImage,
    this.userName,
    this.points,
  });
  factory LeaderboardModel.fromFirestore(String key, int value) {
    var z = LeaderboardModel(
      houseID: key,
      userImage: houseUserMap[key]['userImage'],
      userName: houseUserMap[key]['userName'],
      points: value,
    );
    return z;
  }
}


Map<String, dynamic> houseUserMap = {
  '1': {
    'userImage':
        'assets/images/Users/User1.png',
    'userName': 'Sarah Hue',
  },
  '2': {
    'userImage':
        'assets/images/Users/User2.png',
    'userName': 'Xavier Gordon',
  },
  '3': {
    'userImage':
        'assets/images/Users/User3.png',
    'userName': 'Damian Brown',
  },
  '4': {
    'userImage':
        'assets/images/Users/User4.png',
    'userName': 'Maddison Smith',
  },
  '5': {
    'userImage':
        'assets/images/Users/User5.png',
    'userName': 'Chris Patrick',
  }
};
