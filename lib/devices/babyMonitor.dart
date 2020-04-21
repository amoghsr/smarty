import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:smarty/devices/CommonControllers/deviceCommonControllers.dart';
import 'package:smarty/models/user.dart';
import 'package:smarty/shared/constants.dart';

class BabyMonitorController extends StatefulWidget {
  BabyMonitorController({
    Key key,
    @required this.itemRef,
    @required this.context,
    @required this.roomName,
    @required this.devName,
  }) : super(key: key);

  final DatabaseReference itemRef;
  final BuildContext context;
  final String roomName;
  final String devName;

  @override
  _BabyMonitorControllerState createState() => _BabyMonitorControllerState();
}

class _BabyMonitorControllerState extends State<BabyMonitorController> {
  void initState() {
    super.initState();
    final FirebaseDatabase database = FirebaseDatabase
        .instance; //Rather then just writing FirebaseDatabase(), get the instance.
    itemRef = database.reference();
  }

  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;
    final user = Provider.of<User>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    widget.roomName,
                    style: kLightDeviceTopBar.copyWith(
                        color: Theme.of(context).disabledColor),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Text(
                    'Baby Monitor',
                    style: kLightDeviceBottomBar,
                  ),
                ],
              ),
              Container(
                child: Icon(FontAwesomeIcons.baby, size: 48),
              ),
            ],
          ),
          SizedBox(height: 20),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            child: ClipRRect(
                borderRadius: BorderRadius.all(
                  Radius.circular(30),
                ),
                child: Image.asset('assets/images/baby_monitor.png')),
          ),
        ],
      ),
    );
  }
}
