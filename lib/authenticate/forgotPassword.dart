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
                elevation: 0.0,
              ),
              body: Container(
                padding: EdgeInsets.symmetric(horizontal: 38.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Forgot Password?',
                        textAlign: TextAlign.left,
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
                          horizontal: 100,
                          vertical: 20,
                        ),
                        color: Theme
                            .of(context)
                            .accentColor,
                        child: Text(
                          'Send reset link',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
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
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
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
