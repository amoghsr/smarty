import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:smarty/authenticate/authenticate.dart';
import 'package:smarty/models/darkModeSwitchProvider.dart';
import 'package:smarty/models/leaderboardModel.dart';
import 'package:smarty/models/themeModel.dart';
import 'package:smarty/screens/home_manager/navigation_manager.dart';
import 'package:smarty/screens/manageUsers.dart';
import 'package:smarty/screens/userProfile.dart';
import 'package:smarty/services/auth.dart';
import 'package:smarty/wrapper.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:smarty/models/user.dart';
import 'package:smarty/models/dbService.dart';

class DrawerPage extends StatefulWidget {
  @override
  _DrawerPageState createState() => _DrawerPageState();
}

class _DrawerPageState extends State<DrawerPage> {
  final AuthService _auth = AuthService();
  var user;
  var stream;

  _launchCaller() async {
    const url = 'tel:800123';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  void initState() {
    super.initState();
    () {
      user = Provider.of<User>(context, listen: false);
      while (user == null) {}
      stream = DatabaseService1().getUserDetails(user.uid, user);
    }();
  }

  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    if (user.type == "O") {
      return Drawer(
        child: SafeArea(
// The various items in the hamburger menu are saved inside a ListView, which is basically a vertical list
          child: ListView(
// ListView items are saved in a children list of Widgets
            children: <Widget>[
              new StreamBuilder(
                  stream: stream,
                  builder:
                      (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                    if (snapshot.data == null) return Container();
                    return InkWell(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              UserProfile(houseID: user.houseId),
                        ),
                      ),
                      child: UserAccountsDrawerHeader(
                        accountName: Text(
                          houseUserMap[user.houseId]['userName'],
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        accountEmail: Text(
                          snapshot.data['email'],
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                          ),
                        ),
                        currentAccountPicture: CircleAvatar(
                          backgroundImage: AssetImage(
                              houseUserMap[user.houseId]['userImage']),
                        ),
                      ),
                    );
                  }),
// ListTile represents a list tile item in the menu
              ListTile(
// Leading is an element in the start of the list tile horizontally
                leading:
                    Container(child: Icon(MaterialCommunityIcons.face_profile)),
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
//              ListTile(
//                leading: Icon(Icons.lock),
//                title: Text(
//                  'For Home Manager',
//                ),
//                trailing: Icon(
//                  Icons.arrow_forward,
//                ),
//                onTap: () {
//                  Navigator.push(
//                    context,
//                    MaterialPageRoute(
//                        builder: (context) => NavigationManager()),
//                  );
//                },
//              ),
              ListTile(
                leading: Icon(MaterialIcons.brightness_4),
                title: Text('Dark Mode'),
                trailing: Switch(
                  value: Provider.of<AppThemeProvider>(context, listen: false).getTheme(),
                  activeColor: Colors.white,
                  activeTrackColor: Theme.of(context).accentColor,
                  inactiveTrackColor: Theme.of(context).backgroundColor,
                  onChanged: (value) {
                    setState(() {
                      Provider.of<AppThemeProvider>(context, listen: false).toggleTheme();

                      Provider.of<ThemeModel>(context, listen: false)
                          .toggleTheme();
                    });
                  },
                ),
              ),
              ListTile(
                leading: Icon(MaterialIcons.phone),
                title: Text(
                  'Customer Helpline',
                ),
                onTap: _launchCaller,
              ),
              ListTile(
                leading: Icon(MaterialIcons.report_problem),
                title: Text(
                  'Report Problem',
                ),
                onTap: _launchCaller,
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
                  await _auth.signOut();
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (BuildContext context) {
                      return Authenticate();
                    }),
                  );
                },
                leading: Icon(Icons.exit_to_app),
                title: Text(
                  'Log out',
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      return Drawer(
        child: SafeArea(
// The various items in the hamburger menu are saved inside a ListView, which is basically a vertical list
          child: ListView(
// ListView items are saved in a children list of Widgets
            children: <Widget>[
              new StreamBuilder(
                  stream: stream,
                  builder:
                      (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                    if (snapshot.data == null) return Container();
                    return UserAccountsDrawerHeader(
                      accountName: Text(
                        snapshot.data['displayName'],
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      accountEmail: Text(
                        snapshot.data['email'],
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                        ),
                      ),
                      currentAccountPicture: CircleAvatar(
                        child: Text(
                          user.type,
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                          ),
                        ),
                      ),
                    );
                  }),
// ListTile represents a list tile item in the menu
//              ListTile(
//// Leading is an element in the start of the list tile horizontally
//                leading: Container(
//                    width: screenwidth * 0.03,
//                    child: Icon(FontAwesomeIcons.users)),
//// Title of the list
//                title: Text(
//                  'Manage Users',
//                ),
//                onTap: () {
//                  Navigator.push(
//                    context,
//                    MaterialPageRoute(builder: (context) => ManageUsers()),
//                  );
//                },
//              ),
              ListTile(
                leading: Icon(Icons.settings),
                title: Text(
                  'Account Settings',
                ),
              ),
//              ListTile(
//                leading: Icon(Icons.lock),
//                title: Text(
//                  'For Home Manager',
//                ),
//                trailing: Icon(
//                  Icons.arrow_forward,
//                ),
//                onTap: () {
//                  Navigator.push(
//                    context,
//                    MaterialPageRoute(
//                        builder: (context) => NavigationManager()),
//                  );
//                },
//              ),
              ListTile(
                leading: Icon(FontAwesomeIcons.solidMoon),
                title: Text('Dark Mode'),
                trailing: Switch(
                  value: Provider.of<AppThemeProvider>(context, listen:false).getTheme(),
                  onChanged: (value) {
                    setState(() {
                      Provider.of<AppThemeProvider>(context, listen: false).toggleTheme();
                      Provider.of<ThemeModel>(context, listen: false)
                          .toggleTheme();
                    });
                  },
                ),
              ),
              ListTile(
                leading: Icon(MaterialIcons.phone),
                title: Text(
                  'Customer Helpline',
                ),
                onTap: _launchCaller,
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
                  await _auth.signOut();
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (BuildContext context) {
                      return Authenticate();
                    }),
                  );
                },
                leading: Icon(Icons.exit_to_app),
                title: Text(
                  'Log out',
                ),
              ),
            ],
          ),
        ),
      );
    }
  }
}
