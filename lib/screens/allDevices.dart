import 'package:flutter/material.dart';
import 'package:flutter_vlc_player/vlc_player.dart';
import 'package:flutter_vlc_player/vlc_player_controller.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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

  // TODO: Get the list of rooms
  List<String> roomNames = ["Living Room", "Kitchen"];
  // TODO: Get the list of devices per room (EVEN IF THE CONSUMPTION FOR THAT DEVICE IN THAT DAY IS 0)
  List<String> deviceNames = ["AC", "Lamp", "Speaker"];
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'All Devices',
            style: kAppBarTextStyle,
          ),
        ),
        actions: <Widget>[MicClass()],
      ),
      drawer: DrawerPage(),
      body: ListView.builder(
          shrinkWrap: true,
          itemCount: roomNames.length,
          physics: BouncingScrollPhysics(),
          itemBuilder: (context, i) {
            return Container(
              margin: EdgeInsets.all(5.5),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Container(
                  child: Theme(
                    data: Theme.of(context)
                        .copyWith(dividerColor: Colors.transparent),
                    child: ExpansionTile(
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              getRoomIcons(roomNames[i]),
                              SizedBox(width: screenwidth * 0.05),
                              Column(
                                children: <Widget>[
                                  Text(
                                    roomNames[i],
                                    style: TextStyle(fontSize: 17),
                                  ),
                                  Text(
                                    // TODO: Get the Number of devices per room, to display here
                                    '3 Devices',
                                    style: TextStyle(
                                      fontSize: 10,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Text(
                            // TODO: Total Consumption per room (Total of all devices per room) uptil that point of the day
                            '3 KwH',
                            style: TextStyle(fontSize: 17),
                          ),
                        ],
                      ),
                      children: <Widget>[
                        ListView.builder(
                            shrinkWrap: true,
                            itemCount: deviceNames.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding:
                                    const EdgeInsets.only(right: 62, left: 50),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Row(
                                          children: <Widget>[
                                            getIcons(deviceNames[index]),
                                            SizedBox(width: 10),
                                            Text(
                                              deviceNames[index],
                                              style: TextStyle(fontSize: 16),
                                            ),
                                          ],
                                        ),
                                        Text(
                                          // TODO: Total per device (Sum of consumption throughout the day for that device) up until that point of the day
                                          '1 KwH',
                                          style: TextStyle(fontSize: 16),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                  ],
                                ),
                              );
                            }),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }),
    );
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
