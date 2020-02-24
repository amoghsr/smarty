import 'package:flutter/cupertino.dart';

class Leaderboard {
  String userImage;
  String userName;
  int points;

  Leaderboard({this.userImage, this.userName, this.points});
}

List<Leaderboard> streakLeaderboard = [
  Leaderboard(
    userImage:
        'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcSIKUqNEbwpxA_cEgMyUwUwqqiTXyNhx7m5WkXpk-ONJUrbqvtq',
    userName: 'Ben James',
    points: 7,
  ),
  Leaderboard(
    userImage:
        'https://i.kym-cdn.com/entries/icons/mobile/000/026/618/ZEBxqIA.jpg',
    userName: 'John Doe',
    points: 5,
  ),
  Leaderboard(
    userImage:
        'https://pbs.twimg.com/media/EOI2sKJX4AEyPBu.jpg',
    userName: 'Peter Smith',
    points: 12,
  ),
  Leaderboard(
    userImage:
        'https://i.pinimg.com/564x/88/fa/b7/88fab7fd12ecd9c4b165922feac2b354.jpg',
    userName: 'Paul Thomas',
    points: 10,
  ),
  Leaderboard(
    userImage:
        'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcTof7WdVPFlOR4-geyXhqsnIL5fumPnZs5LHWKJ9vdv-IuUOyYr',
    userName: 'Stacy Jones',
    points: 11,
  ),
];

List<Leaderboard> dailySavingsLeaderboard = [
  Leaderboard(
    userImage:
        'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcSIKUqNEbwpxA_cEgMyUwUwqqiTXyNhx7m5WkXpk-ONJUrbqvtq',
    userName: 'Ben James',
    points: 1,
  ),
  Leaderboard(
    userImage:
        'https://i.kym-cdn.com/entries/icons/mobile/000/026/618/ZEBxqIA.jpg',
    userName: 'John Doe',
    points: 31,
  ),
  Leaderboard(
    userImage:
        'https://pbs.twimg.com/media/EOI2sKJX4AEyPBu.jpg',
    userName: 'Peter Smith',
    points: 10,
  ),
  Leaderboard(
    userImage:
        'https://i.pinimg.com/564x/88/fa/b7/88fab7fd12ecd9c4b165922feac2b354.jpg',
    userName: 'Paul Thomas',
    points: 5,
  ),
  Leaderboard(
    userImage:
        'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcTof7WdVPFlOR4-geyXhqsnIL5fumPnZs5LHWKJ9vdv-IuUOyYr',
    userName: 'Stacy Jones',
    points: 40,
  ),
];

