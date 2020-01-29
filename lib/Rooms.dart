import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:smarty/line_chart.dart';

import 'constants.dart';
import 'routineModel.dart';

class MyOtherRoom extends StatefulWidget {
  @override
  _MyOtherRoomState createState() => _MyOtherRoomState();
}

class _MyOtherRoomState extends State<MyOtherRoom> {
  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'MyOtherRoom',
          style: kAppBarTextStyle,
        ),
      ),
      drawer: Drawer(),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          color: Theme.of(context).scaffoldBackgroundColor,
          child: Column(
            children: <Widget>[
              DefaultTabController(
                length: 5,
                child: Column(
                  children: <Widget>[
                    Container(
                      height: screenheight * 0.13,
                      child: TabBar(
                        isScrollable: true,
                        labelColor: Theme.of(context).accentColor,
                        unselectedLabelColor: Theme.of(context).backgroundColor,
                        indicatorColor: Colors.transparent,
                        indicatorSize: TabBarIndicatorSize.tab,
                        tabs: [
                          Tab(
                            child: Column(
                              children: <Widget>[
                                Icon(FontAwesomeIcons.couch),
                                Text('Living Room'),
                              ],
                            ),
                          ),
                          Tab(
                            child: Column(
                              children: <Widget>[
                                Icon(FontAwesomeIcons.utensils),
                                Text(
                                  'Kitchen',
                                  // style: TextStyle(color: Theme.of(context).cardColor)
                                ),
                              ],
                            ),
                          ),
                          Tab(
                            child: Column(
                              children: <Widget>[
                                Icon(FontAwesome.bed),
                                Text(
                                  'Bedroom',
                                  // style: TextStyle(color: Theme.of(context).cardColor),
                                ),
                              ],
                            ),
                          ),
                          Tab(
                            child: Column(
                              children: <Widget>[
                                Icon(FontAwesome.child),
                                Text(
                                  'Playroom',
                                  // style: TextStyle(color: Theme.of(context).cardColor),
                                ),
                              ],
                            ),
                          ),
                          Tab(
                            child: Column(
                              children: <Widget>[
                                Icon(FontAwesome.bathtub),
                                Text(
                                  'Bathroom',
                                  // style: TextStyle(color: Theme.of(context).cardColor)
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
