import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
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
    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;
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
                  height: screenheight * 0.015,
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
                      height: screenheight * 0.015,
                    ),
                    StreamBuilder(
                      stream: itemRef.child("Sensors/TempandHumid/").onValue,
                      builder: (context, snap) {
                        if (snap.data == null)
                          return Text(
                            "30",
                            style: kLightDeviceBottomBar,
                          );
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
                  width: screenwidth * 0.06,
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
                      height: screenheight * 0.015,
                    ),
                    StreamBuilder(
                      stream: itemRef.child("Sensors/TempandHumid/").onValue,
                      builder: (context, snap) {
                        if (snap.data == null)
                          return Text(
                            "30%",
                            style: kLightDeviceBottomBar,
                          );
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
        SizedBox(
          height: screenheight * 0.01,
        ),
        Expanded(
          child: Center(
            child: Container(
              child: StreamBuilder(
                stream: itemRef
                    .child("Rooms/" + roomName + "/devices/" + devName + "/")
                    .onValue,
                builder: (context, snap) {
                  if (snap.data == null)
                    return SleekCircularSlider(
                        initialValue: 24,
                        min: 16,
                        max: 26,
                        appearance: CircularSliderAppearance(
                            size: screenheight,
                            customColors: CustomSliderColors(
                              trackColor: Colors.grey,
                              progressBarColor: Colors.lightGreenAccent,
                            ),
                            customWidths: CustomSliderWidths(
                              trackWidth: 15,
                              progressBarWidth: 15,
                            ),
                            infoProperties: InfoProperties(
                              topLabelStyle: kLightDeviceTopBar.copyWith(
                                color: Colors.white.withOpacity(0.5),
                                fontSize: 16,
                              ),
                              topLabelText: 'Set Temp.',
                              mainLabelStyle:
                                  TextStyle(color: Colors.white, fontSize: 35),
                              modifier: (value) {
                                final roundedValue =
                                    (value).ceil().toInt().toString();
                                return '$roundedValue°C';
                              },
                            )),
                        onChangeEnd: (double value) {
                          setTemp(value.ceil().toInt(), roomName, devName);
                          print(value);
                        });
                  Map<String, dynamic> values =
                      new Map<String, dynamic>.from(snap.data.snapshot.value);
                  return SleekCircularSlider(
                      initialValue: values["Temperature"].toDouble(),
                      min: 16,
                      max: 26,
                      appearance: CircularSliderAppearance(
                          size: screenheight,
                          customColors: CustomSliderColors(
                            trackColor: Colors.grey,
                            progressBarColor: Colors.lightGreenAccent,
                          ),
                          customWidths: CustomSliderWidths(
                            trackWidth: 15,
                            progressBarWidth: 15,
                          ),
                          infoProperties: InfoProperties(
                            topLabelStyle: kLightDeviceTopBar.copyWith(
                              color: Colors.white.withOpacity(0.5),
                              fontSize: 16,
                            ),
                            topLabelText: 'Set Temp.',
                            mainLabelStyle:
                                TextStyle(color: Colors.white, fontSize: 35),
                            modifier: (value) {
                              final roundedValue =
                                  (value).ceil().toInt().toString();
                              return '$roundedValue°C';
                            },
                          )),
                      onChangeEnd: (double value) {
                        setTemp(value.ceil().toInt(), roomName, devName);
                        print(value);
                      });
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}
