import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:smarty/Devices/CommonControllers/deviceCommonControllers.dart';
import 'package:smarty/constants.dart';

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
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          color: Colors.white,
          padding: EdgeInsets.symmetric(
            horizontal: 15,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Text(
                    widget.roomName,
                    style: kLightDeviceTopBar.copyWith(
                      color: Colors.white.withOpacity(0.5),
                    ),
                  ),
                  SizedBox(
                    height: 8,
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
                      .child("Rooms/" +
                          widget.roomName +
                          "/devices/" +
                          widget.devName +
                          "/")
                      .onValue,
                  builder: (context, snap) {
                    Map<String, dynamic> values =
                        new Map<String, dynamic>.from(snap.data.snapshot.value);
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
              width: 20,
            ),
            Container(
              child: Transform.scale(
                scale: 2,
                child: StreamBuilder(
                  stream: widget.itemRef
                      .child("Rooms/" +
                          widget.roomName +
                          "/devices/" +
                          widget.devName +
                          "/")
                      .onValue,
                  builder: (context, snap) {
                    Map<String, dynamic> values =
                        new Map<String, dynamic>.from(snap.data.snapshot.value);
                    return Switch(
                      value: convert(values["State"]),
                      onChanged: (value) {
                        stateChange(value, widget.roomName, widget.devName);
                        setState(() {
                          isSwitched = value;
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
            SizedBox(
              width: 20,
            ),
            Text(
              'ON',
              style: kLightDeviceBottomBar.copyWith(fontSize: 18),
            ),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          'COLOR',
          style: kLightDeviceTopBar.copyWith(
            fontFamily: 'Montserrat',
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: Colors.white.withOpacity(0.8),
          ),
        ),
        SizedBox(
          height: 15,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            //TODO :ADD db connection
            GestureDetector(
                onTap: () {
                  setColor(Colors.green, widget.roomName, widget.devName);
                  setState(() {
                    bulbColor = Colors.green;
                  });
                },
                child: colorRow(Colors.green)),
            GestureDetector(
              onTap: () {
                setColor(Colors.lightBlue, widget.roomName, widget.devName);
                setState(() {
                  bulbColor = Colors.lightBlue;
                });
              },
              child: colorRow(Colors.lightBlue),
            ),
            GestureDetector(
                onTap: () {
                  setColor(Colors.indigo, widget.roomName, widget.devName);
                  setState(() {
                    bulbColor = Colors.indigo;
                  });
                },
                child: colorRow(Colors.indigo)),
            GestureDetector(
                onTap: () {
                  setColor(Colors.purple, widget.roomName, widget.devName);
                  setState(() {
                    bulbColor = Colors.purple;
                  });
                },
                child: colorRow(Colors.purple)),
            GestureDetector(
                onTap: () {
                  setColor(Colors.red, widget.roomName, widget.devName);
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
          height: 15,
        ),
        Text(
          'BRIGHTNESS',
          style: kLightDeviceTopBar.copyWith(
            fontFamily: 'Montserrat',
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: Colors.white.withOpacity(0.7),
          ),
        ),
        SizedBox(
          height: 10,
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
                color: Colors.white.withOpacity(0.7),
              ),
            ),
            SliderTheme(
              data: SliderTheme.of(context).copyWith(
                activeTrackColor: Theme.of(context).accentColor,
                inactiveTrackColor: Theme.of(context).backgroundColor,
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
                      .child("Rooms/" +
                          widget.roomName +
                          "/devices/" +
                          widget.devName +
                          "/")
                      .onValue,
                  builder: (context, snap) {
                    Map<String, dynamic> values =
                        new Map<String, dynamic>.from(snap.data.snapshot.value);
                    return Slider(
                      value: values["Brightness"].toDouble(),
                      max: 100,
                      min: 0,
                      onChanged: (double newValue) {
                        setBrightness(
                            newValue.round(), widget.roomName, widget.devName);
                        setState(() {
                          brightness = newValue.round();
                        });
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
                color: Colors.white.withOpacity(0.7),
              ),
            ),
          ],
        )
      ],
    );
  }
}
