import 'package:flutter/material.dart';

class HomeManager extends StatefulWidget {
  @override
  _HomeManagerState createState() => _HomeManagerState();
}

class _HomeManagerState extends State<HomeManager> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SafeArea(
          child: ListView(
            padding: EdgeInsets.symmetric(vertical: 20.0),
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(left: 20.0, right: 120.0),
                child: Text(
                  'Home Owners',
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
