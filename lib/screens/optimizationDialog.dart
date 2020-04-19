import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:smarty/models/devicesModel.dart';
import 'package:smarty/models/roomModel.dart';
import 'package:smarty/screens/rooms.dart';
import '../BadgeBox.dart';

class Optimization extends StatefulWidget {
  @override
  List<Room> r;
  Optimization({this.r});
  _OptimizationState createState() => _OptimizationState();
}

class _OptimizationState extends State<Optimization> {
  bool expanded = false;
  List<dynamic> roomDeviceNames = [];
  Icon getDevIcons(String roomName) {
    switch (roomName) {
      case 'Lamp':
        return Icon(Icons.wb_incandescent);
      case 'Exhaust Fan':
        return Icon(FontAwesomeIcons.fan);
      case 'Camera':
        return Icon(FontAwesomeIcons.camera);
      case 'AC':
        return Icon(FontAwesomeIcons.airFreshener);
      case 'Faucet':
        return Icon(FontAwesome.shower);
      case 'heater':
        return Icon(FontAwesomeIcons.fire);
      case 'Speaker':
        return Icon(Icons.speaker);
      case 'TV':
        return Icon(FontAwesomeIcons.tv);
      case 'Water Heater':
        return Icon(FontAwesomeIcons.temperatureHigh);
      case 'Refrigerator':
        return Icon(FontAwesomeIcons.cubes);
      case 'Baby Monitor':
        return Icon(FontAwesomeIcons.baby);
    }
  }

  Widget build(BuildContext context) {
    double screenheight = MediaQuery.of(context).size.height;
    List<Room> rooms = widget.r;

    final devices = Provider.of<List<Device>>(context);
    print('Devices: ${devices[0].deviceName}');
    if (devices != null) {
      for (var i in rooms) {
        for (var j in i.d) {
          for (var k in devices) {
            if (k.inRoom == i.roomName) if (k.deviceName == j) if (k.state ==
                'Off') roomDeviceNames.add([i.roomName.toString(), j]);
          }
        }
      }
    }
    return Stack(
      children: <Widget>[
        //...bottom card part,
        (rooms != null)
            ? Container(
                padding: EdgeInsets.only(
                  top: Consts.padding + 10,
                  bottom: Consts.padding,
                  left: Consts.padding,
                  right: Consts.padding,
                ),
                decoration: new BoxDecoration(
                  color: Theme.of(context).canvasColor,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(Consts.padding),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10.0,
                      offset: const Offset(0.0, 10.0),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min, // To make the card compact
                  children: <Widget>[
                    // Title of the popup
                    Text(
                      'Suggested Optimizations',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        color: Colors.white,
                        fontSize: 18.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 16.0),
                    // Description on the popup
                    Text(
                      'Homi Smart Agent recommends switching off the following devices',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        color: Colors.white,
                        fontSize: 14.0,
                      ),
                    ),
                    SizedBox(height: 15.0),
                    ConstrainedBox(
                      constraints: BoxConstraints(
                          maxHeight: screenheight * 0.35,
                          minHeight: screenheight * 0.1),
                      child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: roomDeviceNames.length,
                          physics: BouncingScrollPhysics(),
                          itemBuilder: (context, i) {
                            return Container(
                              margin: EdgeInsets.all(5.5),
                              decoration: BoxDecoration(
                                color: Theme.of(context).cardColor,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: ListTile(
                                title: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    SizedBox(height: 10),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: <Widget>[
                                            getDevIcons(roomDeviceNames[i][1]),
                                            SizedBox(
                                              width: 8,
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Text(
                                                  roomDeviceNames[i][1],
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                                Text(
                                                  roomDeviceNames[i][0],
                                                  style: TextStyle(
                                                      fontSize: 11,
                                                      color: Colors.white),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: <Widget>[
                                            InkWell(
                                              child: Container(
                                                height: 25,
                                                width: 25,
                                                decoration: BoxDecoration(
                                                  color: Colors.green[600],
                                                  borderRadius:
                                                      BorderRadius.all(
                                                    Radius.circular(5),
                                                  ),
                                                ),
                                                child: Center(
                                                    child: Icon(Icons.check,
                                                        size: 18)),
                                              ),
                                            ),
                                            SizedBox(width: 15),
                                            InkWell(
                                              onTap: () {
                                                setState(() {
                                                  roomDeviceNames.removeAt(i);

                                                  if (roomDeviceNames.length ==
                                                      0) {
                                                    Timer(Duration(seconds: 1),
                                                        () {
                                                      Navigator.pop(context);
                                                    });
                                                  }
                                                });
                                              },
                                              child: Container(
                                                height: 25,
                                                width: 25,
                                                decoration: BoxDecoration(
                                                  color: Colors.red,
                                                  borderRadius:
                                                      BorderRadius.all(
                                                    Radius.circular(5),
                                                  ),
                                                ),
                                                child: Center(
                                                  child: Icon(Icons.clear,
                                                      size: 18),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 10),
                                  ],
                                ),
                              ),
                            );
                          }),
                    ),
                    SizedBox(height: 15),
                    Align(
                      alignment: Alignment.bottomCenter,
                      // A button used for closing the dialog plus switching off the fire alarm.
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Container(
                            height: 40,
                            width: 80,
                            decoration: BoxDecoration(
                              color: Colors.green[600],
                              borderRadius: BorderRadius.all(
                                Radius.circular(5),
                              ),
                            ),
                            child: Center(
                              child: Text('Accept All'),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                roomDeviceNames.clear();
                                if (roomDeviceNames.length == 0) {
                                  Timer(Duration(seconds: 1), () {
                                    Navigator.pop(context);
                                  });
                                }
                              });
                            },
                            child: Container(
                              height: 40,
                              width: 80,
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(5),
                                ),
                              ),
                              child: Center(
                                child: Text('Reject All'),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            //...top circlular image part,
            : Container()
      ],
    );
  }
}
