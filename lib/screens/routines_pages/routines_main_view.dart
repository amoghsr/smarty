import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smarty/screens/routines_pages/current_routines.dart';
import 'package:smarty/screens/routines_pages/suggested_routines.dart';
import 'package:smarty/shared/constants.dart';
import 'package:smarty/widgets/voiceAgent.dart';

class RoutineMainView extends StatefulWidget {
  @override
  _RoutineMainViewState createState() => _RoutineMainViewState();
}

class _RoutineMainViewState extends State<RoutineMainView> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Center(
              child: Text(
                'All Routines',
                style: kAppBarTextStyle,
              ),
            ),
            actions: <Widget>[MicClass()],
            bottom: TabBar(
              tabs: [
                Tab(
                  icon: Icon(Icons.repeat),
                  text: 'Current',
                ),
                Tab(
                  icon: Icon(Icons.add),
                  text: 'Suggested',
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              CurrentRoutines(),
              SuggestedRoutines(),
            ],
          ),
        ),
      ),
    );
  }
}
