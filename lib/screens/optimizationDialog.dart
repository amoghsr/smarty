import 'dart:async';

import 'package:flutter/material.dart';
import 'package:smarty/models/devicesModel.dart';

import '../BadgeBox.dart';

class Optimization extends StatefulWidget {
  @override
  _OptimizationState createState() => _OptimizationState();
}

class _OptimizationState extends State<Optimization> {
  List<String> roomNames = ["Living Room", "Kitchen"];
  List<String> deviceNames = ["AC", "Lamp", "Speaker"];
  bool expanded = false;
  double clickwidth = 40.0;
  
  Widget build(BuildContext context) {
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
                'Homi Smart Agent recommend the following changes',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  color: Colors.white,
                  fontSize: 14.0,
                ),
              ),
              SizedBox(height: 24.0),
              ListView.builder(
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
                        child: ExpansionTile(
                          initiallyExpanded: (i == 0) ? true : false,
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              getIcons(deviceNames[i]),
                              SizedBox(
                                width: 8,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    deviceNames[i],
                                    style: TextStyle(
                                        fontSize: 15, color: Colors.white),
                                  ),
                                  Text(
                                    roomNames[i],
                                    style: TextStyle(
                                        fontSize: 11, color: Colors.white),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          trailing: Switch(
                            // Permanently false
                            value: false,
                            onChanged: (_) {},
                            activeTrackColor: Theme.of(context).accentColor,
                            activeColor: Colors.white,
                            inactiveTrackColor:
                                Theme.of(context).backgroundColor,
                          ),
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                Container(
                                  height: 40,
                                  width: clickwidth,
                                  decoration: BoxDecoration(
                                    color: Colors.green,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(5),
                                    ),
                                  ),
                                  child: Center(child: Icon(Icons.check)),
                                ),
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
                                    height: 40,
                                    width: 40,
                                    decoration: BoxDecoration(
                                      color: Colors.red,
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(5),
                                      ),
                                    ),
                                    child: Center(
                                      child: Icon(Icons.clear),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                          ],
                        ),
                      ),
                    );
                  }),
              SizedBox(height: 6),
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
