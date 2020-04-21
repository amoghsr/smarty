import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_vlc_player/vlc_player.dart';
import 'package:flutter_vlc_player/vlc_player_controller.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:smarty/screens/drawer.dart';
import 'package:smarty/shared/constants.dart';
import 'package:smarty/widgets/voiceAgent.dart';

class Security extends StatefulWidget {
  @override
  _SecurityState createState() => _SecurityState();
}

class _SecurityState extends State<Security> {
  bool isLocked = true;
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;
    final String urlToStreamVideo = 'http://10.0.0.59:8160';
    final VlcPlayerController controller = VlcPlayerController();
    final int playerWidth = 640;
    final int playerHeight = 360;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Security',
          style: kAppBarTextStyle,
        ),
        actions: <Widget>[MicClass()],
      ),
      drawer: DrawerPage(),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Center(
          child: Container(
            color: Theme.of(context).scaffoldBackgroundColor,
            child: Column(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(color: Theme.of(context).cardColor),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: <Widget>[
                        Text(
                          'You can view the footage of your homes CCTV set on your front porch',
                          textAlign: TextAlign.center,
                        )
                      ],
                    ),
                  ),
                ),
                Row(
                  children: <Widget>[
                    Container(
                      height: screenheight * 0.08,
                      width: screenwidth,
                      child: Center(
                        child: Text(
                          "Front-door",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 24.0, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    controller.hasClients
                        ? new VlcPlayer(
                            defaultHeight: playerHeight,
                            defaultWidth: playerWidth,
                            url: urlToStreamVideo,
                            controller: controller,
                          )
                        : Container(
                            decoration: BoxDecoration(
                              color: Theme.of(context).cardColor,
                              borderRadius: BorderRadius.all(
                                Radius.circular(10.0),
                              ),
                            ),
                            height: screenheight * 0.3,
                            width: screenwidth * 0.89,
                          ),
                  ],
                ),
                SizedBox(
                  height: screenheight * 0.03,
                ),
//                Row(
//                  children: <Widget>[
//                    Column(
//                      children: <Widget>[
//                        Container(
//                          height: screenheight * 0.13,
//                          width: screenwidth,
//                          child: Center(
//                            child: InkWell(
//                              onTap: () {
//                                setState(() {
//                                  isLocked = !isLocked;
//                                });
//                              },
//                              child: Container(
//                                // height: screenheight,
//                                decoration: BoxDecoration(
//                                  shape: BoxShape.circle,
//                                  boxShadow: <BoxShadow>[
//                                    BoxShadow(
//                                      color: (isLocked == true)
//                                          ? Colors.green
//                                          : Colors.red,
//                                      blurRadius: 3,
//                                    ),
//                                  ],
//                                ),
//                                child: CircleAvatar(
//                                  radius: 40,
//                                  backgroundColor:
//                                  Theme.of(context).canvasColor,
//                                  child: Icon(
//                                    (isLocked == true)
//                                        ? Icons.lock
//                                        : Icons.lock_open,
//                                    color: (isLocked == true)
//                                        ? Colors.green
//                                        : Colors.red,
//                                    size: 40,
//                                  ),
//                                ),
//                              ),
//                            ),
//                            // ),
//                          ),
//                        ),
//                        SizedBox(
//                          height: screenheight * 0.01,
//                        ),
//                        Text(
//                          (isLocked == true) ? 'DOOR LOCKED' : 'DOOR UNLOCKED',
//                          style: TextStyle(
//                            fontSize: 17,
//                            fontWeight: FontWeight.w300,
//                          ),
//                        ),
//                      ],
//                    ),
//                  ],
//                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
