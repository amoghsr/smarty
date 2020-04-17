import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:smarty/screens/drawer.dart';
import 'package:smarty/shared/constants.dart';
import 'package:smarty/widgets/voiceAgent.dart';

import '../line_chart.dart';

class StatsScreen extends StatefulWidget {
  @override
  _StatsScreenState createState() => _StatsScreenState();
}

class _StatsScreenState extends State<StatsScreen> {
  List<bool> isSelected = [true, false, false];

  var _value = '1';

  Widget build(BuildContext context) {
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
                          190,
                          20.0,
                          0.4,
                          buildCircularProgressWidget(
                            136,
                            20.0,
                            0.6,
                            buildCircularProgressWidget(
                              80,
                              20.0,
                              0.8,
                              Container(),
                              Colors.greenAccent.withOpacity(0.4),
                              Colors.greenAccent[400],
                              3000,
                            ),
                            Colors.orange.withOpacity(0.2),
                            Colors.orange[600],
                            2000,
                          ),
                          Colors.red.withOpacity(0.1),
                          Colors.red,
                          1000,
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
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
                                  height: 12.0,
                                  width: 12.0,
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
                                  height: 12.0,
                                  width: 12.0,
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
                                  height: 12.0,
                                  width: 12.0,
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
              ),
              Divider(
                height: 28.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  DropdownButton(
                    underline: Container(),
                    onChanged: (value) {
                      setState(() {
                        _value = value;
                      });
                    },
                    value: _value,
                    items: [
                      DropdownMenuItem(
                        value: "1",
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Icon(MaterialCommunityIcons.devices),
                            SizedBox(width: 10),
                            Text(
                              "Consumption",
                              style: TextStyle(
                                  fontSize: 18.0, fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                      DropdownMenuItem(
                        value: "2",
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Icon(MaterialCommunityIcons.solar_panel),
                            SizedBox(width: 10),
                            Text(
                              "Generation",
                              style: TextStyle(
                                  fontSize: 18.0, fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      ToggleButtons(
                        constraints: BoxConstraints.tight(Size(36, 36)),
//                        borderRadius: BorderRadius.circular(8.0),
                        selectedColor: Theme
                            .of(context)
                            .accentColor,
                        fillColor: Theme
                            .of(context)
                            .primaryColor,
//                        renderBorder: false,
                        children: <Widget>[
                          Text('D'),
                          Text('W'),
                          Text('M'),
                        ],
                        onPressed: (int index) {
                          setState(() {
                            for (int buttonIndex = 0; buttonIndex <
                                isSelected.length; buttonIndex++) {
                              if (buttonIndex == index) {
                                isSelected[buttonIndex] = true;
                              } else {
                                isSelected[buttonIndex] = false;
                              }
                            }
                          });
                        },
                        isSelected: isSelected,
                      ),
//                      GestureDetector(
//                        onTap: () {
//                          setState(() {
//                            pressAttentionD = !pressAttentionD;
//                          });
//                        },
//                        child: Container(
//                          width: 30.0,
//                          padding: EdgeInsets.all(6.0),
//                          decoration: BoxDecoration(
//                            borderRadius: BorderRadius.circular(4.0),
//                            color: pressAttentionD ? Colors.grey : Colors.blue,
//                          ),
//                          child: Center(
//                            child: Text('D'),
//                          ),
//                        ),
//                      ),
//                      SizedBox(width: 6.0),
//                      GestureDetector(
//                        child: Container(
//                          width: 30.0,
//                          padding: EdgeInsets.all(6.0),
//                          decoration: BoxDecoration(
//                            borderRadius: BorderRadius.circular(4.0),
//                            color: pressAttentionW ? Colors.grey : Colors.blue,
//                          ),
//                          child: Center(
//                            child: Text('W'),
//                          ),
//                        ),
//                      ),
//                      SizedBox(width: 6.0),
//                      GestureDetector(
//                        onTap: () {
//                          setState(() {
//                            pressAttentionW = !pressAttentionW;
//                            print('gay');
//                          });
//                        },
//                        child: Container(
//                          width: 30.0,
//                          padding: EdgeInsets.all(6.0),
//                          decoration: BoxDecoration(
//                            borderRadius: BorderRadius.circular(4.0),
//                            color: Theme.of(context).primaryColor,
//                          ),
//                          child: Center(
//                            child: Text('Y'),
//                          ),
//                        ),
//                      ),
                    ],
                  ),
                ],
              ),

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
      animationDuration: ani,
      circularStrokeCap: CircularStrokeCap.round,
    );
  }
}
