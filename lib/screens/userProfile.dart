import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:smarty/models/dbService.dart';
import 'package:smarty/models/user.dart';
import 'package:smarty/shared/constants.dart';
import 'package:smarty/widgets/voiceAgent.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
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
    for (int i = 0; i < 30; i++) {
      nums.add(i.toString());
    }

    Map<int, dynamic> rewards = {
      1: Icon(FontAwesomeIcons.leaf, color: Colors.green, size: 30),
      5: Icon(Icons.flash_on, color: Color(0xffe8b313), size: 30),
      10: Icon(FontAwesomeIcons.award, color: Colors.redAccent, size: 30),
      11: Icon(Icons.flash_on, color: Color(0xffe8b313), size: 30),
      15: Icon(FontAwesomeIcons.trophy, color: Colors.orangeAccent, size: 30),
      20: Icon(FontAwesomeIcons.medal, color: Colors.tealAccent, size: 30),
      23: Icon(Icons.flash_on, color: Color(0xffe8b313), size: 30),
      25: Icon(FontAwesomeIcons.solarPanel, color: Colors.blueGrey, size: 30),
      30: Icon(FontAwesomeIcons.calendarTimes,
          color: Colors.pinkAccent, size: 30),
    };

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
                                SizedBox(
                                  height: screenheight * 0.02,
                                ),

                                //second carousel
                                Padding(
                                  padding: const EdgeInsets.only(left: 15.0),
                                  child: Row(
                                    children: <Widget>[
                                      Column(
                                        children: <Widget>[
                                          SizedBox(height: 43),
                                          Icon(
                                            Icons.star,
                                            size: 35,
                                            color: Colors.grey,
                                          ),
                                        ],
                                      ),
                                      SizedBox(width: screenwidth * 0.02),
                                      Expanded(
                                        child: SingleChildScrollView(
                                          scrollDirection: Axis.horizontal,
                                          child: Container(
                                            width: (screenwidth * nums.length) /
                                                5.5,
                                            child: StepProgressIndicator(
                                              totalSteps: nums.length,
                                              // currentStep: 3,
                                              size: 85,
                                              selectedColor: Colors.green,
                                              unselectedColor: Colors.grey[200],
                                              customStep: (index, color, _) =>
                                                  index == 3
                                                      ? Column(
                                                          children: <Widget>[
                                                            rewards.containsKey(
                                                                    index + 1)
                                                                ? Column(
                                                                    children: <
                                                                        Widget>[
                                                                      rewards[
                                                                          index +
                                                                              1],
                                                                      SizedBox(
                                                                        height:
                                                                            8,
                                                                      ),
                                                                    ],
                                                                  )
                                                                : SizedBox(
                                                                    height: 43),
                                                            Expanded(
                                                              child: Container(
                                                                color: Colors
                                                                    .green,
                                                                child: Center(
                                                                  child: Text(
                                                                    // Icons.check,
                                                                    '${index + 1}',
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .white),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        )
                                                      : index < 4
                                                          ? Opacity(
                                                              opacity: 0.6,
                                                              child: Column(
                                                                children: <
                                                                    Widget>[
                                                                  rewards.containsKey(
                                                                          index +
                                                                              1)
                                                                      ? Column(
                                                                          children: <
                                                                              Widget>[
                                                                            rewards[index +
                                                                                1],
                                                                            SizedBox(
                                                                              height: 13,
                                                                            ),
                                                                          ],
                                                                        )
                                                                      : SizedBox(
                                                                          height:
                                                                              43),
                                                                  Expanded(
                                                                    child:
                                                                        Container(
                                                                      color: Colors
                                                                          .lightGreen,
                                                                      child:
                                                                          Center(
                                                                        child:
                                                                            Text(
                                                                          // Icons.check,
                                                                          '${index + 1}',
                                                                          style:
                                                                              TextStyle(color: Colors.white),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            )
                                                          : Opacity(
                                                                opacity: 0.6,                                                      child: Column(
                                                                children: <
                                                                    Widget>[
                                                                  rewards.containsKey(
                                                                          index +
                                                                              1)
                                                                      ? Column(
                                                                          children: <
                                                                              Widget>[
                                                                            rewards[index +
                                                                                1],
                                                                            SizedBox(
                                                                              height:
                                                                                  13,
                                                                            ),
                                                                          ],
                                                                        )
                                                                      : SizedBox(
                                                                          height:
                                                                              43),
                                                                  Expanded(
                                                                    child:
                                                                        Container(
                                                                      color: Colors
                                                                          .grey,
                                                                      child:
                                                                          Center(
                                                                        child:
                                                                            Text(
                                                                          // Icons.check,
                                                                          '${index + 1}',
                                                                          style: TextStyle(
                                                                              color:
                                                                                  Colors.white),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                          ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
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
