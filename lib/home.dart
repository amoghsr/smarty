/*
* The home page and the initial page the app starts with.
* This page acts as a doorway to all other parts such as the different rooms,
* various routines and the nav bar (But this stays common to all)
*/

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:smarty/constants.dart';
import 'package:smarty/devicesCarousel.dart';
import 'package:smarty/roomCarousel.dart';
import 'package:smarty/routineCarousel.dart';
import 'package:provider/provider.dart';
import 'alertBox.dart';
import 'auth.dart';
import 'package:firebase_database/firebase_database.dart';

class Home extends StatefulWidget {
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
  DatabaseReference itemRef;

  void initState() {
    super.initState();
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
                              image:
                                  Image.asset("assets/images/pngguru.com.png"),
                              title: "NO NOTIFICATION",
                              description: "What a boring day",
                              col: Color(0xffE26069),
                              buttonText: "Okay",
                            );
                          }
                        },
                      ));
              StreamBuilder(
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
                      new Map<String, dynamic>.from(snap.data.snapshot.value);
                  if (values["Danger"] == "high") {
                    return CustomDialog(
                      image: Image.asset("assets/images/fire.png"),
                      title: "FIRE DETECTED!",
                      description: "Sprinklers have been activated.",
                      col: Color(0xffE26069),
                      buttonText: "Okay",
                    );
                  } else {
                    return null;
                  }
                },
              );
              await _showNotificationWithDefaultSound(
                  'FIRE DETECTED', 'Sprinklers have been activated.');
            },
          ),
        ],
      ),

      // Drawer is the hamburger menu.
      drawer: Drawer(
        child: SafeArea(
          // The various items in the hamburger menu are saved inside a ListView, which is basically a vertical list
          child: ListView(
            // ListView items are saved in a children list of Widgets
            children: <Widget>[
              UserAccountsDrawerHeader(
                accountName: Text(
                  'John Doe',
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w700,
                  ),
                ),
                accountEmail: Text(
                  'johndoe@mail.com',
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                  ),
                ),
                currentAccountPicture: CircleAvatar(
                  child: Text(
                    'JD',
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                    ),
                  ),
                ),
              ),

              // ListTile represents a list tile item in the menu
              ListTile(
                // Leading is an element in the start of the list tile horizontally
                leading: Icon(FontAwesomeIcons.users),

                // Title of the list
                title: Text(
                  'Manage Users',
                ),
              ),
              ListTile(
                leading: Icon(Icons.settings),
                title: Text(
                  'Account Settings',
                ),
              ),
              ListTile(
                leading: Icon(FontAwesomeIcons.questionCircle),
                title: Text(
                  'About Developers',
                ),
              ),
              Divider(),
              // Log out button
              ListTile(
                onTap: () async {
                  await Provider.of<AuthService>(context, listen: false)
                      .logout();
                },
                leading: Icon(Icons.exit_to_app),
                title: Text(
                  'Log Out',
                ),
              ),
            ],
          ),
        ),
      ),

      // Here starts the body of the Home Page, nested inside a SafeArea widget to keep content inside the viewport
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
              padding: EdgeInsets.only(left: 20.0, right: 120.0),
              child: Text(
                'Welcome Home, Ben',
                //${widget.currentUser.email}`
                style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'Poppins'),
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
