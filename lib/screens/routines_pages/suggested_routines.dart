import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:smarty/models/dbRoutines.dart';
import 'package:smarty/models/routineModel.dart';
import 'package:smarty/screens/routines_pages/current_routine_page.dart';
import 'package:smarty/screens/routines_pages/suggested_routine_page.dart';

class SuggestedRoutines extends StatefulWidget {
  @override
  _SuggestedRoutinesState createState() => _SuggestedRoutinesState();
}

class _SuggestedRoutinesState extends State<SuggestedRoutines> {
  @override
  Widget build(BuildContext context) {
    final routines = Provider.of<List<dbRoutine>>(context);
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(
                  left: 30.0, right: 20.0, bottom: 20.0, top: 20),
              child: Text(
                'Suggested routines appear after you use your devices for a while.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14.0,
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: routines.length,
                itemBuilder: (BuildContext context, int index) {
                  dbRoutine routine = routines[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SuggestedRoutinePage(
                              routine: routines[index],
//                              routineColor: routines[index].routineColor,
//                              routineIcon: routines[index].icon,
                            ),
                          ));
                    },
                    child: Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                      width: 400.0,
                      child: Stack(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.all(20.0),
                            height: 80.0,
                            width: 400.0,
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Icon(
                                      FontAwesomeIcons.walking,
                                      color: Colors.blue[100],
                                    ),
                                  ],
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 25.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Row(
                                          children: <Widget>[
                                            Text(
                                              routine.Name,
                                              style: TextStyle(
                                                  fontSize: 18.0,
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.white),
                                            ),
                                          ],
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(top: 1.0),
                                          child: Row(
                                            children: <Widget>[
                                              Opacity(
                                                opacity: 0.8,
                                                child: Text(
                                                  routine.ETime,
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w400,
                                                    color: Colors.white,
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
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Row(
                                      children: <Widget>[
                                        Icon(
                                          Icons.add_circle,
                                          color: Colors.white,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
