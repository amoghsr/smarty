import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
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
  Color selectedColor = Colors.deepOrange;
  Color iconColor = Colors.white;

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
            color: Theme
                .of(context)
                .canvasColor,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(Consts.padding),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min, // To make the card compact
            children: <Widget>[
              // Title of the popup
              Text('Donating to', style: TextStyle(fontSize: 14.0),),
              Text(
                widget.title,
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  color: widget.col,
                  fontSize: 22.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 8.0),
              // Description on the popup
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      InkWell(
                        onTap: () => setState(() {
                          if (donationAmount > 1)
                            donationAmount = donationAmount - 1;
                        }),
                        child: Icon(MaterialCommunityIcons.minus_circle,
                            size: 28, color: Colors.red),
                      ),
                      SizedBox(width: 24.0,),
                      Text(
                        '${donationAmount.toInt()}',
                        style: kLightDeviceBottomBar.copyWith(
                          fontSize: 50,
                        ),
                      ),
                      SizedBox(width: 24.0,),
                      InkWell(
                        onTap: () => setState(() {
                          if (donationAmount < capacity)
                            donationAmount = donationAmount + 1;
                        }),
                        child: Icon(Icons.add_circle,
                            size: 28, color: Colors.blue),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 4.0,
                  ),
                  Text(
                    'Donate KWh units',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 24.0),
                ],
              ),
              SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Donate Using',
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 14.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            (click == 0)
                                ? Row(
                              children: <Widget>[
                                Text(
                                  '${donationAmount.toInt()}',
                                  style: TextStyle(
                                    fontSize: 28,
                                  ),
                                ),
                                Icon(
                                  Icons.flash_on,
                                  color: Colors.deepOrange,
                                  size: 24,
                                ),
                              ],
                            )
                                : Row(
                              children: <Widget>[
                                Text(
                                  '${(double.parse((donationAmount * conversion)
                                      .toStringAsFixed(2)))}',
                                  style: TextStyle(
                                    fontSize: 28,
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
                    Row(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  click = 0;
                                  selectedColor = Colors.deepOrange;
                                });
                              },
                              child: Container(
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                  color: selectedColor == Colors.deepOrange
                                      ? Colors.deepOrange
                                      : Theme
                                      .of(context)
                                      .primaryColor,
                                  borderRadius: BorderRadius.circular(10.0),
                                  boxShadow: [
                                    BoxShadow(
                                        color: selectedColor ==
                                            Colors.deepOrange
                                            ? Colors.deepOrange.withOpacity(0.4)
                                            : Colors.black.withOpacity(0.2),
                                        offset: Offset(0, 0),
                                        blurRadius: 10.0)
                                  ],
                                ),
                                child: Icon(
                                  Icons.flash_on,
                                  color: selectedColor == Colors.deepOrange
                                      ? Colors.white
                                      : Colors.deepOrange,
                                  size: 20,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 12.0,
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  click = 1;
                                  selectedColor = Colors.lightGreen;
                                });
                              },
                              child: Container(
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                    color: selectedColor == Colors.lightGreen
                                        ? Colors.lightGreen
                                        : Theme
                                        .of(context)
                                        .primaryColor,
                                    borderRadius: BorderRadius.circular(10.0),
                                    boxShadow: [
                                      BoxShadow(
                                          color: selectedColor ==
                                              Colors.lightGreen
                                              ? Colors.lightGreen.withOpacity(
                                              0.4)
                                              : Colors.black.withOpacity(0.2),
                                          offset: Offset(0, 0),
                                          blurRadius: 10.0)
                                    ]),
                                child: Icon(
                                  Icons.attach_money,
                                  color: selectedColor == Colors.lightGreen
                                      ? Colors.white
                                      : Colors.lightGreen,
                                  size: 20,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 36.0),
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
                                  ? "${donationAmount
                                  .toInt()} KWh for ${donationAmount.toInt()} "
                                  : "${donationAmount.toInt()} KWh for ${(double
                                  .parse(
                                  (donationAmount * conversion).toStringAsFixed(
                                      2)))}",
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
                  height: 50,
                  decoration: BoxDecoration(
                    color: widget.col,
                    borderRadius: BorderRadius.all(
                      Radius.circular(8.0),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      'Donate',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
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
            top: Consts.padding,
            bottom: Consts.padding,
            left: Consts.padding,
            right: Consts.padding,
          ),
          margin: EdgeInsets.only(top: Consts.avatarRadius),
          decoration: new BoxDecoration(
            color: Theme
                .of(context)
                .primaryColor,
            borderRadius: BorderRadius.circular(Consts.padding),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min, // To make the card compact
            children: <Widget>[
              SizedBox(
                height: 10.0,
              ),
              // Title of the popup
              Text(
                title1,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Montserrat',
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
                      fontSize: 20.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  (click == 0)
                      ? Icon(
                          Icons.flash_on,
                    color: Colors.deepOrange,
                        )
                      : Row(
                          children: <Widget>[
                            SizedBox(width: 5),
                            Text(
                              'AED',
                              style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontSize: 20.0,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        )
                ],
              ),
              SizedBox(
                height: 16.0,
              ),
              // Description on the popup
              Text(
                description,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 16.0,
                ),
              ),
              SizedBox(height: 24.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                                          "Would you like to pay the excess (${(double
                                              .parse(
                                              ((donationAmount - bal) * 0.23)
                                                  .toStringAsFixed(2)))} AED)",
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
                                  return completedTransactionDialog(type);
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
                          child: Text(
                            'Yes',
                            style: TextStyle(color: Colors.white),
                          ),
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
                        child: Text(
                          'No',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.0),
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
              color: Colors.lightGreen,
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
                  style: TextStyle(fontSize: 24.0, color: Colors.lightGreen),
                ),
              ),
            ),
          ],
        ),
        backgroundColor: Theme
            .of(context)
            .primaryColor,
      );
    });
  }
}
