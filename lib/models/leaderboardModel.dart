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
        'https://cdn.vox-cdn.com/thumbor/uoxBooQMoxZlzdt8PpRhs16SFbk=/0x0:2000x1000/1220x813/filters:focal(654x138:974x458):format(webp)/cdn.vox-cdn.com/uploads/chorus_image/image/59408999/Thanos_MCU.0.jpg',
    userName: 'Ben James',
    points: 7,
  ),
  Leaderboard(
    userImage:
        'https://www.cheatsheet.com/wp-content/uploads/2019/10/Tony-Stark-Iron-Man-1024x682.jpg',
    userName: 'John Doe',
    points: 5,
  ),
  Leaderboard(
    userImage:
        'https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/ben-affleck-at-the-justice-league-press-conference-at-the-news-photo-1582124500.jpg?crop=1.00xw:0.668xh;0,0.0239xh&resize=980:*',
    userName: 'Peter Smith',
    points: 12,
  ),
  Leaderboard(
    userImage:
        'http://ichef.bbci.co.uk/wwfeatures/wm/live/1280_720/images/live/p0/2k/p0/p02kp0gw.jpg',
    userName: 'Paul Thomas',
    points: 10,
  ),
  Leaderboard(
    userImage:
        'https://nyppagesix.files.wordpress.com/2020/01/12920-queen-elizabeth-feature.jpg?quality=90&strip=all&w=915',
    userName: 'Stacy Jones',
    points: 11,
  ),
];

List<Leaderboard> dailySavingsLeaderboard = [
  Leaderboard(
    userImage:
        'https://cdn.vox-cdn.com/thumbor/uoxBooQMoxZlzdt8PpRhs16SFbk=/0x0:2000x1000/1220x813/filters:focal(654x138:974x458):format(webp)/cdn.vox-cdn.com/uploads/chorus_image/image/59408999/Thanos_MCU.0.jpg',
    userName: 'Ben James',
    points: 1,
  ),
  Leaderboard(
    userImage:
        'https://www.cheatsheet.com/wp-content/uploads/2019/10/Tony-Stark-Iron-Man-1024x682.jpg',
    userName: 'John Doe',
    points: 31,
  ),
  Leaderboard(
    userImage:
        'https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/ben-affleck-at-the-justice-league-press-conference-at-the-news-photo-1582124500.jpg?crop=1.00xw:0.668xh;0,0.0239xh&resize=980:*',
    userName: 'Peter Smith',
    points: 10,
  ),
  Leaderboard(
    userImage:
        'http://ichef.bbci.co.uk/wwfeatures/wm/live/1280_720/images/live/p0/2k/p0/p02kp0gw.jpg',
    userName: 'Paul Thomas',
    points: 5,
  ),
  Leaderboard(
    userImage:
        'https://nyppagesix.files.wordpress.com/2020/01/12920-queen-elizabeth-feature.jpg?quality=90&strip=all&w=915',
    userName: 'Stacy Jones',
    points: 40,
  ),
];
