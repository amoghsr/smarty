import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smarty/devices/CommonControllers/deviceCommonControllers.dart';
import 'package:smarty/devices/acController.dart';
import 'package:smarty/devices/lightController.dart';
import 'package:smarty/models/user.dart';

import 'devices/faucetController.dart';
import 'devices/speakerController.dart';
import 'devices/tvController.dart';

class DevicesController extends StatefulWidget {
  String chRoom;
  String chDevice;

  // bool isDisabled;
  DevicesController({this.chDevice, this.chRoom});

  _DevicesControllerState createState() => _DevicesControllerState();
}

class _DevicesControllerState extends State<DevicesController>
    with SingleTickerProviderStateMixin {
  DatabaseReference itemRef;

  void initState() {
    super.initState();
    final FirebaseDatabase database = FirebaseDatabase
        .instance; //Rather then just writing FirebaseDatabase(), get the instance.
    itemRef = database.reference();
  }

  @override
  Widget build(BuildContext context) {
    // bool isSwitched = widget.isDisabled;
    final user = Provider.of<User>(context);
    Widget showDevice = LightController(
        itemRef: itemRef,
        context: context,
        roomName: widget.chRoom,
        devName: widget.chDevice);

    if (widget.chDevice == 'Lamp') {
      showDevice = LightController(
          itemRef: itemRef,
          context: context,
          roomName: widget.chRoom,
          devName: widget.chDevice);
    } else if (widget.chDevice == 'AC') {
      showDevice = ACController(
          itemRef: itemRef,
          context: context,
          roomName: widget.chRoom,
          devName: widget.chDevice);
    } else if (widget.chDevice == 'Speaker') {
      showDevice = SpeakerController(
          itemRef: itemRef,
          brightness: brightness,
          context: context,
          roomName: widget.chRoom,
          devName: widget.chDevice);
    } else if (widget.chDevice == 'TV') {
      showDevice = TVController(
          itemRef: itemRef,
          brightness: brightness,
          context: context,
          roomName: widget.chRoom,
          devName: widget.chDevice);
    } else if (widget.chDevice == 'Faucet') {
      showDevice = FaucetController(
          itemRef: itemRef,
          waterAmount: waterAmount,
          context: context,
          roomName: widget.chRoom,
          devName: widget.chDevice);
    } else {
      return Container();
    }
    return showDevice;
  }
}
