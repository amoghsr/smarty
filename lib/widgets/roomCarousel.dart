/*
This file helps create the carousels for the room1 in the house.
 */

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smarty/models/devicesModel.dart';
import 'package:smarty/models/roomModel.dart';
import 'package:smarty/screens/rooms.dart';
import 'package:smarty/shared/constants.dart';

class RoomCarousel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final room1 = Provider.of<List<Room>>(context);
    final devices = Provider.of<List<Device>>(context);

    if (room1 != null && devices != null) {
      return Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('All Rooms', style: kHeadingTextStyle),
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
                  opacity: 0.8,
                  child: Text(
                    'Scroll through all the rooms in your house',
                    style: TextStyle(
                      fontSize: 12.0,
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
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black.withOpacity(0.08),
                                  offset: Offset(2.0, 6.0),
                                  blurRadius: 6.0)
                            ],
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
                                    fontSize: 18.0,
                                    shadows: [
                                      Shadow(
                                        blurRadius: 10.0,
                                        color: Colors.black26.withOpacity(0.4),
                                        offset: Offset(4.0, 4.0),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 2,
                                ),
                                Opacity(
                                  opacity: 1.0,
                                  child: Text(
                                    '${room.nDevices} devices',
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                      shadows: [
                                        Shadow(
                                          blurRadius: 10.0,
                                          color: Colors.black38,
                                          offset: Offset(5.0, 5.0),
                                        ),
                                      ],
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
      );
    } else {
      return Container();
    }
  }
}
