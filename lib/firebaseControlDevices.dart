// THIS IS A TEST FILE.
// THE FOLLOWING DART FILE IS FOR TESTING A LAMP/LIGHT/LED DEVICE USING THE FIREBASE SERVICE.

import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class FirebaseControlDevices extends StatefulWidget {
  @override
  _FirebaseControlDevicesState createState() => _FirebaseControlDevicesState();
}

class _FirebaseControlDevicesState extends State<FirebaseControlDevices> {
  bool val = false;
  final databaseReference = FirebaseDatabase.instance.reference();
  void createRecord(bool newvalue) {
    if (newvalue == false) {
      databaseReference
          .child("Devices/Lights/Light1/")
          .update({'State': "off"});
    } else {
      databaseReference.child("Devices/Lights/Light1/").update({'State': "on"});
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
              Text('Light Switch'),
              Switch(
                value: val,
                onChanged: (bool newValue) {
                  createRecord(newValue);
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
