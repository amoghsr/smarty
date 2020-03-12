import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smarty/authenticate/authenticate.dart';
import 'package:smarty/models/dbService.dart';
import 'package:smarty/models/devicesModel.dart';
import 'package:smarty/models/navigationBar.dart';
import 'package:smarty/models/themeModel.dart';
import 'package:smarty/models/user.dart';

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
        child: StreamProvider<List<Device>>.value(
          value: DatabaseService1().streamDevices(user),
          child: StreamProvider<List<String>>.value(
            value: DatabaseService1().streamHomiIDs(),
            child: MaterialApp(
              theme: Provider.of<ThemeModel>(context).currentTheme,
              home: MyNavigationBar(),
            ),
          ),
        ),
      );
//              home: MyOtherRoom(
//                  initRoom: 0,
//                  rooms: [
//                    Room(
//                        imageUrl: 'assets/images/bathroom.png',
//                        roomName: 'Bathroom',
//                        description: 'Fresh!',
//                        nDevices: '2',
//                        icon: Icon(FontAwesomeIcons.bath),
//                        d: ['Lamp', 'AC']),
//                    Room(
//                        imageUrl: 'assets/images/kitchen.png',
//                        roomName: 'Kitchen',
//                        description: 'Cooking space',
//                        nDevices: '2',
//                        icon: Icon(FontAwesomeIcons.utensils),
//                        d: ['Lamp', 'AC']),
//                  ],
//                  devices: devices),
//            ),
//          ),
//        ),
//      );

    }
  }
}
