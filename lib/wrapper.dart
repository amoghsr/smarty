import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smarty/authenticate/authenticate.dart';
import 'package:smarty/models/navigationBar.dart';
import 'package:smarty/models/user.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    // return either the Home or Authenticate widget
    if (user == null) {
      return Authenticate();
    } else {
      return MyNavigationBar();
    }
  }
}
