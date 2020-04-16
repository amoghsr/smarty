import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smarty/models/dbRoutines.dart';
import 'package:smarty/models/routineModel.dart';
import 'package:smarty/shared/constants.dart';

class RoutineDeviceCarousel extends StatefulWidget {
  final Color routineColor;
  final Map<String, String> devicesMap;

  const RoutineDeviceCarousel({Key key, this.routineColor, this.devicesMap})
      : super(key: key);

  @override
  _RoutineDeviceCarouselState createState() => _RoutineDeviceCarouselState();
}

class _RoutineDeviceCarouselState extends State<RoutineDeviceCarousel> {
  @override
  Widget build(BuildContext context) {
    final rou = Provider.of<List<dbRoutine>>(context);
    return Container(
      height: 120.0,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: widget.devicesMap.keys.map((String key) {
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
                      widget.devicesMap[key].toUpperCase(),
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
