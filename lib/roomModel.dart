import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'devicesModel.dart';

class Room {
  String imageUrl;
  String roomName;
  String description;
  String nDevices;
  Icon icon;
  List<String> d;

  Room({
    this.imageUrl,
    this.roomName,
    this.description,
    this.nDevices,
    this.icon,
    this.d,
  });
}

List<String> getDv (String roomname) {
  List<String> devicelist = [];
  for (var i in devices) {
    if (i.inRoom == roomname) {
      devicelist.add(i.deviceName);
    }
  }
  print(devicelist);
  return devicelist;
}

List<Room> rooms = [
  Room(
      imageUrl: 'assets/images/livingroom.png',
      roomName: 'Living Room',
      description: 'Family space',
      nDevices: '5',
      icon: Icon(FontAwesomeIcons.couch),
      d: getDv('Living Room')),
  Room(
      imageUrl: 'assets/images/kitchen.png',
      roomName: 'Kitchen',
      description: 'Cooking space',
      nDevices: '2',
      icon: Icon(FontAwesomeIcons.utensils),
      d: getDv('Kitchen')),
  Room(
      imageUrl: 'assets/images/bedroom.png',
      roomName: 'Bedroom',
      description: 'Sleeping Space',
      nDevices: '4',
      icon: Icon(FontAwesomeIcons.bed),
      d: getDv('Bedroom')),
  Room(
      imageUrl: 'assets/images/bedroom.png',
      roomName: 'Playroom',
      description: 'Sleeping Space',
      nDevices: '4',
      icon: Icon(FontAwesomeIcons.child),
      d: getDv('Playroom')),
  Room(
      imageUrl: 'assets/images/bathroom.png',
      roomName: 'Bathroom',
      description: 'Fresh!',
      nDevices: '2',
      icon: Icon(FontAwesomeIcons.bath),
      d: getDv('Bathroom')),
];
