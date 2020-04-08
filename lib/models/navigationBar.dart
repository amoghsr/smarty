import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
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
    //Todo : this how you can access all house ids
    final x = Provider.of<List<String>>(context);
    final user = Provider.of<User>(context);
    if (user.type == "O") {
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
    } else {
      final List<Widget> _children = [
        Home(),
        Statistics(),
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
}
