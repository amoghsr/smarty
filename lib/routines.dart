import 'package:flutter/material.dart';
import 'package:smarty/constants.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'routineModel.dart';

class RoutineScreen extends StatefulWidget {
  @override
  _RoutineScreenState createState() => _RoutineScreenState();
}

class _RoutineScreenState extends State<RoutineScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'All Routines',
            style: kAppBarTextStyle,
          ),
        ),
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(
                    left: 30.0, right: 20.0, bottom: 20.0, top: 20),
                child: Text(
                  'Routines allow you to operate or set schedules for multiple devices in your house.',
                  style: TextStyle(
                    fontSize: 12,
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: routines.length,
                  itemBuilder: (BuildContext context, int index) {
                    Routine routine = routines[index];
                    return Container(
                      margin: EdgeInsets.all(8.0),
                      width: 400.0,
                      child: Stack(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.all(20),
                            height: 80.0,
                            width: 400.0,
                            decoration: BoxDecoration(
                              color: Color(0xff333333),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    routine.icon,
                                  ],
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 25.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                        Row(
                                          children: <Widget>[
                                            Text(
                                              routine.routineName,
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(top: 1.0),
                                          child: Row(
                                            children: <Widget>[
                                              Opacity(
                                                opacity: 0.5,
                                                child: Text(
                                                  routine.routineDesc,
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Row(
                                      children: <Widget>[
                                        Icon(Icons.arrow_forward_ios, color: Color(0xFFf8931f),),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );

                  },
                ),
              ),
            ],
          ),
//          child: getListView(),
        ),
      ),
    );
  }
}
