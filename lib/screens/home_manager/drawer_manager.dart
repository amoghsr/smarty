import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_version/get_version.dart';
import 'package:provider/provider.dart';
import 'package:smarty/models/themeModel.dart';
import 'package:smarty/screens/home_manager/all_houses.dart';
import 'package:smarty/screens/manageUsers.dart';
import 'package:smarty/services/auth.dart';
import 'package:url_launcher/url_launcher.dart';

// The drawer manager class handles the drawer menu items and the actions of these items for the Home Manager Role
class DrawerManager extends StatefulWidget {
  @override
  _DrawerManagerState createState() => _DrawerManagerState();
}

class _DrawerManagerState extends State<DrawerManager> {
  String _platformVersion = 'Unknown';
  String _projectVersion = '';
  String _projectCode = '';
  String _projectAppID = '';
  String _projectName = '';

  @override
  void initState() {
    _initPlatformState();
    super.initState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  void _initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      platformVersion = await GetVersion.platformVersion;
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    String projectVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      projectVersion = await GetVersion.projectVersion;
    } on PlatformException {
      projectVersion = 'Failed to get project version.';
    }

    String projectCode;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      projectCode = await GetVersion.projectCode;
    } on PlatformException {
      projectCode = 'Failed to get build number.';
    }

    String projectAppID;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      projectAppID = await GetVersion.appID;
    } on PlatformException {
      projectAppID = 'Failed to get app ID.';
    }

    String projectName;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      projectName = await GetVersion.appName;
    } on PlatformException {
      projectName = 'Failed to get app name.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
      _projectVersion = projectVersion;
      _projectCode = projectCode;
      _projectAppID = projectAppID;
      _projectName = projectName;
    });
  }

  final AuthService _auth = AuthService();
  bool valueSwitch = true;

  _launchCaller() async {
    const url = 'tel:800123';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    return Drawer(
      child: SafeArea(
// The various items in the hamburger menu are saved inside a ListView, which is basically a vertical list
        child: ListView(
// ListView items are saved in a children list of Widgets
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text(
                _projectName,
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w700,
                  fontSize: 20.0,
                ),
              ),
              accountEmail: Text(
                'v$_projectVersion',
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 12.0,
                ),
              ),
            ),
// ListTile represents a list tile item in the menu
            ListTile(
// Leading is an element in the start of the list tile horizontally
              leading: Container(
                  width: screenwidth * 0.03,
                  child: Icon(FontAwesomeIcons.users)),
// Title of the list
              title: Text(
                'Manage Users',
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ManageUsers()),
                );
              },
            ),
            ListTile(
// Leading is an element in the start of the list tile horizontally
              leading: Container(
                  width: screenwidth * 0.03,
                  child: Icon(FontAwesomeIcons.users)),
// Title of the list
              title: Text(
                'All Houses',
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AllHouses()),
                );
              },
            ),
            ListTile(
              leading: Icon(FontAwesomeIcons.solidMoon),
              title: Text('Dark Mode'),
              trailing: Switch(
                value: valueSwitch,
                inactiveTrackColor: Theme.of(context).backgroundColor,
                activeColor: Colors.white,
                activeTrackColor: Theme.of(context).accentColor,
                onChanged: (value) {
                  setState(() {
                    valueSwitch = value;
                    Provider.of<ThemeModel>(context, listen: false)
                        .toggleTheme();
                  });
                },
              ),
            ),
            ListTile(
              leading: Icon(MaterialIcons.phone),
              title: Text(
                'Helpline',
              ),
              onTap: _launchCaller,
            ),
            Divider(),
// Log out button
            ListTile(
              onTap: () async {
                await _auth.signOut();
              },
              leading: Icon(Icons.exit_to_app),
              title: Text(
                "Logout",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
