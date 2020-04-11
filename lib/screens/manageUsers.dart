import 'package:firebase_auth/firebase_auth.dart';
import 'package:smarty/services/auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smarty/shared/constants.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'addNewUser.dart';
import 'package:provider/provider.dart';

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

    //list of users of current house name-email layout
    final userlist = Provider.of<List<String>>(context);
    userlist.forEach((element) {
      print(userlist.length);
      print(element.split('-')[0]);
    });

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Manage Users',
            style: kAppBarTextStyle,
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20),
            child: ListView(
              children: <Widget>[
                Container(
                  child: Card(
                    child: ListTile(
                      title: Text('Add user'),
                      subtitle: Text('Add a new user to your home'),
//                    leading: Icon(Icons.add),
                      trailing: Icon(FontAwesome.user_plus),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => AddNewUser()),
                        );
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4.0, vertical: 20),
                  child: Text(
                    'Users in your home',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: userlist.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: ListTile(
                        leading: CircleAvatar(),
                        title: Text(
                          userlist[index].split('-')[0],
                        ),
                        subtitle: Text(userlist[index].split('-')[1]),
                        trailing: InkWell(
                          // TODO: IMPLEMENT DELETE USER
                          onTap: (){
                            print('pressed list item $index');
                          },
                          child: Icon(
                            Icons.delete,
                            color: Colors.redAccent,
                          ),
                        ),
                      ),
                    );
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
