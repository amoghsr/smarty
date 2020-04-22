import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smarty/models/devicesModel.dart';
import 'package:smarty/models/roomModel.dart';
import 'package:smarty/models/user.dart';
import 'package:smarty/screens/manageUsers.dart';
import 'package:smarty/services/auth.dart';
import 'package:smarty/services/database.dart';
import 'package:smarty/shared/constants.dart';
import 'selectDevices.dart';

class AddNewUser extends StatefulWidget {
  @override
  _AddNewUserState createState() => _AddNewUserState();
}

class _AddNewUserState extends State<AddNewUser> {
  final _formKey = GlobalKey<FormState>();
  String error = '';
  bool loading = false;

  // text field state
  String name = '';
  String email = '';
  String password = '';
  String homeId = '';

  // A list to hold the selectable devices in the house.
  List<String> selectableDevicesList = [];

  // A map to store all the selectable devices in the house. This map is populated using createMap function
  Map<String, bool> devicesMap = {};

  // Here you will get all your selected Checkbox items.
  List<String> finalSelectedDevices = [];

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
    homeId = user.houseId;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,

      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Form(
                  key: _formKey,
                  child: Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 14.0),
                          child: Opacity(
                            opacity: 0.5,
                            child: Text('STEP 1 OF 2',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w600)),
                          ),
                        ),
                        Text(
                          'Add a home member',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 30.0,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 16.0),
                          child: Text(
                              'Provide some basic details about the home member',
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.subtitle),
                        ),
                        SizedBox(
                          height: 24.0,
                        ),
                        TextFormField(
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            labelText: 'Home members name',
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Theme.of(context).accentColor,
                              ),
                            ),
                          ),
                          validator: (val) =>
                              val.isEmpty ? 'Enter the home user name' : null,
                          onChanged: (val) {
                            setState(() => name = val);
                          },
                        ),
                        TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            labelText: 'Member email address',
                            helperText: 'Members will use this email to join your house.'
                          ),
                          validator: (val) =>
                              val.isEmpty ? 'Enter the home user email' : null,
                          onChanged: (val) {
                            setState(() => email = val);
                          },
                        ),
                        SizedBox(
                          height: 40.0,
                        ),
                        RaisedButton(
                          padding: EdgeInsets.symmetric(
                            horizontal: 140,
                            vertical: 20,
                          ),
                          color: Theme.of(context).accentColor,
                          child: Text(
                            'Next',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
//onPressed: getItems,
                          onPressed: () async {
                            if (_formKey.currentState.validate()) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) {
                                  return SelectDevices(
                                    email: email,
                                    password: password,
                                    name: name,
                                    homeId: homeId,
                                  );
                                }),
                              );
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
            ],
          ),
        ),
      ),
    );
  }
}
