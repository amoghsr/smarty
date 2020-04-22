import 'package:flutter/material.dart';
import 'package:smarty/screens/home_manager/user_registered.dart';
import 'package:smarty/services/auth.dart';
import 'package:smarty/shared/constants.dart';

class RegisterHomeOwner extends StatefulWidget {
  @override
  _RegisterHomeOwnerState createState() => _RegisterHomeOwnerState();
}

class _RegisterHomeOwnerState extends State<RegisterHomeOwner> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  String error = '';
  bool loading = false;

  // Text field state
  String name = '';
  String email = '';
  String password = '';
  String homeId = '';

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            appBar: AppBar(
              title: Text(
                'Register Home Owner',
                style: kAppBarTextStyle,
              ),
            ),
            body: ListView(
              shrinkWrap: true,
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 30.0),
              children: <Widget>[
                Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Column(
//            crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(
                          height: 40.0,
                        ),
                        Text(
                          'Register a Home Owner',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                            height: 1.1,
                          ),
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        Text(
                          'Enter the following details',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                            color: Theme.of(context).accentColor,
                          ),
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        TextFormField(
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            labelText: "Name",
                          ),
                          validator: (val) =>
                              val.isEmpty ? 'Enter home owner name' : null,
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
                              val.isEmpty ? 'Enter home owner email' : null,
                          onChanged: (val) {
                            setState(() => email = val);
                          },
                        ),
                        TextFormField(
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: "Home ID",
                          ),
                          validator: (val) =>
                              val.isEmpty ? 'Enter Home ID' : null,
                          onChanged: (val) {
                            setState(() => homeId = val);
                          },
                        ),
                        TextFormField(
                          obscureText: true,
                          decoration: InputDecoration(
                            labelText: "Password",
                          ),
                          validator: (val) => val.length < 6
                              ? 'Enter a password 6+ char long'
                              : null,
                          onChanged: (val) {
                            setState(() => password = val);
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
                            'Proceed',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Poppins',
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                          onPressed: () async {
                            if (_formKey.currentState.validate()) {
                              setState(() => loading = true);
                              dynamic result =
                                  await _auth.registerWithEmailAndPassword(
                                      email, password, name, homeId, "-O");
                              if (result == null) {
                                setState(() {
                                  loading = false;
                                  error = 'Please supply a valid email';
                                });
                              }
                            }
                          },
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50.0),
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
              ],
            ),
          );
  }
}
