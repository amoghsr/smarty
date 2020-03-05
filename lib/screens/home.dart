/*
* The home page and the initial page the app starts with.
* This page acts as a doorway to all other parts such as the different rooms,
* various routines and the nav bar (But this stays common to all)
*/

//import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:smarty/models/dbService.dart';
import 'package:smarty/models/devicesModel.dart';
import 'package:smarty/models/themeModel.dart';
import 'package:smarty/models/user.dart';
import 'package:smarty/screens/drawer.dart';
import 'package:smarty/screens/homeManager.dart';
import 'package:smarty/screens/manageUsers.dart';
import 'package:smarty/services/auth.dart';
import 'package:smarty/shared/constants.dart';
import 'package:smarty/widgets/devicesCarousel.dart';
import 'package:smarty/widgets/roomCarousel.dart';
import 'package:smarty/widgets/routineCarousel.dart';
import 'package:smarty/services/database.dart';
import 'package:smarty/models/weatherModel.dart';

import '../alertBox.dart';

class Home extends StatefulWidget {
//  final weatherdata;
//  Home(this.weatherdata);
//  final FirebaseUser currentUser;   //Ignore
//  Home(this.currentUser);           //Ignore
  @override
  _HomeState createState() => _HomeState();
}

var now = new DateTime.now();
var date = new DateFormat('dd');
String formattedDate = date.format(now);
var year = new DateFormat('y');
String formattedYear = year.format(now);
var month = new DateFormat('MMMM');
String formattedMonth = month.format(now);

class _HomeState extends State<Home> {
  final AuthService _auth = AuthService();

  DatabaseReference itemRef;
  bool valueSwitch = true;

  var weatherdata = WeatherModel().weatherData();

  void initState() {
    super.initState();
//    var l = getLocationData();
    final FirebaseDatabase database = FirebaseDatabase
        .instance; //Rather then just writing FirebaseDatabase(), get the instance.
    itemRef = database.reference();
//    storeValues(l);
//    fetchData();
  }

  @override
  /*
  * A notification plugin that provides the app with the ability to send notifications to
  * the user for certain events such as when there is an anomaly (fire) detected by the flame detector.
  */
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  WeatherModel wm = WeatherModel();

  int temperature;
  int condition;
  String cityName;

//  void storeValues(dynamic weatherdata) {
//    setState(() {
//      if (weatherdata == null) {
//        temperature = 0;
//        condition = 0;
//        cityName = 'ERROR';
//        return;
//      }
//      var temp = weatherdata['main']["temp"];
//      temperature = temp.toInt();
//      condition = weatherdata["weather"][0]["id"];
//      cityName = weatherdata["name"];
//    });
//  }
//  bool isLoading = false;
//
//  fetchData() async {
//    setState(() {
//      isLoading = true; //Data is loading
//    });
//    if (weatherdata == null) {
//      temperature = 0;
//      condition = 0;
//      cityName = 'ERROR';
//      return;
//    }
//    var temp = weatherdata['main']["temp"];
//    temperature = temp.toInt();
//    condition = weatherdata["weather"][0]["id"];
//    cityName = weatherdata["name"];
//    setState(() {
//      isLoading = false; //Data has loaded
//    });
//  }

  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Home',
          style: kAppBarTextStyle,
        ),
        actions: <Widget>[
          new IconButton(
            icon: Icon(
              Icons.notifications_none,
              semanticLabel: 'Notifcations',
            ),
            onPressed: () async {
              showDialog(
                  context: context,
                  builder: (BuildContext context) => StreamBuilder(
                        stream: itemRef.child("Sensors/Fire/").onValue,
                        builder: (context, snap) {
                          if (snap.data == null)
                            return CustomDialog(
                              image: Image.asset("assets/images/fire.png"),
                              title: "NO NOTIFICATION!",
                              description: "What a boring day",
                              col: Color(0xffE26069),
                              buttonText: "Okay",
                            );
                          Map<String, dynamic> values =
                              new Map<String, dynamic>.from(
                                  snap.data.snapshot.value);
                          if (values["Danger"] == "high") {
                            return CustomDialog(
                              image: Image.asset("assets/images/fire.png"),
                              title: "FIRE DETECTED!",
                              description: "Sprinklers have been activated.",
                              col: Color(0xffE26069),
                              buttonText: "Okay",
                            );
                          } else {
                            return CustomDialog(
                              image: Image.asset("assets/images/fire.png"),
                              title: "NO NOTIFICATION!",
                              description: "What a boring day",
                              col: Color(0xffE26069),
                              buttonText: "Okay",
                            );
                          }
                        },
                      ));
              await _showNotificationWithDefaultSound(
                  'FIRE DETECTED', 'Sprinklers have been activated.');
            },
          ),
        ],
      ),

      // Drawer is the hamburger menu.
      // Here starts the body of the Home Page, nested inside a SafeArea widget to keep content inside the viewport
      drawer: DrawerPage(),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(vertical: 20.0),
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 20.0, right: 120.0, bottom: 3.0),
              child: Opacity(
                opacity: 0.6,
                child: Text(
                  '$formattedDate $formattedMonth $formattedYear',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Welcome Home, Ben',
                    //${widget.currentUser.email}`
                    style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'Poppins'),
                  ),
                  Text(
                    '32°C',
                    //${widget.currentUser.email}`
                    style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Poppins'),
                  ),
                ],
              ),
            ),

            SizedBox(
              height: 20.0,
            ),
            // The routine carousel is a carousel which lists the routines in the house based on a routine model. (routineCarousel.dart)
            RoutineCarousel(),
            Divider(),
            // The room carousel is a carousel which lists the rooms in the house based on a room model. (roomCarousel.dart)
            RoomCarousel(),
            Divider(),
            // The device carousel is a carousel which lists the devices in the house based on a device model. (deviceCarousel.dart)
            DeviceCarousel(),
          ],
        ),
      ),
    );
  }

  Future _showNotificationWithDefaultSound(String title, String desc) async {
    flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();
    var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
        'Smarty', 'Kaizen Systems', 'Stage 2',
        importance: Importance.Max, priority: Priority.High);
    var iOSPlatformChannelSpecifics = new IOSNotificationDetails();
    var platformChannelSpecifics = new NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
      0,
      title,
      desc,
      platformChannelSpecifics,
      payload: 'Default_Sound',
    );
  }
}
