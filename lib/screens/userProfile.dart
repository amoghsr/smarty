import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:smarty/alertBox.dart';
import 'package:smarty/models/currentDayProvider.dart';
import 'package:smarty/models/dbService.dart';
import 'package:smarty/models/user.dart';
import 'package:smarty/shared/constants.dart';
import 'package:smarty/widgets/voiceAgent.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:smarty/models/leaderboardModel.dart';
import 'package:smarty/models/boltProvider.dart';

class UserProfile extends StatefulWidget {
  @override
  String houseID;
  UserProfile({this.houseID});
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  @override
  bool valueSwitch = true;
  int totalDays = 30;

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
    // if (Provider.of<BoltProvider>(context, listen: false).getBalanceAsInt() == 10)
    //   Timer.run(
    //       () => Provider.of<DialogProvider>(context, listen: false).popAi());
  }

  @override
  void dispose() {
    super.dispose();
  }

  //TODO: The key of this map is daily streak day count
  Map<int, dynamic> rewards = {
    1: Image.asset('assets/images/save_energy.png', width: 30, height: 30),
    3: Icon(FontAwesomeIcons.trophy, color: Color(0xffe8b313), size: 30),
    5: Icon(Icons.flash_on, color: Color(0xffe8b313), size: 30),
    10: Icon(FontAwesomeIcons.award, color: Colors.redAccent, size: 30),
    11: Icon(Icons.flash_on, color: Color(0xffe8b313), size: 30),
    15: Image.asset('assets/images/eco-battery.png', width: 30, height: 30),
    20: Image.asset('assets/images/solar.png', width: 30, height: 30),
    23: Icon(Icons.flash_on, color: Color(0xffe8b313), size: 30),
    25: Icon(FontAwesomeIcons.solarPanel, color: Colors.blueGrey, size: 30),
    30: Image.asset('assets/images/may_challenge.png', width: 30, height: 30),
  };

  List<dynamic> badges = [
    [
      'Saving',
      [
        [
          false,
          Image.asset('assets/images/save_energy.png', width: 100, height: 100),
          'Energy Saver',
          'Say watt? Your journey has begun!'
        ],
        [
          false,
          Image.asset('assets/images/eco-battery.png', width: 100, height: 100),
          'Eco Warrior',
          'Half way through a month? I\'m shocked!'
        ],
        [
          false,
          Image.asset('assets/images/solar.png', width: 100, height: 100),
          'Solar Marathon',
          'You got the power! Keep saving!'
        ],
      ],
    ],
    [
      'Donation',
      [
        [
          false,
          Image.asset('assets/images/cross_badge.png', width: 100, height: 100),
          'Red Cross Hero',
          'Donated to the Red Cross Charity'
        ],
        [
          false,
          Image.asset('assets/images/paw_badge.png', width: 100, height: 100),
          'Animal Lover',
          'Donated to the Animal Foundation'
        ],
        [
          false,
          Image.asset('assets/images/teddy_badge.png', width: 100, height: 100),
          'Secret Genie',
          'Donated to the Make a Wish Foundation'
        ]
      ],
    ],
    [
      'Challenges',
      [
        [
          true,
          Image.asset('assets/images/april_challenge.png',
              width: 100, height: 100),
          'April Challenge',
          'Ohm you couldn\'t resist, could you?'
        ],
        [
          false,
          Image.asset('assets/images/may_challenge.png',
              width: 100, height: 100),
          'May Challenge',
          'May the force be with you always!'
        ],
        [
          false,
          Image.asset('assets/images/june_challenge.png',
              width: 100, height: 100),
          'July Challenge',
          'You\'ve reached enlightenment!'
        ],
      ],
    ],
  ];

  @override
  Widget build(BuildContext context) {
    //list of users of current house name-email layout
<<<<<<< HEAD
    // List<LeaderboardModel> lb = Provider.of<List<LeaderboardModel>>(context);

=======
    List<LeaderboardModel> lb = Provider.of<List<LeaderboardModel>>(context);
    final x = Provider.of<Map<String, BoltProvider>>(context);
    final bal = Provider.of<BoltProvider>(context);
>>>>>>> e1dc06462992f4c7300d49757d27d2a596600fc4
    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;
    //TODO: GET CURRENT STREAK DAY OVER HERE
    final points = Provider.of<Map<String, PointsProvider>>(context);

    // final currentDay = Provider.of<CurrentDayProvider>(context);
    for (int i = 1; i <= points[widget.houseID].currentDay; i++) {
      setState(() {
        if (i == 1) badges[0][1][0][0] = true;
        if (i == 15) badges[0][1][1][0] = true;
        if (i == 20) badges[0][1][2][0] = true;
        if (i == 30) badges[2][1][1][0] = true;
      });
    }
    if (points[widget.houseID].donationBadges.contains(0))
      badges[1][1][0][0] = true;
    if (points[widget.houseID].donationBadges.contains(1))
      badges[1][1][1][0] = true;
    if (points[widget.houseID].donationBadges.contains(1))
      badges[1][1][2][0] = true;

    return StreamBuilder(
        stream: stream,
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.data == null) return Container();
          return SafeArea(
            child: Scaffold(
              appBar: AppBar(
                actions: <Widget>[MicClass()],
                title: Center(
                  child: Text(
                    'User Profile',
                    style: kAppBarTextStyle,
                  ),
                ),
              ),
              body: SafeArea(
                child: ListView(
                    shrinkWrap: true,
                    // physics: NeverScrollableScrollPhysics(),
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
                              //TODO: Current Home Owner's User Image
                              backgroundImage: NetworkImage(
                                  houseUserMap[widget.houseID]['userImage']),
                              maxRadius: 65,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 12.0, bottom: 4.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    //TODO: Current Home Owner's User Name
                                    // snapshot.data['displayName']
                                    houseUserMap[widget.houseID]['userName']
                                            .split(' ')[0] +
                                        "'s Home",
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
                                        //TODO: Current bolt balance (reflected and updated throughout the app), stored in the db
                                        'Balance: ${points[widget.houseID].getBalanceAsInt()}',
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
                                  SizedBox(height: screenheight * 0.01),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Column(
                                        children: <Widget>[
                                          SizedBox(height: 43),
                                          Icon(
                                            Icons.star,
                                            size: 35,
                                            //TODO: Color changes from grey to red when daily streak count resets to 0
                                            //TODO: i.e., the user has not stayed under the daily limit and broke his streak (hence streak val reset)
                                            //TODO: Color stays grey when daily streak count > 0
                                            color: Colors.grey,
                                          ),
                                        ],
                                      ),
                                      SizedBox(width: screenwidth * 0.02),
                                      Expanded(
                                        child: SingleChildScrollView(
                                          scrollDirection: Axis.horizontal,
                                          child: Container(
                                            width:
                                                (screenwidth * totalDays) / 5.5,
                                            child: StepProgressIndicator(
                                              totalSteps: totalDays,
                                              // currentStep: 3,
                                              size: 85,
                                              selectedColor: Colors.green,
                                              unselectedColor: Colors.grey[200],
                                              customStep: (index, color, _) =>
                                                  //TODO: Replace 3 with current daily streak day + 1
                                                  //TODO: Designs the progress bar for the current streak day
                                                  index ==
                                                          points[widget.houseID]
                                                                  .currentDay -
                                                              1
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
                                                      //TODO: 4 is replaced with (current daily streak day - 1)
                                                      : index <
                                                              points[widget
                                                                          .houseID]
                                                                      .currentDay -
                                                                  1
                                                          ? Column(
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
                                                                        .lightGreen,
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
                                                                )
                                                              ],
                                                            )
                                                          : Column(
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
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Divider(),
                      Padding(
                        padding: EdgeInsets.only(
                            left: screenwidth * 0.05, top: screenheight * 0.01),
                        child: Container(
                          child: Text(
                            "Badges",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                      SizedBox(height: screenheight * 0.02),
                      ConstrainedBox(
                        constraints: BoxConstraints(
                            maxHeight: screenheight,
                            minHeight: screenheight * 0.1),
                        child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: badges.length,
                            itemBuilder: (context, index1) {
                              return Column(
                                children: <Widget>[
                                  Center(
                                    child: Text(
                                      badges[index1][0],
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: screenheight * 0.01,
                                  ),
                                  Container(
                                    height: screenheight * 0.13,
                                    width: screenwidth,
                                    child: Center(
                                      child: ListView.separated(
                                          separatorBuilder:
                                              (BuildContext context,
                                                  int index) {
                                            return SizedBox(
                                              width: screenwidth * 0.07,
                                            );
                                          },
                                          shrinkWrap: true,
                                          scrollDirection: Axis.horizontal,
                                          itemCount: badges[index1][1].length,
                                          itemBuilder: (context, index2) {
                                            return (badges[index1][1][index2]
                                                        [0] ==
                                                    false)
                                                ? Container(
                                                    foregroundDecoration:
                                                        BoxDecoration(
                                                      color: Colors.grey,
                                                      backgroundBlendMode:
                                                          BlendMode.saturation,
                                                    ),
                                                    child: badges[index1][1]
                                                        [index2][1],
                                                  )
                                                : InkWell(
                                                    onTap: () {
                                                      showDialog(
                                                        context: context,
                                                        builder: (BuildContext
                                                                context) =>
                                                            StreamBuilder(
                                                          builder:
                                                              (context, snap) {
                                                            return Dialog(
                                                              shape:
                                                                  RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            Consts.padding),
                                                              ),
                                                              elevation: 0.0,
                                                              // Elevation means the height of element on the screen from the floor. Basically gives a drop shadow.
                                                              backgroundColor:
                                                                  Colors
                                                                      .transparent,
                                                              child: transactionDialog(
                                                                  context,
                                                                  badges[index1]
                                                                              [1]
                                                                          [index2]
                                                                      [2],
                                                                  badges[index1]
                                                                              [
                                                                              1]
                                                                          [
                                                                          index2]
                                                                      [3],
                                                                  badges[index1]
                                                                          [1][
                                                                      index2][1]),
                                                            );
                                                          },
                                                        ),
                                                      );
                                                    },
                                                    child: Container(
                                                      child: badges[index1][1]
                                                          [index2][1],
                                                    ),
                                                  );
                                          }),
                                    ),
                                  ),
                                  (index1 != 2) ? Divider() : Container()
                                ],
                              );
                            }),
                      ),
                    ]),
              ),
            ),
          );
        });
    ;
  }

  transactionDialog(
      BuildContext context, String title1, String description, Image image) {
    return Stack(
      children: <Widget>[
        //...bottom card part,
        Container(
          padding: EdgeInsets.only(
            top: Consts.padding + 30,
            bottom: Consts.padding,
            left: Consts.padding,
            right: Consts.padding,
          ),
          margin: EdgeInsets.only(top: Consts.avatarRadius),
          decoration: new BoxDecoration(
            color: Theme.of(context).canvasColor,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(Consts.padding),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10.0,
                offset: const Offset(0.0, 10.0),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min, // To make the card compact
            children: <Widget>[
              // Title of the popup
              Text(
                title1,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 16.0),
              // Description on the popup
              Text(
                description,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  color: Colors.white,
                  fontSize: 18.0,
                ),
              ),
              SizedBox(height: 24.0),
              FlatButton(
                color: Colors.green,
                textColor: Colors.white,
                padding: EdgeInsets.all(8.0),
                splashColor: Colors.blueAccent,
                onPressed: () {},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Share",
                      style: TextStyle(fontSize: 20.0),
                    ),
                    Icon(Icons.share),
                  ],
                ),
              ),

              Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: FlatButton(
                          color: Colors.blue,
                          textColor: Colors.white,
                          padding: EdgeInsets.all(8.0),
                          splashColor: Colors.blueAccent,
                          onPressed: () {},
                          child: Icon(
                            FontAwesomeIcons.facebookF,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: FlatButton(
                          color: Colors.yellow[600],
                          textColor: Colors.white,
                          padding: EdgeInsets.all(8.0),
                          splashColor: Colors.blueAccent,
                          onPressed: () {},
                          child: Icon(
                            FontAwesomeIcons.snapchatGhost,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: FlatButton(
                          color: Colors.pinkAccent,
                          textColor: Colors.white,
                          padding: EdgeInsets.all(8.0),
                          splashColor: Colors.blueAccent,
                          onPressed: () {},
                          child: Icon(
                            FontAwesomeIcons.instagram,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Column(
                children: [
                  Row(
                    children: [],
                  ),
                ],
              ),
            ],
          ),
        ),
        //...top circlular image part,
        Positioned(
            left: Consts.padding,
            right: Consts.padding,
            bottom: 230,
            child: image),
      ],
    );
  }
}
