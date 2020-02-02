import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:smarty/alert_notification.dart';
import 'package:smarty/constants.dart';

import 'package:smarty/devicesCarousel.dart';
import 'package:smarty/roomCarousel.dart';
import 'package:smarty/routineCarousel.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'alertBox.dart';
import 'auth.dart';

class Home extends StatefulWidget {
//  final FirebaseUser currentUser;   //Ignore
//  Home(this.currentUser);           //Ignore
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
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
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) => CustomDialog(
                  image: Image.asset("assets/images/fire.png"),
                  title: "FIRE DETECTED!",
                  description: "Sprinklers have been activated.",
                  col: Color(0xffE26069),
                  buttonText: "Okay",
                ),
              );

              // AlertNotification not = AlertNotification();
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => AlertNotification(),
              //   ),
              // );
              
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: SafeArea(
          child: ListView(
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
              ListTile(
                leading: Icon(FontAwesomeIcons.users),
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
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(vertical: 20.0),
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 20.0, right: 120.0, bottom: 3.0),
              child: Opacity(
                opacity: 0.6,
                child: Text(
                  '24 January 2020',
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
            RoutineCarousel(),
            Divider(),
            RoomCarousel(),
            Divider(),
            DeviceCarousel(),
          ],
        ),
      ),
    );
  }
}
