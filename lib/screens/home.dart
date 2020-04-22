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
import 'package:smarty/models/leaderboardModel.dart';
import 'package:smarty/models/pointsProvider.dart';
import 'package:smarty/models/roomModel.dart';
import 'package:smarty/models/consumptionModel.dart';
import 'package:smarty/models/generationModel.dart';
import 'package:smarty/models/themeModel.dart';
import 'package:smarty/models/user.dart';
import 'package:smarty/models/weatherModel.dart';
import 'package:smarty/screens/drawer.dart';
import 'package:smarty/services/AIPopUpService.dart';
import 'package:smarty/services/auth.dart';
import 'package:smarty/services/dialogLocator.dart';
import 'package:smarty/services/dialogManager.dart';
import 'package:smarty/services/dialogProvider.dart';
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
  int popup = 0;
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
  }

  void didChangeDependencies() {
    if (popup != 1) {
      final y = Provider.of<Consumption>(context);
      final x2 = Provider.of<Generation>(context);
      if (y != null && x2 != null) {
        if (y.dailyTotal >= x2.dailyTotal * 0.8) {
          if (y.dailyTotal >= x2.dailyTotal * 0.95) {
            Timer.run(() =>
                Provider.of<DialogProvider>(context, listen: false).popP2P());
          } else
            Timer.run(() =>
                Provider.of<DialogProvider>(context, listen: false).popAi());
        }
        final user = Provider.of<User>(context);

        final FirebaseDatabase database = FirebaseDatabase
            .instance; //Rather then just writing FirebaseDatabase(), get the instance.
        DatabaseReference itemRef = database.reference();
        //door dialog
        String q = "0";
        final e =
            itemRef.child("Homes/" + user.houseId + "/Sensors/Door").onValue;
        e.listen((onData) {
          q = onData.snapshot.value;
          if (q == "high") {
            Timer.run(() => Provider.of<DialogProvider>(context, listen: false)
                .popDoorBell());
          }
        });
        //fire dialogbox
        String w = "0";
        final x = itemRef
            .child("Homes/" + user.houseId + "/Sensors/Fire/Danger")
            .onValue;
        x.listen((onData) {
          w = onData.snapshot.value;
          if (w == "high") {
            Timer.run(() => Provider.of<DialogProvider>(context, listen: false)
                .popFireDialog());
          }
        });
        popup += 1;
      }
    }
    super.didChangeDependencies();
  }

  @override
  /*
  * A notification plugin that provides the app with the ability to send notifications to
  * the user for certain events such as when there is an anomaly (fire) detected by the flame detector.
  */

  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Home',
            style: kAppBarTextStyle,
          ),
          actions: <Widget>[MicClass()],
        ),
        // Drawer is the hamburger menu.
        // Here starts the body of the Home Page, nested inside a SafeArea widget to keep content inside the viewport
        drawer: DrawerPage(),
        body: SafeArea(
          child: ListView(
            padding: EdgeInsets.symmetric(vertical: 20.0),
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(right: 120.0, bottom: 3.0),
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
                        Text(
                          'Hello ${houseUserMap[user.houseId.toString()]['userName'].split(' ')[0]}!',
                          //${widget.currentUser.email}`
                          style: TextStyle(
                            fontSize: 24.0,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                    (weather == null)
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(bottom: 3.0),
                                child: Text('Outside'),
                              ),
                              Text(
                                '29°C',
                                //${widget.currentUser.email}`
                                style: TextStyle(
                                  fontSize: 24.0,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          )
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(bottom: 3.0),
                                child: Text('Outside'),
                              ),
                              Text(
                                '${weather.round().toString()}°C',
                                //${widget.currentUser.email}`
                                style: TextStyle(
                                  fontSize: 24.0,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
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
}
