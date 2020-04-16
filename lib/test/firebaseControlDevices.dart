// THIS IS A TEST FILE.
// THE FOLLOWING DART FILE IS FOR TESTING A LAMP/LIGHT/LED DEVICE USING THE FIREBASE SERVICE.

import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

final FirebaseApp app = FirebaseApp(name: null);

class FirebaseControlDevices extends StatefulWidget {
  @override
  _FirebaseControlDevicesState createState() => _FirebaseControlDevicesState();
}

class _FirebaseControlDevicesState extends State<FirebaseControlDevices> {
  bool light1, light2;
  DatabaseReference itemRef;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    final FirebaseDatabase database = FirebaseDatabase
        .instance; //Rather then just writing FirebaseDatabase(), get the instance.
    itemRef = database.reference();
    light2 = false;
    light1 = false;
  }

  void createRecord(bool newvalue, String room, String device) {
    if (newvalue == false) {
      itemRef
          .child("Rooms/" + room + "/" + device + "/")
          .update({'State': "off"});
    } else {
      itemRef
          .child("Rooms/" + room + "/" + device + "/")
          .update({'State': "on"});
    }
  }

  Stream getString(String room, String device) {
    Stream x;
    final FirebaseDatabase database = FirebaseDatabase
        .instance; //Rather then just writing FirebaseDatabase(), get the instance.

    x = database
        .reference()
        .child("Rooms/" + room + "/" + device + "/")
        .onValue;
    return x;
  }

  bool convert(String x) {
    bool w;
    if (x == "on") {
      w = true;
    } else {
      w = false;
    }
    return w;
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
//              Switch(
//                value: light1,
//                onChanged: (bool newValue) {
//                  createRecord(newValue, 1);
//                  setState(() {
//                    light1 = newValue;
//                  });
//                },
//              ),
//              Text('Light 2 Switch'),
//              Switch(
//                value: await getData(2),
//                onChanged: (bool newValue) {
//                  createRecord(newValue, 2);
//                  setState(() {
//                    light2 = newValue;
//                  });
//                },
//              ),
              StreamBuilder(
                stream: itemRef.onValue,
                builder: (context, snap) {
                  Map<String, dynamic> values =
                      new Map<String, dynamic>.from(snap.data.snapshot.value);
                  values.forEach((key, value) {
                    value.forEach((key1, value1) {
//                      print(key1);
                    });
                  });
                  return Switch(
                    value: convert(values["State"]),
                    onChanged: (bool newValue) {
                      createRecord(newValue, "LivingRoom", "Light1");
                      setState(() {
                        light2 = newValue;
                      });
                    },
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
