import 'package:flutter/material.dart';
import 'package:smarty/screens/routines_pages/routine_device_carousel.dart';
import 'package:smarty/shared/constants.dart';
import 'package:smarty/widgets/devicesCarousel.dart';
import 'package:smarty/widgets/roomCarousel.dart';

class SuggestedRoutinePage extends StatelessWidget {
  final String routineName;
  final String time;
  final List devices;
  final Color routineColor;
  final Icon routineIcon;

  const SuggestedRoutinePage(
      {Key key,
      this.routineName,
      this.time,
      this.devices,
      this.routineColor,
      this.routineIcon})
      : super(key: key);

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
              routineName,
              style: kAppBarTextStyle.copyWith(color: Colors.white),
            ),
          ],
        ),
        backgroundColor: routineColor,
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
                          child: routineIcon,
                          maxRadius: 50.0,
                          backgroundColor: routineColor,
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
                          routineName,
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
                            '8:00 AM',
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
                            '9:00 AM',
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
            // TODO Devices carousel widget
            RoutineDeviceCarousel(
              routineColor: routineColor,
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
