import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import 'package:smarty/Devices/CommonControllers/deviceCommonControllers.dart';
import 'package:smarty/constants.dart';

class ACController extends StatelessWidget {
  const ACController({
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
  Widget build(BuildContext context) {
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

 
}
