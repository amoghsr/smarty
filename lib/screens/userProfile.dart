import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smarty/shared/constants.dart';

class UserProfile extends StatefulWidget {
  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //list of users of current house name-email layout
    final userlist = Provider.of<List<String>>(context);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'User Profile',
            style: kAppBarTextStyle,
          ),
        ),
        body: SafeArea(
          child: ListView(
            padding: EdgeInsets.symmetric(vertical: 20.0),
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(
                  top: 20,
                ),
                child: SizedBox(),
              ),
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    CircleAvatar(
                      maxRadius: 50,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 12.0, bottom: 4.0),
                      child: Text(
                        'Username',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ),
                    Opacity(
                      opacity: 0.5,
                      child: Text(
                        'Email_Address',
                        style: kAppBarTextStyle,
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 30.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
