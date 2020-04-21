import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:smarty/models/user.dart';
import 'package:smarty/services/auth.dart';
import 'package:smarty/shared/loadingAuth.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:provider/provider.dart';
import 'package:smarty/models/themeModel.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  String error = '';
  bool loading = false;

  int count = 0;
  // text field state
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
              leading: Container(),
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              elevation: 0.0,
              actions: <Widget>[
                IconButton(
                  icon: Icon(
                    MaterialIcons.brightness_4,
                  ),
                  onPressed: () async {
                    setState(() {
                      Provider.of<ThemeModel>(context, listen: false)
                          .toggleTheme();
                    });
                  },
                ),
              ],
            ),
            body: Container(
              padding: EdgeInsets.symmetric(horizontal: 24.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Sign up to Homi',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 28.0,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Enter the following details',
                      style: TextStyle(
                        fontSize: 14,
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
                          val.isEmpty ? 'Enter your name' : null,
                      onChanged: (val) {
                        setState(() => name = val);
                      },
                    ),
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: "Member email address",
                      ),
                      validator: (val) =>
                          val.isEmpty ? 'Enter your email' : null,
                      onChanged: (val) {
                        setState(() => email = val);
                      },
                    ),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: "Home ID",
                      ),
                      validator: (val) => val.isEmpty ? 'Enter Home ID' : null,
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
                        horizontal: 130,
                        vertical: 20,
                      ),
                      color: Theme.of(context).accentColor,
                      child: Text(
                        'Sign in',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          setState(() => loading = true);
                          var waitinguser = await Firestore.instance
                              .collection('waitingUsers')
                              .document(email);
                          if (waitinguser.documentID == email) {
                            dynamic result;
                            waitinguser.get().then(
                                (DocumentSnapshot value) async => result =
                                    await _auth.registerWithEmailAndPassword(
                                        email,
                                        password,
                                        name,
                                        value["houseId"],
                                        "-U"));
                            if (result == null) {
                              setState(() {
                                loading = false;
                                error = 'Please supply a valid email';
                              });
                            }
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
                    GestureDetector(
                      onTap: () {
                        Navigator.popUntil(context, (route) {
                          return count++ == 2;
                        });
                      },
                      child: Text(
                        'Go back to sign in',
                        style: TextStyle(
                            fontSize: 14.0, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
