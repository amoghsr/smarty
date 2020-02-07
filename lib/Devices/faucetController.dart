import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:smarty/Devices/CommonControllers/deviceCommonControllers.dart';
import 'package:smarty/constants.dart';

class FaucetController extends StatefulWidget {
  const FaucetController({
    Key key,
    @required this.itemRef,
    @required this.waterAmount,
    @required this.context,
    @required this.roomName,
    @required this.devName,
  }) : super(key: key);

  final DatabaseReference itemRef;
  final int waterAmount;
  final BuildContext context;
  final String roomName;
  final String devName;

  @override
  _FaucetControllerState createState() => _FaucetControllerState();
}

class _FaucetControllerState extends State<FaucetController> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        topAppBar(widget.roomName, 'Faucet', FontAwesomeIcons.shower),
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
        Text(
          'Water Dispensed',
          style: kLightDeviceBottomBar,
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            InkWell(
                onTap: () => setState(() {
                      if (waterAmount > 1) waterAmount = waterAmount - 1;
                    }),
                child: Icon(Icons.remove_circle_outline, size: 45)),
            SizedBox(
              width: 15,
            ),
            Text(
              '$waterAmount Oz',
              style: kLightDeviceBottomBar,
            ),
            SizedBox(
              width: 15,
            ),
            InkWell(
                onTap: () => setState(() {
                      if (waterAmount < 20) waterAmount = waterAmount + 1;
                    }),
                child: Icon(Icons.add_circle_outline, size: 45)),
          ],
        ),
        Container(
          margin: EdgeInsets.all(20),
          child: LinearPercentIndicator(
            padding: EdgeInsets.symmetric(horizontal: 20),
            leading: Text(
              '0%',
              style: kLightDeviceTopBar.copyWith(
                fontFamily: 'Montserrat',
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: Colors.white.withOpacity(0.7),
              ),
            ),
            trailing: Text(
              '100%',
              style: kLightDeviceTopBar.copyWith(
                fontFamily: 'Montserrat',
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: Colors.white.withOpacity(0.7),
              ),
            ),
            lineHeight: 14.0,
            percent: 0.7,
            backgroundColor: Theme.of(context).backgroundColor,
            progressColor: Theme.of(context).accentColor,
          ),
        ),
      ],
    );
  }
}
