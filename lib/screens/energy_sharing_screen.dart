import 'package:flutter/material.dart';
import 'package:smarty/screens/drawer.dart';
import 'package:smarty/shared/constants.dart';
import 'package:smarty/widgets/voiceAgent.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:smarty/alertBox.dart';
import 'package:smarty/models/boltProvider.dart';
import 'package:smarty/widgets/donateDialog.dart';

class EnergySharingScreen extends StatefulWidget {
  @override
  _EnergySharingScreenState createState() => _EnergySharingScreenState();
}

class _EnergySharingScreenState extends State<EnergySharingScreen> {
  @override
  double electricityAmount = 5;
  double capacity = 48;
  int click = 0;
  double conversion = 0.23;

  Widget build(BuildContext context) {
    final bal = Provider.of<BoltProvider>(context);
    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;
    List<List<dynamic>> charities = [
      [
        "Red Cross",
        "assets/images/cross.png",
        "assets/images/redcross_circle.png",
        Color(0xffBE1E2D)
      ],
      [
        "Animal Rescue",
        "assets/images/paw.png",
        "assets/images/circlepaw.png",
        Color(0xff14B7F7)
      ],
      [
        "Make a Wish",
        "assets/images/teddy.png",
        "assets/images/bear.png",
        Color(0xffDFA0A0)
      ],
    ];
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Energy Sharing',
          style: kAppBarTextStyle,
        ),
        actions: <Widget>[
          Row(
            children: <Widget>[
              Text(
                '${bal.getBalanceAsInt()}',
                style: TextStyle(
                  fontSize: 19,
                ),
              ),
              Icon(Icons.flash_on, size: 19, color: Color(0xffe8b313)),
              SizedBox(
                width: screenwidth * 0.03,
              )
            ],
          ),
        ],
      ),
      drawer: DrawerPage(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: screenheight * 0.025,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                children: <Widget>[
                  Text('Donate', style: kHeadingTextStyle),
                  SizedBox(
                    width: screenwidth * 0.03,
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Opacity(
                    opacity: 0.8,
                    child: Text(
                      'Support your local charities and make a difference.',
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
              height: 150.0,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 3,
                itemBuilder: (BuildContext context, int index) {
                  // Room room = room1[index];
                  return InkWell(
                      child: Container(
                        margin: EdgeInsets.all(8.0),
                        width: 140.0,
                        child: Stack(
                          alignment: Alignment.topCenter,
                          children: <Widget>[
                            Container(
                              height: 190.0,
                              width: 140.0,
                              decoration: BoxDecoration(
                                //Image inside box
                                image: DecorationImage(
                                  image: AssetImage(charities[index][1]),
                                  fit: BoxFit.scaleDown,
                                ),

                                borderRadius: BorderRadius.circular(10.0),
                                color: charities[index][3],
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(10.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Center(
                                      child: Text(
                                        charities[index][0],
                                        style: TextStyle(
                                          fontFamily: 'Montserrat',
                                          fontWeight: FontWeight.w700,
                                          color: Colors.white,
                                          fontSize: 15,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 2,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      onTap: () async {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) =>
                                StatefulBuilder(builder: (context, setState) {
                                  return DonateDialog(
                                    type: 0,
                                    image: charities[index][2],
                                    title: charities[index][0],
                                    balance: bal.getBalance(),
                                    description:
                                        "Sprinklers have been activated.",
                                    col: charities[index][3],
                                    buttonText: "Okay",
                                  );
                                }));
                      });
                },
              ),
            ),
            SizedBox(
              height: screenheight * 0.005,
            ),
            Divider(
              height: 20.0,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                children: <Widget>[
                  Text(
                    'Purchase',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(
                    width: screenwidth * 0.03,
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Opacity(
                    opacity: 0.8,
                    child: Column(
                      children: <Widget>[
                        Text(
                          'Your average consumption: 5kWh',
                          style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                              color: Theme.of(context).accentColor),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      InkWell(
                        onTap: () => setState(() {
                          if (electricityAmount > 1)
                            electricityAmount = electricityAmount - 1;
                        }),
                        child:
                            Icon(Icons.remove, size: 30, color: Colors.white54),
                      ),
                      SizedBox(width: 20.0),
                      Text(
                        '${electricityAmount.toInt()}',
                        style: TextStyle(
                          fontSize: 56.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(width: 20.0),
                      InkWell(
                        onTap: () => setState(() {
                          if (electricityAmount < capacity)
                            electricityAmount = electricityAmount + 1;
                        }),
                        child: Icon(Icons.add, size: 30, color: Colors.white54),
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
                ],
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0),
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          click = 0;
                        });
                      },
                      child: Container(
                        height: 70,
                        width: 70,
                        decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.circular(10.0)),
                        child: Icon(Icons.flash_on,
                            color: Color(0xffe8b313), size: 30),
                      ),
                    ),
                    Column(
                      children: <Widget>[
                        SizedBox(height: screenheight * 0.01),
                        Text(
                          'Purchase Using',
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 15.0,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                        SizedBox(height: screenheight * 0.01),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            (click == 0)
                                ? Row(
                                    children: <Widget>[
                                      Text(
                                        '${electricityAmount.toInt()}',
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
                                        '${(double.parse((electricityAmount * conversion).toStringAsFixed(2)))}',
                                        style: TextStyle(
                                          fontSize: 25,
                                        ),
                                      ),
                                      SizedBox(
                                        width: screenwidth * 0.02,
                                      ),
                                      Text('AED')
                                    ],
                                  ),
                          ],
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          click = 1;
                        });
                      },
                      child: Container(
                        height: 70,
                        width: 70,
                        decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.circular(10.0)),
                        child: Icon(
                          Icons.attach_money,
                          color: Colors.lightGreen,
                          size: 30,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
              child: Container(
                child: GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: Container(
                    height: 50.0,
                    padding:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 150.0),
                    decoration: BoxDecoration(
                      color: Theme.of(context).accentColor,
                      borderRadius: BorderRadius.all(
                        Radius.circular(10.0),
                      ),
                    ),
                    child: InkWell(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) => StreamBuilder(
                            builder: (context, snap) {
                              return Dialog(
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.circular(Consts.padding),
                                ),
                                elevation: 0.0,
                                // Elevation means the height of element on the screen from the floor. Basically gives a drop shadow.
                                backgroundColor: Colors.transparent,
                                child: TransactionDialog().transactionDialog(
                                    context,
                                    0,
                                    "You are buying",
                                    (click == 0)
                                        ? "$electricityAmount kWh for $electricityAmount "
                                        : "$electricityAmount kWh for ${(double.parse((electricityAmount * conversion).toStringAsFixed(2)))}",
                                    "Would you like to proceed?",
                                    Colors.green,
                                    click,
                                    bal.getBalance(),
                                    electricityAmount,
                                    0), // The required child is the content inside the dialog box.
                              );
                            },
                          ),
                        );
                      },
                      child: InkWell(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) => StreamBuilder(
                              builder: (context, snap) {
                                return Dialog(
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.circular(Consts.padding),
                                  ),
                                  elevation: 0.0,
                                  // Elevation means the height of element on the screen from the floor. Basically gives a drop shadow.
                                  backgroundColor: Colors.transparent,
                                  child: TransactionDialog().transactionDialog(
                                      context,
                                      0,
                                      "You are purchasing",
                                      (click == 0)
                                          ? "${electricityAmount.toInt()} kWh for ${electricityAmount.toInt()} "
                                          : "${electricityAmount.toInt()} kWh for ${(double.parse((electricityAmount * conversion).toStringAsFixed(2)))}",
                                      "Would you like to proceed?",
                                      Colors.green,
                                      click,
                                      bal.getBalance(),
                                      electricityAmount,
                                      0), // The required child is the content inside the dialog box.
                                );
                              },
                            ),
                          );
                        },
                        child: Center(
                          child: Text(
                            "BUY",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
