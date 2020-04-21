import 'package:flutter/material.dart';
import 'package:smarty/authenticate/greeting.dart';
import 'package:smarty/authenticate/register.dart';
import 'package:smarty/authenticate/sign_in.dart';
import 'package:provider/provider.dart';
import 'package:smarty/models/themeModel.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool showSignIn = true;

  void toggleView() {
    //print(showSignIn.toString());
    setState(() => showSignIn = !showSignIn);
  }

  @override
  Widget build(BuildContext context) {
    if (showSignIn) {
      return MaterialApp(home: GreetingPage(), theme: Provider.of<ThemeModel>(context).currentTheme,);
    }
  }
}
