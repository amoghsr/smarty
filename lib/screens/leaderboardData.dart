import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:smarty/models/leaderboardModel.dart';
import 'package:smarty/models/pointsProvider.dart';
import 'package:smarty/models/user.dart';
import 'package:smarty/screens/userProfile.dart';

class LeaderboardData extends StatefulWidget {
  @override
  String leaderboardType;

  LeaderboardData({this.leaderboardType});

  _LeaderboardDataState createState() => _LeaderboardDataState();
}

class _LeaderboardDataState extends State<LeaderboardData> {
  @override
  Widget build(BuildContext context) {
    final points = Provider.of<Map<String, PointsProvider>>(context);
    List<LeaderboardModel> lb = [];
    var newMap = {};
    List<dynamic> newList = [];
    if (widget.leaderboardType == 'DAILY SAVINGS') {
      lb = Provider.of<List<LeaderboardModel>>(context);
      lb.sort((b, a) => a.points.compareTo(b.points));
    } else {
      newMap = Map.fromEntries(points.entries.toList()
        ..sort((e2, e1) => e1.value.currentDay.compareTo(e2.value.currentDay)));

      newMap.forEach((k, v) => newList.add([k, v]));
    }

    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;

    final user = Provider.of<User>(context);

    if (user != null && points != null) {
      return Scaffold(
        body: SafeArea(
          child: Column(
            children: <Widget>[
              ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: screenheight * 0.40,
                  minHeight: screenheight * 0.1,
                ),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            height: screenheight * 0.06,
                          ),
                          Container(
                            child: Icon(
                              FontAwesomeIcons.trophy,
                              size: 30,
                              color: Color(0xffAAA9AD),
                            ),
                          ),
                          SizedBox(
                            height: screenheight * 0.02,
                          ),
                          Container(
                            // height: screenheight,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                            child: CircleAvatar(
                              radius: 40,
                              backgroundColor: Theme.of(context).canvasColor,
                              backgroundImage:
                                  (widget.leaderboardType == 'DAILY SAVINGS')
                                      ? AssetImage(lb[1].userImage)
                                      : AssetImage(houseUserMap[newList[1][1]
                                          .houseID
                                          .toString()]['userImage']),
                            ),
                          ),
                          SizedBox(
                            height: screenheight * 0.01,
                          ),
                          (widget.leaderboardType == 'DAILY SAVINGS')
                              ? Text(lb[1].userName.split(' ')[0])
                              : Text(
                                  houseUserMap[newList[1][1].houseID.toString()]
                                      ['userName']),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            height: screenheight * 0.03,
                          ),
                          Container(
                            child: Icon(
                              FontAwesomeIcons.trophy,
                              size: 45,
                              color: Colors.yellow,
                            ),
                          ),
                          SizedBox(
                            height: screenheight * 0.02,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                            child: CircleAvatar(
                              radius: 65,
                              backgroundColor: Theme.of(context).canvasColor,
                              backgroundImage:
                                  (widget.leaderboardType == 'DAILY SAVINGS')
                                      ? AssetImage(lb[0].userImage)
                                      : AssetImage(houseUserMap[newList[0][1]
                                          .houseID
                                          .toString()]['userImage']),
                            ),
                          ),
                          SizedBox(
                            height: screenheight * 0.01,
                          ),
                          (widget.leaderboardType == 'DAILY SAVINGS')
                              ? Text(lb[0].userName.split(' ')[0])
                              : Text(
                                  houseUserMap[newList[0][1].houseID.toString()]
                                      ['userName']),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            height: screenheight * 0.06,
                          ),
                          Container(
                            child: Icon(
                              FontAwesomeIcons.trophy,
                              size: 30,
                              color: Colors.deepOrange,
                            ),
                          ),
                          SizedBox(
                            height: screenheight * 0.02,
                          ),
                          Container(
                            // height: screenheight,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                            child: CircleAvatar(
                              radius: 40,
                              backgroundColor: Theme.of(context).canvasColor,
                              backgroundImage:
                                  (widget.leaderboardType == 'DAILY SAVINGS')
                                      ? AssetImage(lb[2].userImage)
                                      : AssetImage(houseUserMap[newList[2][1]
                                          .houseID
                                          .toString()]['userImage']),
                            ),
                          ),
                          SizedBox(
                            height: screenheight * 0.01,
                          ),
                          (widget.leaderboardType == 'DAILY SAVINGS')
                              ? Text(lb[2].userName.split(' ')[0])
                              : Text(
                                  houseUserMap[newList[2][1].houseID.toString()]
                                      ['userName']),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: TabBarView(
                  physics: NeverScrollableScrollPhysics(),
                  children: [
                    getListTile(lb, user, widget.leaderboardType),
                    getListTile(newList, user, widget.leaderboardType),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      return Scaffold(
        body: CircularProgressIndicator(),
      );
    }
  }

  ListView getListTile(dynamic lb, User user, String type) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: lb.length,
        // physics: BouncingScrollPhysics(),
        itemBuilder: (context, i) {
          return Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(bottom: 10.0, left: 10.0, right: 10.0),
                decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(8.0),
                    border: (type == 'DAILY SAVINGS')
                        ? (lb[i].houseID == user.houseId)
                            ? Border.all(color: Colors.green, width: 2)
                            : null
                        : (lb[i][1].houseID == user.houseId)
                            ? Border.all(color: Colors.green, width: 2)
                            : null),
                child: ListTile(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => (type == 'DAILY SAVINGS')
                            ? UserProfile(houseID: lb[i].houseID)
                            : UserProfile(houseID: lb[i][1].houseID),
                      ),
                    );
                  },
                  title: Row(
                    children: <Widget>[
                      Text((i + 1).toString()),
                      SizedBox(
                        width: 25,
                      ),
                      Container(
                        // height: screenheight,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: CircleAvatar(
                          radius: 20,
                          backgroundColor: Theme.of(context).canvasColor,
                          backgroundImage: (type == 'DAILY SAVINGS')
                              ? AssetImage(lb[i].userImage)
                              : AssetImage(
                                  houseUserMap[lb[i][1].houseID]['userImage']),
                        ),
                      ),
                      SizedBox(width: 20),
                      (type == 'DAILY SAVINGS')
                          ? Text(lb[i].userName)
                          : Text(houseUserMap[lb[i][1].houseID]['userName']),
                    ],
                  ),
                  trailing: (type == 'DAILY SAVINGS')
                      ? Text(lb[i].points.toString())
                      : Text(lb[i][1].currentDay.toString()),
                ),
              ),
            ],
          );
        });
  }
}
