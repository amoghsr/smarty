import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:smarty/devices/CommonControllers/deviceCommonControllers.dart';
import 'package:smarty/models/user.dart';
import 'package:smarty/shared/constants.dart';

class ExhaustFanController extends StatefulWidget {
  ExhaustFanController({
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
  _ExhaustFanControllerState createState() => _ExhaustFanControllerState();
}

class _ExhaustFanControllerState extends State<ExhaustFanController> {
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
                          color: Theme.of(context).disabledColor),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Text(
                      'Exhaust Fan',
                      style: kLightDeviceBottomBar,
                    ),
                  ],
                ),
                Icon(FontAwesomeIcons.fan, size: 48),
              ],
            ),
          ),
          SizedBox(
            height: screenheight * 0.05,
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
            height: screenheight * 0.02,
          ),
          Text(
            'SPEED',
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
                  child: Slider(
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
