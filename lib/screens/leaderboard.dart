import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smarty/models/pointsProvider.dart';
import 'package:smarty/screens/drawer.dart';
import 'package:smarty/shared/constants.dart';
import 'package:smarty/widgets/voiceAgent.dart';

import 'leaderboardData.dart';

class Leaderboard extends StatefulWidget {
  @override
  _LeaderboardState createState() => _LeaderboardState();
}

class _LeaderboardState extends State<Leaderboard> {
  @override
    void initState() {
    super.initState();
    // if (Provider.of<BoltProvider>(context, listen: false).getBalanceAsInt() == 10)
    //   Timer.run(
    //       () => Provider.of<DialogProvider>(context, listen: false).popAi());
  }
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;
    return Scaffold(
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
                actions: <Widget>[MicClass()],
                bottom: TabBar(
//                  labelPadding: EdgeInsets.only(left: 40, right: 40, top: 5),
                  isScrollable: true,
                  labelColor: Theme.of(context).accentColor,
                  unselectedLabelColor: Theme.of(context).disabledColor,
                  indicatorColor: Colors.transparent,
                  indicatorSize: TabBarIndicatorSize.tab,
                  tabs: [
                    Container(
                      width: screenwidth * 0.4,
                      child: Tab(
                        text: "DAILY SAVINGS",
                      ),
                    ),
                    Container(
                      width: screenwidth * 0.4,
                      child: Tab(
                        text: "DAILY STREAK",
                      ),
                    ),
                  ],
                ),
              ),
            ];
          },
          body: GestureDetector(
            onVerticalDragUpdate: (_) {},
            child: Container(
//              height: screenheight * 0.8,
              width: screenwidth,
              child: TabBarView(
                physics: NeverScrollableScrollPhysics(),
                children: [
                  LeaderboardData(leaderboardType: 'DAILY SAVINGS'),
                  LeaderboardData(leaderboardType: 'DAILY STREAK'),
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
