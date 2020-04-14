import 'package:flutter/material.dart';
import 'package:smarty/authenticate/forgotPassword.dart';
import 'package:smarty/services/auth.dart';
import 'package:smarty/shared/loadingAuth.dart';

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
            body: Center(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 50.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Glad to have you back.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 36,
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
                                  validator: (val) =>
                                      val.isEmpty ? 'Enter your email' : null,
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
                                        ? 'Passwords must be at least 6 characters long.'
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
                      SizedBox(height: 40.0),
                      RaisedButton(
                        padding: EdgeInsets.symmetric(
                          horizontal: 80,
                          vertical: 20,
                        ),
                        child: Text(
                          'Sign In',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Poppins',
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
                        color: Theme.of(context).accentColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                      ),
                      SizedBox(height: 20.0),
                      Text(
                        error,
                        style: TextStyle(color: Colors.red, fontSize: 14.0),
                      ),
                      GestureDetector(
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
                            fontSize: 13,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      GestureDetector(
                        onTap: () => widget.toggleView(),
                        child: Text(
                          'Don\'t have an account? Sign up here',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
//                        RaisedButton(
//                          child: Text(
//                            'Sign In for Home Managers',
//                            style: TextStyle(
//                              fontWeight: FontWeight.bold,
//                              fontFamily: 'Poppins',
//                              color: Theme.of(context).primaryColor,
//                            ),
//                          ),
//                          shape: RoundedRectangleBorder(
//                            borderRadius: BorderRadius.circular(50.0),
//                          ),
//                          onPressed: () {},
//                        ),
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}
