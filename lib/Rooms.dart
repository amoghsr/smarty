import 'package:flutter/material.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import 'package:smarty/devicesModel.dart';
import 'package:smarty/roomModel.dart';
import 'constants.dart';
import 'package:smarty/devices_controller.dart';

List<Tab> tabList = [
  Tab(text: rooms[0].roomName, icon: rooms[0].icon),
  Tab(text: rooms[1].roomName, icon: rooms[1].icon),
  Tab(text: rooms[2].roomName, icon: rooms[2].icon),
  Tab(text: rooms[3].roomName, icon: rooms[3].icon),
  Tab(text: rooms[4].roomName, icon: rooms[4].icon),
];

Icon getIcons(String devIc) {
  for (var j in devices) {
    if (j.deviceName == devIc) {
      return j.icon;
    }
  }
}

Device getDevState(String roomName, String devName) {
  //bool isSwitched = true;
  for (var i in devices)
    if ((i.inRoom == roomName) && (i.deviceName == devName)) return i;
}

class MyOtherRoom extends StatefulWidget {
  @override
  int initRoom;
  MyOtherRoom({@required this.initRoom});
  _MyOtherRoomState createState() => _MyOtherRoomState();
}

// String appBarrmName = tabList[0].text;

Color bulb_color = Colors.white;
String currDevice = 'Lamp';
String currRoom = 'Living Room';
String initrmName = tabList[0].text;
String rmName = tabList[0].text;
bool isAbsorbed = false;

class _MyOtherRoomState extends State<MyOtherRoom> {
  @override
  bool isSwitched = true;
  int brightness = 60;

  void initState() {
    initrmName = tabList[widget.initRoom].text;
    rmName = tabList[widget.initRoom].text;
  }

  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          (rmName != tabList[widget.initRoom].text) ? rmName : initrmName,
          style: kAppBarTextStyle,
        ),
      ),
//      drawer: Drawer(),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          child: DefaultTabController(
            initialIndex: widget.initRoom,
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
                    SizedBox(height: screenheight * 0.02),
                    AbsorbPointer(
                        absorbing: isAbsorbed,
                        child: (isAbsorbed == true)
                            ? controllerContainer(
                                screenheight, screenwidth, 0.2)
                            : controllerContainer(
                                screenheight, screenwidth, 1)),
                    // SizedBox(height: screenheight * 0.001),
                    Container(
                      padding: EdgeInsets.only(left: 10),
                      child: Row(
                        children: <Widget>[
                          Text(
                            'Devices',
                            style: TextStyle(
                              color: Theme.of(context).accentColor,
                              fontSize: 20,
                              fontFamily: 'Montserrat',
                            ),
                            // textAlign: TextAlign.left,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: screenheight * 0.005),
                    Container(
                      height: screenheight * 0.35,
                      width: screenwidth,
                      child: TabBarView(
                        physics: NeverScrollableScrollPhysics(),
                        children: [
                          getListTile(0),
                          getListTile(1),
                          getListTile(2),
                          getListTile(3),
                          getListTile(4),
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

  Opacity controllerContainer(
      double screenheight, double screenwidth, double opc) {
    return Opacity(
      opacity: opc,
      child: Container(
        height: screenheight * 0.4,
        width: screenwidth,
        margin: EdgeInsets.only(left: 10, right: 10),
        // color: Colors.red,
        child: DevicesController(
          chDevice: currDevice,
          chRoom:
              (rmName != tabList[widget.initRoom].text) ? rmName : initrmName,
          // isDisabled: isAbsorbed,
          // toggleState: getDevState(rooms[rmName].roomName, rooms[l].d[i]).toggleSt,
        ),
      ),
    );
  }

  ListView getListTile(int l) {
    return ListView.builder(
        itemCount: rooms[l].d.length,
        itemBuilder: (context, i) {
          return Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.all(5.5),
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ListTile(
                  onTap: () => {
                    setState(() {
                      currRoom = rooms[l].roomName;
                      currDevice = rooms[l].d[i];
                    })
                  },
                  leading: getIcons(rooms[l].d[i]),
                  title: Text(rooms[l].d[i]),
                  trailing: Switch(
                    value:
                        getDevState(rooms[l].roomName, rooms[l].d[i]).toggleSt,
                    onChanged: (value) {
                      setState(() {
                        getDevState(rooms[l].roomName, rooms[l].d[i]).toggleSt =
                            value;
                        isAbsorbed =
                            !getDevState(rooms[l].roomName, rooms[l].d[i])
                                .toggleSt;
                      });
                    },
                    activeTrackColor: Theme.of(context).backgroundColor,
                    activeColor: Colors.lightGreenAccent,
                    inactiveTrackColor: Theme.of(context).backgroundColor,
                  ),
                ),
              ),
            ],
          );
        });
  }
}
