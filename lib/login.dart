import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'auth.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  String _password;
  String _email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(height: 140.0),
                      Text(
                        'Glad to have you back.',
                        style: TextStyle(
                          fontSize: 48,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w700,
                          height: 1.1,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Log in to continue',
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
                        onSaved: (value) {
                          _email = value;
                        },
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          labelText: "Email Address",
                        ),
                      ),
                      TextFormField(
                        onSaved: (value) => _password = value,
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: "Password",
                        ),
                      ),
                      SizedBox(
                        height: 40.0,
                      ),
                      RaisedButton(
                        padding: EdgeInsets.symmetric(
                          horizontal: 130,
                          vertical: 20,
                        ),
                        child: Text(
                          "LOGIN",
                        ),
                        onPressed: () async {
                          // Save the fields ...
                          final form = _formKey.currentState;
                          form.save();

                          // Validate will return true if is valid, or false if invalid.
                          if (form.validate()) {
                            try {
                              FirebaseUser result =
                              await Provider.of<AuthService>(context,
                                  listen: false)
                                  .loginUser(
                                  email: _email, password: _password);
                              print(result);
                            } on AuthException catch (error) {
                              // handle the firebase specific error
                              return _buildErrorDialog(context, error.message);
                            } on Exception catch (error) {
                              // gracefully handle anything else that might happen..
                              return _buildErrorDialog(
                                  context, error.toString());
                            }
                          }
                        },
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                      ),
                      SizedBox(
                        height: 40.0,
                      ),
                      Text(
                        'Don\'t have an account? Sign up here',
                        style: TextStyle(
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
//tjknln
  Future _buildShowErrorDialog(BuildContext context, _message) {
    return showDialog(
      builder: (context) {
        return AlertDialog(
          title: Text('Error Message'),
          content: Text(_message),
          actions: <Widget>[
            FlatButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        );
      },
      context: context,
    );
  }
}

Future _buildErrorDialog(BuildContext context, _message) {
  return showDialog(
    builder: (context) {
      return AlertDialog(
        title: Text('Error Message'),
        content: Text(_message),
        actions: <Widget>[
          FlatButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              })
        ],
      );
    },
    context: context,
  );
}
