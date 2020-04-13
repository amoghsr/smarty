import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smarty/models/dbService.dart';
import 'package:smarty/models/user.dart';
import 'package:smarty/shared/constants.dart';
import 'package:url_launcher/url_launcher.dart';

class UserProfile extends StatefulWidget {
  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  @override
  bool valueSwitch = true;
  var user;
  var stream;

  _launchCaller() async {
    const url = 'tel:800123';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  void initState() {
    super.initState();
    () {
      user = Provider.of<User>(context, listen: false);
      while (user == null) {}
      stream = DatabaseService1().getUserDetails(user.uid, user);
    }();
  }

  @override
  Widget build(BuildContext context) {
    //list of users of current house name-email layout

    return StreamBuilder(
        stream: stream,
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.data == null) return Container();
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
                            padding:
                                const EdgeInsets.only(top: 12.0, bottom: 4.0),
                            child: Text(
                              snapshot.data['displayName'],
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                          ),
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
        });
  }
}
