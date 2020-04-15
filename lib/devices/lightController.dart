import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smarty/devices/CommonControllers/deviceCommonControllers.dart';
import 'package:smarty/models/user.dart';
import 'package:smarty/shared/constants.dart';

class LightController extends StatefulWidget {
  LightController({
    Key key,
    @required this.itemRef,
    @required this.context,
    @required this.roomName,
    @required this.devName,
  }) : super(key: key);

  final DatabaseReference itemRef;
  final BuildContext context;
  final String roomName;
  final String devName;

  @override
  _LightControllerState createState() => _LightControllerState();
}

class _LightControllerState extends State<LightController> {
  void initState() {
    super.initState();
    final FirebaseDatabase database = FirebaseDatabase
        .instance; //Rather then just writing FirebaseDatabase(), get the instance.
    itemRef = database.reference();
  }

  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;
    final user = Provider.of<User>(context);
    return Container(
      height: screenheight,
      width: screenwidth,
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: screenwidth * 0.04,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      widget.roomName,
                      style: kLightDeviceTopBar.copyWith(
                        color: Theme.of(context).disabledColor
                      ),
                    ),
                    SizedBox(
                      height: screenheight * 0.015,
                    ),
                    Text(
                      'Lights',
                      style: kLightDeviceBottomBar,
                    ),
                  ],
                ),
                Container(
                  child: StreamBuilder(
                    stream: widget.itemRef
                        .child("Homes/" +
                            user.houseId +
                            "/Rooms/" +
                            widget.roomName +
                            "/devices/" +
                            widget.devName +
                            "/")
                        .onValue,
                    builder: (context, snap) {
                      if (snap.data == null)
                        return Icon(Icons.wb_incandescent,
                            size: 48, color: Colors.white);
                      Map<String, dynamic> values =
                          new Map<String, dynamic>.from(
                              snap.data.snapshot.value);
                      bulbColor = stringtocol(values["Color"]);
                      return Icon(Icons.wb_incandescent,
                          size: 48, color: bulbColor);
                    },
                  ),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'OFF',
                style: kLightDeviceBottomBar.copyWith(fontSize: 18),
              ),
              SizedBox(
                width: screenwidth * 0.05,
              ),
              Container(
                child: Transform.scale(
                  scale: 2,
                  child: StreamBuilder(
                    stream: widget.itemRef
                        .child("Homes/" +
                            user.houseId +
                            "/Rooms/" +
                            widget.roomName +
                            "/devices/" +
                            widget.devName +
                            "/")
                        .onValue,
                    builder: (context, snap) {
                      if (snap.data == null)
                        return Switch(
                          value: false,
                          onChanged: (value) {
                            stateChange(value, widget.roomName, widget.devName,
                                user.houseId, user);
                            setState(() {
                              isSwitched = value;
                            });
                          },
                          activeTrackColor: Theme.of(context).canvasColor,
                          activeColor: Theme.of(context).canvasColor,
                          inactiveTrackColor: Theme.of(context).canvasColor,
                          inactiveThumbColor: Theme.of(context).canvasColor,
                        );
                      Map<String, dynamic> values =
                          new Map<String, dynamic>.from(
                              snap.data.snapshot.value);
                      return Switch(
                        value: convert(values["State"]),
                        onChanged: (value) {
                          stateChange(value, widget.roomName, widget.devName,
                              user.houseId, user);
                          setState(() {
                            isSwitched = value;
                          });
                        },
                        activeTrackColor: Theme.of(context).accentColor,
                        activeColor: Colors.white,
                        inactiveTrackColor: Theme.of(context).backgroundColor,
                      );
                    },
                  ),
                ),
              ),
              SizedBox(
                width: screenwidth * 0.05,
              ),
              Text(
                'ON',
                style: kLightDeviceBottomBar.copyWith(fontSize: 18),
              ),
            ],
          ),
          SizedBox(
            height: screenheight * 0.01,
          ),
          Text(
            'COLOR',
            style: kLightDeviceTopBar.copyWith(
              fontFamily: 'Montserrat',
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: Theme.of(context).disabledColor,
            ),
          ),
          SizedBox(
            height: screenheight * 0.02,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              GestureDetector(
                  onTap: () {
                    setColor(Colors.green, widget.roomName, widget.devName,
                        user.houseId);
                    setState(() {
                      bulbColor = Colors.green;
                    });
                  },
                  child: colorRow(Colors.green)),
              GestureDetector(
                onTap: () {
                  setColor(Colors.lightBlue, widget.roomName, widget.devName,
                      user.houseId);
                  setState(() {
                    bulbColor = Colors.lightBlue;
                  });
                },
                child: colorRow(Colors.lightBlue),
              ),
              GestureDetector(
                  onTap: () {
                    setColor(Colors.indigo, widget.roomName, widget.devName,
                        user.houseId);
                    setState(() {
                      bulbColor = Colors.indigo;
                    });
                  },
                  child: colorRow(Colors.indigo)),
              GestureDetector(
                  onTap: () {
                    setColor(Colors.purple, widget.roomName, widget.devName,
                        user.houseId);
                    setState(() {
                      bulbColor = Colors.purple;
                    });
                  },
                  child: colorRow(Colors.purple)),
              GestureDetector(
                  onTap: () {
                    setColor(Colors.red, widget.roomName, widget.devName,
                        user.houseId);
                    setState(() {
                      bulbColor = Colors.red;
                    });
                  },
                  child: colorRow(Colors.red)),
//            GestureDetector(
//                onTap: () {
//                  setColor(Colors.orange, roomName, devName);
//                  setState(() {
//                    bulbColor = Colors.orange;
//                  });
//                },
//                child: colorRow(Colors.orange)),
//            GestureDetector(
//                onTap: () {
//                  setColor(Colors.yellow, roomName, devName);
//                  setState(() {
//                    bulbColor = Colors.yellow;
//                  });
//                },
//                child: colorRow(Colors.yellow)),
            ],
          ),
          SizedBox(
            height: screenheight * 0.02,
          ),
          Text(
            'BRIGHTNESS',
            style: kLightDeviceTopBar.copyWith(
              fontFamily: 'Montserrat',
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: Theme.of(context).disabledColor,
            ),
          ),
          SizedBox(
            height: screenheight * 0.01,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'MIN',
                style: kLightDeviceTopBar.copyWith(
                  fontFamily: 'Montserrat',
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).disabledColor,
                ),
              ),
              SliderTheme(
                data: SliderTheme.of(context).copyWith(
                  activeTrackColor: Theme.of(context).accentColor,
                  inactiveTrackColor: Theme.of(context).cardColor,
                  thumbColor: Theme.of(context).accentColor,
                  overlayColor: Theme.of(context).accentColor,
                  thumbShape: RoundSliderThumbShape(
                    enabledThumbRadius: 15.0,
                  ),
                  overlayShape: RoundSliderOverlayShape(
                    overlayRadius: 20.0,
                  ),
                  trackHeight: 8,
                ),
                child: Container(
                  width: 250,
                  child: StreamBuilder(
                    stream: widget.itemRef
                        .child("Homes/" +
                            user.houseId +
                            "/Rooms/" +
                            widget.roomName +
                            "/devices/" +
                            widget.devName +
                            "/")
                        .onValue,
                    builder: (context, snap) {
                      if (snap.data == null)
                        return Slider(
                          value: 0.0,
                          max: 100,
                          min: 0,
                          onChanged: (double newValue) {
                            setState(() {
                              brightness = newValue.round();
                            });
                          },
                          onChangeEnd: (double newValue) {
                            setBrightness(newValue.round(), widget.roomName,
                                widget.devName, "Brightness", user.houseId);
                          },
                        );

                      Map<String, dynamic> values =
                          new Map<String, dynamic>.from(
                              snap.data.snapshot.value);
                      return Slider(
                        value: values["Brightness"].toDouble(),
                        max: 100,
                        min: 0,
                        onChanged: (double newValue) {
                          setState(() {
                            brightness = newValue.round();
                          });
                        },
                        onChangeEnd: (double newValue) {
                          setBrightness(newValue.round(), widget.roomName,
                              widget.devName, "Brightness", user.houseId);
                        },
                      );
                    },
                  ),
                ),
              ),
              Text(
                'MAX',
                style: kLightDeviceTopBar.copyWith(
                  fontFamily: 'Montserrat',
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).disabledColor,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
