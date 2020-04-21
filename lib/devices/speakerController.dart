import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:smarty/devices/CommonControllers/deviceCommonControllers.dart';
import 'package:smarty/models/user.dart';
import 'package:smarty/shared/constants.dart';

class SpeakerController extends StatefulWidget {
  SpeakerController({
    Key key,
    @required this.itemRef,
    @required this.brightness,
    @required this.context,
    @required this.roomName,
    @required this.devName,
  }) : super(key: key);

  final DatabaseReference itemRef;

  // final AnimationController controller;
  int brightness;
  final BuildContext context;
  final String roomName;
  final String devName;

  @override
  _SpeakerControllerState createState() => _SpeakerControllerState();
}

class _SpeakerControllerState extends State<SpeakerController>
    with SingleTickerProviderStateMixin {
  Animation<double> myAnimation;
  AnimationController controller;

  void initState() {
    super.initState();
    controller = AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;
    final user = Provider.of<User>(context);
    return Column(
      children: <Widget>[
        topAppBar(widget.roomName, 'Speaker', Icons.speaker),
        SizedBox(
          height: screenheight * 0.01,
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
                    value: convert(values["State"]) ?? false,
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
            width: 20,
          ),
          Text(
            'ON',
            style: kLightDeviceBottomBar.copyWith(fontSize: 18),
          ),
        ]),
        SizedBox(
          height: screenheight * 0.01,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(Icons.fast_rewind, size: 45),
            SizedBox(
              width: 20,
            ),
            InkWell(
              onTap: () {
                _onpressed();
              },
              child: AnimatedIcon(
                size: 50,
                icon: AnimatedIcons.play_pause,
                progress: controller,
              ),
            ),
            SizedBox(
              width: 20,
            ),
            Icon(Icons.fast_forward, size: 45),
          ],
        ),
        SizedBox(
          height: screenheight * 0.01,
        ),
        Text(
          'VOLUME',
          style: kLightDeviceTopBar.copyWith(
            fontFamily: 'Montserrat',
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: Theme
                .of(context)
                .disabledColor,
          ),
        ),
        SizedBox(
          height: screenheight * 0.02,
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
//                    print(widget.roomName + "help help");
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
                    Map<String, dynamic> values =
                        new Map<String, dynamic>.from(snap.data.snapshot.value);
                    return Slider(
                      value: values["Volume"].toDouble() ?? 22.0,
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
            Icon(FontAwesomeIcons.volumeUp, size: 30),
          ],
        )
      ],
    );
  }

  _onpressed() {
    setState(() {
      isPlaying = !isPlaying;
      isPlaying ? controller.forward() : controller.reverse();
    });
  }
}
