import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:smarty/screens/drawer.dart';
import 'package:smarty/shared/constants.dart';
import 'package:smarty/widgets/voiceAgent.dart';

import '../energyData.dart';
import '../line_chart.dart';

class StatsScreen extends StatefulWidget {
  @override
  _StatsScreenState createState() => _StatsScreenState();
}

class _StatsScreenState extends State<StatsScreen> {
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'Statistics',
            style: kAppBarTextStyle,
          ),
        ),
        actions: <Widget>[MicClass()],
      ),
      drawer: DrawerPage(),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 16.0),
          child: Column(
            children: [

              /// DAILY CONSUMPTION CONTAINER
              Container(
                decoration: BoxDecoration(
//                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Text('DAILY CONSUMPTION LIMIT'),
                            ],
                          ),
                          Text(
                            '19 KWh',
                            style: TextStyle(
                                fontSize: 24.0, fontWeight: FontWeight.w600),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Divider(
                height: 20.0,
              ),

              /// CIRCLE INDICATOR CONTAINER
              Container(
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
                padding: EdgeInsets.symmetric(horizontal: 12.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        buildCircularProgressWidget(
                          200,
                          24.0,
                          0.4,
                          buildCircularProgressWidget(
                            136,
                            20.0,
                            0.4,
                            buildCircularProgressWidget(
                              80,
                              20.0,
                              0.4,
                              Container(),
                              Colors.greenAccent.withOpacity(0.4),
                              Colors.greenAccent[400],
                              3,
                            ),
                            Colors.orange.withOpacity(0.2),
                            Colors.orange[600],
                            6,
                          ),
                          Colors.red.withOpacity(0.1),
                          Colors.red,
                          7,
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[

                        /// BOX ONE
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.red,
                                    shape: BoxShape.circle,
                                  ),
                                  height: 10.0,
                                  width: 10.0,
                                ),
                                SizedBox(width: 4.0),
                                Text('Community'),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: <Widget>[
                                Text(
                                  '100',
                                  style: TextStyle(
                                    height: 1,
                                    fontSize: 32.0,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 4.0, bottom: 4.0),
                                  child: Text(
                                    'KWh',
                                    style:
                                    TextStyle(height: 1.0, fontSize: 14.0),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                        SizedBox(height: 12.0),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.orange[600],
                                    shape: BoxShape.circle,
                                  ),
                                  height: 10.0,
                                  width: 10.0,
                                ),
                                SizedBox(width: 4.0),
                                Text('Consumption'),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: <Widget>[
                                Text(
                                  '100',
                                  style: TextStyle(
                                    height: 1,
                                    fontSize: 32.0,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 4.0, bottom: 4.0),
                                  child: Text(
                                    'KWh',
                                    style:
                                    TextStyle(height: 1.0, fontSize: 14.0),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                        SizedBox(height: 12.0),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.greenAccent,
                                    shape: BoxShape.circle,
                                  ),
                                  height: 10.0,
                                  width: 10.0,
                                ),
                                SizedBox(width: 4.0),
                                Text('Generation'),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: <Widget>[
                                Text(
                                  '100',
                                  style: TextStyle(
                                    height: 1,
                                    fontSize: 32.0,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 4.0, bottom: 4.0),
                                  child: Text(
                                    'KWh',
                                    style:
                                    TextStyle(height: 1.0, fontSize: 14.0),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ],
                    )
                  ],
                ),
//              child: Row(
//                mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                crossAxisAlignment: CrossAxisAlignment.center,
//                children: [
//                  Column(
//                    children: [
//                      buildCircularProgressWidget(
//                        140,
//                        9,
//                        0.6,
//                        buildCircularProgressWidget(
//                            100,
//                            9,
//                            0.5,
//                            buildCircularProgressWidget(
//                              60,
//                              9,
//                              0.4,
//                              Container(),
//                              Colors.grey.withOpacity(0.4),
//                              Colors.yellow,
//                            ),
//                            Colors.grey.withOpacity(0.4),
//                            Colors.teal[300]),
//                        Colors.grey.withOpacity(0.2),
//                        Colors.red,
//                      )
//                    ],
//                  ),
//                ],
//              ),
              ),

              Divider(
                height: 20.0,
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Energy Consumption',
                    style: TextStyle(fontSize: 18.0),
                  ),
                  Row(
                    children: <Widget>[
                      GestureDetector(
                        child: Container(
                          width: 30.0,
                          padding: EdgeInsets.all(6.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4.0),
                            color: Theme
                                .of(context)
                                .primaryColor,
                          ),
                          child: Center(
                            child: Text('D'),
                          ),
                        ),
                      ),
                      SizedBox(width: 6.0),
                      GestureDetector(
                        child: Container(
                          width: 30.0,
                          padding: EdgeInsets.all(6.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4.0),
                            color: Theme
                                .of(context)
                                .primaryColor,
                          ),
                          child: Center(
                            child: Text('D'),
                          ),
                        ),
                      ),
                      SizedBox(width: 6.0),
                      GestureDetector(
                        child: Container(
                          width: 30.0,
                          padding: EdgeInsets.all(6.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4.0),
                            color: Theme
                                .of(context)
                                .primaryColor,
                          ),
                          child: Center(
                            child: Text('D'),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: <Widget>[
                    Container(
                      height: screenheight * 0.35,
                      child: LineChartSample2('Consumption', 'Week', 1.7, 13),
                    ),
                  ],
                ),
              ),

              /// GRAPHS
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    children: <Widget>[
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildCircularProgressWidget(double rad, double width, double percent,
      Widget widget, Color col1, Color col2, int ani) {
    return CircularPercentIndicator(
      radius: rad,
      lineWidth: width,
      percent: percent,
      center: widget,
      backgroundColor: col1,
      progressColor: col2,
      animation: true,
      circularStrokeCap: CircularStrokeCap.round,
    );
  }
}
