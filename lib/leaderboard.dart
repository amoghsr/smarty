import 'package:flutter/material.dart';

import 'package:smarty/shared/constants.dart';

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
        child: Column(
          children: <Widget>[
//            ListTile(
//              leading: Image(
//                image: AssetImage('assets/images/shield.png'),
//              ),
//              title: Text('John Doe'),
//              subtitle: Text('Saved the most this week.'),
//            )
          ],
        ),
      ),
    );
  }
}
