import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:smarty/models/leaderboardModel.dart';
import 'package:smarty/models/user.dart';
import 'package:smarty/screens/allDevices.dart';
import 'package:smarty/screens/energy_sharing_screen.dart';
import 'package:smarty/screens/home.dart';
import 'package:smarty/screens/leaderboard.dart';
import 'package:smarty/screens/security.dart';
import 'package:smarty/screens/statsPage.dart';
import 'package:smarty/services/dialogProvider.dart';
import 'package:smarty/shared/constants.dart';

import 'pointsProvider.dart';
import 'devicesModel.dart';
import 'generationModel.dart';

class MyNavigationBar extends StatefulWidget {
  @override
  _MyNavigationBarState createState() => _MyNavigationBarState();
}

class _MyNavigationBarState extends State<MyNavigationBar> {
  int _currentIndex = 0;
  @override
  void initState() {
    super.initState();
  }

  void onTappedBar(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  final controller = PageController(
    initialPage: 1,
  );

  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    if (user.type == "O") {
      final List<Widget> _children = [
        Home(),
        StatsScreen(),
        EnergySharingScreen(),
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
            selectedItemColor: Theme.of(context).accentColor,
            backgroundColor: Theme.of(context).primaryColor,
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
                  semanticLabel:
                      'View Energy Statistics or sell your homes energy to the community',
                ),
                title: new Text(
                  'Stats',
                  style: kNavigationBarTextStyle,
                ),
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  MaterialCommunityIcons.share,
                  semanticLabel: 'Share energy among the community!',
                ),
                title: new Text(
                  'eShare',
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
            selectedItemColor: Theme.of(context).accentColor,
            backgroundColor: Theme.of(context).primaryColor,
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
