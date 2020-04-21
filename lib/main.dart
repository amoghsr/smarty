import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smarty/models/currentDayProvider.dart';
import 'package:smarty/models/themeModel.dart';
import 'package:smarty/models/user.dart';
import 'package:smarty/services/auth.dart';
import 'package:smarty/services/dialogLocator.dart';
import 'package:smarty/services/dialogManager.dart';
import 'package:smarty/services/dialogProvider.dart';
import 'package:smarty/services/service_locator.dart';
import 'package:smarty/wrapper.dart';
import 'package:smarty/models/pointsProvider.dart';

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
      child: StreamProvider<Map<String, PointsProvider>>.value(
        value: DatabaseService1().streamPoints(),
        child: Wrapper(),
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
