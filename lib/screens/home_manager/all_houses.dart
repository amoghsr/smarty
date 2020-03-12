import 'package:flutter/material.dart';
import 'package:smarty/shared/constants.dart';

import 'drawer_manager.dart';

class AllHouses extends StatefulWidget {
  @override
  _AllHousesState createState() => _AllHousesState();
}

class _AllHousesState extends State<AllHouses> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'All Houses',
            style: kAppBarTextStyle,
          ),
        ),
        drawer: DrawerManager(),
        body: SafeArea(
          child: ListView(
            padding: EdgeInsets.symmetric(vertical: 20.0),
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Houses',
                      //${widget.currentUser.email}`
                      style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'Poppins',
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 4,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Opacity(
                      opacity: 0.5,
                      child: Text(
                        'List of all houses currently registered on database.',
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
                child: Card(
                  margin: EdgeInsets.zero,
                  child: ExpansionTile(
                    title: Text('Birth of Universe'),
                    children: <Widget>[
                      Text('Hello1'),
                      Text('Hello1'),
                      Text('Hello1'),
                      Text('Hello1'),
                      Text('Hello1'),
                    ],
                  ),
                ),
              ),
              Divider(),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
                child: Card(
                  margin: EdgeInsets.zero,
                  child: ExpansionTile(
                    title: Text('Birth of Universe'),
                    children: <Widget>[
                      Text('Hello1'),
                      Text('Hello1'),
                      Text('Hello1'),
                      Text('Hello1'),
                      Text('Hello1'),
                    ],
                  ),
                ),
              ),
              Divider(),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
                child: Card(
                  margin: EdgeInsets.zero,
                  child: ExpansionTile(
                    title: Text('Birth of Universe'),
                    children: <Widget>[
                      Text('Hello1'),
                      Text('Hello1'),
                      Text('Hello1'),
                      Text('Hello1'),
                      Text('Hello1'),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

}
