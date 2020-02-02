import 'package:flutter/material.dart';
import 'package:smarty/Rooms.dart';

import 'roomModel.dart';

class RoomCarousel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
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
              // GestureDetector(
              //   onTap: () => print('See All'),
              //   child: Text(
              //     'See All',
              //     style: TextStyle(
              //       fontSize: 12.0,
              //       color: Theme.of(context).accentColor,
              //       fontWeight: FontWeight.w600,
              //     ),
              //   ),
              // ),
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
            itemCount: rooms.length,
            itemBuilder: (BuildContext context, int index) {
              Room room = rooms[index];
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
                          builder: (context) => MyOtherRoom(initRoom: index),
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
//                                color: Colors.white,
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
//                                  color: Colors.white,
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

//                    Positioned(
//                      child: Container(
//                        decoration: BoxDecoration(
//                          color: Colors.green,
//                          borderRadius: BorderRadius.circular(20.0),
//                          boxShadow: [
//                            BoxShadow(
//                              color: Colors.black26,
//                              offset: Offset(0.0, 2.0),
//                              blurRadius: 6.0,
//                            ),
//                          ],
//                        ),
//                      child: Stack(
//                        children: <Widget>[
//                          ClipRRect(
//                            borderRadius: BorderRadius.circular(20.0),
//                            child: Image(
//                              height: 60.0,
//                              width: 75.0,
//                              image: AssetImage(destination.imageUrl),
//                              fit: BoxFit.cover,
//                            ),
//                          )
//                        ],
//                      ),
//                      ),
//                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
