import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

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
class CustomDialog extends StatelessWidget {
  // Init various values needed by the popup
  final String title, description, buttonText;
  final Image image;
  final Color col;

  CustomDialog({
    @required this.title,
    @required this.description,
    @required this.buttonText,
    this.image,
    this.col,
  });

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

  // Content inside the dialogBox
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
            color: Theme.of(context).canvasColor,
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
              Text(
                title,
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  color: col,
                  fontSize: 24.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 16.0),
              // Description on the popup
              Text(
                description,
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
                    onTap: () => Navigator.of(context).pop(),
                    child: Container(
                      height: 40,
                      width: 100,
                      decoration: BoxDecoration(
                        color: col,
                        borderRadius: BorderRadius.all(
                          Radius.circular(5),
                        ),
                      ),
                      child: Center(
                        child: Text(buttonText),
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
            child: image,
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
