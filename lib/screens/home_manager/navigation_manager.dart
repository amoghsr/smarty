import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:provider/provider.dart';
import 'package:smarty/screens/home_manager/dashboard_manager.dart';
import 'package:smarty/shared/constants.dart';

import 'all_houses.dart';

class NavigationManager extends StatefulWidget {
  @override
  _NavigationManagerState createState() => _NavigationManagerState();
}

class _NavigationManagerState extends State<NavigationManager> {
  int _currentIndex = 0;

  final List<Widget> _children = [
    DashboardManager(),
    AllHouses(),
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
    final x = Provider.of<List<String>>(context);
//    x.forEach((element) {
//      print(element);
//    });
    return SafeArea(
      child: Scaffold(
        body: _children[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          onTap: onTappedBar,
          currentIndex: _currentIndex,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Theme.of(context).accentColor,
          backgroundColor: Theme.of(context).primaryColor,
          items: [
            BottomNavigationBarItem(
              icon: Icon(
                AntDesign.dashboard,
                semanticLabel: 'Home Manager Dashboard',
              ),
              title: Text(
                'Dashboard',
                style: kNavigationBarTextStyle,
              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                AntDesign.home,
                semanticLabel: 'All houses',
              ),
              title: Text(
                'All Houses',
                style: kNavigationBarTextStyle,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
