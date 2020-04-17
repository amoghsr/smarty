import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:provider/provider.dart';
import 'package:smarty/models/devicesModel.dart';
import 'package:smarty/models/roomModel.dart';
import 'package:smarty/models/user.dart';
import 'package:smarty/screens/manageUsers.dart';
import 'package:smarty/services/auth.dart';
import 'package:smarty/services/database.dart';
import 'package:smarty/shared/constants.dart';

class SelectDevices extends StatefulWidget {
  final String name;
  final String email;
  final String password;
  final String homeId;

  SelectDevices(
      {Key key, @required this.name, this.email, this.password, this.homeId})
      : super(key: key);

  @override
  _SelectDevicesState createState() => _SelectDevicesState();
}

class _SelectDevicesState extends State<SelectDevices> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  String error = '';
  bool loading = false;
  double _opacity = 0.0;
  // text field state

  // A list to hold the selectable devices in the house.
  List<String> selectableDevicesList = [];

  // A map to store all the selectable devices in the house. This map is populated using createMap function
  Map<String, bool> devicesMap = {};

  // Here you will get all your selected Checkbox items.
  List<String> finalSelectedDevices = [];

  int count = 0;

  selectAllDevices() {
    devicesMap.forEach((key, value) {
      setState(() {
        devicesMap[key] = true;
      });
    });
  }

  deselectAllDevices() {
    devicesMap.forEach((key, value) {
      setState(() {
        devicesMap[key] = false;
      });
    });
  }

  getItems() {
    // If value is true in map, then add it to the final list of selected devices by the user
    devicesMap.forEach((key, value) {
      if (value == true) {
        // Add true checkbox items to the holder list
        finalSelectedDevices.add(key);
      }
    });

    // Printing all selected items on Terminal screen.
    print(finalSelectedDevices);

    // Clear array after use.
//    finalSelectedDevices.clear();
  }

  addUser(List<String> x, String houseId, String email) {
    x.forEach((element) {
      print(element);
      String x = element;
      String y = x.split("-")[0]; // room
      String w = x.split("-")[1]; // device
      Firestore.instance
          .collection('waitingHomes')
          .document(email)
          .collection("layout")
          .document(y)
          .setData({w: 0}, merge: true);
    });
    finalSelectedDevices.clear();
    Firestore.instance
        .collection('waitingUsers')
        .document(email)
        .setData({"houseId": houseId}, merge: true);
    Firestore.instance
        .collection('waitingUsers')
        .document(email)
        .setData({"userType": "U"}, merge: true);
  }

  @override
  Widget build(BuildContext context) {
    // Get rooms list using provider
    final roomsList = Provider.of<List<Room>>(context);

    // Get device list using provider
    final devicesList = Provider.of<List<Device>>(context);

    void createMap(
        List<Device> devices, List<Room> rooms, List<String> selectedDevices) {
      // Counter for adding devices to map
      int devicesCount = 0;
      rooms.forEach((roomElement) {
        devices.forEach((deviceElement) {
          // Check if room names from both lists match
          if (roomElement.roomName == deviceElement.inRoom) {
            // Prevents app hot reloads/rebuilds to repopulate the selectedDevices list
            if (!selectedDevices.contains("${roomElement.roomName}" +
                "-" +
                "${deviceElement.deviceName}")) {
              selectedDevices.add("${roomElement.roomName}" +
                  "-" +
                  "${deviceElement.deviceName}");

              //Add devices as key from the list of selectable devices to the map and set its value to false
              devicesMap[selectedDevices[devicesCount]] = false;

              // Increments when a device is added
              devicesCount++;
            }
          }
        });
      });
    }

    createMap(devicesList, roomsList, selectableDevicesList);

    // Get currently logged in user's details
    final user = Provider.of<User>(context);
    // Use home owner's homeID and add it to the home user.

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: Center(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
//              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 14.0),
                  child: Opacity(
                    opacity: 0.5,
                    child: Text(
                      'STEP 2 OF 2',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 14.0, fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                Text(
                  'Select devices your member can have access to',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 23.0),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
//                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    OutlineButton(
                      padding: EdgeInsets.symmetric(horizontal: 50.0),
                      child: Text('Select all'),
                      onPressed: () {
                        selectAllDevices();
                      },
                    ),
                    devicesMap.containsValue(true) == false
                        ? Container()
                        : Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                            child: GestureDetector(
                                onTap: deselectAllDevices,
                                child: Text(
                                  'Reset selection',
                                  style: Theme.of(context).textTheme.body2,
                                )),
                          ),
                  ],
                ),
                SizedBox(
                  height: 20.0,
                ),
                Expanded(
                  child: Scrollbar(
                    child: ListView(
                      children: devicesMap.keys.map((String key) {
                        return new CheckboxListTile(
                          title: Text(
                            key.split('-')[1],
                          ),
                          subtitle: Text(
                            key.split('-')[0],
                          ),
                          value: devicesMap[key],
                          activeColor: Theme.of(context).accentColor,
                          checkColor: Theme.of(context).scaffoldBackgroundColor,
                          onChanged: (bool value) {
                            setState(() {
                              devicesMap[key] = value;
                            });
                          },
                        );
                      }).toList(),
                    ),
                  ),
                ),
                SizedBox(
                  height: 40.0,
                ),
                RaisedButton(
                  padding: EdgeInsets.symmetric(
                    horizontal: 120.0,
                    vertical: 20.0,
                  ),
                  color: Theme.of(context).accentColor,
                  child: Text(
                    'Add user',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
//onPressed: getItems,
                  onPressed: () async {
                    getItems();
                    if (_formKey.currentState.validate()) {
                      setState(() => loading = true);
                      addUser(finalSelectedDevices, user.houseId, widget.email);
                      print("done here");
                      Navigator.popUntil(context, (route) {
                        return count++ == 2;
                      });
                    }
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                SizedBox(height: 12.0),
                Text(
                  error,
                  style: TextStyle(color: Colors.red, fontSize: 14.0),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
