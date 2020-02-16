import 'package:flutter/material.dart';
import 'package:smarty/authenticate/sign_in.dart';
import 'package:smarty/services/auth.dart';
import 'package:smarty/shared/loadingAuthforForgot.dart';

class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final _formKey = GlobalKey<FormState>();
  final AuthService _auth = AuthService();
  String email = '';
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return loading
        ? LoadingForgot()
        : SafeArea(
            child: Scaffold(
              appBar: AppBar(
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                elevation: 0,
              ),
              body: Container(
                padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Forgot Password',
                        textAlign: TextAlign.center,
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
                        'Enter the registered email address',
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
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          labelText: "Email Address",
                        ),
                        validator: (val) =>
                            val.isEmpty ? 'Enter your email' : null,
                        onChanged: (val) {
                          setState(() => email = val);
                        },
                      ),
                      SizedBox(height: 40.0),
                      RaisedButton(
                        padding: EdgeInsets.symmetric(
                          horizontal: 80,
                          vertical: 20,
                        ),
                        child: Text(
                          'Send Reset Link',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Poppins',
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            setState(() => loading = true);
                            await _auth.resetPasswordEmail(email);
                            Navigator.pop(
                              context,
                                MaterialPageRoute(builder: (context) => SignIn()),
                            );
                          }
                        },
                        color: Theme.of(context).accentColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}
