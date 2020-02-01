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

  Device(
      {this.imageUrl,
      this.deviceName,
      this.inRoom,
      this.state,
      this.level,
      this.opacity,
      this.icon,
      this.toggleSt});
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
    imageUrl: 'assets/images/deviceAssets/fan.png',
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
    icon: Icon(FontAwesomeIcons.video),
    deviceName: 'Baby Monitor',
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
