import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import 'package:smarty/constants.dart';

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

class _DevicesControllerState extends State<DevicesController> {
  @override
  int brightness = 60;
  var isPlaying = false;
  bool icon = false;

  SleekCircularSlider acController() {
    return SleekCircularSlider(
        initialValue: 24,
        min: 16,
        max: 26,
        appearance: CircularSliderAppearance(
            customColors: CustomSliderColors(
              trackColor: Colors.grey,
              progressBarColor: Colors.lightGreenAccent,
            ),
            customWidths: CustomSliderWidths(),
            infoProperties: InfoProperties(
              mainLabelStyle: TextStyle(color: Colors.white, fontSize: 60),
              modifier: (value) {
                final roundedValue = (value).ceil().toInt().toString();
                return '$roundedValue°C';
              },
            )),
        onChange: (double value) {
          print(value);
        });
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
                child: Icon(Icons.wb_incandescent, size: 48, color: bulb_color),
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
                child: Switch(
                  value: isSwitched,
                  onChanged: (value) {
                    setState(() {
                      isSwitched = value;
                    });
                  },
                  activeTrackColor: Theme.of(context).backgroundColor,
                  activeColor: Colors.lightGreenAccent,
                  inactiveTrackColor: Theme.of(context).backgroundColor,
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
            GestureDetector(
                onTap: () {
                  setState(() {
                    bulb_color = Colors.green;
                  });
                },
                child: colorRow(Colors.green)),
            GestureDetector(
              onTap: () {
                setState(() {
                  bulb_color = Colors.lightBlue;
                });
              },
              child: colorRow(Colors.lightBlue),
            ),
            GestureDetector(
                onTap: () {
                  setState(() {
                    bulb_color = Colors.indigo;
                  });
                },
                child: colorRow(Colors.indigo)),
            GestureDetector(
                onTap: () {
                  setState(() {
                    bulb_color = Colors.purple;
                  });
                },
                child: colorRow(Colors.purple)),
            GestureDetector(
                onTap: () {
                  setState(() {
                    bulb_color = Colors.red;
                  });
                },
                child: colorRow(Colors.red)),
            GestureDetector(
                onTap: () {
                  setState(() {
                    bulb_color = Colors.orange;
                  });
                },
                child: colorRow(Colors.orange)),
            GestureDetector(
                onTap: () {
                  setState(() {
                    bulb_color = Colors.yellow;
                  });
                },
                child: colorRow(Colors.yellow)),
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
        tvSpeakerTopAppBar(roomName, 'Speaker', Icons.speaker),
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
              child: Switch(
                value: isSwitched,
                onChanged: (value) {
                  setState(() {
                    isSwitched = value;
                  });
                },
                activeTrackColor: Theme.of(context).backgroundColor,
                activeColor: Colors.lightGreenAccent,
                inactiveTrackColor: Theme.of(context).backgroundColor,
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
                setState(() => icon = !icon);
              },
              child: (icon == true)
                  ? Icon(
                      Icons.pause_circle_outline,
                      size: 60.0,
                    )
                  : Icon(
                      Icons.play_circle_outline,
                      size: 60.0,
                    ),
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
        tvSpeakerTopAppBar(roomName, 'TV', Icons.tv),
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
              child: Switch(
                value: isSwitched,
                onChanged: (value) {
                  setState(() {
                    isSwitched = value;
                  });
                },
                activeTrackColor: Theme.of(context).backgroundColor,
                activeColor: Colors.lightGreenAccent,
                inactiveTrackColor: Theme.of(context).backgroundColor,
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

  Container tvSpeakerTopAppBar(
      String roomName, String appliance, IconData icon) {
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

  @override
  Widget build(BuildContext context) {
    // bool isSwitched = widget.isDisabled;
    Widget showDevice =
        lightController(context, widget.chRoom, widget.chDevice);

    if (widget.chDevice == 'LAMP') {
      showDevice = lightController(context, widget.chRoom, widget.chDevice);
    } else if (widget.chDevice == 'A/C') {
      showDevice = acController();
    } else if (widget.chDevice == 'Speaker') {
      showDevice = speakerController(context, widget.chRoom, widget.chDevice);
    } else if (widget.chDevice == 'TV') {
      showDevice = tvController(context, widget.chRoom, widget.chDevice);
    }
    return showDevice;
  }
}
