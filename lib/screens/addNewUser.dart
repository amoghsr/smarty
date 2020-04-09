import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smarty/models/devicesModel.dart';
import 'package:smarty/models/roomModel.dart';
import 'package:smarty/models/user.dart';
import 'package:smarty/shared/constants.dart';
import 'package:smarty/services/auth.dart';

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

  void onChanged(bool value) {}
  @override
  Widget build(BuildContext context) {

    // Get rooms list using provider
    final rooms = Provider.of<List<Room>>(context);

    // Get device list using provider
    final devices = Provider.of<List<Device>>(context);

    // Get currently logged in user's details
    final user = Provider.of<User>(context);

    // Use home owner's homeID and add it to the home user.
    homeId = user.houseId;
    devices.forEach((element) {
      print(element.deviceName);
    });

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add User',
          style: kAppBarTextStyle,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 30.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Add a new user to your home',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 30,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w600,
                  height: 1.1,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 30.0,
              ),
              TextFormField(
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: 'Name',
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
                  labelText: "Email Address",
                ),
                validator: (val) =>
                    val.isEmpty ? 'Enter the home user email' : null,
                onChanged: (val) {
                  setState(() => email = val);
                },
              ),

//              TextFormField(
//                keyboardType: TextInputType.number,
//                decoration: InputDecoration(
//                  labelText: "Home ID",
//                ),
//                validator: (val) => val.isEmpty ? 'Enter Home ID' : null,
//                onChanged: (val) {
//                  setState(() => homeId = val);
//                },
//              ),

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
              CheckboxListTile(
                subtitle: Text('Living room'),
                title: Text('Light'),
                value: _isChecked,
                activeColor: Theme.of(context).accentColor,
                onChanged: (bool value) {
                  setState(() {
                    _isChecked = value;
                    print('Changed state to: $_isChecked');
                  });
                },
              ),
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
                    dynamic result = await _auth.register(
                        email, password, name, homeId, "-U");
                    if (result == null) {
                      setState(() {
                        loading = false;
                        error = 'Please supply a valid email';
                      });
                    }
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
    );
  }
}