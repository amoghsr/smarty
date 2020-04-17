import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smarty/models/dbRoutines.dart';
import 'package:smarty/models/routineModel.dart';
import 'package:flutter_iconpicker/flutter_iconpicker.dart';
import '../screens/routines_pages/routines_main_view.dart';

class RoutineCarousel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final routines = Provider.of<List<Routine>>(context);
    return Column(
      children: <Widget>[
        SizedBox(
          height: 4.0,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'Routines',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RoutineMainView(),
                  ),
                ),
                child: Text(
                  'See all',
                  style: TextStyle(
                    fontSize: 12.0,
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).accentColor,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 4.0,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Opacity(
                opacity: 0.8,
                child: Text(
                  'Tap to control multiple devices at once',
                  style: TextStyle(
                    fontSize: 12.0,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 10.0,
        ),
        Container(
          height: 90.0,
//          color: Colors.blue,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: routines.length,
            itemBuilder: (BuildContext context, int index) {
              Routine routine = routines[index];
              return Container(
                margin: EdgeInsets.all(8.0),
                width: 160.0,
                decoration: BoxDecoration(
                  color: routines[index].routineColor,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Stack(
                  alignment: Alignment.topCenter,
                  children: <Widget>[
                    Container(
                      height: 100.0,
                      width: 160.0,
                      child: Padding(
                        padding: EdgeInsets.all(6.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                routine.icon,
                                Text(
                                  routine.routineName,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16.0,
                                      color: Colors.white),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
