import 'package:flutter/material.dart';
import 'package:smarty/alertBox.dart';
import 'package:smarty/devices/CommonControllers/deviceCommonControllers.dart';
import 'package:smarty/screens/p2pPanel.dart';
import 'package:smarty/services/AIPopUpService.dart';
import 'package:smarty/services/dialogLocator.dart';
import 'package:smarty/services/doorbellPopUpService.dart';
import 'package:smarty/services/firePopUpService.dart';
import 'package:smarty/services/p2pPopUpService.dart';

class DialogManager extends StatefulWidget {
  final Widget child;
  DialogManager({Key key, this.child}) : super(key: key);

  _DialogManagerState createState() => _DialogManagerState();
}

class _DialogManagerState extends State<DialogManager> {
  AIDialogService _aiDialog = locator<AIDialogService>();
  P2PDialogService _p2pDialog = locator<P2PDialogService>();
  DoorBellService _doorBellDialog = locator<DoorBellService>();
  FireService _fireDialog = locator<FireService>();
  @override
  void initState() {
    super.initState();
    _aiDialog.registerDialogListener(_showAIDialog);
    _p2pDialog.registerDialogListener(_showP2PDialog);
    _doorBellDialog.registerDialogListener(_showDoorBellDialog);
    _fireDialog.registerDialogListener(_showFireDialog);
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }

  void _showAIDialog() {
    // ************************* AI DIALOG BOX ******************************//
    // TODO: POPUP THIS DIALOG WHEN DAILY CONSUMPTION REACHES 80% OF THE CALCULATED DAILY LIMIT
    showDialog(
      context: context,
      builder: (BuildContext context) => StreamBuilder(
        // stream: itemRef.child("Sensors/Fire/").onValue,
        builder: (context, snap) {
          return CustomDialog(
            image: Image.asset("assets/images/renewable-energy.png"),
            title: "CAREFUL!",
            description: "You have almost reached your daily limit!",
            col: Colors.red[500],
            buttonText: "Optimize Now",
            optimize: true,
          );
        },
      ),
    );
  }

  void _showP2PDialog() {
    // ************************* P2P DIALOG BOX ******************************//
    // TODO: POPUP THIS DIALOG WHEN DAILY CONSUMPTION REACHES THE DAILY GENERATION VALUE (BATTERY LEVEL EMPTY)
    // TODO: POPUP THIS DIALOG ONLY AFTER 6PM (WHEN GENERATION IS ZERO BECAUSE DURING THE DAY THE GENERATION VALUE KEEPS INCREASING)
    showDialog(
      context: context,
      builder: (BuildContext context) => StreamBuilder(
        // stream: itemRef.child("Sensors/Fire/").onValue,
        builder: (context, snap) {
          return CustomDialog(
            image: Image.asset("assets/images/battery.png"),
            title: "BATTERY EMPTY!",
            description: "You are running out of electricity!",
            col: Colors.red[500],
            buttonText: "Purchase Electricity",
            path: P2P(),
          );
        },
      ),
    );
  }

  void _showDoorBellDialog() {
    // ************************* DOORBELL RUNG ******************************//
    showDialog(
      context: context,
      builder: (BuildContext context) => StreamBuilder(
          // stream: itemRef.child("Sensors/Fire/").onValue,
          builder: (context, snap) {
            return CustomDialog(
              image: Image.asset("assets/images/doorbell.png"),
              title: "DOORBELL RUNG!",
              description: "Someone's at the door!",
              col: Colors.red[500],
              buttonText: "Okay",
            );
          }),
    );
  }

  void _showFireDialog() {
    // ************************* FIRE ALERT ******************************//
    showDialog(
      context: context,
      builder: (BuildContext context) => StreamBuilder(
          // stream: itemRef.child("Sensors/Fire/").onValue,
          builder: (context, snap) {
        return CustomDialog(
          image: Image.asset("assets/images/fire.png"),
          title: "FIRE DETECTED!",
          description: "Sprinklers have been activated.",
          col: Color(0xffE26069),
          buttonText: "Okay",
        );
      }),
    );
  }

}
