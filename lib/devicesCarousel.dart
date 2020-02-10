/*
This file helps create the carousels for the devices in the house.
 */

import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:smarty/firebaseControlDevices.dart';

import 'devicesModel.dart';

class DeviceCarousel extends StatelessWidget {
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
                'Favourite Devices',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              // GestureDetector(
              //   onTap: () => print('See All'),
              //   child: Text(
              //     'See All Devices',
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
                  'Most used devices in your house.',
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
          height: 180.0,
//          color: Colors.blue,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: devices.length,
            itemBuilder: (BuildContext context, int index) {
              Device device = devices[index];
              return Container(
                margin: EdgeInsets.all(8.0),
                width: 170.0,
//                color: Colors.red,
                child: Stack(
                  alignment: Alignment.topCenter,
                  children: <Widget>[
                    Opacity(
                      opacity: device.opacity,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => FirebaseControlDevices()),
                          );
                        },
                        child: Container(
                          height: 180.0,
                          width: 170.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: Theme.of(context).backgroundColor,
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(14.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Opacity(
                                      opacity: 0.7,
                                      child: Text(
                                        device.inRoom,
                                        style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w400,
                                          fontFamily: 'Poppins',
//                                      color: Theme.of(context).accentColor,
                                        ),
                                      ),
                                    ),
                                    Icon(
                                      FontAwesome.toggle_on,
                                      size: 24,
                                      color: Theme.of(context).accentColor,
                                    )
                                  ],
                                ),
                                Row(
                                  children: <Widget>[
                                    Image(
                                      height: 50,
                                      width: 50,
                                      image: AssetImage(
                                        device.imageUrl,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(
                                      device.deviceName,
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    Text(
                                      device.state,
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                        fontFamily: 'Montserrat',
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
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
  }
}
