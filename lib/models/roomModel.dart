import 'package:cloud_firestore/cloud_firestore.dart';
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

//TODO: Fix Provider
  // String getImageUrl(String roomName) {
  //   switch (roomName) {
  //     case 'Living Room':
  //       return 'assets/images/livingroom.png';
  //     case 'Kitchen':
  //       return 'assets/images/kitchen.png';
  //     case 'Bedroom':
  //       return 'assets/images/bedroom.png';
  //     case 'Playroom':
  //       return 'assets/images/bedroom.png';
  //     case 'Bathroom':
  //       return 'assets/images/bathroom.png';
  // }
  // }

  // Icon getIcons(String roomName) {
  //   switch (roomName) {
  //     case 'Living Room':
  //       return Icon(FontAwesomeIcons.couch);
  //     case 'Kitchen':
  //       return Icon(FontAwesomeIcons.utensils);
  //     case 'Bedroom':
  //       return Icon(FontAwesomeIcons.bed);
  //     case 'Playroom':
  //       return Icon(FontAwesomeIcons.child);
  //     case 'Bathroom':
  //       return Icon(FontAwesomeIcons.bath);
  // }}
//
//  factory Room.fromFirestore(DocumentSnapshot doc) {
//    Map data = doc.data;
//    return Room(
//      roomName: data.key,
//      nDevices: data['nDevices'],
//      icon: getIcons(data['roomName']),
//      imageUrl: getImageUrl(data['roomName']),
//    );
//  }
}

List<String> getDv(String roomname) {
  List<String> devicelist = [];
  for (var i in devices) {
    if (i.inRoom == roomname) {
      devicelist.add(i.deviceName);
      // devicelist.add(i.icon);
    }
  }
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
