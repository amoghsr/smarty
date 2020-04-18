/*
* The home page and the initial page the app starts with.
* This page acts as a doorway to all other parts such as the different rooms,
* various routines and the nav bar (But this stays common to all)
*/

import 'dart:async';
import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:smarty/models/themeModel.dart';
import 'package:smarty/models/weatherModel.dart';
import 'package:smarty/screens/drawer.dart';
import 'package:smarty/screens/p2pPanel.dart';
import 'package:smarty/services/auth.dart';
import 'package:smarty/shared/constants.dart';
import 'package:smarty/widgets/devicesCarousel.dart';
import 'package:smarty/widgets/roomCarousel.dart';
import 'package:smarty/widgets/routineCarousel.dart';
import 'package:smarty/widgets/voiceAgent.dart';
import 'package:weather/weather.dart';
import '../alertBox.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
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
  double weather;
  String key = 'd6990a93802ef960b648309d2769ec32';

  Future<Position> getPosition() async {
    Position position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    return position;
  }

  Future getWeather(var lat, var lon) async {
    http.Response response = await http.get(
        'https://api.openweathermap.org/data/2.5/weather?lat=${lat.toInt()}&units=metric&lon=${lon.toInt()}&appid=d6990a93802ef960b648309d2769ec32');

    var results = jsonDecode(response.body);
    setState(() {
      this.weather = results['main']['temp'];
    });
  }

  void initState() {
    super.initState();
    getPosition().then((position) {
      getWeather(position.latitude, position.longitude);
    });

    final FirebaseDatabase database = FirebaseDatabase
        .instance; //Rather then just writing FirebaseDatabase(), get the instance.
    itemRef = database.reference();
  }

  @override
  /*
  * A notification plugin that provides the app with the ability to send notifications to
  * the user for certain events such as when there is an anomaly (fire) detected by the flame detector.
  */
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text(
              'Home',
              style: kAppBarTextStyle,
            ),
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(MaterialCommunityIcons.theme_light_dark),
              onPressed: () async {
                setState(() {
                  Provider.of<ThemeModel>(context, listen: false).toggleTheme();
                });
              },
            ),
            MicClass()
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
                  opacity: 0.8,
                  child: Text(
                    '$formattedDate $formattedMonth $formattedYear',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600,
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
                      ),
                    ),
                    (weather == null)
                        ? CircularProgressIndicator()
                        : Text(
                            '${weather.round().toString()}°C',
                            //${widget.currentUser.email}`
                            style: TextStyle(
                              fontSize: 24.0,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                  ],
                ),
              ),

              SizedBox(
                height: 20.0,
              ),
              // The routine carousel is a carousel which lists the routines in the house based on a routine model. (routineCarousel.dart)
              RoutineCarousel(),
              Divider(
                height: 28.0,
              ),
              // The room carousel is a carousel which lists the rooms in the house based on a room model. (roomCarousel.dart)
              RoomCarousel(),
              Divider(
                height: 28.0,
              ),
              // The device carousel is a carousel which lists the devices in the house based on a device model. (deviceCarousel.dart)
              DeviceCarousel(),
            ],
          ),
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

// onPressed: () async {
// showDialog(
//       context: context,
//       builder: (BuildContext context) => StreamBuilder(
//             stream: itemRef.child("Sensors/Fire/").onValue,
//             builder: (context, snap) {
//               if (snap.data == null)
//                 return CustomDialog(
//                   image: Image.asset("assets/images/fire.png"),
//                   title: "NO NOTIFICATION!",
//                   description: "What a boring day",
//                   col: Colors.red[500],,
//                   buttonText: "Okay",
//                 );
//               Map<String, dynamic> values =
//                   new Map<String, dynamic>.from(
//                       snap.data.snapshot.value);
//               if (values["Danger"] == "high") {
// return CustomDialog(
//   image: Image.asset("assets/images/fire.png"),
//   title: "FIRE DETECTED!",
//   description: "Sprinklers have been activated.",
//   col: Color(0xffE26069),
//   buttonText: "Okay",
// );
//               } else {
//                 return CustomDialog(
//                   image: Image.asset("assets/images/fire.png"),
//                   title: "NO NOTIFICATION!",
//                   description: "What a boring day",
//                   col: Colors.red[500],,
//                   buttonText: "Okay",
//                 );
//               }
//             },
//           ));
// await _showNotificationWithDefaultSound(
//     'FIRE DETECTED', 'Sprinklers have been activated.');
// },
// ************************* DOORBELL RUNG ******************************//
// return CustomDialog(
//                   image: Image.asset("assets/images/doorbell.png"),
//                   title: "DOORBELL RUNG!",
//                   description: "Someone's at the door!",
//                   col: Colors.red[500],,
//                   buttonText: "Okay",
//                 );
// ************************* AI DIALOG BOX ******************************//
// TODO: POPUP THIS DIALOG WHEN DAILY CONSUMPTION REACHES 80% OF THE CALCULATED DAILY LIMIT
// showDialog(
//   context: context,
//   builder: (BuildContext context) => StreamBuilder(
//     stream: itemRef.child("Sensors/Fire/").onValue,
//     builder: (context, snap) {
//       return CustomDialog(
//         image:
//             Image.asset("assets/images/renewable-energy.png"),
//         title: "CAREFUL!",
//         description:
//             "You have almost reached your daily limit!",
//         col: Colors.red[500],
//         buttonText: "Optimize Now",
//         optimize: true,
//       );
//     },
//   ),
// );

// ************************* P2P DIALOG BOX ******************************//
// TODO: POPUP THIS DIALOG WHEN DAILY CONSUMPTION REACHES THE DAILY GENERATION VALUE (BATTERY LEVEL EMPTY)
// TODO: POPUP THIS DIALOG ONLY AFTER 6PM (WHEN GENERATION IS ZERO BECAUSE DURING THE DAY THE GENERATION VALUE KEEPS INCREASING)

// showDialog(
//                   context: context,
//                   builder: (BuildContext context) => StreamBuilder(
//                     stream: itemRef.child("Sensors/Fire/").onValue,
//                     builder: (context, snap) {
//                       return CustomDialog(
//                         image: Image.asset("assets/images/battery.png"),
//                         title: "BATTERY EMPTY!",
//                         description: "You are running out of electricity!",
//                         col: Colors.red[500],
//                         buttonText: "Purchase Electricity",
//                         path: P2P(),
//                       );
//                     },
//                   ),
//                 );
