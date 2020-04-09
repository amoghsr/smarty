/*
This file helps create the carousels for the devices in the house.
 */

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:provider/provider.dart';
import 'package:smarty/devices/CommonControllers/deviceCommonControllers.dart';
import 'package:smarty/models/devicesModel.dart';
import 'package:smarty/models/user.dart';
import 'package:smarty/test/firebaseControlDevices.dart';

class DeviceCarousel extends StatefulWidget {
  DatabaseReference itemRef;
  @override
  _DeviceCarouselState createState() => _DeviceCarouselState();
}

class _DeviceCarouselState extends State<DeviceCarousel> {
  void initState() {
    super.initState();
    final FirebaseDatabase database = FirebaseDatabase
        .instance; //Rather then just writing FirebaseDatabase(), get the instance.
    DatabaseReference itemRef = database.reference();
  }

  List<Device> favouritedevices(List<Device> x) {
    x..sort((a, b) => b.count.compareTo(a.count));
    return x;
  }

  @override
  Widget build(BuildContext context) {
    final devices = Provider.of<List<Device>>(context);
    final user = Provider.of<User>(context);
    List<Device> dev = favouritedevices(devices);
    if (devices != null) {
      return Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Favourite Devices',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                // GestureDetector(
                //   onTap: () => print('See All'),
                //   child: Text(
                //     'See All Devices',
                //     style: TextStyle(
                //       fontSize: 12.0,
                //       color: Theme.of(context).accentColor,
                //       fontWeight: FontWeight.w600,
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
          SizedBox(
            height: 4,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Opacity(
                  opacity: 0.5,
                  child: Text(
                    'Most used devices in your house.',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Container(
            height: 180.0,
//          color: Colors.blue,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              //Todo: change devices from here to stream
              itemCount: 3,
              itemBuilder: (BuildContext context, int index) {
                Device device = dev[index];
                return Container(
                  margin: EdgeInsets.all(8.0),
                  width: 170.0,
//                color: Colors.red,
                  child: Stack(
                    alignment: Alignment.topCenter,
                    children: <Widget>[
                      Opacity(
                        opacity: device.opacity,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      FirebaseControlDevices()),
                            );
                          },
                          child: Container(
                            height: 180.0,
                            width: 170.0,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: Theme.of(context).cardColor,
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(14.0),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Opacity(
                                        opacity: 0.7,
                                        child: Text(
                                          device.inRoom,
                                          style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w400,
                                            fontFamily: 'Poppins',
//                                      color: Theme.of(context).accentColor,
                                          ),
                                        ),
                                      ),
                                      StreamBuilder(
                                        stream: itemRef
                                            .child("Homes/" +
                                                user.houseId +
                                                "/Rooms/" +
                                                device.inRoom +
                                                "/devices/" +
                                                device.deviceName +
                                                "/")
                                            .onValue,
                                        builder: (context, snap) {
                                          if (snap.data == null)
                                            return Switch(
                                              value: false,
                                              onChanged: (value) {
                                                stateChange(
                                                    value,
                                                    device.inRoom,
                                                    device.deviceName,
                                                    user.houseId,
                                                    user);
                                                setState(() {
                                                  isSwitched = value;
                                                });
                                              },
                                              activeTrackColor:
                                                  Theme.of(context).canvasColor,
                                              activeColor:
                                                  Theme.of(context).canvasColor,
                                              inactiveTrackColor:
                                                  Theme.of(context).canvasColor,
                                              inactiveThumbColor:
                                                  Theme.of(context).canvasColor,
                                            );
                                          Map<String, dynamic> values =
                                              new Map<String, dynamic>.from(
                                                  snap.data.snapshot.value);
                                          return Switch(
                                            value: convert(values["State"]),
                                            onChanged: (value) {
                                              stateChange(
                                                  value,
                                                  device.inRoom,
                                                  device.deviceName,
                                                  user.houseId,
                                                  user);
                                              setState(() {
                                                isSwitched = value;
                                              });
                                            },
                                            activeTrackColor: Theme.of(context)
                                                .backgroundColor,
                                            activeColor:
                                                Colors.lightGreenAccent,
                                            inactiveTrackColor:
                                                Theme.of(context)
                                                    .backgroundColor,
                                          );
                                        },
                                      ),
                                    ],
                                  ),
//                                  Row(
//                                    children: <Widget>[
//                                      Image(
//                                        height: 50,
//                                        width: 50,
//                                        image: AssetImage(
//                                          device.imageUrl,
//                                        ),
//                                      ),
//                                    ],
//                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text(
                                        device.deviceName,
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      Text(
                                        device.state,
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500,
                                          fontFamily: 'Montserrat',
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      );
    } else {
      return Container();
    }
  }
}
