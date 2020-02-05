import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import 'package:smarty/constants.dart';
import 'package:firebase_database/firebase_database.dart';

class DevicesController extends StatefulWidget {
  @override
  String chRoom;
  String chDevice;
  // bool isDisabled;
  DevicesController({this.chDevice, this.chRoom});
  _DevicesControllerState createState() => _DevicesControllerState();
}

bool isSwitched = false;
Color bulb_color = Colors.white;

class _DevicesControllerState extends State<DevicesController>
    with SingleTickerProviderStateMixin {
  @override
  int brightness = 50;
  var isPlaying = false;
  bool icon = false;
  int water_amount = 8;
  DatabaseReference itemRef;

  Animation<double> myAnimation;
  AnimationController controller;

  void initState() {
    super.initState();
    controller = AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this);
    final FirebaseDatabase database = FirebaseDatabase
        .instance; //Rather then just writing FirebaseDatabase(), get the instance.
    itemRef = database.reference();
  }

  void stateChange(bool newvalue, String room, String device) {
    if (newvalue == false) {
      itemRef
          .child("Rooms/" + room + "/devices/" + device + "/")
          .update({'State': "off"});
    } else {
      itemRef
          .child("Rooms/" + room + "/devices/" + device + "/")
          .update({'State': "on"});
    }
  }

  Stream getString(String room, String device) {
    Stream x;
    final FirebaseDatabase database = FirebaseDatabase
        .instance; //Rather then just writing FirebaseDatabase(), get the instance.

    x = database
        .reference()
        .child("Rooms/" + room + "/" + device + "/")
        .onValue;
    return x;
  }

  bool convert(String x) {
    bool w;
    if (x == "on") {
      w = true;
    } else {
      w = false;
    }
    return w;
  }

  void setColor(Color newvalue, String room, String device) {
    var hex = '#${newvalue.value.toRadixString(16)}';
    itemRef
        .child("Rooms/" + room + "/devices/" + device + "/")
        .update({'Color': hex});
  }

  void setBrightness(int newvalue, String room, String device) {
    itemRef
        .child("Rooms/" + room + "/devices/" + device + "/")
        .update({'Brightness': newvalue});
  }

  Color stringtocol(String code) {
    Map<String, Color> map = {
      "#ff4caf50": Colors.green,
      "#ff03a9f4": Colors.lightBlue,
      "#ff3f51b5": Colors.indigo,
      "#ff9c27b0": Colors.purple,
      "#fff44336": Colors.red,
      "#ffff9800": Colors.orange,
      "#ffff9800": Colors.yellow
    };
    return map[code];
  }

  void setTemp(int newvalue, String room, String device) {
    itemRef
        .child("Rooms/" + room + "/devices/" + device + "/")
        .update({'Temperature': newvalue});
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  _onpressed() {
    setState(() {
      isPlaying = !isPlaying;
      isPlaying ? controller.forward() : controller.reverse();
    });
  }

//TODO: ac
  Column acController(BuildContext context, String roomName, String devName) {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              children: <Widget>[
                Text(
                  roomName,
                  style: kLightDeviceTopBar.copyWith(
                    color: Colors.white.withOpacity(0.5),
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  'AC',
                  style: kLightDeviceBottomBar,
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Text(
                      'Temperature',
                      style: kLightDeviceTopBar.copyWith(
                        color: Colors.white.withOpacity(0.5),
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    StreamBuilder(
                      stream: itemRef.child("Sensors/TempandHumid/").onValue,
                      builder: (context, snap) {
                        Map<String, dynamic> values =
                            new Map<String, dynamic>.from(
                                snap.data.snapshot.value);
                        return Text(
                          values["Temp"].toString(),
                          style: kLightDeviceBottomBar,
                        );
                      },
                    ),
                  ],
                ),
                SizedBox(
                  width: 25,
                ),
                Column(
                  children: <Widget>[
                    Text(
                      'Humidity',
                      style: kLightDeviceTopBar.copyWith(
                        color: Colors.white.withOpacity(0.5),
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    StreamBuilder(
                      stream: itemRef.child("Sensors/TempandHumid/").onValue,
                      builder: (context, snap) {
                        Map<String, dynamic> values =
                            new Map<String, dynamic>.from(
                                snap.data.snapshot.value);
                        return Text(
                          values["Humid"].toString() + "%",
                          style: kLightDeviceBottomBar,
                        );
                      },
                    ),
                  ],
                )
              ],
            )
          ],
        ),
        SizedBox(height: 20),
        SleekCircularSlider(
            initialValue: 24,
            min: 16,
            max: 26,
            appearance: CircularSliderAppearance(
                size: 205,
                customColors: CustomSliderColors(
                  trackColor: Colors.grey,
                  progressBarColor: Colors.lightGreenAccent,
                ),
                customWidths: CustomSliderWidths(),
                infoProperties: InfoProperties(
                  topLabelStyle: kLightDeviceTopBar.copyWith(
                    color: Colors.white.withOpacity(0.5),
                    fontSize: 16,
                  ),
                  topLabelText: 'Set Temp.',
                  mainLabelStyle: TextStyle(color: Colors.white, fontSize: 40),
                  modifier: (value) {
                    final roundedValue = (value).ceil().toInt().toString();
                    return '$roundedValue°C';
                  },
                )),
            onChangeEnd: (double value) {
              setTemp(value.ceil().toInt(), roomName, devName);
              print(value);
            }),
      ],
    );
  }

  Column lightController(
      BuildContext context, String roomName, String devName) {
    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: 15,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Text(
                    roomName,
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
                  stream: itemRef
                      .child("Rooms/" + roomName + "/devices/" + devName + "/")
                      .onValue,
                  builder: (context, snap) {
                    Map<String, dynamic> values =
                        new Map<String, dynamic>.from(snap.data.snapshot.value);
                    bulb_color = stringtocol(values["Color"]);
                    return Icon(Icons.wb_incandescent,
                        size: 48, color: bulb_color);
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
                  stream: itemRef
                      .child("Rooms/" + roomName + "/devices/" + devName + "/")
                      .onValue,
                  builder: (context, snap) {
                    Map<String, dynamic> values =
                        new Map<String, dynamic>.from(snap.data.snapshot.value);
                    return Switch(
                      value: convert(values["State"]),
                      onChanged: (value) {
                        stateChange(value, roomName, devName);
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
                  setColor(Colors.green, roomName, devName);
                  setState(() {
                    bulb_color = Colors.green;
                  });
                },
                child: colorRow(Colors.green)),
            GestureDetector(
              onTap: () {
                setColor(Colors.lightBlue, roomName, devName);
                setState(() {
                  bulb_color = Colors.lightBlue;
                });
              },
              child: colorRow(Colors.lightBlue),
            ),
            GestureDetector(
                onTap: () {
                  setColor(Colors.indigo, roomName, devName);
                  setState(() {
                    bulb_color = Colors.indigo;
                  });
                },
                child: colorRow(Colors.indigo)),
            GestureDetector(
                onTap: () {
                  setColor(Colors.purple, roomName, devName);
                  setState(() {
                    bulb_color = Colors.purple;
                  });
                },
                child: colorRow(Colors.purple)),
            GestureDetector(
                onTap: () {
                  setColor(Colors.red, roomName, devName);
                  setState(() {
                    bulb_color = Colors.red;
                  });
                },
                child: colorRow(Colors.red)),
//            GestureDetector(
//                onTap: () {
//                  setColor(Colors.orange, roomName, devName);
//                  setState(() {
//                    bulb_color = Colors.orange;
//                  });
//                },
//                child: colorRow(Colors.orange)),
//            GestureDetector(
//                onTap: () {
//                  setColor(Colors.yellow, roomName, devName);
//                  setState(() {
//                    bulb_color = Colors.yellow;
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
                  stream: itemRef
                      .child("Rooms/" + roomName + "/devices/" + devName + "/")
                      .onValue,
                  builder: (context, snap) {
                    Map<String, dynamic> values =
                        new Map<String, dynamic>.from(snap.data.snapshot.value);
                    return Slider(
                      value: values["Brightness"].toDouble(),
                      max: 100,
                      min: 0,
                      onChanged: (double newValue) {
                        setBrightness(newValue.round(), roomName, devName);
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

  Container colorRow(Color color) {
    return Container(
      height: 25,
      width: 25,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
      ),
    );
  }

  Column speakerController(
      BuildContext context, String roomName, String devName) {
    return Column(
      children: <Widget>[
        topAppBar(roomName, 'Speaker', Icons.speaker),
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
                stream: itemRef
                    .child("Rooms/" + roomName + "/devices/" + devName + "/")
                    .onValue,
                builder: (context, snap) {
                  Map<String, dynamic> values =
                      new Map<String, dynamic>.from(snap.data.snapshot.value);
                  return Switch(
                    value: convert(values["State"]),
                    onChanged: (value) {
                      stateChange(value, roomName, devName);
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

              // child: (icon == true)
              //     animate() => myAnimation.reverse();
              //     ? AnimatedIcon(
              //         Icons.pause_circle_outline,
              //         icon: AnimatedIcon.play_pause,
              //         progress: myAnimation,
              //         size: 60.0,
              //       )
              //     : Icon(
              //         AnimatedIcon(
              //         Icons.pause_circle_outline,
              //         icon: AnimatedIcon.play_pause,
              //         progress: myAnimation,
              //         size: 60.0,
              //       ),
            ),
            SizedBox(
              width: 20,
            ),
            Icon(Icons.fast_forward, size: 45),
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
                  value: brightness.toDouble(),
                  max: 100,
                  min: 0,
                  onChanged: (double newValue) {
                    setState(() {
                      brightness = newValue.round();
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

  Column tvController(BuildContext context, String roomName, String devName) {
    return Column(
      children: <Widget>[
        topAppBar(roomName, 'TV', Icons.tv),
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
                stream: itemRef
                    .child("Rooms/" + roomName + "/devices/" + devName + "/")
                    .onValue,
                builder: (context, snap) {
                  Map<String, dynamic> values =
                      new Map<String, dynamic>.from(snap.data.snapshot.value);
                  return Switch(
                    value: convert(values["State"]),
                    onChanged: (value) {
                      stateChange(value, roomName, devName);
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
                  value: brightness.toDouble(),
                  max: 100,
                  min: 0,
                  onChanged: (double newValue) {
                    setState(() {
                      brightness = newValue.round();
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

  Container topAppBar(String roomName, String appliance, IconData icon) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 15,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            children: <Widget>[
              Text(
                roomName,
                style: kLightDeviceTopBar.copyWith(
                  color: Colors.white.withOpacity(0.5),
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                appliance,
                style: kLightDeviceBottomBar,
              ),
            ],
          ),
          Container(
            child: Icon(icon, size: 48, color: bulb_color),
          ),
        ],
      ),
    );
  }

  Column faucetController(
      BuildContext context, String roomName, String devName) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        topAppBar(roomName, 'Faucet', FontAwesomeIcons.shower),
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
                stream: itemRef
                    .child("Rooms/" + roomName + "/devices/" + devName + "/")
                    .onValue,
                builder: (context, snap) {
                  Map<String, dynamic> values =
                      new Map<String, dynamic>.from(snap.data.snapshot.value);
                  return Switch(
                    value: convert(values["State"]),
                    onChanged: (value) {
                      stateChange(value, roomName, devName);
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
                      if (water_amount > 1) water_amount = water_amount - 1;
                    }),
                child: Icon(Icons.remove_circle_outline, size: 45)),
            SizedBox(
              width: 15,
            ),
            Text(
              '$water_amount Oz',
              style: kLightDeviceBottomBar,
            ),
            SizedBox(
              width: 15,
            ),
            InkWell(
                onTap: () => setState(() {
                      if (water_amount < 20) water_amount = water_amount + 1;
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

  @override
  Widget build(BuildContext context) {
    // bool isSwitched = widget.isDisabled;
    Widget showDevice =
        lightController(context, widget.chRoom, widget.chDevice);

    if (widget.chDevice == 'LAMP') {
      showDevice = lightController(context, widget.chRoom, widget.chDevice);
    } else if (widget.chDevice == 'AC') {
      showDevice = acController(context, widget.chRoom, widget.chDevice);
    } else if (widget.chDevice == 'Speaker') {
      showDevice = speakerController(context, widget.chRoom, widget.chDevice);
    } else if (widget.chDevice == 'TV') {
      showDevice = tvController(context, widget.chRoom, widget.chDevice);
    } else if (widget.chDevice == 'Faucet') {
      showDevice = faucetController(context, widget.chRoom, widget.chDevice);
    }
    return showDevice;
  }
}
