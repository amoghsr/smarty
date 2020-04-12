import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:smarty/alertBox.dart';
import 'package:smarty/shared/constants.dart';

class DonateDialog extends StatefulWidget {
  // Init various values needed by the popup'
  final int type;
  final String title, description, buttonText;
  final String image;
  final Color col;
  final double balance;

  DonateDialog({
    @required this.type,
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
  double donationAmount = 5;
  double conversion = 0.23;
  double capacity = 48;

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
                        '${donationAmount.toInt()}',
                        style: kLightDeviceBottomBar.copyWith(
                          fontSize: 50,
                        ),
                      ),
                      SizedBox(
                        width: screenwidth * 0.02,
                      ),
                      InkWell(
                        onTap: () => setState(() {
                          if (donationAmount < capacity)
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
                                Text('AED'),
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
                onTap: () {
                  Navigator.of(context).pop();
                  showDialog(
                    context: context,
                    builder: (BuildContext context) => StreamBuilder(
                      builder: (context, snap) {
                        return Dialog(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(Consts.padding),
                          ),
                          elevation: 0.0,
                          // Elevation means the height of element on the screen from the floor. Basically gives a drop shadow.
                          backgroundColor: Colors.transparent,
                          child: TransactionDialog().transactionDialog(
                              context,
                              1,
                              (widget.type == 0)
                                  ? "You are purchasing"
                                  : "You are donating",
                              (click == 0)
                                  ? "${donationAmount.toInt()} kWh for ${donationAmount.toInt()} "
                                  : "${donationAmount.toInt()} kWh for ${(double.parse((donationAmount * conversion).toStringAsFixed(2)))}",
                              "Would you like to proceed?",
                              widget.col,
                              click,
                              widget.balance,
                              donationAmount,
                              0), // The required child is the content inside the dialog box.
                        );
                      },
                    ),
                  );
                },
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

class TransactionDialog extends StatelessWidget {
  @override
  final int type;
  final String title1;
  final String title2;
  final String description;
  final Color col;
  final int click;
  final double bal;
  final double donationAmount;

  TransactionDialog(
      {this.type,
      this.title1,
      this.title2,
      this.description,
      this.col,
      this.click,
      this.bal,
      this.donationAmount});

  Widget build(BuildContext context) {
    int type = 1;
    return transactionDialog(context, type, title1, title2, description, col,
        click, bal, donationAmount, 0);
  }

  transactionDialog(
      BuildContext context,
      int type,
      String title1,
      String title2,
      String description,
      Color col,
      int click,
      double bal,
      double donationAmount,
      int c) {
    return Stack(
      children: <Widget>[
        //...bottom card part,
        Container(
          padding: EdgeInsets.only(
            top: Consts.padding + 10,
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
                title1,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    title2,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  (click == 0)
                      ? Icon(
                          Icons.flash_on,
                          color: Color(0xffe8b313),
                        )
                      : Row(
                          children: <Widget>[
                            SizedBox(width: 5),
                            Text(
                              'AED',
                              style: TextStyle(
                                fontFamily: 'Montserrat',
                                color: Colors.white,
                                fontSize: 20.0,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        )
                ],
              ),
              SizedBox(height: 16.0),
              // Description on the popup
              Text(
                description,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  color: Colors.white,
                  fontSize: 18.0,
                ),
              ),
              SizedBox(height: 24.0),
              Align(
                alignment: Alignment.bottomCenter,
                // A button used for closing the dialog plus switching off the fire alarm.
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: (click == 1)
                          ? InkWell(
                              onTap: () {
                                Navigator.pop(context);
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return completedTransactionDialog(type);
                                    });
                              },
                              child: Container(
                                height: 40,
                                width: 80,
                                decoration: BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(5),
                                  ),
                                ),
                                child: Center(
                                  child: Text('Yes'),
                                ),
                              ),
                            )
                          : InkWell(
                              onTap: () {
                                Navigator.pop(context);
                                if (bal < donationAmount) {
                                  print("Bal: $bal, Donation: $donationAmount");

                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) =>
                                        StreamBuilder(
                                      builder: (context, snap) {
                                        return Dialog(
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                                Consts.padding),
                                          ),
                                          elevation: 0.0,
                                          // Elevation means the height of element on the screen from the floor. Basically gives a drop shadow.
                                          backgroundColor: Colors.transparent,
                                          child: transactionDialog2(
                                              context,
                                              type,
                                              "You do not have",
                                              "sufficient ",
                                              "Would you like to pay the excess (${(double.parse(((donationAmount - bal) * 0.23).toStringAsFixed(2)))} AED)",
                                              col,
                                              click,
                                              bal,
                                              donationAmount,
                                              1),
                                        );
                                      },
                                    ),
                                  );
                                } else {
                                  if (c != 1) {
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return completedTransactionDialog(
                                              type);
                                        });
                                  }
                                }
                                print(c);
                                if (c == 1) {
                                  Navigator.pop(context);
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return completedTransactionDialog(type);
                                      });
                                }
                              },
                              child: Container(
                                height: 40,
                                width: 80,
                                decoration: BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(5),
                                  ),
                                ),
                                child: Center(
                                  child: Text('Yes'),
                                ),
                              ),
                            ),
                    ),
                    InkWell(
                      onTap: () => Navigator.of(context).pop(),
                      child: Container(
                        height: 40,
                        width: 80,
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.all(
                            Radius.circular(5),
                          ),
                        ),
                        child: Center(
                          child: Text('No'),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        //...top circlular image part,
      ],
    );
  }

  transactionDialog2(
      BuildContext context,
      int type,
      String title1,
      String title2,
      String description,
      Color col,
      int click,
      double bal,
      double donationAmount,
      int choice) {
    choice = 1;
    return transactionDialog(context, type, title1, title2, description, col,
        click, bal, donationAmount, choice);
  }

  completedTransactionDialog(int type) {
    return StatefulBuilder(builder: (context, setState) {
      return AlertDialog(
        title: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Icon(
              FontAwesomeIcons.checkCircle,
              color: Colors.green,
              size: 100,
            ),
            SizedBox(height: 20),
            Container(
              height: MediaQuery.of(context).size.height * 0.1,
              width: MediaQuery.of(context).size.width * 0.5,
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(6.0),
              ),
              child: Center(
                child: Text(
                  (type == 0) ? "PURCHASE SUCCESSFUL!" : "DONATION SUCCESSFUL!",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 24.0, color: Colors.green),
                ),
              ),
            ),
          ],
        ),
        backgroundColor: Colors.transparent,
      );
    });
  }
}
