import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconpicker/Models/IconPack.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:smarty/models/dbRoutines.dart';
import 'package:smarty/models/user.dart';
import 'package:smarty/screens/routines_pages/routine_device_carousel.dart';
import 'package:smarty/shared/constants.dart';
import 'package:flutter_iconpicker/flutter_iconpicker.dart';

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

            /// ADD ROUTINES SECTION
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Container(
                child: GestureDetector(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (_) {
                          return CustomDialog(
                            routineName: routine.Name,
                          );
                        });
                  },
                  child: Card(
                    color: Theme
                        .of(context)
                        .primaryColor,
                    child: ListTile(
                      leading: Icon(
                        Icons.add,
                        color: Colors.lightGreen,
                      ),
                      title: Text(
                        'Add to your routines',
                        style: TextStyle(
                            color: Colors.lightGreen,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Divider(
              height: 40.0,
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

          ],
        ),
      ),
    );
  }
}

class CustomDialog extends StatefulWidget {
  final routineName;

  const CustomDialog({Key key, this.routineName}) : super(key: key);

  @override
  _CustomDialogState createState() => new _CustomDialogState();
}

class _CustomDialogState extends State<CustomDialog> {
  Widget _icon;
  String routineNameByUser;
  String routineDescByUser;

  _pickIcon() async {
    IconData icon = await FlutterIconPicker.showIconPicker(context,
        iconPackMode: IconPack.material);

    _icon = Icon(
      icon,
      color: Colors.white,
      size: 36.0,
    );

    setState(() {});
  }

  // DEFAULT COLOR OPTION
  Color selectedColor = Colors.blue;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Theme
          .of(context)
          .primaryColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      title: Center(
        child: Text('Add ${widget.routineName.toString()}'),
      ),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                'Customise ${widget.routineName
                    .toString()} here before adding it',
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20.0),
              GestureDetector(
                onTap: _pickIcon,
                child: CircleAvatar(
                  child: AnimatedSwitcher(
                    duration: Duration(milliseconds: 300),
                    child: _icon != null
                        ? _icon
                        : Icon(
                      Icons.add,
                      size: 40.0,
                      color: Colors.white,
                    ),
                  ),
                  maxRadius: 40.0,
                  backgroundColor: selectedColor,
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              OutlineButton(
                padding: EdgeInsets.symmetric(horizontal: 30.0),
                color: selectedColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                onPressed: _pickIcon,
                child: Text('Pick an icon'),
              ),
              SizedBox(height: 8.0),
              TextFormField(
                validator: (value) {
                  if (value.isEmpty) {
                    return 'This field cannot be empty';
                  }
                  return null;
                },
                onChanged: (val) {
                  setState(() => routineNameByUser = val);
                },
                decoration: InputDecoration(
                  hintText: widget.routineName,
                  helperText: 'For ex. Going out',
                  focusColor: selectedColor,
                  enabledBorder: new UnderlineInputBorder(
                    borderSide: new BorderSide(color: selectedColor),
                  ),
                  focusedBorder: new UnderlineInputBorder(
                    borderSide: new BorderSide(color: selectedColor),
                  ),
                ),
              ),
              TextFormField(
                validator: (value) {
                  if (value.isEmpty) {
                    return 'This field cannot be empty';
                  }
                  return null;
                },
                onChanged: (val) {
                  setState(() => routineDescByUser = val);
                },
                decoration: InputDecoration(
                  hintText: 'Short description',
                  helperText: 'For ex. Routine while going out',
                  enabledBorder: new UnderlineInputBorder(
                    borderSide: new BorderSide(color: selectedColor),
                  ),
                  focusedBorder: new UnderlineInputBorder(
                    borderSide: new BorderSide(color: selectedColor),
                  ),
                ),
              ),
              SizedBox(
                height: 24.0,
              ),
              Center(
                  child: Text(
                      'Give your routine a color',
                      style: TextStyle(fontSize: 16.0,)
                  )),
              SizedBox(
                height: 18.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedColor = Colors.blue;
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        border: selectedColor == Colors.blue
                            ? Border.all(width: 4.0, color: Colors.white)
                            : null,
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      height: 40.0,
                      width: 40.0,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedColor = Colors.lightGreen;
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        border: selectedColor == Colors.lightGreen
                            ? Border.all(width: 4.0, color: Colors.white)
                            : null,
                        color: Colors.lightGreen,
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      height: 40.0,
                      width: 40.0,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedColor = Colors.deepOrange;
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        border: selectedColor == Colors.deepOrange
                            ? Border.all(width: 4.0, color: Colors.white)
                            : null,
                        color: Colors.deepOrange,
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      height: 40.0,
                      width: 40.0,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedColor = Colors.red;
                      });
                    },
                    child: Container(
//              color: Colors.red,
                      decoration: BoxDecoration(
                        border: selectedColor == Colors.red
                            ? Border.all(width: 4.0, color: Colors.white)
                            : null,
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      height: 40.0,
                      width: 40.0,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedColor = Colors.deepPurpleAccent;
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        border: selectedColor == Colors.deepPurpleAccent
                            ? Border.all(width: 4.0, color: Colors.white)
                            : null,
                        color: Colors.deepPurpleAccent,
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      height: 40.0,
                      width: 40.0,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      actions: <Widget>[
        FlatButton(
          child: Text(
            'CANCEL',
            style: TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        FlatButton(
          child: Text(
            'ADD',
            style: TextStyle(fontWeight: FontWeight.bold, color: selectedColor),
          ),
          onPressed: () {
            /// VALIDATION OF FIELDS
            if (_formKey.currentState.validate()) {
              print(selectedColor.toString() +
                  ' ' +
                  routineDescByUser +
                  ' ' +
                  routineDescByUser);
              Navigator.of(context).pop();
            } else {
              return null;
            }
          },
        ),
      ],
    );
  }
}
