import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:smarty/models/dbRoutines.dart';
import 'package:smarty/models/user.dart';
import 'package:smarty/screens/routines_pages/routine_device_carousel.dart';
import 'package:smarty/shared/constants.dart';
import 'package:smarty/widgets/devicesCarousel.dart';
import 'package:smarty/widgets/roomCarousel.dart';

class SuggestedRoutinePage extends StatelessWidget {
  final dbRoutine routine;

  const SuggestedRoutinePage({Key key, this.routine}) : super(key: key);
  AddtoCurrentRoutines(dbRoutine routine, User user, String logo, String color,
      String description) {
    Firestore.instance
        .collection("Routines")
        .document(user.houseId)
        .collection("Suggested Routines")
        .document(routine.Name)
        .setData({
      "STime": routine.STime,
      "ETime": routine.ETime,
      "logo": logo,
      "Description": description,
      "color": color
    });
    Firestore.instance
        .collection("Routines")
        .document(user.houseId)
        .collection("Suggested Routines")
        .document(routine.Name)
        .setData(routine.devices, merge: true);
//      Firestore.instance
//          .collection("Routines")
//          .document(user.houseId).collection("Suggested Routines").document(routine.routineName).delete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Suggested Routine',
              style: TextStyle(fontSize: 12.0, color: Colors.white),
            ),
            SizedBox(height: 2.0),
            Text(
              routine.Name,
              style: kAppBarTextStyle.copyWith(color: Colors.white),
            ),
          ],
        ),
        backgroundColor: routine.color,
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Center(
                child: Container(
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 40.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20.0),
                        child: CircleAvatar(
                          child: Icon(
                            FontAwesomeIcons.walking,
                            color: Colors.blue[100],
                          ),
                          maxRadius: 50.0,
                          backgroundColor: routine.color,
                        ),
                      ),
                      Text(
                        'ROUTINE',
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Theme.of(context).disabledColor),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 6.0),
                        child: Text(
                          routine.Name,
                          style: TextStyle(
                              fontSize: 28.0, fontWeight: FontWeight.w600),
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
                      )
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Container(
                padding: EdgeInsets.all(8.0),
                width: MediaQuery.of(context).size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(
                              bottom: 8.0, right: 16.0, left: 16.0),
                          child: Text(
                            'STARTS AT',
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Theme.of(context).disabledColor),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16.0,
                          ),
                          child: Text(
                            routine.STime,
                            style: Theme.of(context).textTheme.headline6,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(
                              bottom: 8.0, right: 16.0, left: 16.0),
                          child: Text(
                            'ENDS AT',
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Theme.of(context).disabledColor),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Text(
                            routine.ETime,
                            style: Theme.of(context).textTheme.headline6,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20.0),

            /// DEVICES SECTION
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              child: Text(
                'DEVICES',
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).disabledColor),
              ),
            ),

            RoutineDeviceCarousel(
              routineColor: routine.color,
              devicesMap: routine.devices,
            ),

            Divider(
              height: 40.0,
            ),

            /// ADD ROUTINES SECTION
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Container(
                child: GestureDetector(
                  onTap: () {},
                  child: Card(
                    color: Theme.of(context).primaryColor,
                    child: ListTile(
                      leading: Icon(
                        Icons.add_circle,
                        color: Colors.greenAccent,
                      ),
                      title: Text(
                        'Add this routine',
                        style: TextStyle(
                            color: Colors.greenAccent,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
