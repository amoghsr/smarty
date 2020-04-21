import 'package:flutter/material.dart';
import 'package:flutter_vlc_player/vlc_player.dart';
import 'package:flutter_vlc_player/vlc_player_controller.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:smarty/models/consumptionModel.dart';
import 'package:smarty/models/devicesModel.dart';

import 'package:smarty/screens/drawer.dart';
import 'package:smarty/shared/constants.dart';
import 'package:smarty/widgets/voiceAgent.dart';
import 'package:smarty/models/leaderboardModel.dart';

class AllDevices extends StatefulWidget {
  @override
  _AllDevicesState createState() => _AllDevicesState();
}

class _AllDevicesState extends State<AllDevices> with TickerProviderStateMixin {
  double height = 70;
  bool showDevices = false;

  void initState() {
    // if (Provider.of<BoltProvider>(context, listen: false).getBalanceAsInt() == 10)
    //   Timer.run(
    //       () => Provider.of<DialogProvider>(context, listen: false).popAi());
  }

  Widget build(BuildContext context) {
    List<String> roomNames = [];
    Map<String, double> usage = {};
    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;
    final y = Provider.of<Consumption>(context);
    if (y != null) {
      y.devicesDaily.forEach((key, va) {
        roomNames.add(key);
        double total = 0;
        va.forEach((key, va1) {
          total = total + va1;
        });
        try {
          usage[key] = num.parse(total.toStringAsFixed(3));
        } catch (s) {
          usage[key] = 0.0;
        }
      });
    }
    if (y != null) {
      return Scaffold(
        appBar: AppBar(
          title: Text(
            'All Devices',
            style: kAppBarTextStyle,
          ),
          actions: <Widget>[MicClass()],
        ),
        body: ListView.builder(
            shrinkWrap: true,
            itemCount: roomNames.length,
            itemBuilder: (context, i) {
              return Container(
                margin: EdgeInsets.only(left: 12.0, right: 12.0, top: 6.0),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
//                elevation: 4.0,
                  child: Container(
                    child: ExpansionTile(
                      title: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                SizedBox(
                                  width: 6.0,
                                ),
                                getRoomIcons(roomNames[i]),
                                SizedBox(width: screenwidth * 0.05),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      roomNames[i],
                                      style: TextStyle(fontSize: 18.0),
                                    ),
                                    SizedBox(
                                      height: 4.0,
                                    ),
                                    Text(
                                      y.devicesDaily[roomNames[i]].length
                                          .toString(),
                                      style: TextStyle(
                                        fontSize: 12.0,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Text(
                              usage[roomNames[i]].toString() + ' KWh',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 22.0),
                          child: ListView.separated(
                              separatorBuilder:
                                  (BuildContext context, int index) =>
                                      Divider(),
                              shrinkWrap: true,
                              itemCount: y.devicesDaily[roomNames[i]].length,
                              itemBuilder: (context, index) {
                                return Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: <Widget>[
                                            getIcons(y
                                                .devicesDaily[roomNames[i]].keys
                                                .toList()[index]),
                                            SizedBox(width: 10),
                                            Text(
                                              y.devicesDaily[roomNames[i]].keys
                                                  .toList()[index],
                                              style: TextStyle(fontSize: 16),
                                            ),
                                          ],
                                        ),
                                        Text(
                                          y.devicesDaily[roomNames[i]][y
                                                  .devicesDaily[roomNames[i]]
                                                  .keys
                                                  .toList()[index]]
                                              .toString(),
                                          style: TextStyle(fontSize: 16),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                  ],
                                );
                              }),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
      );
    } else {
      return Container();
    }
  }

  Icon getRoomIcons(String roomName) {
    switch (roomName) {
      case 'Living Room':
        return Icon(FontAwesomeIcons.couch);
      case 'Kitchen':
        return Icon(FontAwesomeIcons.utensils);
      case 'Bedroom':
        return Icon(FontAwesomeIcons.bed);
      case 'Playroom':
        return Icon(FontAwesomeIcons.child);
      case 'Bathroom':
        return Icon(FontAwesomeIcons.bath);
    }
  }
}
