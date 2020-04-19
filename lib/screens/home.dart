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
import 'package:smarty/models/boltProvider.dart';
<<<<<<< HEAD
import 'package:smarty/models/roomModel.dart';
=======
import 'package:smarty/models/consumptionModel.dart';
import 'package:smarty/models/generationModel.dart';
>>>>>>> 4fb534cfcd1722cb5416b6645b258a8021d95782
import 'package:smarty/models/themeModel.dart';
import 'package:smarty/models/weatherModel.dart';
import 'package:smarty/screens/drawer.dart';
import 'package:smarty/screens/p2pPanel.dart';
import 'package:smarty/services/AIPopUpService.dart';
import 'package:smarty/services/auth.dart';
import 'package:smarty/services/dialogLocator.dart';
import 'package:smarty/services/dialogManager.dart';
import 'package:smarty/shared/constants.dart';
import 'package:smarty/widgets/devicesCarousel.dart';
import 'package:smarty/widgets/roomCarousel.dart';
import 'package:smarty/widgets/routineCarousel.dart';
import 'package:smarty/widgets/voiceAgent.dart';
import 'package:weather/weather.dart';
import '../alertBox.dart';
import 'package:http/http.dart' as http;

import 'optimizationDialog.dart';

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
<<<<<<< HEAD
=======

//     if (Provider.of<BoltProvider>(context, listen: false).getBalanceAsInt() == 10)
//     Timer.run(
//         () => Provider.of<DialogProvider>(context, listen: false).popAi());

    if (Provider.of<Consumption>(context, listen: false).dailyTotal >=
        Provider.of<Generation>(context, listen: false).dailyTotal * 0.8)
      Timer.run(
          () => Provider.of<DialogProvider>(context, listen: false).popAi());

    if (Provider.of<Consumption>(context, listen: false).dailyTotal >=
        Provider.of<Generation>(context, listen: false).dailyTotal * 0.95)
      Timer.run(
          () => Provider.of<DialogProvider>(context, listen: false).popP2P());

>>>>>>> 4fb534cfcd1722cb5416b6645b258a8021d95782
    // if (Provider.of<BoltProvider>(context, listen: false).getBalanceAsInt() == 10)
    //   Timer.run(
    //       () => Provider.of<DialogProvider>(context, listen: false).popAi());

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

  void showAIAlert(BuildContext context, List<Room> room) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Consts.padding),
          ),
          elevation: 0.0,
          // Elevation means the height of element on the screen from the floor. Basically gives a drop shadow.
          backgroundColor: Colors.transparent,
          child: Optimization(
              r: room) // The required child is the content inside the dialog box.
          ),
    );
  }

  Widget build(BuildContext context) {
    final rooms = Provider.of<List<Room>>(context);
    // TODO: AI Condition Here
    Future.delayed(Duration.zero, () => showAIAlert(context, rooms));

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
              SizedBox(
                height: 36.0,
              ),
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
