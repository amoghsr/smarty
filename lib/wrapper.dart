import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smarty/authenticate/authenticate.dart';
import 'package:smarty/models/dbService.dart';
import 'package:smarty/models/navigationBar.dart';
import 'package:smarty/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:smarty/services/auth.dart';
import 'package:smarty/models/themeModel.dart';

import 'models/roomModel.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    if (user == null) {
      return Authenticate();
    } else {
      return StreamProvider<List<Room>>.value(
        value: DatabaseService1().streamRooms(user),
        child: MaterialApp(
          theme: Provider.of<ThemeModel>(context).currentTheme,
          home: MyNavigationBar(),

        ),
      );
    }
  }
}
