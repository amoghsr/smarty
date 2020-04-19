import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:smarty/models/consumptionModel.dart';
import 'package:smarty/models/generationModel.dart';
import 'package:smarty/screens/allDevices.dart';
import 'package:smarty/screens/drawer.dart';
import 'package:smarty/shared/constants.dart';
import 'package:smarty/widgets/voiceAgent.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';

import '../line_chart.dart';

class StatsScreen extends StatefulWidget {
  @override
  _StatsScreenState createState() => _StatsScreenState();
}

class _StatsScreenState extends State<StatsScreen> {
  int percentConverter(double val) {
    batteryValue = val * 100;
    return batteryValue.toInt();
  }

  void initState() {
    super.initState();
    // if (Provider.of<BoltProvider>(context, listen: false).getBalanceAsInt() == 10)
    //   Timer.run(
    //       () => Provider.of<DialogProvider>(context, listen: false).popAi());
  }

  // moied integration for battery
  double doubleBatteryValue = 0.5; // uses single double value from here
  double batteryValue;
  List<bool> isSelected = [true, false, false];

  // USED TO FIND OUT THE SELECTED VIEW BY OPTION FROM THE LIST OF VIEW BY
  int selectedViewIndex = 0;

  // SET THE DROP DOWN LIST INITIAL VALUE TO 0, WHICH IS CONSUMPTION.
  var _value = 0;
  List<String> viewBy = ['Day', 'Week', 'Month'];
  List<String> dropdownItems = ['Consumption', 'Generation'];

