import 'package:flutter/material.dart';
import 'package:smarty/shared/constants.dart';

class RoutineDeviceCarousel extends StatefulWidget {
  final Color routineColor;

  const RoutineDeviceCarousel({Key key, this.routineColor}) : super(key: key);

  @override
  _RoutineDeviceCarouselState createState() => _RoutineDeviceCarouselState();
}

class _RoutineDeviceCarouselState extends State<RoutineDeviceCarousel> {
  static Map<String, String> devicesMap = {
    'Living Room-Speaker': 'off',
    'Living Room-TV': 'off',
    'Living Room-Lights': 'off',
    'Bedroom-Lights': 'off',
    'Outdoor-Lights': 'on',
  };

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120.0,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: devicesMap.keys.map((String key) {
          return Padding(
            padding: const EdgeInsets.only(left: 10.0, top: 8.0, bottom: 8.0),
            child: Container(
              width: 110,
              decoration: BoxDecoration(
                color: widget.routineColor,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(14.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      key.split('-')[0],
                      style: kSubtitleText.copyWith(
                        color: Colors.white.withOpacity(0.9),
                        fontSize: 12.0,
                      ),
                    ),
                    Text(
                      key.split('-')[1],
                      style: kAppBarTextStyle.copyWith(
                          color: Colors.white, fontSize: 18.0),
                    ),
                    Text(
                      devicesMap[key].toUpperCase(),
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
