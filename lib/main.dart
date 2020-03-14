import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smarty/models/themeModel.dart';
import 'package:smarty/models/user.dart';
import 'package:smarty/services/auth.dart';
import 'package:smarty/wrapper.dart';
import 'package:smarty/services/service_locator.dart';

void main() {
  setupLocator();
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
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: Provider.of<ThemeModel>(context).currentTheme,
        home: Wrapper(),
      ),
    );
  }
}