  Widget build(BuildContext context) {
    final x = Provider.of<Generation>(context);
    final y = Provider.of<Consumption>(context);
    var now = new DateTime.now();
    var date = new DateFormat('dd');
    int weekly = 0;
    if (y != null) {
      y.weekly.forEach((ke, val) {
        weekly = weekly + val;
      });
    }
    String formattedDate = date.format(now);
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
          padding: const EdgeInsets.symmetric(vertical: 16.0),
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
                            // TODO: DAILY LIMIT IS BASED ON THE NUMBER OF USERS PER HOUSE (9 * N) kwh
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
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 12.0),
                  child: Column(
                    children: <Widget>[
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              buildCircularProgressWidget(
                                190,
                                20.0,
                                //TODO: (AVERAGE DAILY CONSUMPTION OF OTHER HOUSES / AVERAGE DAILY CONSUMPTION LIMIT OF OTHER HOUSES)
                                0.4,
                                buildCircularProgressWidget(
                                  136,
                                  20.0,
                                  y.dailyTotal.toDouble() / 400,
                                  buildCircularProgressWidget(
                                    80,
                                    20.0,
                                    x.dailyTotal.toDouble() / 500,
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
                                        //TODO: AVERAGE DAILY CONSUMPTION OF ALL OTHER HOUSES (NOT INCLUDING OURS) UP UNTIL THAT POINT OF THE DAY
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
                                          style: TextStyle(
                                              height: 1.0, fontSize: 14.0),
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
                                        y.dailyTotal.toString(),
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
                                          style: TextStyle(
                                              height: 1.0, fontSize: 14.0),
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
                                        x.dailyTotal.toString(),
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
                                          style: TextStyle(
                                              height: 1.0, fontSize: 14.0),
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
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0, bottom: 4.0),
                        child: Column(
                          children: <Widget>[
                            Text(
                              'Comparison between the community average consumption and your own energy consumption.',
                              style: TextStyle(fontSize: 12.0),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Divider(
                height: 24.0,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Row(
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
                          value: 0,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              Icon(MaterialCommunityIcons.power_plug),
                              SizedBox(width: 10),
                              Text(
                                "Consumption",
                                style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        ),
                        DropdownMenuItem(
                          value: 1,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              Icon(MaterialCommunityIcons.solar_panel),
                              SizedBox(width: 10),
                              Text(
                                "Generation",
                                style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.w600),
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
                          selectedColor: Theme.of(context).accentColor,
                          fillColor: Theme.of(context).primaryColor,
//                        renderBorder: false,
                          children: <Widget>[
                            Text(
                              'D',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              'W',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              'M',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                          onPressed: (int index) {
                            setState(() {
                              selectedViewIndex = index;
                              for (int buttonIndex = 0;
                                  buttonIndex < isSelected.length;
                                  buttonIndex++) {
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
                      ],
                    ),
                  ],
                ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Container(
                  height: 250.0,
                  // TODO: Retrieve FLChart values passed in by Piya
                  child: LineChartSample2(
                      dropdownItems[_value], viewBy[selectedViewIndex], 5, 49),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 10.0, horizontal: 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'A detailed graph view that your describes your Energy ${dropdownItems[_value]} sorted by ${viewBy[selectedViewIndex]}.',
                      style: TextStyle(fontSize: 12.0),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 18.0, bottom: 8.0),
                              child: Text(
                                'Today\'s average',
                                style: TextStyle(
                                    color: Theme.of(context).accentColor),
                              ),
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: <Widget>[
                                Text(
                                  // TODO: AVERAGE CONSUMPTION UP UNTIL THAT POINT (TOTAL DAILY CONSUMPTION / TOTAL HOURS THAT HAS PASSED)
                                  (y.dailyTotal / int.parse(formattedDate))
                                      .floor()
                                      .toString(),
                                  style: TextStyle(
                                    height: 1,
                                    fontSize: 34.0,
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
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 18.0, bottom: 8.0),
                              child: Text(
                                'This week\'s average',
                                style: TextStyle(
                                    color: Theme.of(context).accentColor),
                              ),
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: <Widget>[
                                Text(
                                  (weekly / y.weekly.length).toString(),
                                  style: TextStyle(
                                    height: 1,
                                    fontSize: 34.0,
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
                            ),
                          ],
                        )
                      ],
                    )
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AllDevices()),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 24.0, vertical: 12.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(10.0),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black.withOpacity(0.08),
                              offset: Offset(1.0, 3.0),
                              blurRadius: 4.0)
                        ]),
                    padding: EdgeInsets.all(20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Expanded(
                          child: Row(
                            children: <Widget>[
                              Icon(MaterialCommunityIcons.devices),
                              SizedBox(
                                width: 22.0,
                              ),
                              Text(
                                'See All Devices',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Icon(Icons.arrow_forward)
                      ],
                    ),
                  ),
                ),
              ),
              Divider(
                height: 28.0,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Current Battery Level',
                      style: kHeadingTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 12.0, horizontal: 24.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            Text(
                              // TODO: BATTERY ((DAILY GENERATION - DAILY CONSUMPTION)/DAILY GENERATION) * 100
//                              percentConverter(doubleBatteryValue).toString(),
                              (((x.dailyTotal - y.dailyTotal) / x.dailyTotal) *
                                      100)
                                  .floor()
                                  .toString(),
                              style: TextStyle(
                                fontSize: 40.0,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 4.0, bottom: 4.0),
                              child: Text(
                                '%',
                                style: TextStyle(height: 1.0, fontSize: 14.0),
                              ),
                            ),
                          ],
                        ),
                        Text('Battery health is normal'),
                      ],
                    ),
                    LiquidCustomProgressIndicator(
                      center: Text(
                        (((x.dailyTotal - y.dailyTotal) / x.dailyTotal) * 100)
                                .floor()
                                .toString() +
                            '%',
                        style: TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      value: ((x.dailyTotal - y.dailyTotal) / x.dailyTotal),
                      valueColor: AlwaysStoppedAnimation(
                          (((((x.dailyTotal - y.dailyTotal) / x.dailyTotal) *
                                          100)
                                      .floor() <=
                                  20)
                              ? Colors.redAccent
                              : ((((x.dailyTotal - y.dailyTotal) /
                                                      x.dailyTotal) *
                                                  100)
                                              .floor() >
                                          20 &&
                                      (((x.dailyTotal - y.dailyTotal) /
                                                      x.dailyTotal) *
                                                  100)
                                              .floor() <=
                                          60)
                                  ? Colors.orangeAccent
                                  : Colors.greenAccent)),
                      backgroundColor: Theme.of(context).cardColor,
                      direction: Axis.horizontal,
                      shapePath: _buildBattery(),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 32.0,
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

Path _buildBattery() {
  return Path()
    ..addRect(Rect.fromLTWH(0, 0, 100, 60))
    ..addRect(Rect.fromLTWH(100, 10, 10, 40))
    ..close();
}
