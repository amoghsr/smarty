import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:smarty/models/user.dart';
import 'package:smarty/screens/home.dart';
import 'package:smarty/screens/leaderboard.dart';
import 'package:smarty/screens/security.dart';
import 'package:smarty/screens/statistics.dart';
import 'package:smarty/shared/constants.dart';

class MyNavigationBar extends StatefulWidget {
  @override
  _MyNavigationBarState createState() => _MyNavigationBarState();
}

class _MyNavigationBarState extends State<MyNavigationBar> {
  int _currentIndex = 0;

  void onTappedBar(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  final controller = PageController(
    initialPage: 1,
  );

  Widget build(BuildContext context) {
    final x = Provider.of<List<String>>(context);
    final user = Provider.of<User>(context);
    if (user.type == "O") {
      final List<Widget> _children = [
        SafeArea(child: Home()),
        SafeArea(child: Statistics()),
        SafeArea(child: Security()),
        SafeArea(child: Leaderboard()),
      ];
      return SafeArea(
        child: Scaffold(
          body: _children[_currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            onTap: onTappedBar,
            currentIndex: _currentIndex,
            type: BottomNavigationBarType.fixed,
            showUnselectedLabels: false,
            selectedItemColor: Theme.of(context).accentColor,
            backgroundColor: Theme
                .of(context)
                .primaryColor,
            items: [
              BottomNavigationBarItem(
                icon: Icon(
                  MaterialCommunityIcons.home_automation,
                  semanticLabel: 'This is the home page',
                ),
                title: new Text(
                  'Home',
                  style: kNavigationBarTextStyle,
                ),
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  MaterialCommunityIcons.chart_bar,
                  semanticLabel: 'View Energy Statistics or sell your homes energy to the community',
                ),
                title: new Text(
                  'Stats',
                  style: kNavigationBarTextStyle,
                ),
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.visibility,
                  semanticLabel: 'Home Security',
                ),
                title: new Text(
                  'Security',
                  style: kNavigationBarTextStyle,
                ),
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  MaterialCommunityIcons.trophy,
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
    } else if (user.type == "U") {
      final List<Widget> _children = [
        Home(),
        Security(),
        Leaderboard(),
      ];
      return SafeArea(
        child: Scaffold(
          body: _children[_currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            onTap: onTappedBar,
            currentIndex: _currentIndex,
            type: BottomNavigationBarType.fixed,
            showUnselectedLabels: false,
            selectedItemColor: Theme
                .of(context)
                .accentColor,
            backgroundColor: Theme
                .of(context)
                .primaryColor,
            items: [
              BottomNavigationBarItem(
                icon: Icon(
                  MaterialCommunityIcons.home_automation,
                  semanticLabel: 'Home page',
                ),
                title: new Text(
                  'Home',
                  style: kNavigationBarTextStyle,
                ),
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.visibility,
                  semanticLabel: 'Home Security',
                ),
                title: new Text(
                  'Security',
                  style: kNavigationBarTextStyle,
                ),
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  MaterialCommunityIcons.trophy,
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
}
