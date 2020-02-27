import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smarty/devices_controller.dart';
import 'package:smarty/models/devicesModel.dart';
import 'package:smarty/models/roomModel.dart';
import 'package:smarty/models/user.dart';
import 'package:smarty/shared/constants.dart';
import 'package:smarty/screens/drawer.dart';

//List<Tab> rlist = [
//  Tab(text: room1[0].roomName, icon: room1[0].icon),
//  Tab(text: room1[1].roomName, icon: room1[1].icon),
//  Tab(text: room1[2].roomName, icon: room1[2].icon),
//  Tab(text: room1[3].roomName, icon: room1[3].icon),
//  Tab(text: room1[4].roomName, icon: room1[4].icon),
//];

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

  _MyOtherroom1tate createState() => _MyOtherroom1tate();
}

// String appBarrmName = rlist[0].text;

Color bulbColor = Colors.white;

class _MyOtherroom1tate extends State<MyOtherRoom> {
  @override
  bool isSwitched = true;
  int brightness = 60;
  DatabaseReference itemRef;

  void initState() {
    super.initState();

    final FirebaseDatabase database = FirebaseDatabase
        .instance; //Rather then just writing FirebaseDatabase(), get the instance.
    itemRef = database.reference();
  }

  void stateChange(bool newvalue, String room, String device) {
    if (newvalue == false) {
      itemRef
          .child("room1/" + room + "/devices/" + device + "/")
          .update({'State': "off"});
    } else {
      itemRef
          .child("room1/" + room + "/devices/" + device + "/")
          .update({'State': "on"});
    }
  }

  Stream getString(String room, String device) {
    Stream x;
    final FirebaseDatabase database = FirebaseDatabase
        .instance; //Rather then just writing FirebaseDatabase(), get the instance.
    x = database
        .reference()
        .child("room1/" + room + "/" + device + "/")
        .onValue;
    return x;
  }

  String initrmName;
  String rmName;
  String currDevice;
  String currRoom;
  bool convert(String x) {
    bool w;
    if (x == "on") {
      w = true;
    } else {
      w = false;
    }
    return w;
  }

  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;
    final room1 = Provider.of<List<Room>>(context);

    List<Tab> rlist = [];
    for (var r in room1) {
      rlist.add(
        Tab(text: r.roomName, icon: r.icon),
      );
    }

    currRoom = rlist[0].text;
    currDevice = room1[0].d[0];
    initrmName = rlist[0].text;
    rmName = rlist[0].text;
    bool isAbsorbed = false;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          (rmName != rlist[widget.initRoom].text) ? rmName : initrmName,
          style: kAppBarTextStyle,
        ),
      ),
      // Drawer is the hamburger menu.
      drawer: DrawerPage(),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          child: DefaultTabController(
            initialIndex: widget.initRoom,
            length: 3,
            child: Column(
              children: <Widget>[
                TabBar(
                  isScrollable: true,
                  labelColor: Theme.of(context).accentColor,
                  unselectedLabelColor: Theme.of(context).backgroundColor,
                  indicatorColor: Colors.transparent,
                  indicatorSize: TabBarIndicatorSize.tab,
                  tabs: rlist,
                  onTap: (value) {
                    setState(() {
                      rmName = rlist[value].text;
                      currRoom = rlist[value].text;
                      currDevice = room1[value].d[0];
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
                            for (var i in room1) getListTile(room1.indexOf(i)),
                          ]
//                            getListTile(0),
//                          getListTile(1),
//                          getListTile(2),

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
    final room1 = Provider.of<List<Room>>(context);
    List<Tab> rlist = [];
    for (var r in room1) {
      rlist.add(
        Tab(text: r.roomName, icon: r.icon),
      );
    }
    return Opacity(
      opacity: opc,
      child: Container(
        height: screenheight * 0.4,
        width: screenwidth,
        margin: EdgeInsets.only(left: 10, right: 10),
        // color: Colors.red,
        child: DevicesController(
          chDevice: currDevice,
          chRoom: (rmName != rlist[widget.initRoom].text) ? rmName : initrmName,
          // isDisabled: isAbsorbed,
          // toggleState: getDevState(room1[rmName].roomName, room1[l].d[i]).toggleSt,
        ),
      ),
    );
  }

  ListView getListTile(int l) {
    final room1 = Provider.of<List<Room>>(context);
    List<Tab> rlist = [];
    for (var r in room1) {
      rlist.add(
        Tab(text: r.roomName, icon: r.icon),
      );
    }
    return ListView.builder(
        itemCount: room1.length,
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
                  onTap: () {
                    setState(() {
                      currRoom = room1[l].roomName;
                      currDevice = room1[l].d[i];
                    });
                  },
                  leading: getIcons(room1[l].d[i]),
                  title: Text(room1[l].d[i]),
                  trailing: StreamBuilder(
                    stream: itemRef
                        .child("room1/" +
                            room1[l].roomName +
                            "/devices/" +
                            room1[l].d[i] +
                            "/")
                        .onValue,
                    builder: (context, snap) {
                      Map<String, dynamic> values =
                          new Map<String, dynamic>.from(
                              snap.data.snapshot.value);
                      return Switch(
                        value: convert(values["State"]),
                        onChanged: (value) {
                          stateChange(value, room1[l].roomName, room1[l].d[i]);
                          setState(() {
                            getDevState(room1[l].roomName, room1[l].d[i])
                                .toggleSt = value;
                          });
                        },
                        activeTrackColor: Theme.of(context).backgroundColor,
                        activeColor: Colors.lightGreenAccent,
                        inactiveTrackColor: Theme.of(context).backgroundColor,
                      );
                    },
                  ),
                ),
              ),
            ],
          );
        });
  }
}
