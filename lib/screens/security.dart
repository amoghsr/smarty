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
      body: VlcPlayer(
        defaultWidth: playerWidth,
        defaultHeight: playerHeight,
        url: urlToStreamVideo,
        controller: controller,
        placeholder: Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
