import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Device {
  String imageUrl;
  String deviceName;
  String inRoom;
  String state;
  String level;
  double opacity;
  Icon icon;
  bool toggleSt;
  int count;

  Device(
      {this.imageUrl,
      this.deviceName,
      this.inRoom,
      this.state,
      this.level,
      this.opacity,
      this.icon,
      this.toggleSt,
      this.count});

//  static List<Device> fromFirestore(DocumentSnapshot doc) {
//    List<Device> x = [];
//    Map data = doc.data;
//    data.forEach((key, value) {
//      x.add(Device(
//        deviceName: key,
//        inRoom: doc.documentID,
//        icon: getIcons(key),
//        imageUrl: getImageUrl(key),
//        count: value,
//        state: 'Off',
//        toggleSt: false,
//        level: '5',
//        opacity: 1,
//      ));
//    });
//    return x;
//  }

  factory Device.fromFirestore(String key, int value, String doc) => Device(
        deviceName: key,
        inRoom: doc,
        icon: getIcons(key),
        imageUrl: getImageUrl(key),
        count: value,
        state: 'Off',
        toggleSt: false,
        level: '5',
        opacity: 1,
      );
}

String getImageUrl(String roomName) {
  switch (roomName) {
    case 'Lamp':
      return 'assets/images/deviceAssets/bulb.png';
    case 'Exhaust Fan':
      return 'assets/images/deviceAssets/fan.png';
    case 'Camera':
      return 'assets/images/deviceAssets/cctv.png';
    case 'AC':
      return 'assets/images/deviceAssets/ac.png';
    case 'Faucet':
      return 'assets/images/deviceAssets/faucet.png';
    case 'heater':
      return 'assets/images/deviceAssets/heater.png';
    case 'Speaker':
      return 'assets/images/deviceAssets/speaker.png';
  }
}

Icon getIcons(String roomName) {
  switch (roomName) {
    case 'Lamp':
      return Icon(Icons.wb_incandescent);
    case 'Exhaust Fan':
      return Icon(FontAwesomeIcons.fan);
    case 'Camera':
      return Icon(FontAwesomeIcons.camera);
    case 'AC':
      return Icon(FontAwesomeIcons.airFreshener);
    case 'Faucet':
      return Icon(FontAwesome.shower);
    case 'heater':
      return Icon(FontAwesomeIcons.fire);
    case 'Speaker':
      return Icon(Icons.speaker);
    case 'TV':
      return Icon(FontAwesomeIcons.tv);
  }
}

List<Device> devices = [
  //Living room devices
  Device(
    imageUrl: 'assets/images/deviceAssets/bulb.png',
    deviceName: 'Lamp',
    icon: Icon(Icons.wb_incandescent),
    inRoom: 'Living Room',
    state: 'Off',
    toggleSt: false,
    level: '5',
    opacity: 1,
  ),
  Device(
    imageUrl: 'assets/images/deviceAssets/bulb.png',
    deviceName: 'AC',
    icon: Icon(Icons.ac_unit),
    inRoom: 'Living Room',
    state: 'Off',
    toggleSt: false,
    level: '5',
    opacity: 1,
  ),
  Device(
    imageUrl: 'assets/images/deviceAssets/bulb.png',
    deviceName: 'Speaker',
    icon: Icon(Icons.speaker),
    inRoom: 'Living Room',
    state: 'Off',
    toggleSt: false,
    level: '5',
    opacity: 1,
  ),

  //Kitchen devices
  Device(
    imageUrl: 'assets/images/deviceAssets/fan.png',
    deviceName: 'Lamp',
    icon: Icon(FontAwesomeIcons.fan),
    inRoom: 'Kitchen',
    state: 'Off',
    toggleSt: false,
    level: '5',
    opacity: 0.3,
  ),
  Device(
    imageUrl: 'assets/images/deviceAssets/fan.png',
    deviceName: 'Faucet',
    icon: Icon(FontAwesome.shower),
    inRoom: 'Kitchen',
    state: 'Off',
    toggleSt: false,
    level: '5',
    opacity: 0.3,
  ),
  Device(
    imageUrl: 'assets/images/deviceAssets/fan.png',
    deviceName: 'Exhaust Fan',
    icon: Icon(FontAwesomeIcons.fan),
    inRoom: 'Kitchen',
    state: 'Off',
    toggleSt: false,
    level: '5',
    opacity: 0.3,
  ),
  //Bedroom devices
  Device(
    imageUrl: 'assets/images/deviceAssets/fan.png',
    deviceName: 'Lamp',
    icon: Icon(Icons.wb_incandescent),
    inRoom: 'Bedroom',
    state: 'Off',
    toggleSt: false,
    level: '5',
    opacity: 0.3,
  ),
  Device(
    imageUrl: 'assets/images/deviceAssets/fan.png',
    icon: Icon(FontAwesomeIcons.tv),
    deviceName: 'TV',
    inRoom: 'Bedroom',
    state: 'Off',
    toggleSt: false,
    level: '5',
    opacity: 0.3,
  ),
  Device(
    imageUrl: 'assets/images/deviceAssets/fa+n.png',
    deviceName: 'Speaker',
    icon: Icon(Icons.speaker),
    inRoom: 'Bedroom',
    state: 'Off',
    toggleSt: false,
    level: '5',
    opacity: 0.3,
  ),
  //Playroom devices
  Device(
    imageUrl: 'assets/images/deviceAssets/ac.png',
    deviceName: 'Lamp',
    icon: Icon(Icons.wb_incandescent),
    inRoom: 'Playroom',
    state: 'Off',
    toggleSt: false,
    level: '5',
    opacity: 1,
  ),
  Device(
    imageUrl: 'assets/images/deviceAssets/ac.png',
    deviceName: 'AC',
    icon: Icon(Icons.ac_unit),
    inRoom: 'Playroom',
    state: 'Off',
    toggleSt: false,
    level: '5',
    opacity: 1,
  ),
  Device(
    imageUrl: 'assets/images/deviceAssets/ac.png',
    icon: Icon(Icons.speaker),
    deviceName: 'Speaker',
    inRoom: 'Playroom',
    state: 'Off',
    toggleSt: false,
    level: '5',
    opacity: 1,
  ),

  //Bathroom devices
  Device(
    imageUrl: 'assets/images/deviceAssets/ac.png',
    deviceName: 'Lamp',
    icon: Icon(Icons.wb_incandescent),
    inRoom: 'Bathroom',
    state: 'Off',
    toggleSt: false,
    level: '5',
    opacity: 1,
  ),
  Device(
    imageUrl: 'assets/images/deviceAssets/ac.png',
    icon: Icon(FontAwesomeIcons.fire),
    deviceName: 'Water Heater',
    inRoom: 'Bathroom',
    state: 'Off',
    toggleSt: false,
    level: '5',
    opacity: 1,
  ),
  Device(
    imageUrl: 'assets/images/deviceAssets/ac.png',
    icon: Icon(FontAwesomeIcons.fan),
    deviceName: 'Exhaust Fan',
    inRoom: 'Bathroom',
    state: 'Off',
    toggleSt: false,
    level: '5',
    opacity: 1,
  ),
];
