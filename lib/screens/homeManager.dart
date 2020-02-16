import 'package:flutter/material.dart';
import 'package:smarty/services/auth.dart';

class HomeManager extends StatefulWidget {
  @override
  _HomeManagerState createState() => _HomeManagerState();
}

class _HomeManagerState extends State<HomeManager> {

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: Drawer(
          child: SafeArea(
            // The various items in the hamburger menu are saved inside a ListView, which is basically a vertical list
            child: ListView(
              // ListView items are saved in a children list of Widgets
              children: <Widget>[
                ListTile(
                  leading: Icon(Icons.settings),
                  title: Text(
                    'Sample Text',
                  ),
                ),
                ListTile(
                  leading: Icon(
                      Icons.lock
                  ),
                  title: Text(
                    'Sample Text',
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HomeManager()),
                    );
                  },
                ),
                Divider(),
                // Log out button
                ListTile(
                  onTap: () async {
                    await _auth.signOut();
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
                padding: EdgeInsets.only(left: 20.0, right: 120.0),
                child: Text(
                  'Home Owner',
                  style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Poppins'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
