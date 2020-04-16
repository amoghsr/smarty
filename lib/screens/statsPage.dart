import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:smarty/screens/drawer.dart';
import 'package:smarty/shared/constants.dart';
import 'package:smarty/widgets/voiceAgent.dart';

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
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(10),
              ),
              padding: EdgeInsets.all(17),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Column(
                        children: <Widget>[
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                color: Colors.red,
                                height: 10,
                                width: 10,
                              ),
                              SizedBox(width: 5),
                              Text('Consumption'),
                            ],
                          ),
                          Text('Statistics'),
                        ],
                      ),
                      Text('Statistics'),
                      Text('Statistics'),
                      Text('Statistics'),
                    ],
                  ),
                  Column(
                    children: [
                      buildCircularProgressWidget(
                        140,
                        9,
                        0.6,
                        buildCircularProgressWidget(
                            100,
                            9,
                            0.5,
                            buildCircularProgressWidget(
                              60,
                              9,
                              0.4,
                              Container(),
                              Colors.grey.withOpacity(0.4),
                              Colors.yellow,
                            ),
                            Colors.grey.withOpacity(0.4),
                            Colors.teal[300]),
                        Colors.grey.withOpacity(0.2),
                        Colors.red,
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildCircularProgressWidget(double rad, double width, double percent,
      Widget widget, Color col1, Color col2) {
    return CircularPercentIndicator(
      radius: rad,
      lineWidth: width,
      percent: percent,
      center: widget,
      backgroundColor: col1,
      progressColor: col2,
      circularStrokeCap: CircularStrokeCap.round,

    );
  }
}
