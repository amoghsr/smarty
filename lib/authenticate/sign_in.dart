import 'package:flutter/material.dart';
import 'package:smarty/authenticate/forgotPassword.dart';
import 'package:smarty/services/auth.dart';
import 'package:smarty/shared/loadingAuth.dart';
// import 'package:flutter_svg/flutter_svg.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;

  SignIn({this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  String error = '';
  bool loading = false;

  // text field state
  String email = '';
  String password = '';
  var _controller = TextEditingController();
  var _passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return loading == null
        ? Loading()
        : Scaffold(
            body: Center(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 38.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(height: 20),
                      Image(
                        image: AssetImage('assets/images/logo_white.png'),
                        height: 100,
                      ),
                      SizedBox(
                        height: 30.0,
                      ),
                      Text(
                        'Welcome to Homi',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 32.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Log in to continue',
                        style: TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.w400,
                          color: Theme.of(context).accentColor,
                        ),
                      ),
                      SizedBox(
                        height: 30.0,
                      ),
                      Column(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Expanded(
                                child: Stack(
                                  alignment: Alignment(1.0, 1.0),
                                  children: <Widget>[
                                    TextFormField(
                                      decoration: InputDecoration(
                                        labelText: 'Email Address',
                                      ),
                                      validator: (val) => val.isEmpty
                                          ? 'Enter your email'
                                          : null,
                                      onChanged: (val) {
                                        setState(() => email = val);
                                      },
                                      controller: _controller,
                                    ),
                                    _controller.text.length > 0
                                        ? new IconButton(
                                            icon: new Icon(Icons.clear),
                                            onPressed: () {
                                              setState(() {
                                                _controller.clear();
                                              });
                                            })
                                        : Container(
                                            height: 0.0,
                                          )
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Expanded(
                                child: Stack(
                                    alignment: Alignment(1.0, 1.0),
                                    children: <Widget>[
                                      TextFormField(
                                        obscureText: true,
                                        decoration: InputDecoration(
                                          labelText: 'Password',
                                        ),
                                        validator: (val) => val.length < 6
                                            ? 'Passwords must be at least 6 characters long'
                                            : null,
                                        onChanged: (val) {
                                          setState(() => password = val);
                                        },
                                        controller: _passController,
                                      ),
                                      _passController.text.length > 0
                                          ? new IconButton(
                                              icon: new Icon(Icons.clear),
                                              onPressed: () {
                                                setState(() {
                                                  _passController.clear();
                                                });
                                              })
                                          : Container(
                                              height: 0.0,
                                            )
                                    ]),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 20.0),
                      Container(
                        alignment: Alignment.centerRight,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ForgotPassword(),
                              ),
                            );
                          },
                          child: Text(
                            'Forgot Password?',
                            style: TextStyle(
                              fontSize: 14.0,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 40.0),
                      RaisedButton(
                        padding: EdgeInsets.symmetric(
                          horizontal: 130,
                          // vertical: 10,
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
                            dynamic result = await _auth
                                .signInWithEmailAndPassword(email, password);
                            if (result == null) {
                              setState(() {
                                loading = false;
                                error =
                                    'Could not sign in with those credentials. Please try again.';
                              });
                            }
                          }
                        },
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                      ),
                      SizedBox(height: 20.0),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4.0),
                        child: Text(
                          error,
                          style: TextStyle(color: Colors.red, fontSize: 14.0),
                        ),
                      ),
                      SizedBox(
                        height: 8.0,
                      ),
                      GestureDetector(
                        onTap: () => widget.toggleView(),
                        child: Text(
                          'Don\'t have an account? Sign up here',
                          style: TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.w600,
                          ),
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
