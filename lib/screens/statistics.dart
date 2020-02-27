import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:smarty/models/roomModel.dart';
import 'package:smarty/models/user.dart';
import 'package:smarty/shared/constants.dart';
import 'package:smarty/screens/drawer.dart';

import '../energyData.dart';

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
      appBar: AppBar(
        title: Text(
          'Statistics',
          style: kAppBarTextStyle,
        ),
      ),
      drawer: DrawerPage(),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Center(
          child: Container(
            color: Theme.of(context).scaffoldBackgroundColor,
            child: DefaultTabController(
              length: 2,
              child: Column(
                children: <Widget>[
                  TabBar(
                    labelPadding: EdgeInsets.only(left: 50, right: 50, top: 5),
                    isScrollable: true,
                    labelColor: Theme.of(context).accentColor,
                    unselectedLabelColor: Theme.of(context).backgroundColor,
                    indicatorColor: Colors.transparent,
                    indicatorSize: TabBarIndicatorSize.tab,
                    tabs: [
                      Tab(
                        text: "Generation",
                        icon: Icon(FontAwesomeIcons.solarPanel),
                      ),
                      Tab(
                        text: "Consumption",
                        icon: Icon(FontAwesomeIcons.plug),
                      ),
                    ],
                  ),
                  Container(
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
