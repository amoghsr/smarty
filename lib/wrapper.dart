import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smarty/authenticate/authenticate.dart';
import 'package:smarty/models/navigationBar.dart';
import 'package:smarty/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:smarty/services/auth.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    if (user == null) {
      return Authenticate();
    } else {
      StreamProvider<User>.value(
        value: AuthService().user,
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: MyNavigationBar(),
        ),
      );
    }
  }
}
