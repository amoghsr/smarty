import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:smarty/devices/CommonControllers/deviceCommonControllers.dart';
import 'package:smarty/models/user.dart';
import 'package:smarty/shared/constants.dart';

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
    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;
    final user = Provider.of<User>(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        topAppBar(widget.roomName, 'Faucet', FontAwesomeIcons.shower),
        SizedBox(height: screenheight * 0.001),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
          Text(
            'OFF',
            style: kLightDeviceBottomBar.copyWith(fontSize: 18),
          ),
          SizedBox(
            width: screenwidth * 0.04,
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
                },
              ),
            ),
          ),
          SizedBox(
            width: screenwidth * 0.04,
          ),
          Text(
            'ON',
            style: kLightDeviceBottomBar.copyWith(fontSize: 18),
          ),
        ]),
        SizedBox(
          height: screenheight * 0.02,
        ),
        Text(
          'Water Dispensed',
          style: kLightDeviceBottomBar,
        ),
        SizedBox(
          height: screenheight * 0.02,
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
              width: screenwidth * 0.02,
            ),
            Text(
              '$waterAmount Oz',
              style: kLightDeviceBottomBar,
            ),
            SizedBox(
              width: screenwidth * 0.02,
            ),
            InkWell(
                onTap: () => setState(() {
                      if (waterAmount < 20) waterAmount = waterAmount + 1;
                    }),
                child: Icon(Icons.add_circle_outline, size: 45),),
          ],
        ),
        Container(
          margin: EdgeInsets.all(screenheight * 0.02),
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
            backgroundColor: Theme.of(context).cardColor,
            progressColor: Theme.of(context).accentColor,
          ),
        ),
      ],
    );
  }
}
