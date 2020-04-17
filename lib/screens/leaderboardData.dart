import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:smarty/models/leaderboardModel.dart';

class LeaderboardData extends StatefulWidget {
  @override
  String leaderboardType;

  LeaderboardData({this.leaderboardType});

  _LeaderboardDataState createState() => _LeaderboardDataState();
}

class _LeaderboardDataState extends State<LeaderboardData> {
  @override
  Widget build(BuildContext context) {
    List<Leaderboard> lb = (widget.leaderboardType == 'DAILY SAVINGS')
        ? dailySavingsLeaderboard
        : streakLeaderboard;

    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;

    (widget.leaderboardType == 'DAILY STREAK')
        ? lb.sort((b, a) => a.points.compareTo(b.points))
        : lb.sort((a, b) => a.points.compareTo(b.points));

    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        // physics: NeverScrollableScrollPhysics(),
        child: GestureDetector(
          onVerticalDragUpdate: (_) {},
          child: Container(
            child: Column(
              children: <Widget>[
                Container(
                  height: screenheight * 0.39,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Column(
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
                              // TODO: Get leaderboard image based on House ID (2nd Place)
                              backgroundImage: NetworkImage(lb[1].userImage),
                            ),
                          ),
                          SizedBox(
                            height: screenheight * 0.01,
                          ),
                          Text(lb[1].userName.split(' ')[0]),
                        ],
                      ),
                      Column(
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
                              // TODO: Get leaderboard image based on House ID (1st Place)
                              backgroundImage: NetworkImage(lb[0].userImage),
                            ),
                          ),
                          SizedBox(
                            height: screenheight * 0.01,
                          ),
                          Text(lb[0].userName.split(' ')[0]),
                        ],
                      ),
                      Column(
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
                              // TODO: Get leaderboard image based on House ID (3rd Place)
                              backgroundImage: NetworkImage(lb[2].userImage),
                            ),
                          ),
                          SizedBox(
                            height: screenheight * 0.01,
                          ),
                          Text(lb[2].userName.split(' ')[0]),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  // color: Colors.green,
                  height: screenheight * 0.35,
                  child: TabBarView(
                    physics: NeverScrollableScrollPhysics(),
                    children: [
                      getListTile(lb),
                      getListTile(lb),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  ListView getListTile(List<Leaderboard> lb) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: lb.length,
        physics: BouncingScrollPhysics(),
        itemBuilder: (context, i) {
          return Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(bottom: 10.0, left: 10.0, right: 10.0),
                decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(8.0),
                    // TODO: OUTLINE BASED ON CURRENT HOME OWNER
                    border: (i == 2)
                        ? Border.all(color: Colors.green, width: 2)
                        : null),
                child: ListTile(
                  // TODO: MAKE THE LIST TILE CLICKABLE WHICH LEADS TO THE USER PROFILE FOR THAT HOME OWNER
                  // onTap: () {
                  //   setState(() {
                  //     currRoom = rooms[l].roomName;
                  //     currDevice = rooms[l].d[i];
                  //   });
                  // },
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
                          // TODO: Get leaderboard image based on House ID
                          backgroundImage: NetworkImage(lb[i].userImage),
                        ),
                      ),
                      SizedBox(width: 20),
                      // TODO: GET THE HOME OWNER NAMES
                      Text(lb[i].userName),
                    ],
                  ),
                  // TODO: GET THE HOUSEWISE DAILY CONSUMPTION UP UNTIL THAT POINT IN THE DAY
                  trailing: Text(
                    lb[i].points.toString(),
                  ),
                ),
              ),
            ],
          );
        });
  }
}
