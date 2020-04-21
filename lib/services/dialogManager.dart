import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:smarty/alertBox.dart';
import 'package:smarty/devices/CommonControllers/deviceCommonControllers.dart';
import 'package:smarty/screens/energy_sharing_screen.dart';
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
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  void initState() {
    super.initState();
    _aiDialog.registerDialogListener(_showAIDialog);
    _p2pDialog.registerDialogListener(_showP2PDialog);
    _doorBellDialog.registerDialogListener(_showDoorBellDialog);
    _fireDialog.registerDialogListener(_showFireDialog);

    // initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
    // If you have skipped STEP 3 then change app_icon to @mipmap/ic_launcher
    var initializationSettingsAndroid =
        new AndroidInitializationSettings('app_icon');
    var initializationSettingsIOS = new IOSInitializationSettings();
    var initializationSettings = new InitializationSettings(
        initializationSettingsAndroid, initializationSettingsIOS);
    flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();
    flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
    );
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }

  Future _showNotificationWithDefaultSound(String title, String desc) async {
    flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();
    var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
        'Smarty', 'Kaizen Systems', 'Stage 2',
        importance: Importance.Max, priority: Priority.High);
    var iOSPlatformChannelSpecifics = new IOSNotificationDetails();
    var platformChannelSpecifics = new NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
      0,
      title,
      desc,
      platformChannelSpecifics,
      payload: 'Default_Sound',
    );
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
    _showNotificationWithDefaultSound(
        'CAREFUL!', 'You have almost reached your daily limit!');
  }

  void _showP2PDialog() {
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
            path: EnergySharingScreen(),
          );
        },
      ),
    );
    _showNotificationWithDefaultSound(
        'BATTERY EMPTY!', 'You are running out of electricity!');
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
    _showNotificationWithDefaultSound(
        'DOORBELL RUNG!', 'Someone\'s at the door!');
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
    _showNotificationWithDefaultSound(
        'FIRE DETECTED!', 'Sprinklers have been activated.');
  }
}
