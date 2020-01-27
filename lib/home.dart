import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:smarty/constants.dart';
import 'package:smarty/devicesCarousel.dart';
import 'package:smarty/roomCarousel.dart';
import 'package:smarty/routineCarousel.dart';

class Home extends StatefulWidget {
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
            onPressed: () {},
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
                leading: Icon(FontAwesomeIcons.personBooth),
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
