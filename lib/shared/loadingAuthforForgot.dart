import 'package:flutter/material.dart';

class LoadingForgot extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          color: Theme.of(context).scaffoldBackgroundColor,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              CircularProgressIndicator(
                backgroundColor: Theme.of(context).backgroundColor,
              ),
              SizedBox(
                height: 25,
              ),
              Text(
                'Sending you a reset mail',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
