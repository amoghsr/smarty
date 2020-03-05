import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:smarty/models/roomModel.dart';
import 'package:smarty/models/user.dart';
import 'package:smarty/shared/constants.dart';
import '../energyData.dart';
import 'package:smarty/screens/drawer.dart';

class Statistics extends StatefulWidget {
  @override
  _StatisticsState createState() => _StatisticsState();
}

class _StatisticsState extends State<Statistics> {
  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(
      //     'Statistics',
      //     style: kAppBarTextStyle,
      //   ),
      // ),
      drawer: DrawerPage(),
      body: DefaultTabController(
        length: 2,
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxisScrolled) {
            return <Widget>[
              SliverAppBar(
                pinned: true,
                floating: false,
                title: Text(
                  'Statistics',
                  style: kAppBarTextStyle,
                ),
                bottom: TabBar(
                  labelPadding: EdgeInsets.only(left: 50, right: 50, top: 5),
                  isScrollable: true,
                  labelColor: Theme.of(context).accentColor,
                  unselectedLabelColor: Theme.of(context).backgroundColor,
                  indicatorColor: Colors.transparent,
                  indicatorSize: TabBarIndicatorSize.tab,
                  tabs: [
                    Tab(
                      text: "Generation",
                      icon: Container(
                          width: screenwidth * 0.03,
                          child: Icon(FontAwesomeIcons.solarPanel)),
                    ),
                    Tab(
                      text: "Consumption",
                      icon: Icon(FontAwesomeIcons.plug),
                    ),
                  ], //tabs
                ),
              ),
            ];
          },
          body: Container(
            height: screenheight,
            width: screenwidth,
            child: TabBarView(
              physics: NeverScrollableScrollPhysics(),
              children: [
                EnergyStats(energyType: 'Generation'),
                EnergyStats(energyType: 'Consumption'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
