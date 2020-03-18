import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:smarty/shared/constants.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:smarty/services/local_authentication_service.dart';
import 'package:smarty/services/service_locator.dart';
import 'drawer_manager.dart';

class AllHouses extends StatefulWidget {
  @override
  _AllHousesState createState() => _AllHousesState();
}

class _AllHousesState extends State<AllHouses> {

  final LocalAuthenticationService _localAuth = locator<LocalAuthenticationService>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'All Houses',
            style: kAppBarTextStyle,
          ),
          actions: <Widget>[
            new IconButton(
                icon: Icon(
                  Icons.search,
                  semanticLabel: 'Notifcations',
                ),
                onPressed: () {}),
          ],
        ),
        drawer: DrawerManager(),
        body: SafeArea(
          child: ListView(
            padding: EdgeInsets.symmetric(vertical: 20.0),
            children: <Widget>[
              Center(
                child: RaisedButton(
                  child: Text('authenticate'),
                  onPressed: _localAuth.authenticate,
                ),
              ),
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
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Opacity(
                      opacity: 0.5,
                      child: Text(
                        'Tap on a house to show more information.',
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
                    leading: Icon(
                      MaterialIcons.home,
                    ),
                    title: Text('House No. 1'),
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(
                            top: 10.0, bottom: 20.0, left: 20.0, right: 20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Opacity(
                                  opacity: 0.5,
                                  child: Text(
                                    'HOUSE OWNER',
                                    style: kSubtitleText,
                                  ),
                                ),
                                Text(
                                  'Michael Scott',
                                  style: kUserDataText,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Opacity(
                                  opacity: 0.5,
                                  child: Text(
                                    'CONTACT DETAILS',
                                    style: kSubtitleText,
                                  ),
                                ),
                                Text(
                                  '+97150456787',
                                  style: kUserDataText,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Opacity(
                                  opacity: 0.5,
                                  child: Text(
                                    'EMAIL',
                                    style: kSubtitleText,
                                  ),
                                ),
                                Text(
                                  'michaelscott@dmcorp.com',
                                  style: kUserDataText,
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
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

class DataSearch extends SearchDelegate<String> {

  final cities = [
    "Bhandup",
    "Mumbai",
    "Delhi",
    "Agra",
    "Lucknow",
    "Kochi",
    "Bangalore",
    "Bhopal",
    "Jaipur",
    "Allahabad",
    "Noida",
    "Thane",
    "Pune"
  ];

  final recentCities = [
    "Bhandup",
    "Mumbai",
    "Delhi",
    "Agra"
  ];

  @override
  List<Widget> buildActions(BuildContext context) {
    // TODO: implement buildActions
    // Actions for the app bar
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {},
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    // Leading icon on the right of the app bar
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {},
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    // Show some result based on the selection

    throw UnimplementedError();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions
    // Show when someone searches for anything

  }
}
