import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:smarty/devicesModel.dart';
import 'package:smarty/line_chart.dart';
import 'package:smarty/roomModel.dart';
import 'constants.dart';
import 'routineModel.dart';

class MyOtherRoom extends StatefulWidget {
  @override
  _MyOtherRoomState createState() => _MyOtherRoomState();
}

List<Tab> tabList = [
  Tab(text: rooms[0].roomName, icon: rooms[0].icon),
  Tab(text: rooms[1].roomName, icon: rooms[1].icon),
  Tab(text: rooms[2].roomName, icon: rooms[2].icon),
  Tab(text: rooms[3].roomName, icon: rooms[3].icon),
  Tab(text: rooms[4].roomName, icon: rooms[4].icon),
];

List<Text> getDevices(List<String> gDv) {
  List<Text> dv = [];

  for (var i in gDv) {
    dv.add(Text(i));
  }

  return dv;
}

String rmName = tabList[0].text;

class _MyOtherRoomState extends State<MyOtherRoom> {
  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          rmName,
          style: kAppBarTextStyle,
        ),
      ),
      drawer: Drawer(),
      body: Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: Container(
          child: DefaultTabController(
            length: 5,
            child: Column(
              children: <Widget>[
                TabBar(
                  isScrollable: true,
                  labelColor: Theme.of(context).accentColor,
                  unselectedLabelColor: Theme.of(context).backgroundColor,
                  indicatorColor: Colors.transparent,
                  indicatorSize: TabBarIndicatorSize.tab,
                  tabs: tabList,
                  onTap: (value) {
                    setState(() {
                      rmName = tabList[value].text;
                    });
                  },
                ),
                Column(
                  children: <Widget>[
                    Container(
                      height: screenheight * 0.4,
                      width: screenwidth,
                      margin: EdgeInsets.only(left: 10, right: 10),
                      color: Colors.red,
                    ),
                    Container(
                      height: screenheight * 0.35,
                      width: screenwidth,
                      child: TabBarView(
                        children: [
                          Column(children: getDevices(rooms[0].d)),
                          Column(children: getDevices(rooms[1].d)),
                          Column(children: getDevices(rooms[2].d)),
                          Column(children: getDevices(rooms[3].d)),
                          Column(children: getDevices(rooms[4].d)),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
