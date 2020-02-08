import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:smarty/auth.dart';
import 'package:smarty/home.dart';
import 'package:smarty/leaderboard.dart';
import 'package:smarty/security.dart';
import 'package:smarty/login.dart';

import 'Statistics.dart';
import 'constants.dart';

import 'package:provider/provider.dart';
import 'auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(
      ChangeNotifierProvider<AuthService>(
        // Helps to look for AuthService in the entire widget tree
        child: MyApp(),
        create: (BuildContext context) {
          return AuthService();
        },
      ),
    );
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.dark,
//        primaryColor: Colors.lightGreen[500],
        accentColor: Colors.lightGreenAccent,
        fontFamily: 'Montserrat',
        platform: TargetPlatform.iOS,
      ),
      home: FutureBuilder(
        // Getting the Provider, and call the getUser method
        future: Provider.of<AuthService>(context).getUser(),
        // Wait for the future to resolve and render the appropriate
        // Load the widget for Home page or LoginPage
        builder: (context, AsyncSnapshot<FirebaseUser> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            // Log any errors to the console
            if (snapshot.error != null) {
              print("Error");
              return Text(snapshot.error.toString());
            }
            // Redirect to the Home() page
            return snapshot.hasData ? MyNavigationBar() : LoginPage();
          } else {
            // Show the loading indicator
            return LoadingCircle();
          }
        },
      ),
//      home: MyNavigationBar(),
    );
  }
}

class MyNavigationBar extends StatefulWidget {
  @override
  _MyNavigationBarState createState() => _MyNavigationBarState();
}

class _MyNavigationBarState extends State<MyNavigationBar> {
  int _currentIndex = 0;
  final List<Widget> _children = [
    Home(),
    Statistics(),
    Security(),
    Leaderboard(),
  ];

  void onTappedBar(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  final controller = PageController(
    initialPage: 1,
  );

  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: _children[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          onTap: onTappedBar,
          currentIndex: _currentIndex,
          type: BottomNavigationBarType.fixed,
//          backgroundColor: Theme.of(context).primaryColor,
          items: [
            BottomNavigationBarItem(
              icon: Icon(
                AntDesign.home,
                semanticLabel: 'Home page',
              ),
              title: new Text(
                'Home',
                style: kNavigationBarTextStyle,
              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                FontAwesome5.chart_bar,
                semanticLabel: 'Energy Statistics',
              ),
              title: new Text(
                'Stats',
                style: kNavigationBarTextStyle,
              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                FontAwesome5.eye,
                semanticLabel: 'Home Security',
              ),
              title: new Text(
                'Security',
                style: kNavigationBarTextStyle,
              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                AntDesign.up,
                semanticLabel: 'Community Leaderboard',
              ),
              title: new Text(
                'Leaderboard',
                style: kNavigationBarTextStyle,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LoadingCircle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: CircularProgressIndicator(),
        alignment: Alignment(0.0, 0.0),
      ),
    );
  }
}
