import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:smarty/constants.dart';

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
    return Column(
      children: <Widget>[
        topAppBar(widget.roomName, 'TV', Icons.tv),
        SizedBox(height: 5),
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
        ]),
        SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                color: Theme.of(context).backgroundColor,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  topLeft: Radius.circular(30),
                ),
              ),
              child: Center(
                child: Text(
                  'CH-',
                  style: kLightDeviceBottomBar.copyWith(fontSize: 18),
                ),
              ),
            ),
            SizedBox(width: 30),
            Container(
              height: 55,
              width: 55,
              decoration: BoxDecoration(
                color: Theme.of(context).backgroundColor,
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
                color: Theme.of(context).backgroundColor,
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
          height: 20,
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
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(FontAwesomeIcons.volumeOff, size: 30),
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
                child: Slider(
                  value: widget.brightness.toDouble(),
                  max: 100,
                  min: 0,
                  onChanged: (double newValue) {
                    setState(() {
                      widget.brightness = newValue.round();
                    });
                  },
                ),
              ),
            ),
            Icon(FontAwesomeIcons.volumeUp, size: 30),
          ],
        )
      ],
    );
  }
}
