import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:smarty/devices/CommonControllers/deviceCommonControllers.dart';
import 'package:smarty/screens/optimizationDialog.dart';

import 'models/devicesModel.dart';

// Future showAlertBox(
//     BuildContext context, String img, String title, String desc, Color color) {
//   return showDialog(
//     context: context,
//     builder: (BuildContext context) => CustomDialog(
//       image: Image.asset(img),
//       title: title,
//       description: desc,
//       buttonText: "Okay",
//       col: color,
//     ),
//   );
// }

// A dialog popup that is displayed when there is an anomaly (fire) detected by the sensors.
class CustomDialog extends StatefulWidget {
  // Init various values needed by the popup
  final String title, description, buttonText;
  final Image image;
  final Color col;
  final dynamic path;
  final bool optimize;

  CustomDialog(
      {@required this.title,
      @required this.description,
      @required this.buttonText,
      this.image,
      this.col,
      this.path,
      this.optimize});

  @override
  _CustomDialogState createState() => _CustomDialogState();
}

class _CustomDialogState extends State<CustomDialog> {
  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  Widget build(BuildContext context) {
    // Returning a dialog box. Here we are specifying the properties of the dialog box.
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Consts.padding),
      ),
      elevation: 0.0,
      // Elevation means the height of element on the screen from the floor. Basically gives a drop shadow.
      backgroundColor: Colors.transparent,
      child: dialogContent(
          context), // The required child is the content inside the dialog box.
    );
  }

  dialogContent(BuildContext context) {
    return Stack(
      children: <Widget>[
        //...bottom card part,
        Container(
          padding: EdgeInsets.only(
            top: Consts.avatarRadius + Consts.padding,
            bottom: Consts.padding,
            left: Consts.padding,
            right: Consts.padding,
          ),
          margin: EdgeInsets.only(top: Consts.avatarRadius),
          decoration: new BoxDecoration(
            color: Theme.of(context).primaryColor,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(Consts.padding),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10.0,
                offset: const Offset(0.0, 10.0),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min, // To make the card compact
            children: <Widget>[
              // Title of the popup
              Center(
                child: Text(
                  widget.title,
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    color: widget.col,
                    fontSize: 24.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              // Description on the popup
              Text(
                widget.description,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  color: Colors.white,
                  fontSize: 16.0,
                ),
              ),
              SizedBox(height: 24.0),
              Align(
                alignment: Alignment.bottomCenter,
                // A button used for closing the dialog plus switching off the fire alarm.
                child: FlatButton(
                  onPressed: () {
                    FirebaseDatabase.instance
                        .reference()
                        .child("Sensors/Fire")
                        .update({'Danger': "low"}); // To close the dialog
                  },
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                      if (widget.optimize != true) {
                        if (widget.path != null)
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => widget.path),
                          );
                      } else if (widget.optimize == true) {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) =>
                              StreamBuilder(builder: (context, snap) {
                            return Dialog(
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.circular(Consts.padding),
                                ),
                                elevation: 0.0,
                                // Elevation means the height of element on the screen from the floor. Basically gives a drop shadow.
                                backgroundColor: Colors.transparent,
                                child: Optimization() // The required child is the content inside the dialog box.
                                );
                          }),
                        );
                      }
                    },
                    child: Container(
                      height: 40,
                      width: 200,
                      decoration: BoxDecoration(
                        color: widget.col,
                        borderRadius: BorderRadius.all(
                          Radius.circular(5),
                        ),
                      ),
                      child: Center(
                        child: Text(widget.buttonText),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        //...top circlular image part,
        Positioned(
          left: Consts.padding,
          right: Consts.padding,
          child: CircleAvatar(
            backgroundColor: Colors.white,
            radius: Consts.avatarRadius,
            child: widget.image,
          ),
        ),
      ],
    );
  }

}

class Consts {
  Consts._();

  static const double padding = 16.0;
  static const double avatarRadius = 66.0;
}
