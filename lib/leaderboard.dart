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
          padding: EdgeInsets.symmetric(vertical: 60.0),
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Congratulations!',
                      style: TextStyle(
                        fontSize: 30.0,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Opacity(
                      opacity: 0.5,
                      child: Text(
                        'You have saved the most energy in the last week. Keep it up!',
                        style: TextStyle(
                          fontSize: 11.0,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 60,
                    ),
                  ],
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  height: 150,
                  width: 320,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    color: Colors.lightGreen,
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(14.0),
                    child: Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text('You Saved:'),
                                Text(
                                  '80 KWh',
                                  style: TextStyle(
                                      fontSize: 30.0,
                                      fontWeight: FontWeight.w700),
                                ),
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
