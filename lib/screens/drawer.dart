import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:smarty/models/themeModel.dart';
import 'package:smarty/screens/homeManager.dart';
import 'package:smarty/screens/manageUsers.dart';
import 'package:smarty/services/auth.dart';

class DrawerPage extends StatefulWidget {
  @override
  _DrawerPageState createState() => _DrawerPageState();
}

class _DrawerPageState extends State<DrawerPage> {
  final AuthService _auth = AuthService();
  bool valueSwitch = true;

  Widget build(BuildContext context) {
    return Drawer(
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
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ManageUsers()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text(
                'Account Settings',
              ),
            ),
            ListTile(
              leading: Icon(Icons.lock),
              title: Text(
                'For Home Manager',
              ),
              trailing: Icon(
                Icons.arrow_forward,
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomeManager()),
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
