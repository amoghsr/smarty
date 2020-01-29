import 'package:flutter/material.dart';
import 'package:smarty/line_chart.dart';

import 'constants.dart';
import 'routineModel.dart';

class MyOtherRoom extends StatefulWidget {
  @override
  _MyOtherRoomState createState() => _MyOtherRoomState();
}

class _MyOtherRoomState extends State<MyOtherRoom> {
  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'MyOtherRoom',
          style: kAppBarTextStyle,
        ),
      ),
      drawer: Drawer(),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          color: Theme.of(context).scaffoldBackgroundColor,

          child: Column(
            children: <Widget>[
              SizedBox(
                height: screenheight * 0.5,
              ),
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

                ),
              ),
              /*Row(
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
                                    mainAxisAlignment: MainAxisAlignment.center,
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
                                                  fontFamily: 'Montserrat',
                                                  fontWeight: FontWeight.w100,
                                                  color: Colors.white
                                                      .withOpacity(0.7),
                                                  fontSize: 10,
                                                ),
                                              ),
                                              SizedBox(
                                                height: screenheight * 0.007,
                                              ),
                                              Text(
                                                '90%',
                                                style: TextStyle(
                                                  fontFamily: 'Poppins',
                                                  fontWeight: FontWeight.w700,
                                                  color: Theme.of(context)
                                                      .accentColor,
                                                  fontSize: 24,
                                                ),
                                              ),
                                              Text(
                                                '-',
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
                          padding: EdgeInsets.only(left: screenwidth * 0.03),
                          child: Row(
                            // alignment: Alignment.,
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
                                              '103.5',
                                              style: TextStyle(
                                                fontFamily: 'Poppins',
                                                fontWeight: FontWeight.w700,
                                                color:
                                                Theme.of(context).accentColor,
                                                fontSize: 24,
                                              ),
                                            ),
                                            Text(
                                              'AMOUNT DUE',
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
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ), */
            ],
          ),
        ),
      ),
    );
  }
}
