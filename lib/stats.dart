import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:flutter/material.dart';
import 'package:smarty/line_chart.dart';

import 'constants.dart';

class Statistics extends StatefulWidget {
  @override
  _StatisticsState createState() => _StatisticsState();
}

class _StatisticsState extends State<Statistics> {
  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;

    bool pressed = false;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Statistics',
          style: kAppBarTextStyle,
        ),
      ),
      drawer: Drawer(),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          color: Theme.of(context).scaffoldBackgroundColor,
          child: DefaultTabController(
            length: 3,
            child: Column(
              children: <Widget>[
                TabBar(
                  labelColor: Theme.of(context).cardColor,
                  unselectedLabelColor: Colors.white,
                  indicator: BubbleTabIndicator(
                    indicatorHeight: 25.0,
                    indicatorColor: Theme.of(context).accentColor,
                    tabBarIndicatorSize: TabBarIndicatorSize.tab,
                  ),
                  indicatorSize: TabBarIndicatorSize.tab,
                  tabs: [
                    Tab(
                      child: Text(
                        'Day',
                        // style: TextStyle(color: Theme.of(context).cardColor),
                      ),
                    ),
                    Tab(
                      child: Text(
                        'Week',
                        // style: TextStyle(color: Theme.of(context).cardColor)
                      ),
                    ),
                    Tab(
                      child: Text(
                        'Month',
                        // style: TextStyle(color: Theme.of(context).cardColor),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: <Widget>[
                    SizedBox(height: screenheight * 0.01),
                    Text(
                      'Energy Consumed',
                      style: TextStyle(
                        color: Theme.of(context).accentColor,
                        fontSize: 20,
                        fontFamily: 'Montserrat',
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: screenheight * 0.01),
                    Container(
                      height: screenheight * 0.35,
                      width: screenwidth,
                      child: TabBarView(
                        children: [
                          LineChartSample2('Day', 5, 49),
                          LineChartSample2('Week', 1.7, 13),
                          LineChartSample2('Month', 2.8, 23),
                        ],
                      ),
                    ),
                    SizedBox(height: screenheight * 0.01),
                    Container(
                      child: Container(
                        height: screenheight * 0.07,
                        child: Row(
                          children: <Widget>[
                            SizedBox(width: screenwidth * 0.05),
                            Container(
                              child: Column(
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      Text(
                                        'TODAY 3PM',
                                        style: TextStyle(
                                          fontFamily: 'Montserrat',
                                          color: Theme.of(context).accentColor,
                                          fontSize: 12,
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Text(
                                        '76 kWh',
                                        style: TextStyle(
                                          fontFamily: 'Montserrat',
                                          color: Theme.of(context).accentColor,
                                          fontSize: 20,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: screenwidth * 0.28),
                            Column(
                              children: <Widget>[
                                Container(
                                  color: Theme.of(context).accentColor,
                                  width: screenwidth * 0.4,
                                  height: screenheight * 0.05,
                                  child: Center(
                                    child: Text(
                                      'VIEW GENERATION',
                                      style: TextStyle(
                                          color: Theme.of(context)
                                              .bottomAppBarColor,
                                          fontFamily: 'Montserrat',
                                          fontSize: 10,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Divider(),
                    Container(
                      height: screenheight * 0.15,
//          color: Colors.blue,
                      child: Container(
                        margin: EdgeInsets.all(8.0),
                        width: screenwidth * 0.9,
                        decoration: BoxDecoration(
                          color: Theme.of(context).backgroundColor,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Row(
                          // alignment: Alignment.,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.all(6.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Column(
                                        children: <Widget>[
                                          Icon(
                                            Icons.power,
                                            size: 35,
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        width: screenwidth * 0.03,
                                      ),
                                      Column(
                                        children: <Widget>[
                                          Text(
                                            'CONSUMING',
                                            style: TextStyle(
                                              fontFamily: 'Montserrat',
                                              fontWeight: FontWeight.w100,
                                              color:
                                                  Colors.white.withOpacity(0.7),
                                              fontSize: 10,
                                            ),
                                          ),
                                          SizedBox(
                                            height: screenheight * 0.007,
                                          ),
                                          Text(
                                            '2 kWh',
                                            style: TextStyle(
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.w700,
                                              color:
                                                  Theme.of(context).accentColor,
                                              fontSize: 24,
                                            ),
                                          ),
                                          Text(
                                            '3 DEVICES',
                                            style: TextStyle(
                                              fontFamily: 'Montserrat',
                                              fontWeight: FontWeight.w400,
                                              color: Colors.white,
                                              fontSize: 10,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              height: screenheight * 0.09,
                              width: screenwidth * 0.13,
                              child: VerticalDivider(
                                color: Colors.black,
                                thickness: 0.8,
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Column(
                                      children: <Widget>[
                                        Icon(
                                          Icons.flash_on,
                                          size: 35,
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      width: screenwidth * 0.03,
                                    ),
                                    Column(
                                      children: <Widget>[
                                        Text(
                                          'GENERATING',
                                          style: TextStyle(
                                            fontFamily: 'Montserrat',
                                            fontWeight: FontWeight.w100,
                                            color:
                                                Colors.white.withOpacity(0.7),
                                            fontSize: 10,
                                          ),
                                        ),
                                        SizedBox(
                                          height: screenheight * 0.005,
                                        ),
                                        Text(
                                          '103 Wh',
                                          style: TextStyle(
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w700,
                                            color:
                                                Theme.of(context).accentColor,
                                            fontSize: 24,
                                          ),
                                        ),
                                        Text(
                                          '40% COVERAGE',
                                          style: TextStyle(
                                            fontFamily: 'Montserrat',
                                            fontWeight: FontWeight.w400,
                                            color: Colors.white,
                                            fontSize: 10,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Row(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.only(left: screenwidth * 0.03),
                          child: Align(
                            alignment: Alignment.bottomLeft,
                            child: Container(
                              height: screenheight * 0.15,
//          color: Colors.blue,
                              child: Flexible(
                                child: Container(
                                  margin: EdgeInsets.all(8.0),
                                  width: screenwidth * 0.4,
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).backgroundColor,
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  child: Row(
                                    // alignment: Alignment.,
                                    children: <Widget>[
                                      Padding(
                                        padding: EdgeInsets.all(6.0),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: <Widget>[
                                                Column(
                                                  children: <Widget>[
                                                    Icon(
                                                      Icons.battery_full,
                                                      size: 35,
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  width: screenwidth * 0.03,
                                                ),
                                                Column(
                                                  children: <Widget>[
                                                    Text(
                                                      'BATTERY LEVEL',
                                                      style: TextStyle(
                                                        fontFamily:
                                                            'Montserrat',
                                                        fontWeight:
                                                            FontWeight.w100,
                                                        color: Colors.white
                                                            .withOpacity(0.7),
                                                        fontSize: 10,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height:
                                                          screenheight * 0.007,
                                                    ),
                                                    Text(
                                                      '90%',
                                                      style: TextStyle(
                                                        fontFamily: 'Poppins',
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        color: Theme.of(context)
                                                            .accentColor,
                                                        fontSize: 24,
                                                      ),
                                                    ),
                                                    Text(
                                                      '-',
                                                      style: TextStyle(
                                                        fontFamily:
                                                            'Montserrat',
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color: Colors.white,
                                                        fontSize: 10,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        //3rd card
                        Flexible(
                          child: Container(
                            padding: EdgeInsets.only(right: screenwidth * 0.03),
                            height: screenheight * 0.15,
//          color: Colors.blue,
                            child: Container(
                              margin: EdgeInsets.all(8.0),
                              width: screenwidth * 0.6,
                              decoration: BoxDecoration(
                                color: Theme.of(context).backgroundColor,
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Container(
                                padding:
                                    EdgeInsets.only(left: screenwidth * 0.03),
                                child: Row(
                                  // alignment: Alignment.,
                                  children: <Widget>[
                                    Padding(
                                      padding: EdgeInsets.all(6.0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: <Widget>[
                                              Column(
                                                children: <Widget>[
                                                  Icon(
                                                    Icons.euro_symbol,
                                                    size: 35,
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                width: screenwidth * 0.03,
                                              ),
                                              Column(
                                                children: <Widget>[
                                                  Text(
                                                    'VIEW BILLS',
                                                    style: TextStyle(
                                                      fontFamily: 'Montserrat',
                                                      fontWeight:
                                                          FontWeight.w100,
                                                      color: Colors.white
                                                          .withOpacity(0.7),
                                                      fontSize: 10,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height:
                                                        screenheight * 0.007,
                                                  ),
                                                  Text(
                                                    '103.5',
                                                    style: TextStyle(
                                                      fontFamily: 'Poppins',
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      color: Theme.of(context)
                                                          .accentColor,
                                                      fontSize: 24,
                                                    ),
                                                  ),
                                                  Text(
                                                    'AMOUNT DUE',
                                                    style: TextStyle(
                                                      fontFamily: 'Montserrat',
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: Colors.white,
                                                      fontSize: 10,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
