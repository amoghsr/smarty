import 'package:flutter/gestures.dart';
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
    List<Leaderboard> lb = (widget.leaderboardType == 'DAILY STREAK')
        ? streakLeaderboard
        : dailySavingsLeaderboard;

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
            color: Theme.of(context).scaffoldBackgroundColor,
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
                          Icon(
                            FontAwesomeIcons.trophy,
                            size: 30,
                            color: Color(0xffAAA9AD),
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
                      Column(
                        // mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(
                            height: screenheight * 0.03,
                          ),
                          Icon(
                            FontAwesomeIcons.trophy,
                            size: 45,
                            color: Color(0xffD4AF37),
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
                      Column(
                        children: <Widget>[
                          SizedBox(
                            height: screenheight * 0.06,
                          ),
                          Icon(
                            FontAwesomeIcons.trophy,
                            size: 30,
                            color: Color(0xffBE5504),
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
                      /* getListTile(lb),
                            getListTile(lb),
                            getListTile(lb),
                            getListTile(lb), */
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
                margin: EdgeInsets.all(5.5),
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ListTile(
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
                          backgroundImage: NetworkImage(lb[i].userImage),
                        ),
                      ),
                      SizedBox(width: 20),
                      Text(lb[i].userName),
                    ],
                  ),
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
