import 'package:flutter/material.dart';
import 'package:smarty/shared/constants.dart';

class ManageUsers extends StatefulWidget {
  @override
  _ManageUsersState createState() => _ManageUsersState();
}

class _ManageUsersState extends State<ManageUsers> {
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

          ),
        ),
      ),
    );
  }
}
