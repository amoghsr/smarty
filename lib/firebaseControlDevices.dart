// THIS IS A TEST FILE.
// THE FOLLOWING DART FILE IS FOR TESTING A LAMP/LIGHT/LED DEVICE USING THE FIREBASE SERVICE.

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'dart:async';

final FirebaseApp app = FirebaseApp();

class FirebaseControlDevices extends StatefulWidget {
  @override
  _FirebaseControlDevicesState createState() => _FirebaseControlDevicesState();
}

class _FirebaseControlDevicesState extends State<FirebaseControlDevices> {
  final databaseReference = FirebaseDatabase.instance.reference();
  bool light1, light2;
  DatabaseReference itemRef;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    final FirebaseDatabase database = FirebaseDatabase
        .instance; //Rather then just writing FirebaseDatabase(), get the instance.
    itemRef = database.reference().child('Devices/Lights/Light1/State');
//    itemRef.onChildChanged.listen(_onEntryChanged);
//    getData(1).then((news) {
//      light1 = news;
//    });
//    getData(2).then((news) {
//      light2 = news;
//    });
    light2 = false;
    // ignore: unnecessary_statements
    light1 = false;
  }

  void createRecord(bool newvalue, int light) {
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
//
//  _onEntryChanged(Event event) {
//    setState(() {
//      if (event.snapshot.value == "on") {
//        light2 = true;
//      } else {
//        light2 = false;
//      }
//    });
//  }

//  Future<String> getString(int light) async {
//    await databaseReference.once().then((DataSnapshot snapshot) {
//      Future<String> x = snapshot.value['Devices']['Lights']
//          ['Light' + light.toString()]['State'];
//      return x;
//    });
//  }
//
//  Future<bool> getData(int light) async {
//    String x;
//    await getString(light).then((news) {
//      x = news;
//    });
//    bool w;
//    print(x);
//    if (x == "on") {
//      w = true;
//    } else {
//      w = false;
//    }
//    return w;
//  }
  bool convert(String x) {
    bool w;
    print(x);
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
                  print(snap.data.snapshot.value);
                  if (snap.hasData &&
                      !snap.hasError &&
                      snap.data.snapshot.value != null) {
                    return Switch(
                      value: convert(snap.data.snapshot.value),
                      onChanged: (bool newValue) {
                        createRecord(newValue, 1);
                        setState(() {
                          light2 = newValue;
                        });
                      },
                    );
                  } else
                    return Text("No data");
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
