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

  factory Device.fromFirestore(String key, int value, String doc) => Device(
        deviceName: key,
        inRoom: doc,
        icon: getIcons(key),
        imageUrl: getImageUrl(key),
        count: value,
        state: '',
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
    case 'Refrigerator':
      return 'assets/images/deviceAssets/fridge.png';
    case 'Water Heater':
      return 'assets/images/deviceAssets/waterheater.png';
    case 'Baby Monitor':
      return 'assets/images/deviceAssets/babymonitor.png';
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
    case 'Water Heater':
      return Icon(FontAwesomeIcons.temperatureHigh);
    case 'Refrigerator':
      return Icon(FontAwesomeIcons.cubes);
    case 'Baby Monitor':
      return Icon(FontAwesomeIcons.baby);
  }
}
