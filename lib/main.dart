import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smarty/models/currentDayProvider.dart';
import 'package:smarty/models/themeModel.dart';
import 'package:smarty/models/user.dart';
import 'package:smarty/services/auth.dart';
import 'package:smarty/services/dialogLocator.dart';
import 'package:smarty/services/service_locator.dart';
import 'package:smarty/wrapper.dart';
import 'package:smarty/models/boltProvider.dart';

import 'models/dbService.dart';
import 'models/devicesModel.dart';
import 'models/roomModel.dart';

void main() {
  setupLocator();
  setupAIPopUp();
  setupP2PPopUp();
  setupDoorBell();
  setupFire();
  debugDefaultTargetPlatformOverride = TargetPlatform.fuchsia;
  runApp(
    ChangeNotifierProvider<ThemeModel>(
      create: (BuildContext context) => ThemeModel(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
      //Todo: remove all this
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider<BoltProvider>(
            create: (_) => BoltProvider(25),
          ),
          ChangeNotifierProvider<CurrentDayProvider>(
            create: (_) => CurrentDayProvider(20),
          ),
        ],
        child: Consumer<BoltProvider>(builder: (context, counter, _) {
          return Consumer<CurrentDayProvider>(builder: (context, counter, _) {
            return StreamProvider<List<Room>>.value(
              value: DatabaseService1().streamRooms(Provider.of<User>(context)),
              child: StreamProvider<List<Device>>.value(
                value: DatabaseService1().streamDevices(Provider.of<User>(context)),
                child: MaterialApp(
                  home: Wrapper(),
                  theme: Provider.of<ThemeModel>(context).currentTheme,
                ),
              ),
            );
          });
        }),
      ),
    );
  }
}

// MaterialApp(
//           debugShowCheckedModeBanner: false,
//           theme: Provider.of<ThemeModel>(context).currentTheme,
//           home: ChangeNotifierProvider<BoltProvider>(
//             create: (_) => BoltProvider(25),
//             child: Wrapper(),
//           ),
//         ),
//       ),);
