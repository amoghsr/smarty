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
import 'package:smarty/models/boltProvider.dart';

void main() {
  setupLocator();
  setupAIPopUp();
  setupP2PPopUp();
  setupDoorBell();
  setupFire();
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
          ChangeNotifierProvider<DialogProvider>(
            create: (_) => DialogProvider(),
          ),
        ],
        child: Consumer<BoltProvider>(builder: (context, counter, _) {
          return MaterialApp(
            home: Wrapper(),
            builder: (context, widget) => Navigator(
              onGenerateRoute: (settings) => MaterialPageRoute(
                builder: (context) => DialogManager(
                  child: widget,
                ),
              ),
            ),
            theme: Provider.of<ThemeModel>(context).currentTheme,
          );
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
