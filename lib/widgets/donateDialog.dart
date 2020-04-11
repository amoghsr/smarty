import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:smarty/shared/constants.dart';

class DonateDialog extends StatefulWidget {
  // Init various values needed by the popup
  final String title, description, buttonText;
  final String image;
  final Color col;
  final double balance;

  DonateDialog({
    @required this.title,
    @required this.description,
    @required this.buttonText,
    @required this.balance,
    this.image,
    this.col,
  });

  @override
  _DonateDialogState createState() => _DonateDialogState();
}

class _DonateDialogState extends State<DonateDialog> {
  int donationAmount = 5;
  double conversion = 0.23;
  // double conversion = 0.23;
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

  int click = 0;

  dialogContent(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;
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
                widget.title,
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  color: widget.col,
                  fontSize: 24.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: screenheight * 0.03),
              // Description on the popup
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      InkWell(
                        onTap: () => setState(() {
                          if (donationAmount > 1)
                            donationAmount = donationAmount - 1;
                        }),
                        child:
                            Icon(Icons.remove, size: 45, color: Colors.white54),
                      ),
                      SizedBox(
                        width: screenwidth * 0.02,
                      ),
                      Text(
                        '$donationAmount',
                        style: kLightDeviceBottomBar.copyWith(
                          fontSize: 50,
                        ),
                      ),
                      SizedBox(
                        width: screenwidth * 0.02,
                      ),
                      InkWell(
                        onTap: () => setState(() {
                          if (donationAmount < widget.balance)
                            donationAmount = donationAmount + 1;
                        }),
                        child: Icon(Icons.add, size: 45, color: Colors.white54),
                      ),
                    ],
                  ),
                  Text(
                    'kWh',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: screenheight * 0.01),
                  Text(
                    'Donate Using',
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 18.0,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  SizedBox(height: screenheight * 0.02),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      (click == 0)
                          ? Row(
                              children: <Widget>[
                                Text(
                                  '${donationAmount.toInt()}',
                                  style: TextStyle(
                                    fontSize: 25,
                                  ),
                                ),
                                Icon(
                                  Icons.flash_on,
                                  color: Color(0xffe8b313),
                                  size: 22,
                                ),
                              ],
                            )
                          : Row(
                              children: <Widget>[
                                Text(
                                  '${(double.parse((donationAmount * conversion).toStringAsFixed(2)))}',
                                  style: TextStyle(
                                    fontSize: 25,
                                  ),
                                ),
                                SizedBox(
                                  width: screenwidth * 0.02,
                                ),
                                Icon(
                                  FontAwesomeIcons.moneyBillWave,
                                  color: Colors.green,
                                  size: 22,
                                ),
                              ],
                            ),
                    ],
                  ),
                ],
              ),
              Align(
                alignment: Alignment.bottomCenter,
                // A button used for closing the dialog plus switching off the fire alarm.
                child: FlatButton(
                  onPressed: () {},
                  //   FirebaseDatabase.instance
                  //       .reference()
                  //       .child("Sensors/Fire")
                  //       .update({'Danger': "low"}); // To close the dialog
                  // },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      InkWell(
                        onTap: () {
                          setState(() {
                            click = 0;
                          });
                        },
                        child: Container(
                          height: 40,
                          width: 70,
                          decoration: BoxDecoration(
                            border: Border.all(color: widget.col, width: 2),
                            borderRadius: BorderRadius.all(
                              Radius.circular(5),
                            ),
                          ),
                          child: Icon(Icons.flash_on,
                              color: Color(0xffe8b313), size: 30),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          setState(() {
                            click = 1;
                          });
                        },
                        child: Container(
                          height: 40,
                          width: 70,
                          decoration: BoxDecoration(
                            border: Border.all(color: widget.col, width: 2),
                            borderRadius: BorderRadius.all(
                              Radius.circular(5),
                            ),
                          ),
                          child: Icon(
                            FontAwesomeIcons.moneyBillWave,
                            color: Colors.green,
                            size: 30,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: screenheight * 0.02),
              InkWell(
                onTap: () => Navigator.of(context).pop(),
                child: Container(
                  height: 40,
                  width: 150,
                  decoration: BoxDecoration(
                    color: widget.col,
                    borderRadius: BorderRadius.all(
                      Radius.circular(5),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      "DONATE",
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 16,
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
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
            ),
            child: CircleAvatar(
              backgroundColor: widget.col,
              radius: Consts.avatarRadius,
              // backgroundImage: ExactAssetImage(image),
              child: Image.asset(widget.image, fit: BoxFit.fill),
            ),
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
