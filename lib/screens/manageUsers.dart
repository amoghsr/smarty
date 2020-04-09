import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smarty/shared/constants.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'addNewUser.dart';

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
              Container(
                padding: EdgeInsets.all(10),
//                color: Theme.of(context).cardColor,
                child: Card(
                  child: ListTile(
                    title: Text('Add user'),
                    subtitle: Text('Add a new user to your home'),
//                    leading: Icon(Icons.add),
                    trailing: Icon(FontAwesome.user_plus),
                    onTap: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AddNewUser()),
                      );
                    },
                  ),

                ),
              ),
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
