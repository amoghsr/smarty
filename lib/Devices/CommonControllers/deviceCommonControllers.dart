import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:smarty/constants.dart';

bool isSwitched = false;
Color bulbColor = Colors.white;

int brightness = 50;
var isPlaying = false;
bool icon = false;
int waterAmount = 8;
DatabaseReference itemRef;

void stateChange(bool newvalue, String room, String device) {
  if (newvalue == false) {
    itemRef
        .child("Rooms/" + room + "/devices/" + device + "/")
        .update({'State': "off"});
  } else {
    itemRef
        .child("Rooms/" + room + "/devices/" + device + "/")
        .update({'State': "on"});
  }
}

Stream getString(String room, String device) {
  Stream x;
  final FirebaseDatabase database = FirebaseDatabase
      .instance; //Rather then just writing FirebaseDatabase(), get the instance.

  x = database.reference().child("Rooms/" + room + "/" + device + "/").onValue;
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

void setColor(Color newvalue, String room, String device) {
  var hex = '#${newvalue.value.toRadixString(16)}';
  itemRef
      .child("Rooms/" + room + "/devices/" + device + "/")
      .update({'Color': hex});
}

void setBrightness(int newvalue, String room, String device) {
  itemRef
      .child("Rooms/" + room + "/devices/" + device + "/")
      .update({'Brightness': newvalue});
}

Color stringtocol(String code) {
  Map<String, Color> map = {
    "#ff4caf50": Colors.green,
    "#ff03a9f4": Colors.lightBlue,
    "#ff3f51b5": Colors.indigo,
    "#ff9c27b0": Colors.purple,
    "#fff44336": Colors.red,
    "#ffff9800": Colors.orange,
    "#ffff9800": Colors.yellow
  };
  return map[code];
}

void setTemp(int newvalue, String room, String device) {
  itemRef
      .child("Rooms/" + room + "/devices/" + device + "/")
      .update({'Temperature': newvalue});
}

Container colorRow(Color color) {
  return Container(
    height: 25,
    width: 25,
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.all(
        Radius.circular(20),
      ),
    ),
  );
}

Container topAppBar(String roomName, String appliance, IconData icon) {
  return Container(
    padding: EdgeInsets.symmetric(
      horizontal: 15,
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Column(
          children: <Widget>[
            Text(
              roomName,
              style: kLightDeviceTopBar.copyWith(
                color: Colors.white.withOpacity(0.5),
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              appliance,
              style: kLightDeviceBottomBar,
            ),
          ],
        ),
        Container(
          child: Icon(icon, size: 48, color: bulbColor),
        ),
      ],
    ),
  );
}

