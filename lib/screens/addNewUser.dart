import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smarty/models/devicesModel.dart';
import 'package:smarty/models/roomModel.dart';
import 'package:smarty/models/user.dart';
import 'package:smarty/screens/manageUsers.dart';
import 'package:smarty/services/auth.dart';
import 'package:smarty/services/database.dart';
import 'package:smarty/shared/constants.dart';

class AddNewUser extends StatefulWidget {
  @override
  _AddNewUserState createState() => _AddNewUserState();
}

class _AddNewUserState extends State<AddNewUser> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  String error = '';
  bool loading = false;

  // text field state
  String name = '';
  String email = '';
  String password = '';
  String homeId = '';

  bool _isChecked = false;

  addUser(List<String> x, String houseId, String email) {
    x.forEach((element) {
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
    final rooms = Provider.of<List<Room>>(context);
    rooms.forEach((element) {
      print(element.nDevices);
    });

    // Get device list using provider
    final devices = Provider.of<List<Device>>(context);
//    devices.forEach((element) {
//      print(element.deviceName);
//    });

    // Get currently logged in user's details
    final user = Provider.of<User>(context);
    // Use home owner's homeID and add it to the home user.
    homeId = user.houseId;

    List<String> selectedDevices = [];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add User',
          style: kAppBarTextStyle,
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('Add a new user to your home',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headline5),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10.0),
                    child: Text(
                        'Provide some basic details about the home member',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.subtitle1),
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      labelText: 'Members name',
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
                      labelText: "Their email address",
                    ),
                    validator: (val) =>
                        val.isEmpty ? 'Enter the home user email' : null,
                    onChanged: (val) {
                      setState(() => email = val);
                    },
                  ),
                  TextFormField(
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: "Password",
                    ),
                    validator: (val) =>
                        val.length < 6 ? 'Enter a password 6+ char long' : null,
                    onChanged: (val) {
                      setState(() => password = val);
                    },
                  ),
//                  ListView.separated(
//                    separatorBuilder: (context, index) {
//                      return Divider();
//                    },
//                    shrinkWrap: true,
//                    physics: NeverScrollableScrollPhysics(),
//                    itemCount: rooms.length,
//                    itemBuilder: (context, index) {
//                      return Card(
//                        child: ExpansionTile(
//                          title: Text(rooms[index].roomName),
//                          backgroundColor: Theme.of(context).cardColor,
//                          children: <Widget>[
//                            CheckboxListTile(
//                              title: Text('Light'),
//                              subtitle: Text('Living room'),
//                              value: _isChecked,
//                              activeColor: Theme.of(context).accentColor,
//                              onChanged: (bool value) {
//                                setState(() {
//                                  _isChecked = value;
//                                  print('Changed state to: $_isChecked');
//                                });
//                                if (value) {
//                                  selectedDevices.add(value.toString());
//                                }
//                              },
//                            ),
//                          ],
//                        ),
//                      );
//                    },
//                  ),

                  SizedBox(
                    height: 40.0,
                  ),

                  RaisedButton(
                    padding: EdgeInsets.symmetric(
                      horizontal: 80,
                      vertical: 20,
                    ),
                    color: Theme.of(context).accentColor,
                    child: Text(
                      'Add user',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    onPressed: () async {
                      if (_formKey.currentState.validate()) {
                        setState(() => loading = true);
                        addUser(["Bedroom-Lamp", "Bedroom-Speaker"],
                            user.houseId, email);
                        Navigator.pop(
                          context,
                          MaterialPageRoute(builder: (context) {
                            return ManageUsers();
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
      ),
    );
  }
}
