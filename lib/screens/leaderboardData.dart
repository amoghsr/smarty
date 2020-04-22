import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
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
      if (lb != null) lb.sort((a, b) => a.points.compareTo(b.points));
    } else {
      newMap = Map.fromEntries(points.entries.toList()
        ..sort((e2, e1) => e1.value.currentDay.compareTo(e2.value.currentDay)));

      newMap.forEach((k, v) => newList.add([k, v]));
    }

    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;

    final user = Provider.of<User>(context);

    if (user == null || points == null || lb == null) return Container();
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Row(
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
                          backgroundImage: (widget.leaderboardType ==
                                  'DAILY SAVINGS')
                              ? AssetImage(lb[1].userImage)
                              : AssetImage(
                                  houseUserMap[newList[1][1].houseID.toString()]
                                      ['userImage']),
                        ),
                      ),
                      SizedBox(
                        height: screenheight * 0.01,
                      ),
                      (widget.leaderboardType == 'DAILY SAVINGS')
                          ? Text(lb[1].userName.split(' ')[0])
                          : Text(houseUserMap[newList[1][1].houseID.toString()]
                              ['userName']),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
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
                          backgroundImage: (widget.leaderboardType ==
                                  'DAILY SAVINGS')
                              ? AssetImage(lb[0].userImage)
                              : AssetImage(
                                  houseUserMap[newList[0][1].houseID.toString()]
                                      ['userImage']),
                        ),
                      ),
                      SizedBox(
                        height: screenheight * 0.01,
                      ),
                      (widget.leaderboardType == 'DAILY SAVINGS')
                          ? Text(
                              lb[0].userName.split(' ')[0],
                              style: TextStyle(fontWeight: FontWeight.bold),
                            )
                          : Text(houseUserMap[newList[0][1].houseID.toString()]
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
                          backgroundImage: (widget.leaderboardType ==
                                  'DAILY SAVINGS')
                              ? AssetImage(lb[2].userImage)
                              : AssetImage(
                                  houseUserMap[newList[2][1].houseID.toString()]
                                      ['userImage']),
                        ),
                      ),
                      SizedBox(
                        height: screenheight * 0.01,
                      ),
                      (widget.leaderboardType == 'DAILY SAVINGS')
                          ? Text(lb[2].userName.split(' ')[0])
                          : Text(houseUserMap[newList[2][1].houseID.toString()]
                              ['userName']),
                    ],
                  ),
                ),
              ],
            ),
            Container(
              decoration: BoxDecoration(
//                  color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            (widget.leaderboardType == 'DAILY SAVINGS')
                                ? Text('ENERGY SAVER OF THE DAY')
                                : Text('DAILY STREAKER!'),
                          ],
                        ),
                        SizedBox(height: 4.0),
                        (widget.leaderboardType == 'DAILY SAVINGS')
                            ? Text(lb[0].userName.split(' ')[0],
                                style: TextStyle(
                                    fontSize: 24.0,
                                    fontWeight: FontWeight.w700))
                            : Text(
                                houseUserMap[newList[0][1].houseID.toString()]
                                    ['userName'],
                                style: TextStyle(
                                    fontSize: 24.0,
                                    fontWeight: FontWeight.w700),
                              ),
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        Icon(
                          MaterialCommunityIcons.trophy,
                          color: Colors.yellow,
                          size: 42.0,
                        )
                      ],
                    )
                  ],
                ),
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
                            ? Border.all(
                                color: Theme.of(context).accentColor, width: 2)
                            : null
                        : (lb[i][1].houseID == user.houseId)
                            ? Border.all(
                                color: Theme.of(context).accentColor, width: 2)
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
                      ? Text(lb[i].points.toString(),
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16.0))
                      : Text(
                          lb[i][1].currentDay.toString(),
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16.0),
                        ),
                ),
              ),
            ],
          );
        });
  }
}
