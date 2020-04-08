import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smarty/shared/constants.dart';
import 'package:flutter_icons/flutter_icons.dart';

class ManageUsers extends StatefulWidget {
  @override
  _ManageUsersState createState() => _ManageUsersState();
}

class _ManageUsersState extends State<ManageUsers> {


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Manage Users',
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
              // Home Owner Container
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[

                    CircleAvatar(
                      maxRadius: 50,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 12.0, bottom: 4.0),
                      child: Text(
                        '\$Home_Owner_Name',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ),
                    Opacity(
                      opacity: 0.5,
                      child: Text(
                        'THE HOME OWNER',
                        style: kSubtitleText,
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 30.0,
              ),
              Container(
                margin: EdgeInsets.only(left: 10, right: 10),
                child: GridView.count(
                  crossAxisCount: 2,
                  physics: ScrollPhysics(), // to disable GridView's scrolling
                  shrinkWrap: true,
                  children: <Widget>[
                    // This is the card that holds the home USER information. onTap() it opens the settings for the user.
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: InkWell(
                        onTap: () {
                          showModalBottomSheet(
                              context: context,
                              builder: (BuildContext context) {
                                return Padding(
                                  padding: const EdgeInsets.only(
                                      bottom: 14.0, top: 5.0),
                                  child: Container(
                                    child: new Wrap(
                                      children: <Widget>[
                                        Opacity(
                                          opacity: 0.5,
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 14.0, vertical: 10),
                                            child: Text(
                                              'USER SETTINGS',
                                              style: kSubtitleText,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 14.0, vertical: 10),
//                                          child: Row(
//                                            mainAxisAlignment:
//                                                MainAxisAlignment.spaceBetween,
//                                            children: <Widget>[
//                                              GestureDetector(
//                                                onTap: () {
//                                                  print('elderly button pressed');
//                                                },
//                                                child: Container(
//                                                  height: 140,
//                                                  width: 110,
//                                                  decoration: BoxDecoration(
//                                                    color: Theme.of(context)
//                                                        .cardColor,
//                                                    borderRadius:
//                                                        BorderRadius.circular(
//                                                            10.0),
//                                                    boxShadow: [
//                                                      BoxShadow(
//                                                        color: Colors.black12
//                                                            .withOpacity(0.03),
//                                                        blurRadius: 4,
//                                                        spreadRadius: 3,
//                                                        offset: Offset(
//                                                          1,
//                                                          4,
//                                                        ),
//                                                      ),
//                                                    ],
//                                                  ),
//                                                  child: Column(
////                                                  mainAxisAlignment: MainAxisAlignment.center,
//                                                    crossAxisAlignment: CrossAxisAlignment.center,
//                                                    children: <Widget>[
//                                                      Padding(
//                                                        padding: const EdgeInsets.only(top: 40.0, right: 35, left: 35, bottom: 15,),
//                                                        child: Image.asset('assets/images/person/child.png'),
//                                                      ),
//                                                      Text(
//                                                        'Child',
//                                                        style: kUserDataText,
//                                                      )
//                                                    ],
//                                                  ),
//                                                ),
//                                              ),
//                                              Container(
//                                                height: 140,
//                                                width: 110,
//                                                decoration: BoxDecoration(
//                                                  color: Theme.of(context)
//                                                      .cardColor,
//                                                  borderRadius:
//                                                  BorderRadius.circular(
//                                                      10.0),
//                                                  boxShadow: [
//                                                    BoxShadow(
//                                                      color: Colors.black12
//                                                          .withOpacity(0.03),
//                                                      blurRadius: 4,
//                                                      spreadRadius: 3,
//                                                      offset: Offset(
//                                                        1,
//                                                        4,
//                                                      ),
//                                                    ),
//                                                  ],
//                                                ),
//                                                child: Column(
////                                                  mainAxisAlignment: MainAxisAlignment.center,
//                                                  crossAxisAlignment: CrossAxisAlignment.center,
//                                                  children: <Widget>[
//                                                    Padding(
//                                                      padding: const EdgeInsets.only(top: 40.0, right: 35, left: 35, bottom: 15,),
//                                                      child: Image.asset('assets/images/person/adult.png'),
//
//                                                    ),
//                                                    Text(
//                                                      'Adult',
//                                                    )
//                                                  ],
//                                                ),
//                                              ),
//                                              Container(
//                                                height: 140,
//                                                width: 110,
//                                                decoration: BoxDecoration(
//                                                  color: Theme.of(context)
//                                                      .cardColor,
//                                                  borderRadius:
//                                                  BorderRadius.circular(
//                                                      10.0),
//                                                  border: Border.all(
//                                                    color: Theme.of(context).accentColor.withOpacity(0.8),
//                                                  ),
//                                                  boxShadow: [
//                                                    BoxShadow(
//                                                      color: Theme.of(context).accentColor
//                                                          .withOpacity(0.09),
//                                                      blurRadius: 4,
//                                                      spreadRadius: 3,
//                                                      offset: Offset(
//                                                        1,
//                                                        4,
//                                                      ),
//                                                    ),
//                                                  ],
//                                                ),
//                                                child: Column(
////                                                  mainAxisAlignment: MainAxisAlignment.center,
//                                                  crossAxisAlignment: CrossAxisAlignment.center,
//                                                  children: <Widget>[
//                                                    Padding(
//                                                      padding: const EdgeInsets.only(top: 40.0, right: 35, left: 35, bottom: 15,),
//                                                      child: Image.asset('assets/images/person/old.png'),
//
//                                                    ),
//                                                    Text(
//                                                      'Elderly',
//                                                    )
//                                                  ],
//                                                ),
//                                              ),
//                                            ],
//                                          ),
                                        ),
                                        new ListTile(
                                          leading: new Icon(Icons.mode_edit),
                                          title: new Text('Modify user type'),
                                          onTap: () {
                                          },
                                        ),
                                        new ListTile(
                                          leading: new Icon(
                                            Icons.delete,
                                            color: Colors.red,
                                          ),
                                          title: new Text(
                                            'Delete this user',
                                            style: TextStyle(color: Colors.red),
                                          ),
                                          onTap: () {},
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Theme.of(context).cardColor,
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black12.withOpacity(0.03),
                                  blurRadius: 4,
                                  spreadRadius: 3,
                                  offset: Offset(
                                    1,
                                    4,
                                  )),
                            ],
                          ),
                          height: 24,
                          child: Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                CircleAvatar(
                                  maxRadius: 30,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 12.0, bottom: 4.0),
                                  child: Text(
                                    'Son Appleseed',
                                    style: TextStyle(),
                                  ),
                                ),
                                Opacity(
                                  opacity: 0.5,
                                  child: Text(
                                    'CHILD',
                                    style: kSubtitleText,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: InkWell(
                        onTap: () {
                          showModalBottomSheet(
                              context: context,
                              builder: (BuildContext context) {
                                return Padding(
                                  padding: const EdgeInsets.only(
                                      bottom: 14.0, top: 5.0),
                                  child: Container(
                                    child: new Wrap(
                                      children: <Widget>[
                                        Opacity(
                                          opacity: 0.5,
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 14.0, vertical: 10),
                                            child: Text(
                                              'USER SETTINGS',
                                              style: kSubtitleText,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 14.0, vertical: 10),
//                                          child: Row(
//                                            mainAxisAlignment:
//                                                MainAxisAlignment.spaceBetween,
//                                            children: <Widget>[
//                                              GestureDetector(
//                                                onTap: () {
//                                                  print('elderly button pressed');
//                                                },
//                                                child: Container(
//                                                  height: 140,
//                                                  width: 110,
//                                                  decoration: BoxDecoration(
//                                                    color: Theme.of(context)
//                                                        .cardColor,
//                                                    borderRadius:
//                                                        BorderRadius.circular(
//                                                            10.0),
//                                                    boxShadow: [
//                                                      BoxShadow(
//                                                        color: Colors.black12
//                                                            .withOpacity(0.03),
//                                                        blurRadius: 4,
//                                                        spreadRadius: 3,
//                                                        offset: Offset(
//                                                          1,
//                                                          4,
//                                                        ),
//                                                      ),
//                                                    ],
//                                                  ),
//                                                  child: Column(
////                                                  mainAxisAlignment: MainAxisAlignment.center,
//                                                    crossAxisAlignment: CrossAxisAlignment.center,
//                                                    children: <Widget>[
//                                                      Padding(
//                                                        padding: const EdgeInsets.only(top: 40.0, right: 35, left: 35, bottom: 15,),
//                                                        child: Image.asset('assets/images/person/child.png'),
//                                                      ),
//                                                      Text(
//                                                        'Child',
//                                                        style: kUserDataText,
//                                                      )
//                                                    ],
//                                                  ),
//                                                ),
//                                              ),
//                                              Container(
//                                                height: 140,
//                                                width: 110,
//                                                decoration: BoxDecoration(
//                                                  color: Theme.of(context)
//                                                      .cardColor,
//                                                  borderRadius:
//                                                  BorderRadius.circular(
//                                                      10.0),
//                                                  boxShadow: [
//                                                    BoxShadow(
//                                                      color: Colors.black12
//                                                          .withOpacity(0.03),
//                                                      blurRadius: 4,
//                                                      spreadRadius: 3,
//                                                      offset: Offset(
//                                                        1,
//                                                        4,
//                                                      ),
//                                                    ),
//                                                  ],
//                                                ),
//                                                child: Column(
////                                                  mainAxisAlignment: MainAxisAlignment.center,
//                                                  crossAxisAlignment: CrossAxisAlignment.center,
//                                                  children: <Widget>[
//                                                    Padding(
//                                                      padding: const EdgeInsets.only(top: 40.0, right: 35, left: 35, bottom: 15,),
//                                                      child: Image.asset('assets/images/person/adult.png'),
//
//                                                    ),
//                                                    Text(
//                                                      'Adult',
//                                                    )
//                                                  ],
//                                                ),
//                                              ),
//                                              Container(
//                                                height: 140,
//                                                width: 110,
//                                                decoration: BoxDecoration(
//                                                  color: Theme.of(context)
//                                                      .cardColor,
//                                                  borderRadius:
//                                                  BorderRadius.circular(
//                                                      10.0),
//                                                  border: Border.all(
//                                                    color: Theme.of(context).accentColor.withOpacity(0.8),
//                                                  ),
//                                                  boxShadow: [
//                                                    BoxShadow(
//                                                      color: Theme.of(context).accentColor
//                                                          .withOpacity(0.09),
//                                                      blurRadius: 4,
//                                                      spreadRadius: 3,
//                                                      offset: Offset(
//                                                        1,
//                                                        4,
//                                                      ),
//                                                    ),
//                                                  ],
//                                                ),
//                                                child: Column(
////                                                  mainAxisAlignment: MainAxisAlignment.center,
//                                                  crossAxisAlignment: CrossAxisAlignment.center,
//                                                  children: <Widget>[
//                                                    Padding(
//                                                      padding: const EdgeInsets.only(top: 40.0, right: 35, left: 35, bottom: 15,),
//                                                      child: Image.asset('assets/images/person/old.png'),
//
//                                                    ),
//                                                    Text(
//                                                      'Elderly',
//                                                    )
//                                                  ],
//                                                ),
//                                              ),
//                                            ],
//                                          ),
                                        ),
                                        new ListTile(
                                          leading: new Icon(Icons.mode_edit),
                                          title: new Text('Modify user type'),
                                          onTap: () {
                                          },
                                        ),
                                        new ListTile(
                                          leading: new Icon(
                                            Icons.delete,
                                            color: Colors.red,
                                          ),
                                          title: new Text(
                                            'Delete this user',
                                            style: TextStyle(color: Colors.red),
                                          ),
                                          onTap: () {},
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Theme.of(context).cardColor,
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black12.withOpacity(0.03),
                                  blurRadius: 4,
                                  spreadRadius: 3,
                                  offset: Offset(
                                    1,
                                    4,
                                  )),
                            ],
                          ),
                          height: 24,
                          child: Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                CircleAvatar(
                                  maxRadius: 30,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 12.0, bottom: 4.0),
                                  child: Text(
                                    'Son Appleseed',
                                    style: TextStyle(),
                                  ),
                                ),
                                Opacity(
                                  opacity: 0.5,
                                  child: Text(
                                    'CHILD',
                                    style: kSubtitleText,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
