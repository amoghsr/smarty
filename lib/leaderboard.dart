import 'package:flutter/material.dart';

import 'constants.dart';

class Leaderboard extends StatefulWidget {
  @override
  _LeaderboardState createState() => _LeaderboardState();
}

class _LeaderboardState extends State<Leaderboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Leaderboard',
          style: kAppBarTextStyle,
        ),
      ),
      drawer: Drawer(),
      body: SafeArea(
        child: ListView(
        ),
      ),
    );
  }
}
