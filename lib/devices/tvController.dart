import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:smarty/models/user.dart';
import 'package:smarty/shared/constants.dart';

import 'CommonControllers/deviceCommonControllers.dart';

class TVController extends StatefulWidget {
  TVController({
    Key key,
    @required this.itemRef,
    @required this.brightness,
    @required this.context,
    @required this.roomName,
    @required this.devName,
  }) : super(key: key);

  final DatabaseReference itemRef;
  int brightness;
  final BuildContext context;
  final String roomName;
  final String devName;

  @override
  _TVControllerState createState() => _TVControllerState();
}

class _TVControllerState extends State<TVController> {
  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;
    final user = Provider.of<User>(context);
    return Column(
      children: <Widget>[
        topAppBar(widget.roomName, 'TV', Icons.tv),
        SizedBox(
          height: screenheight * 0.003,
        ),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
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
                    .child("Homes/" +
                        user.houseId +
                        "/Rooms/" +
                        widget.roomName +
                        "/devices/" +
                        widget.devName +
                        "/")
                    .onValue,
                builder: (context, snap) {
                  if (snap.data == null) {
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
                  } else {
                    Map<String, dynamic> values =
                        new Map<String, dynamic>.from(snap.data.snapshot.value);
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
                  }
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
        ]),
        SizedBox(
          height: screenheight * 0.03,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
    boxShadow: [
    BoxShadow(
    color: Colors.black.withOpacity(0.1),
    offset: Offset(1.0, 4.0),
    blurRadius: 4.0)
    ],
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  topLeft: Radius.circular(30),
                ),
              ),
              child: Center(
                child: Text(
                  'CH -',
                  style: kLightDeviceBottomBar.copyWith(fontSize: 18),
                ),
              ),
            ),
            SizedBox(width: 30),
            Container(
              height: 55,
              width: 55,
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
    boxShadow: [
    BoxShadow(
    color: Colors.black.withOpacity(0.1),
    offset: Offset(1.0, 4.0),
    blurRadius: 4.0)
    ],
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
              ),
              child: Center(
                child: Icon(Icons.home, size: 30),
              ),
            ),
            SizedBox(width: 30),
            Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
    boxShadow: [
    BoxShadow(
    color: Colors.black.withOpacity(0.1),
    offset: Offset(1.0, 4.0),
    blurRadius: 4.0)
    ],
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Center(
                child: Text(
                  'CH+',
                  style: kLightDeviceBottomBar.copyWith(fontSize: 18),
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: screenheight * 0.02,
        ),
        Text(
          'VOLUME',
          style: kLightDeviceTopBar.copyWith(
            fontFamily: 'Montserrat',
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: Colors.white.withOpacity(0.7),
          ),
        ),
        SizedBox(
          height: screenheight * 0.01,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(Icons.volume_mute, size: 30),
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
                          setBrightness(newValue.round(), widget.roomName,
                              widget.devName, "Volume", user.houseId);
                          setState(() {
                            brightness = newValue.round();
                          });
                        },
                      );
                    ;

                    Map<String, dynamic> values =
                        new Map<String, dynamic>.from(snap.data.snapshot.value);
                    return Slider(
                      value: values["Volume"].toDouble(),
                      max: 100,
                      min: 0,
                      onChanged: (double newValue) {
                        setBrightness(newValue.round(), widget.roomName,
                            widget.devName, "Volume", user.houseId);
                        setState(() {
                          brightness = newValue.round();
                        });
                      },
                    );
                  },
                ),
              ),
            ),
            Icon(Icons.volume_up, size: 30),
          ],
        )
      ],
    );
  }
}
