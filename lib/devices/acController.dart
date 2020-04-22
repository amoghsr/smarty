import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import 'package:smarty/devices/CommonControllers/deviceCommonControllers.dart';
import 'package:smarty/models/user.dart';
import 'package:smarty/shared/constants.dart';

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
    final user = Provider.of<User>(context);
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  roomName,
                  style: kLightDeviceTopBar.copyWith(
                    color: Theme.of(context).disabledColor,
                  ),
                ),
                SizedBox(
                  height: 4,
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
                        color: Theme
                            .of(context)
                            .disabledColor,
                      ),
                    ),
                    SizedBox(
                      height:4,
                    ),
                    StreamBuilder(
                      stream: itemRef
                          .child("Homes/" +
                              user.houseId +
                              "/Sensors/TempandHumid/")
                          .onValue,
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
                          '${values["Temp"].toString()} °C',
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
                        color: Theme
                            .of(context)
                            .disabledColor,
                      ),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    StreamBuilder(
                      stream: itemRef
                          .child("Homes/" +
                              user.houseId +
                              "/Sensors/TempandHumid/")
                          .onValue,
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
          height: screenheight * 0.03,
        ),
        Expanded(
          child: Center(
            child: Container(
              child: StreamBuilder(
                stream: itemRef
                    .child("Homes/" +
                        user.houseId +
                        "/Rooms/" +
                        roomName +
                        "/devices/" +
                        devName +
                        "/")
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
                          setTemp(value.ceil().toInt(), roomName, devName,
                              user.houseId);
//                          print(value);
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
                            trackColor: Theme.of(context).disabledColor,
                            progressBarColor: Theme.of(context).accentColor,
                          ),
                          customWidths: CustomSliderWidths(
                            trackWidth: 20,
                            progressBarWidth: 24,
                          ),
                          infoProperties: InfoProperties(
                            topLabelStyle: kLightDeviceTopBar.copyWith(
                              color: Theme.of(context).disabledColor,
                              fontSize: 18.0,
                              fontWeight: FontWeight.w600
                            ),
                            topLabelText: 'Set Temp.',
                            mainLabelStyle:
                                TextStyle(fontWeight: FontWeight.bold, fontSize: 36),
                            modifier: (value) {
                              final roundedValue =
                                  (value).ceil().toInt().toString();
                              return '$roundedValue°C';
                            },
                          )),
                      onChangeEnd: (double value) {
                        setTemp(value.ceil().toInt(), roomName, devName,
                            user.houseId);
//                        print(value);
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
