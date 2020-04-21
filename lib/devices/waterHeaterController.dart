import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import 'package:smarty/devices/CommonControllers/deviceCommonControllers.dart';
import 'package:smarty/models/user.dart';
import 'package:smarty/shared/constants.dart';

class WaterHeaterController extends StatelessWidget {
  const WaterHeaterController({
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
                    color: Colors.white.withOpacity(0.5),
                  ),
                ),
                SizedBox(
                  height: 4.0,
                ),
                Text(
                  'Water Heater',
                  style: kLightDeviceBottomBar,
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Text(
                      'Temperature',
                      style: kLightDeviceTopBar.copyWith(
                        color: Theme.of(context).disabledColor,
                      ),
                    ),
                    SizedBox(
                      height: 4.0
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
                          "55°C",
                          style: kLightDeviceBottomBar,
                        );
                      },
                    ),
                  ],
                ),
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
                child: SleekCircularSlider(
              initialValue: 50,
              min: 45,
              max: 55,
              appearance: CircularSliderAppearance(
                  size: screenheight,
                  customColors: CustomSliderColors(
                    trackColor: Colors.grey,
                    progressBarColor: Colors.deepOrange,
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
                    topLabelText: 'Current Temp.',
                    mainLabelStyle:
                        TextStyle(color: Colors.white, fontSize: 35),
                    modifier: (value) {
                      // final roundedValue =
                      //     (value).ceil().toInt().toString();
                      return '55 °C';
                    },
                  )),
            )),
          ),
        ),
      ],
    );
  }
}
