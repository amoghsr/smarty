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
      // appBar: AppBar(
      // title: Text(
      //   'Leaderboard',
      //   style: kAppBarTextStyle,
      // ),
      // ),
      drawer: DrawerPage(),
      body: DefaultTabController(
        length: 2,
        child: NestedScrollView(
          // scrollDirection: Axis.vertical,
          headerSliverBuilder: (BuildContext context, bool innerBoxisScrolled) {
            return <Widget>[
              SliverAppBar(
                pinned: true,
                floating: false,
                title: Text(
                  'Leaderboard',
                  style: kAppBarTextStyle,
                ),
                bottom: TabBar(
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
              ),
            ];
          },
          body: GestureDetector(
            onVerticalDragUpdate: (_) {},
            child: Container(
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
          ),
        ),
      ),
    );
  }
}

// Container(
//               height: screenheight * 0.8,
//               width: screenwidth,
//               child: TabBarView(
//                 physics: NeverScrollableScrollPhysics(),
//                 children: [
//                   LeaderboardData(leaderboardType: 'DAILY STREAK'),
//                   LeaderboardData(leaderboardType: 'DAILY SAVINGS'),
//                 ],
//               ),
//             ),

//     delegate: SliverChildListDelegate(
//       <Widget>[
//         Column(
//           mainAxisSize: MainAxisSize.min,
//           children: <Widget>[
//   TabBarView(
//     physics: NeverScrollableScrollPhysics(),
//     children: [
//       LeaderboardData(leaderboardType: 'DAILY STREAK'),
//       LeaderboardData(leaderboardType: 'DAILY SAVINGS'),
//     ],
//   ),
//     ],
//   ),
//       ],
//     ),
//   ),
// ),
