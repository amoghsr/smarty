import 'package:smarty/models/dbService.dart';

class LeaderboardModel {
  String userImage;
  String userName; //house id
  int points; //house current day consumption

  LeaderboardModel({this.userImage, this.userName, this.points});
  factory LeaderboardModel.fromFirestore(String key, int value) {
    print("debug4");
    var z = LeaderboardModel(
      userImage:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcSIKUqNEbwpxA_cEgMyUwUwqqiTXyNhx7m5WkXpk-ONJUrbqvtq',
      userName: "House No " + key,
      points: value * 40,
    );
    return z;
  }
}

//  DAILY LIMIT IS 9 KwH X NUMBER OF USERS PER THAT HOUSE
//  ONLY SHOW UP IF THE DAILY CONSUMPTION THAT USER < DAILY LIMIT
//  (DAILY LIMIT - CONSUMPTION)/DAILY LIMIT) * 100% = DAILY SAVINGS
//List<LeaderboardModel> dailySavingsLeaderboard = [
//  LeaderboardModel(
//    userImage:
//        'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcSIKUqNEbwpxA_cEgMyUwUwqqiTXyNhx7m5WkXpk-ONJUrbqvtq',
//    userName: 'Ben James',
//    points: 1,
//  ),
//  LeaderboardModel(
//    userImage:
//        'https://i.kym-cdn.com/entries/icons/mobile/000/026/618/ZEBxqIA.jpg',
//    userName: 'John Doe',
//    points: 31,
//  ),
//  LeaderboardModel(
//    userImage: 'https://pbs.twimg.com/media/EOI2sKJX4AEyPBu.jpg',
//    userName: 'Peter Smith',
//    points: 10,
//  ),
//  LeaderboardModel(
//    userImage:
//        'https://i.pinimg.com/564x/88/fa/b7/88fab7fd12ecd9c4b165922feac2b354.jpg',
//    userName: 'Paul Thomas',
//    points: 5,
//  ),
//  LeaderboardModel(
//    userImage:
//        'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcTof7WdVPFlOR4-geyXhqsnIL5fumPnZs5LHWKJ9vdv-IuUOyYr',
//    userName: 'Stacy Jones',
//    points: 40,
//  ),
//];
//
List<LeaderboardModel> streakLeaderboard = [
  LeaderboardModel(
    userImage:
        'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcSIKUqNEbwpxA_cEgMyUwUwqqiTXyNhx7m5WkXpk-ONJUrbqvtq',
    userName: 'Ben James',
    points: 7,
  ),
  LeaderboardModel(
    userImage:
        'https://i.kym-cdn.com/entries/icons/mobile/000/026/618/ZEBxqIA.jpg',
    userName: 'John Doe',
    points: 5,
  ),
  LeaderboardModel(
    userImage: 'https://pbs.twimg.com/media/EOI2sKJX4AEyPBu.jpg',
    userName: 'Peter Smith',
    points: 12,
  ),
  LeaderboardModel(
    userImage:
        'https://i.pinimg.com/564x/88/fa/b7/88fab7fd12ecd9c4b165922feac2b354.jpg',
    userName: 'Paul Thomas',
    points: 10,
  ),
  LeaderboardModel(
    userImage:
        'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcTof7WdVPFlOR4-geyXhqsnIL5fumPnZs5LHWKJ9vdv-IuUOyYr',
    userName: 'Stacy Jones',
    points: 11,
  ),
];
