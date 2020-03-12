import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smarty/services/auth.dart';
import 'homeManagerOne.dart';

int bottomSelectedIndex = 0;

List<BottomNavigationBarItem> buildBottomNavBarItems() {
  return [
    BottomNavigationBarItem(
        icon: new Icon(Icons.home),
        title: new Text('Red')
    ),
    BottomNavigationBarItem(
      icon: new Icon(Icons.search),
      title: new Text('Blue'),
    ),
    BottomNavigationBarItem(
        icon: Icon(Icons.info_outline),
        title: Text('Yellow')
    )
  ];
}

class HomeManager extends StatefulWidget {
  HomeManager({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomeManagerState createState() => _HomeManagerState();

}

class _HomeManagerState extends State<HomeManager> {

  PageController pageController = PageController(
    initialPage: 0,
    keepPage: true,
  );

  void pageChanged(int index) {
    setState(() {
      bottomSelectedIndex = index;
    });
  }

  Widget buildPageView() {
    return PageView(
      controller: pageController,
      onPageChanged: (index) {
        pageChanged(index);
      },
      children: <Widget>[
        Red(),
        Blue(),
        Yellow(),
      ],
    );
  }

  @override
  void initState() {
    super.initState();
  }

  void bottomTapped(int index) {
    setState(() {
      bottomSelectedIndex = index;
      pageController.animateToPage(index, duration: Duration(milliseconds: 500), curve: Curves.ease);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
//        title: Text(widget.title),
      ),
      body: buildPageView(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: bottomSelectedIndex,
        onTap: (index) {
          bottomTapped(index);
        },
        items: buildBottomNavBarItems(),
      ),
    );
  }
}




class Blue extends StatefulWidget {
  @override
  _BlueState createState() => _BlueState();
}

class _BlueState extends State<Blue> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blueAccent,
    );
  }
}



class Yellow extends StatefulWidget {
  @override
  _YellowState createState() => _YellowState();
}

class _YellowState extends State<Yellow> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.yellowAccent,
    );
  }
}












//class HomeManager extends StatefulWidget {
//  @override
//  _HomeManagerState createState() => _HomeManagerState();
//}
//
//class _HomeManagerState extends State<HomeManager> {
//  bool _isExpanded = false;
//  final AuthService _auth = AuthService();
//  void _toggleExpand() {
//    setState(() {
//      _isExpanded = !_isExpanded;
//    });
//  }
//
//  String greeting() {
//    var hour = DateTime.now().hour;
//    if (hour < 12) {
//      return 'Good Morning';
//    }
//    if (hour < 17) {
//      return 'Good Afternoon';
//    }
//    return 'Good Evening';
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return SafeArea(
//      child: Scaffold(
//        appBar: AppBar(),
//        drawer: Drawer(
//          child: SafeArea(
//            // The various items in the hamburger menu are saved inside a ListView, which is basically a vertical list
//            child: ListView(
//              // ListView items are saved in a children list of Widgets
//              children: <Widget>[
//                ListTile(
//                  leading: Icon(Icons.settings),
//                  title: Text(
//                    'Sample Text',
//                  ),
//                ),
//                ListTile(
//                  leading: Icon(Icons.lock),
//                  title: Text(
//                    'Sample Text',
//                  ),
//                  onTap: () {
//                    Navigator.push(
//                      context,
//                      MaterialPageRoute(builder: (context) => HomeManager()),
//                    );
//                  },
//                ),
//                Divider(),
//                // Log out button
//                ListTile(
//                  onTap: () async {
//                    await _auth.signOut();
//                  },
//                  leading: Icon(Icons.exit_to_app),
//                  title: Text(
//                    'Log Out',
//                  ),
//                ),
//              ],
//            ),
//          ),
//        ),
//        body: PageView(
//          children: <Widget>[
//            Container(
//              color: Colors.blueAccent,
//            ),
//            Container(
//              color: Colors.redAccent,
//            )
//          ],
//        ),
//
////        body: SafeArea(
////          child: ListView(
////            padding: EdgeInsets.symmetric(vertical: 20.0),
////            children: <Widget>[
////              Padding(
////                padding: EdgeInsets.only(left: 20.0, right: 120.0),
////                child: Text(
////                  greeting(),
////                  style: TextStyle(
////                      fontSize: 24.0,
////                      fontWeight: FontWeight.w700,
////                      fontFamily: 'Poppins'),
////                ),
////              ),
////              Padding(
////                padding: EdgeInsets.all(20.0),
////                child: Semantics(
////                  child: Card(
////                    child: Column(
////                      mainAxisSize: MainAxisSize.min,
////                      children: <Widget>[
////                        Container(
////                          height: 180,
////                          decoration: BoxDecoration(
////                            borderRadius: BorderRadius.circular(10),
////                            color: Theme.of(context).cardColor,
////                          ),
////                          child: Padding(
////                            padding: const EdgeInsets.all(24.0),
////                            child: Column(
////                              mainAxisAlignment: MainAxisAlignment.center,
////                              children: <Widget>[
////                                Row(
////                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
////                                  children: <Widget>[
////                                    Column(
////                                      crossAxisAlignment: CrossAxisAlignment.start,
////                                      children: <Widget>[
////                                        Text(
////                                          'Register a',
////                                          style: TextStyle(
//////                                          fontFamily: 'Poppins',
////                                            fontWeight: FontWeight.w700,
////                                            fontSize: 22,
////                                          ),
////                                        ),
////                                        Text(
////                                          'Home Owner',
////                                          style: TextStyle(
//////                                          fontFamily: 'Poppins',
////                                            fontWeight: FontWeight.w700,
////                                            fontSize: 22,
////                                          ),
////                                        ),
////                                      ],
////                                    ),
////                                    Column(
////                                      children: <Widget>[
////                                        Icon(Icons.arrow_forward, size: 35, color: Theme.of(context).accentColor,),
////                                      ],
////                                    ),
////                                  ],
////                                ),
////                                SizedBox(
////                                  height: 10,
////                                ),
////                                Row(
////                                  children: <Widget>[
////                                    Opacity(
////                                      opacity: 0.6,
////                                      child: Text(
////                                        'Go here to add a new home owner to the database.',
////                                        style: TextStyle(
////                                          fontSize: 11,
////                                        ),
////                                      ),
////                                    ),
////                                  ],
////                                ),
////                              ],
////                            ),
////                          ),
////                        ),
////                      ],
////                    ),
////                  ),
////                ),
////              ),
////            ],
////          ),
////        ),
//      ),
//    );
//  }
//}
