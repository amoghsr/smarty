import 'package:flutter/material.dart';
import 'package:smarty/shared/constants.dart';
class Security extends StatefulWidget {
  @override
  _SecurityState createState() => _SecurityState();
}

class _SecurityState extends State<Security> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Security',
          style: kAppBarTextStyle,
        ),
      ),
      drawer: Drawer(),
      body: Column(
        children: <Widget>[Text('Dummy Text Security Page')],
      ),
    );
  }
}
