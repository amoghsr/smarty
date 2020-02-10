import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:provider/provider.dart';
import 'package:smarty/statistics.dart';
import 'package:smarty/home.dart';
import 'package:smarty/leaderboard.dart';
import 'package:smarty/models/user.dart';
import 'package:smarty/security.dart';
import 'package:smarty/services/auth.dart';
import 'package:smarty/shared/constants.dart';
import 'package:smarty/wrapper.dart';

void main() {
  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
        theme: ThemeData(
          brightness: Brightness.dark,
//        primaryColor: Colors.lightGreen[500],
          accentColor: Colors.lightGreenAccent,
          fontFamily: 'Montserrat',
          platform: TargetPlatform.iOS,
        ),
        home: Wrapper(),
      ),
    );
  }
}

class MyNavigationBar extends StatefulWidget {
  @override
  _MyNavigationBarState createState() => _MyNavigationBarState();
}

class _MyNavigationBarState extends State<MyNavigationBar> {
  @override
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
