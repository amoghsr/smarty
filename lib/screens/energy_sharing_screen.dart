import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_vlc_player/generated/i18n.dart';
import 'package:smarty/models/consumptionModel.dart';
import 'package:smarty/models/user.dart';
import 'package:smarty/screens/drawer.dart';
import 'package:smarty/shared/constants.dart';
import 'package:smarty/widgets/voiceAgent.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:smarty/alertBox.dart';
import 'package:smarty/models/pointsProvider.dart';
import 'package:smarty/widgets/donateDialog.dart';

class EnergySharingScreen extends StatefulWidget {
  @override
  int drawerbool;
  EnergySharingScreen({@required this.drawerbool});
  _EnergySharingScreenState createState() => _EnergySharingScreenState();
}

class _EnergySharingScreenState extends State<EnergySharingScreen> {
  @override
  num electricityAmount = 5;
  num capacity = 48;
  num click = 0;
  num conversion = 0.23;
  Color selectedColor = Colors.deepOrange;
  Color iconColor = Colors.white;

  Future<void> _infoDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Theme.of(context).primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          title: Center(
            child: Text('P2P Energy Sharing'),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                  'Extra electricity produced by your home\'s solar panel\'s can be used by donating them to charitable organisations.',
                  style: TextStyle(fontSize: 14.0),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Icon(MaterialCommunityIcons.check),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    final y = Provider.of<Consumption>(context);
    final now = DateTime.now();
    final date = DateTime(2020, 1, 1);
    final diff = now.difference(new DateTime(date.year, 1, 1, 0, 0));
    final diffInDays = diff.inDays;
    String avg = "0";
    if (y != null) {
      avg = (y.monthly.values.toList().reduce((a, b) => a + b) / diffInDays)
          .toStringAsFixed(2);
    }
    final bal = Provider.of<Map<String, PointsProvider>>(context);
    num screenwidth = MediaQuery.of(context).size.width;
    num screenheight = MediaQuery.of(context).size.height;
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Text('${bal[user.houseId].getBalanceAsInt()}',
                    style: kAppBarTextStyle.copyWith(fontSize: 20.0)),
                Icon(Icons.flash_on, size: 20.0, color: Colors.deepOrange),
              ],
            ),
          ),
        ],
      ),
      drawer: (widget.drawerbool == 0) ? DrawerPage() : null,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: screenheight * 0.025,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'Donate Energy',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      GestureDetector(
                        onTap: _infoDialog,
                        child: Icon(MaterialCommunityIcons.help_circle_outline),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 4.0, bottom: 4.0, right: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Support your local charities and make a difference',
                          style: TextStyle(fontSize: 12.0),
                        )
                      ],
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
                                    balance: bal[user.houseId].getBalance(),
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
              height: 28.0,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Purchase Energy',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  top: 8.0, bottom: 4.0, left: 20.0, right: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'You can purchase energy from the community when your home is in need of energy.',
                    style: TextStyle(fontSize: 12.0),
                  )
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
                        child: Icon(
                          MaterialCommunityIcons.minus_circle,
                          size: 36,
                          color: Colors.red,
                        ),
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
                        child: Icon(
                          Icons.add_circle,
                          size: 36,
                          color: Colors.blue,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    'Purchase KWh units',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(6.0),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.06),
                          offset: Offset(1.0, 4.0),
                          blurRadius: 8.0)
                    ]),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 12.0, horizontal: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'Your avg consumption',
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        avg + ' KWh',
                        style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.w700,
                            color: Colors.red),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0),
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(height: screenheight * 0.01),
                        Text(
                          'Purchase with',
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 16.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: screenheight * 0.01),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            (click == 0)
                                ? Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Text(
                                        '${electricityAmount.toInt()}',
                                        style: TextStyle(
                                          fontSize: 28,
                                        ),
                                      ),
                                      Icon(
                                        Icons.flash_on,
                                        color: Colors.deepOrange,
                                        size: 28,
                                      ),
                                    ],
                                  )
                                : Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: <Widget>[
                                      Text(
                                        '${(num.parse((electricityAmount * conversion).toStringAsFixed(2)))}',
                                        style: TextStyle(
                                          fontSize: 28,
                                        ),
                                      ),
                                      SizedBox(
                                        width: screenwidth * 0.02,
                                      ),
                                      Column(
                                        children: <Widget>[
                                          Text('AED'),
                                          SizedBox(height: 3.0)
                                        ],
                                      ),
                                    ],
                                  ),
                          ],
                        ),
                      ],
                    ),
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
                            height: 70,
                            width: 70,
                            decoration: BoxDecoration(
                              color: selectedColor == Colors.deepOrange
                                  ? Colors.deepOrange
                                  : Theme.of(context).primaryColor,
                              borderRadius: BorderRadius.circular(10.0),
                              boxShadow: [
                                BoxShadow(
                                    color: selectedColor == Colors.deepOrange
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
                              size: 30,
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
                            height: 70,
                            width: 70,
                            decoration: BoxDecoration(
                                color: selectedColor == Colors.lightGreen
                                    ? Colors.lightGreen
                                    : Theme.of(context).primaryColor,
                                borderRadius: BorderRadius.circular(10.0),
                                boxShadow: [
                                  BoxShadow(
                                      color: selectedColor == Colors.lightGreen
                                          ? Colors.lightGreen.withOpacity(0.4)
                                          : Colors.black.withOpacity(0.2),
                                      offset: Offset(0, 0),
                                      blurRadius: 10.0)
                                ]),
                            child: Icon(
                              Icons.attach_money,
                              color: selectedColor == Colors.lightGreen
                                  ? Colors.white
                                  : Colors.lightGreen,
                              size: 30,
                            ),
                          ),
                        ),
                      ],
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
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    height: 50.0,
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
                                child: transactionDialog(
                                    context,
                                    0,
                                    "You are buying",
                                    (click == 0)
                                        ? "$electricityAmount kWh for $electricityAmount "
                                        : "$electricityAmount kWh for ${(num.parse((electricityAmount * conversion).toStringAsFixed(2)))}",
                                    "Would you like to proceed?",
                                    Colors.green,
                                    click,
                                    bal[user.houseId].getBalance(),
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
                                  child: transactionDialog(
                                      context,
                                      0,
                                      "You are purchasing",
                                      (click == 0)
                                          ? "${electricityAmount.toInt()} kWh for ${electricityAmount.toInt()} "
                                          : "${electricityAmount.toInt()} kWh for ${(num.parse((electricityAmount * conversion).toStringAsFixed(2)))}",
                                      "Would you like to proceed?",
                                      Colors.green,
                                      click,
                                      bal[user.houseId].getBalance(),
                                      electricityAmount.toDouble(),
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
            SizedBox(
              height: 40.0,
            ),
          ],
        ),
      ),
    );
  }
}
