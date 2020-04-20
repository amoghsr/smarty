import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:smarty/models/boltProvider.dart';
import 'package:smarty/models/leaderboardModel.dart';
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
    List<LeaderboardModel> lb = Provider.of<List<LeaderboardModel>>(context);

    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;
    final points = Provider.of<Map<String, PointsProvider>>(context);
    
    if (widget.leaderboardType == 'DAILY SAVINGS')
      lb.sort((a, b) => a.points.compareTo(b.points));

    
    // if (widget.leaderboardType == 'DAILY STREAK')
    //   points.sort((a, b) => points[(a+1).toString()].currentDay.compareTo(points[(b+1).toString()].currentDay));

    final user = Provider.of<User>(context);

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
                            backgroundImage: NetworkImage(lb[1].userImage),
                          ),
                        ),
                        SizedBox(
                          height: screenheight * 0.01,
                        ),
                        Text(lb[1].userName.split(' ')[0]),
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
                            backgroundImage: NetworkImage(lb[0].userImage),
                          ),
                        ),
                        SizedBox(
                          height: screenheight * 0.01,
                        ),
                        Text(lb[0].userName.split(' ')[0]),
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
                            backgroundImage: NetworkImage(lb[2].userImage),
                          ),
                        ),
                        SizedBox(
                          height: screenheight * 0.01,
                        ),
                        Text(lb[2].userName.split(' ')[0]),
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
                  getListTile(lb, user, widget.leaderboardType),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  ListView getListTile(List<LeaderboardModel> lb, User user, String type) {
    
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
                    border: (lb[i].houseID == user.houseId)
                        ? Border.all(color: Colors.green, width: 2)
                        : null),
                child: ListTile(
                  // TODO: MAKE THE LIST TILE CLICKABLE WHICH LEADS TO THE USER PROFILE FOR THAT HOME OWNER alister
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            UserProfile(houseID: lb[i].houseID),
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
                          backgroundImage: NetworkImage(lb[i].userImage),
                        ),
                      ),
                      SizedBox(width: 20),
                      Text(lb[i].userName),
                    ],
                  ),
                  trailing: (type == 'DAILY SAVINGS')
                      ? Text(lb[i].points.toString())
                      : Text(
                          Provider.of<Map<String, PointsProvider>>(
                                  context)[(i + 1).toString()]
                              .currentDay
                              .toString(),
                        ),
                ),
              ),
            ],
          );
        });
  }
}
