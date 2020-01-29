
// THIS IS A TEST FILE.
// THE FOLLOWING DART FILE IS FOR TESTING A LAMP/LIGHT/LED DEVICE USING THE FIREBASE SERVICE.

import 'package:flutter/material.dart';

class FirebaseControlDevices extends StatefulWidget {
  @override
  _FirebaseControlDevicesState createState() => _FirebaseControlDevicesState();
}

class _FirebaseControlDevicesState extends State<FirebaseControlDevices> {

  bool val = false;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Device Testing Page'),
        ),
        body: SafeArea(
          child: Column(
            children: <Widget>[
              Text('Light Switch'),
              Switch(
                value: val,
                onChanged: (bool newValue) {
                  setState(() {
                    val = newValue;
                  });
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

