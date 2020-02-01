import 'package:flutter/material.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import 'package:smarty/constants.dart';

class DevicesController extends StatefulWidget {
  @override
  String chRoom;
  String chDevice;
  DevicesController({this.chDevice, this.chRoom});
  _DevicesControllerState createState() => _DevicesControllerState();
}

Color bulb_color = Colors.white;

class _DevicesControllerState extends State<DevicesController> {
  @override
  bool isSwitched = true;

  int brightness = 60;

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

  Column lightController(BuildContext context) {
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
                    'Living Room',
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

  @override
  Widget build(BuildContext context) {
    Widget showDevice = lightController(context);

    if (widget.chDevice == 'LAMP') {
      showDevice = lightController(context);
    } else if (widget.chDevice == 'A/C') {
      showDevice = acController();
    }
    return showDevice;
  }
}
