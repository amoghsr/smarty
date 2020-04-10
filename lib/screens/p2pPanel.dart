import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:provider/provider.dart';
import 'package:smarty/models/devicesModel.dart';
import 'package:smarty/models/navigationBar.dart';
import 'package:smarty/models/roomModel.dart';
import 'package:smarty/screens/drawer.dart';
import 'package:smarty/screens/rooms.dart';
import 'package:smarty/shared/constants.dart';
import 'package:smarty/widgets/voiceAgent.dart';

class P2P extends StatefulWidget {
  @override
  _P2PState createState() => _P2PState();
}

class _P2PState extends State<P2P> {
  @override
  Widget build(BuildContext context) {
    final room1 = Provider.of<List<Room>>(context);
    final devices = Provider.of<List<Device>>(context);
    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Energy Sharing',
          style: kAppBarTextStyle,
        ),
        actions: <Widget>[
          Row(
            children: <Widget>[
              Text(
                '25',
                style: TextStyle(
                  fontSize: 19,
                ),
              ),
              Icon(Icons.flash_on, size: 19, color: Color(0xffe8b313)),
              SizedBox(
                width: screenwidth * 0.03,
              )
            ],
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Your Rooms',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 4,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Opacity(
                    opacity: 0.5,
                    child: Text(
                      'Scroll through all the rooms in your house.',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Container(
              height: 200.0,
//          color: Colors.blue,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: room1.length,
                itemBuilder: (BuildContext context, int index) {
                  Room room = room1[index];
                  return Container(
                    margin: EdgeInsets.all(8.0),
                    width: 140.0,
//                color: Colors.red,
                    child: Stack(
                      alignment: Alignment.topCenter,
                      children: <Widget>[
                        GestureDetector(
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MyOtherRoom(
                                  initRoom: index,
                                  rooms: room1,
                                  devices: devices),
                            ),
                          ),
                          child: Container(
                            height: 190.0,
                            width: 140.0,
                            decoration: BoxDecoration(
                              //Image inside box
                              image: DecorationImage(
                                image: AssetImage(room.imageUrl),
                                fit: BoxFit.fill,
                              ),
                              borderRadius: BorderRadius.circular(10.0),
                              color: Theme.of(context).backgroundColor,
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    room.roomName,
                                    style: TextStyle(
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white,
                                      fontSize: 15,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 2,
                                  ),
                                  Opacity(
                                    opacity: 0.8,
                                    child: Text(
                                      '${room.nDevices} devices',
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 10,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10.0,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
