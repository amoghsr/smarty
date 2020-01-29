// THIS IS A TEST FILE.
// THE FOLLOWING DART FILE IS FOR TESTING A LAMP/LIGHT/LED DEVICE USING THE FIREBASE SERVICE.

import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class FirebaseControlDevices extends StatefulWidget {
  @override
  _FirebaseControlDevicesState createState() => _FirebaseControlDevicesState();
}

class _FirebaseControlDevicesState extends State<FirebaseControlDevices> {
  bool light1 = false;
  bool light2 = false;
  final databaseReference = FirebaseDatabase.instance.reference();
  void createRecord(bool newvalue, int light) {
    toString();
    if (newvalue == false) {
      databaseReference
          .child("Devices/Lights/Light" + light.toString() + "/")
          .update({'State': "off"});
    } else {
      databaseReference
          .child("Devices/Lights/Light" + light.toString() + "/")
          .update({'State': "on"});
    }
  }

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
              Text('Light 1 Switch'),
              Switch(
                value: light1,
                onChanged: (bool newValue) {
                  createRecord(newValue, 1);
                  setState(() {
                    light1 = newValue;
                  });
                },
              ),
              Text('Light 2 Switch'),
              Switch(
                value: light2,
                onChanged: (bool newValue) {
                  createRecord(newValue, 2);
                  setState(() {
                    light2 = newValue;
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
