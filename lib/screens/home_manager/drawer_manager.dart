import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:smarty/models/themeModel.dart';
import 'package:smarty/screens/manageUsers.dart';
import 'package:smarty/services/auth.dart';
import 'package:url_launcher/url_launcher.dart';

// The drawer manager class handles the drawer menu items and the actions of these items for the Home Manager Role
class DrawerManager extends StatefulWidget {
  @override
  _DrawerManagerState createState() => _DrawerManagerState();
}

class _DrawerManagerState extends State<DrawerManager> {
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
              leading: Icon(FontAwesomeIcons.solidMoon),
              title: Text('Dark Mode'),
              trailing: Switch(
                value: valueSwitch,
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
