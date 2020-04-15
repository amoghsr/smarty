import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smarty/models/dbService.dart';
import 'package:smarty/models/user.dart';
import 'package:smarty/shared/constants.dart';
import 'package:smarty/widgets/voiceAgent.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:smarty/models/leaderboardModel.dart';

class UserProfile extends StatefulWidget {
  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  @override
  bool valueSwitch = true;
  var user;
  var stream;
  double bal = 25;

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
    List<Leaderboard> lb = streakLeaderboard;
    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;

    List<List<dynamic>> charities = [
      [
        "Red Cross",
        "assets/images/cross.png",
        "assets/images/redcross_circle.png",
        Color(0xffBE1E2D)
      ],
      [
        "Animal Rescue",
        "assets/images/paw.png",
        "assets/images/circlepaw.png",
        Color(0xff14B7F7)
      ],
      [
        "Make a Wish",
        "assets/images/teddy.png",
        "assets/images/bear.png",
        Color(0xffDFA0A0)
      ],
    ];

    List<String> nums = [];
    for (int i = 0; i < 100; i++) {
      nums.add(i.toString());
    }

    return StreamBuilder(
        stream: stream,
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.data == null) return Container();
          return SafeArea(
            child: Scaffold(
              appBar: AppBar(
                actions: <Widget>[MicClass()],
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
                            backgroundImage: NetworkImage(lb[3].userImage),
                            // Text(
                            //   'JD',
                            //   style: TextStyle(
                            //     fontSize: 30,
                            //     fontFamily: 'Montserrat',
                            //   ),
                            // ),
                            maxRadius: 65,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(top: 12.0, bottom: 4.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  // snapshot.data['displayName']
                                  lb[3].userName.split(" ")[0] + "'s Home",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                SizedBox(height: screenheight * 0.01),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    SizedBox(
                                      width: screenwidth * 0.04,
                                    ),
                                    Text(
                                      'Balance: ${bal.toInt()}',
                                      style: TextStyle(
                                        fontSize: 14.5,
                                      ),
                                    ),
                                    Icon(Icons.flash_on,
                                        size: 19, color: Color(0xffe8b313)),
                                    SizedBox(
                                      width: screenwidth * 0.03,
                                    ),
                                  ],
                                ),
                                SizedBox(height: screenheight*0.03,),
                                //progress bar
                                Container(
                                  height: screenheight * 0.06,
                                  width: screenwidth * 0.89,
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: nums.length,
                                    itemBuilder: (context, index) {
                                      return Row(
                                        children: <Widget>[
                                          SizedBox(
                                            width: screenwidth * 0.002,
                                          ),
                                          Container(
                                              color: Colors.blue,
                                              width: screenwidth * 0.2,
                                              child: Container(
                                                child: Center(
                                                  child: Text(
                                                    nums[index].toString(),
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 20.0),
                                                  ),
                                                ),
                                              )),
                                        ],
                                      );
                                    },
                                  ),
                                ),
                              ],
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
