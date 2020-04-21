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
        'https://images.pexels.com/photos/1239291/pexels-photo-1239291.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260',
    'userName': 'Sarah Hue',
  },
  '2': {
    'userImage':
        'https://images.pexels.com/photos/736716/pexels-photo-736716.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260',
    'userName': 'Xavier Gordon',
  },
  '3': {
    'userImage':
        'https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260',
    'userName': 'Damian Brown',
  },
  '4': {
    'userImage':
        'https://images.pexels.com/photos/1181686/pexels-photo-1181686.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260',
    'userName': 'Maddison Smith',
  },
  '5': {
    'userImage':
        'https://images.pexels.com/photos/2380795/pexels-photo-2380795.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260',
    'userName': 'Chris Patrick',
  }
};
