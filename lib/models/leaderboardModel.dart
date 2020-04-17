class Leaderboard {
  String userImage;
  String userName;
  int points;

  Leaderboard({this.userImage, this.userName, this.points});
}

// TODO: STORE THE USER NAME, IMAGE AND DAILY CONSUMPTION PER HOUSE
// TODO: DISPLAY THE DAILY SAVINGS USING THE DAILY CONSUMPTION VALUE, BASED ON THE FORMULA BELOW
// TODO: DAILY LIMIT IS 9 KwH X NUMBER OF USERS PER THAT HOUSE
// TODO: ONLY SHOW UP IF THE DAILY CONSUMPTION THAT USER < DAILY LIMIT
// TODO: (DAILY LIMIT - CONSUMPTION)/DAILY LIMIT) * 100% = DAILY SAVINGS
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
    userImage: 'https://pbs.twimg.com/media/EOI2sKJX4AEyPBu.jpg',
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

// TODO: STORE THE USER NAME, IMAGE AND DAILY STREAK COUNT (BASED ON COUNTER IF CONSUMPTION < DAILY LIMIT FOR A DAY) PER HOUSE
// TODO: IF USER STAYED UNDER THE DAILY LIMIT FOR 3 DAYS CONSECUTIVELY, A DAILY STREAK IS STARTED (AS 3) AND INCREASES ACCORDINGLY
// TODO: IF USER'S DAILY CONSUMPTION > DAILY LIMIT, STREAK RESETS TO 0 AND IS TAKEN OFF BOTH LEADERBOARDS
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
    userImage: 'https://pbs.twimg.com/media/EOI2sKJX4AEyPBu.jpg',
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
