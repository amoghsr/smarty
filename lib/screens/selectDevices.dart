import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smarty/models/devicesModel.dart';
import 'package:smarty/models/roomModel.dart';

class SelectDevices extends StatefulWidget {
  List<Room> rooms;
  @override
  _SelectDevicesState createState() => _SelectDevicesState();
}

class _SelectDevicesState extends State<SelectDevices> {
  @override
  Widget build(BuildContext context) {
    final rooms = Provider.of<List<Room>>(context);

    // Get device list using provider
    final devices = Provider.of<List<Device>>(context);
//    devices.forEach((element) {
//      print(element.deviceName);
//    });

    return Scaffold(
      appBar: AppBar(),
    );
  }
}
