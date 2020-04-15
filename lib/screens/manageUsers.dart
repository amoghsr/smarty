import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:provider/provider.dart';
import 'package:smarty/shared/constants.dart';

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
    //list of users of current house name-email layout
    final userlist = Provider.of<List<String>>(context);
    String size = userlist.length.toString();

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
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: ListView(
              children: <Widget>[
                Container(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Card(
                      color: Theme.of(context).primaryColor,
                      child: ListTile(
                        title: Text('Add user'),
                        subtitle: Text('Set up a new user to your home'),
//                    leading: Icon(Icons.add),
                        trailing: Icon(FontAwesome.user_plus),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AddNewUser()),
                          );
                        },
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 4.0, right: 4.0, top: 20.0),
                  child: Text(
                    'Users in your home',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: 4.0, right: 4.0, bottom: 20.0, top: 4.0),
                  child: Text('Currently $size users are present'),
                ),
                ListView.separated(
                  separatorBuilder: (context, index) {
                    return Divider();
                  },
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: userlist.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundColor:
                            Theme.of(context).scaffoldBackgroundColor,
                        child: Text(
                          '$index',
                          style: Theme.of(context).textTheme.headline6,
                        ),
                      ),
                      title: Text(
                        userlist[index].split('-')[0],
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w500
                        ),
                      ),
                      subtitle: Text(userlist[index].split('-')[1]),
                      trailing: InkWell(
                        onTap: () {
//                          print('pressed list item $index');
                        },
                        child: Icon(
                          Icons.clear,
                          color: Colors.redAccent,
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
