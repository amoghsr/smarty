import 'dart:async';

import 'package:flutter/material.dart';
import 'package:smarty/models/devicesModel.dart';

import '../BadgeBox.dart';

class Optimization extends StatefulWidget {
  @override
  _OptimizationState createState() => _OptimizationState();
}

class _OptimizationState extends State<Optimization> {
  // TODO: Get the room names
  List<String> roomNames = ["Living Room", "Kitchen", "Playroom"];
  // TODO: Get the device names for each room (IF THEY ARE ON)
  List<String> deviceNames = ["AC", "Lamp", "Speaker"];

  Map<String, String> desc = {
    "AC": "Set the temperature to 24°C",
    "Lamp": "Set the brightness to 25%",
    "Speaker": "Turn off the Speakers",
    "TV": "Turn off TV",
    "Exhaust Fan": "Turn off the Exhaust Fan "
  };
  bool expanded = false;

  Widget build(BuildContext context) {
    double screenheight = MediaQuery.of(context).size.height;
    return Stack(
      children: <Widget>[
        //...bottom card part,
        Container(
          padding: EdgeInsets.only(
            top: Consts.padding + 10,
            bottom: Consts.padding,
            left: Consts.padding,
            right: Consts.padding,
          ),
          decoration: new BoxDecoration(
            color: Theme.of(context).canvasColor,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(Consts.padding),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10.0,
                offset: const Offset(0.0, 10.0),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min, // To make the card compact
            children: <Widget>[
              // Title of the popup
              Text(
                'Suggested Optimizations',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  color: Colors.white,
                  fontSize: 18.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 16.0),
              // Description on the popup
              Text(
                'Homi Smart Agent recommends the following changes',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  color: Colors.white,
                  fontSize: 14.0,
                ),
              ),
              SizedBox(height: 24.0),
              ConstrainedBox(
                constraints: BoxConstraints(
                    maxHeight: screenheight * 0.35,
                    minHeight: screenheight * 0.1),
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: roomNames.length,
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (context, i) {
                      return Container(
                        margin: EdgeInsets.all(5.5),
                        decoration: BoxDecoration(
                          color: Theme.of(context).cardColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Theme(
                          data: Theme.of(context)
                              .copyWith(dividerColor: Colors.transparent),
                          child: ListTile(
                            title: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                SizedBox(height: 10),
                                Text(
                                  desc[deviceNames[i]],
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        getIcons(deviceNames[i]),
                                        SizedBox(
                                          width: 8,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                              deviceNames[i],
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                            Text(
                                              roomNames[i],
                                              style: TextStyle(
                                                  fontSize: 11,
                                                  color: Colors.white),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: <Widget>[
                                        Container(
                                          height: 25,
                                          width: 25,
                                          decoration: BoxDecoration(
                                            color: Colors.green,
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(5),
                                            ),
                                          ),
                                          child: Center(
                                              child:
                                                  Icon(Icons.check, size: 18)),
                                        ),
                                        SizedBox(width: 15),
                                        InkWell(
                                          onTap: () {
                                            setState(() {
                                              roomNames.removeAt(i);

                                              if (roomNames.length == 0) {
                                                Timer(Duration(seconds: 1), () {
                                                  Navigator.pop(context);
                                                });
                                              }
                                            });
                                          },
                                          child: Container(
                                            height: 25,
                                            width: 25,
                                            decoration: BoxDecoration(
                                              color: Colors.red,
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(5),
                                              ),
                                            ),
                                            child: Center(
                                              child:
                                                  Icon(Icons.clear, size: 18),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
              ),
              SizedBox(height: 15),
              Align(
                alignment: Alignment.bottomCenter,
                // A button used for closing the dialog plus switching off the fire alarm.
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Container(
                      height: 40,
                      width: 80,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.all(
                          Radius.circular(5),
                        ),
                      ),
                      child: Center(
                        child: Text('Accept All'),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          roomNames.clear();
                          if (roomNames.length == 0) {
                            Timer(Duration(seconds: 1), () {
                              Navigator.pop(context);
                            });
                          }
                        });
                      },
                      child: Container(
                        height: 40,
                        width: 80,
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.all(
                            Radius.circular(5),
                          ),
                        ),
                        child: Center(
                          child: Text('Reject All'),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        //...top circlular image part,
      ],
    );
  }
}
