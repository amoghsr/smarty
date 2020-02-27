import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:smarty/screens/Drawer.dart';
import 'package:smarty/shared/constants.dart';

import 'leaderboardData.dart';


class Leaderboard extends StatefulWidget {
  @override
  _LeaderboardState createState() => _LeaderboardState();
}

class _LeaderboardState extends State<Leaderboard> {
  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Leaderboard',
          style: kAppBarTextStyle,
        ),
      ),
      drawer: DrawerPage(),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        // padding: EdgeInsets.only(bottom: 0),
        // physics: BouncingScrollPhysics(),
        child: Center(
          child: Container(
            color: Theme.of(context).scaffoldBackgroundColor,
            // height: screenheight,
            child: DefaultTabController(
              length: 2,
              child: Column(
                children: <Widget>[
                  TabBar(
                    labelPadding: EdgeInsets.only(left: 40, right: 40, top: 5),
                    isScrollable: true,
                    labelColor: Theme.of(context).accentColor,
                    unselectedLabelColor: Theme.of(context).backgroundColor,
                    indicatorColor: Colors.transparent,
                    indicatorSize: TabBarIndicatorSize.tab,
                    tabs: [
                      Tab(
                        text: "DAILY STREAK",
                        // icon: Icon(FontAwesomeIcons.solarPanel),
                      ),
                      Tab(
                        text: "DAILY SAVINGS",
                        // icon: Icon(FontAwesomeIcons.plug),
                      ),
                    ],
                  ),
                  Container(
                    height: screenheight * 0.8,
                    width: screenwidth,
                    child: TabBarView(
                      physics: NeverScrollableScrollPhysics(),
                      children: [
                        LeaderboardData(leaderboardType: 'DAILY STREAK'),
                        LeaderboardData(leaderboardType: 'DAILY SAVINGS'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
