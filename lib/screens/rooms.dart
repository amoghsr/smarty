import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smarty/devices_controller.dart';
import 'package:smarty/models/devicesModel.dart';
import 'package:smarty/models/roomModel.dart';
import 'package:smarty/models/user.dart';
import 'package:smarty/shared/constants.dart';

//Todo:first
//List<Tab> rlist = [
//  Tab(text: rooms[0].roomName, icon: rooms[0].icon),
//  Tab(text: rooms[1].roomName, icon: rooms[1].icon),
//  Tab(text: rooms[2].roomName, icon: rooms[2].icon),
//  Tab(text: rooms[3].roomName, icon: rooms[3].icon),
//  Tab(text: rooms[4].roomName, icon: rooms[4].icon),
//];

class MyOtherRoom extends StatefulWidget {
  @override
  int initRoom;
  List<Room> rooms;
  MyOtherRoom({@required this.initRoom, @required this.rooms});

  _MyOtherRoomState createState() => _MyOtherRoomState();
}

class _MyOtherRoomState extends State<MyOtherRoom> {
  @override
  List<Room> rooms;
  List<Tab> rlist = [];
  bool isSwitched = true;
  int brightness = 60;
  DatabaseReference itemRef;
  //Todo:first
  Color bulbColor = Colors.white;
  String currRoom;
  String currDevice;
  String initrmName;
  String rmName;
  bool isAbsorbed = false;

  void initState() {
    rooms = widget.rooms;
    for (var r in rooms) {
      rlist.add(
        Tab(text: r.roomName, icon: r.icon),
      );
    }
    initrmName = rlist[widget.initRoom].text;
    rmName = rlist[widget.initRoom].text;
    currRoom = rlist[0].text;
    currDevice = rooms[0].d[0];
    initrmName = rlist[0].text;
    rmName = rlist[0].text;
    super.initState();
    final FirebaseDatabase database = FirebaseDatabase
        .instance; //Rather then just writing FirebaseDatabase(), get the instance.
    itemRef = database.reference();
  }

  void stateChange(bool newvalue, String room, String device) {
    if (newvalue == false) {
      itemRef
          .child("Rooms/" + room + "/devices/" + device + "/")
          .update({'State': "off"});
    } else {
      itemRef
          .child("Rooms/" + room + "/devices/" + device + "/")
          .update({'State': "on"});
    }
  }

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

  Stream getString(String room, String device) {
    Stream x;
    final FirebaseDatabase database = FirebaseDatabase
        .instance; //Rather then just writing FirebaseDatabase(), get the instance.
    x = database
        .reference()
        .child("Rooms/" + room + "/" + device + "/")
        .onValue;
    return x;
  }

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
//    rooms = Provider.of<List<Room>>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          (rmName != rlist[widget.initRoom].text) ? rmName : initrmName,
          style: kAppBarTextStyle,
        ),
      ),
//      drawer: Drawer(),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          child: DefaultTabController(
            initialIndex: widget.initRoom,
            length: rooms.length,
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
                      currDevice = rooms[value].d[0];
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
                          for (var i in rooms) getListTile(rooms.indexOf(i)),
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
          chRoom: (rmName != rlist[widget.initRoom].text) ? rmName : initrmName,
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
                  onTap: () {
                    setState(() {
                      currRoom = rooms[l].roomName;
                      currDevice = rooms[l].d[i];
                    });
                  },
                  leading: getIcons(rooms[l].d[i]),
                  title: Text(rooms[l].d[i]),
                  trailing: StreamBuilder(
                    stream: itemRef
                        .child("Rooms/" +
                            rooms[l].roomName +
                            "/devices/" +
                            rooms[l].d[i] +
                            "/")
                        .onValue,
                    builder: (context, snap) {
                      Map<String, dynamic> values =
                          new Map<String, dynamic>.from(
                              snap.data.snapshot.value);
                      return Switch(
                        value: convert(values["State"]),
                        onChanged: (value) {
                          stateChange(value, rooms[l].roomName, rooms[l].d[i]);
                          setState(() {
                            getDevState(rooms[l].roomName, rooms[l].d[i])
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
