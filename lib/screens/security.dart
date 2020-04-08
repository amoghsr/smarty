import 'package:flutter/material.dart';
import 'package:smarty/screens/drawer.dart';
import 'package:smarty/shared/constants.dart';
import 'package:smarty/widgets/voiceAgent.dart';
import 'package:flutter_vlc_player/vlc_player_controller.dart';
import 'package:flutter_vlc_player/vlc_player.dart';

class Security extends StatefulWidget {
  @override
  _SecurityState createState() => _SecurityState();
}

class _SecurityState extends State<Security> {
  bool isLocked = true;

  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;
    final String urlToStreamVideo = 'http://10.0.0.55/html/';
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
        // physics: NeverScrollableScrollPhysics(),
        child: Center(
          child: Container(
            color: Theme.of(context).scaffoldBackgroundColor,
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Container(
                      height: screenheight * 0.08,
                      width: screenwidth,
                      child: Center(
                        child: Text(
                          "Front Door",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 17,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        color: Color(0xffBEBEBE),
                        borderRadius: BorderRadius.all(
                          Radius.circular(20),
                        ),
                      ),
                      height: screenheight * 0.55,
                      width: screenwidth * 0.89,
                    ),
                    VlcPlayer(
                      defaultWidth: playerWidth,
                      defaultHeight: playerHeight,
                      url: urlToStreamVideo,
                      controller: controller,
                      placeholder: Center(child: CircularProgressIndicator()),
                    ),
                  ],
                ),
                SizedBox(
                  height: screenheight * 0.02,
                ),
                Row(
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Container(
                          height: screenheight * 0.13,
                          width: screenwidth,
                          child: Center(
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  isLocked = !isLocked;
                                });
                              },
                              child: Container(
                                // height: screenheight,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  boxShadow: <BoxShadow>[
                                    BoxShadow(
                                      color: (isLocked == true)
                                          ? Colors.green
                                          : Colors.red,
                                      blurRadius: 3,
                                    ),
                                  ],
                                ),
                                child: CircleAvatar(
                                  radius: 40,
                                  backgroundColor:
                                      Theme.of(context).canvasColor,
                                  child: Icon(
                                    (isLocked == true)
                                        ? Icons.lock
                                        : Icons.lock_open,
                                    color: (isLocked == true)
                                        ? Colors.green
                                        : Colors.red,
                                    size: 40,
                                  ),
                                ),
                              ),
                            ),
                            // ),
                          ),
                        ),
                        SizedBox(
                          height: screenheight * 0.01,
                        ),
                        Text(
                          (isLocked == true) ? 'DOOR LOCKED' : 'DOOR UNLOCKED',
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
