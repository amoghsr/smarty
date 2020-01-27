import 'package:flutter/material.dart';

import 'constants.dart';

class Statistics extends StatefulWidget {
  @override
  _StatisticsState createState() => _StatisticsState();
}

class _StatisticsState extends State<Statistics> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Statistics',
          style: kAppBarTextStyle,
        ),
      ),
      drawer: Drawer(),
      body: Column(
        children: <Widget>[Text('Dummy Text Statistics Page')],
      ),
    );
  }
}
