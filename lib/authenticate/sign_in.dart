import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smarty/authenticate/forgotPassword.dart';
import 'package:smarty/services/auth.dart';
import 'package:smarty/shared/loadingAuth.dart';
import 'package:provider/provider.dart';
import 'package:smarty/models/themeModel.dart';
import 'package:flutter_icons/flutter_icons.dart';

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
    return loading
        ? Loading()
        : Scaffold(
            appBar: AppBar(
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
            body: Center(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 24.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Hero(
                        tag: 'logo',
                        child: Material(
                          color: Colors.green.withOpacity(0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    colorFilter: ColorFilter.mode(
                                        Theme.of(context)
                                            .scaffoldBackgroundColor,
                                        BlendMode.difference),
                                    image: AssetImage(
                                        'assets/images/logo_white.png'),
                                  ),
                                ),
                              ),
                              SizedBox(width: 20.0),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    'HOMI',
                                    style: TextStyle(
                                      letterSpacing: 10.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    'CONTROL',
                                    style: TextStyle(
                                      letterSpacing: 10.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    'SYSTEM',
                                    style: TextStyle(
                                        letterSpacing: 10.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30.0,
                      ),
                      Text(
                        'Log in to continue',
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
                                fontSize: 14.0, fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                      SizedBox(height: 40.0),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        child: GestureDetector(
                          onTap: () async {
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
                          child: Container(
                            decoration: BoxDecoration(
                                color: Theme.of(context).accentColor,
                                borderRadius: BorderRadius.circular(8.0),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black.withOpacity(0.2),
                                      offset: Offset(0, 2),
                                      blurRadius: 6.0)
                                ]),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 20.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    'Sign in',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context)
                                          .scaffoldBackgroundColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20.0),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4.0),
                        child: Text(
                          error,
                          style: TextStyle(
                              color: Colors.red,
                              fontSize: 14.0,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(
                        height: 8.0,
                      ),
                      GestureDetector(
                        onTap: () {
                          print('Take user to sign up page');
                        },
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
