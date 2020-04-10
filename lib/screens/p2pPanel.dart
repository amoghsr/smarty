import 'package:flutter/material.dart';
import 'package:smarty/screens/drawer.dart';
import 'package:smarty/shared/constants.dart';
import 'package:smarty/widgets/voiceAgent.dart';

class P2P extends StatefulWidget {
  @override
  _P2PState createState() => _P2PState();
}

class _P2PState extends State<P2P> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Security',
          style: kAppBarTextStyle,
        ),
        actions: <Widget>[MicClass()],
      ),
      drawer: DrawerPage(),
    );
  }
}
