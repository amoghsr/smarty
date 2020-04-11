import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:smarty/shared/constants.dart';
import 'package:smarty/widgets/donateDialog.dart';

class P2P extends StatefulWidget {
  @override
  _P2PState createState() => _P2PState();
}

class _P2PState extends State<P2P> {
  @override
  int electricityAmount = 5;
  Widget build(BuildContext context) {
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
                '25',
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
      body: Column(
        children: <Widget>[
          SizedBox(
            height: screenheight * 0.025,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              children: <Widget>[
                Text(
                  'Donate',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(
                  width: screenwidth * 0.03,
                ),
                Column(
                  children: <Widget>[
                    Image.asset(
                      "assets/images/heart.png",
                      color: Colors.white54,
                      // height: screenheight * 0.08,
                      width: screenwidth * 0.07,
                    ),
                    SizedBox(
                      height: screenheight * 0.01,
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: 4,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Opacity(
                  opacity: 0.5,
                  child: Text(
                    'Support your local charities and make a difference.',
                    style: TextStyle(
                      fontSize: 11,
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
                                  image: charities[index][2],
                                  title: charities[index][0],
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
            height: screenheight * 0.025,
          ),
          Divider(
            color: Theme.of(context).backgroundColor,
          ),
          Column(
            children: <Widget>[
              SizedBox(
                height: screenheight * 0.025,
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
                    Column(
                      children: <Widget>[
                        Image.asset(
                          "assets/images/energy.png",
                          color: Colors.white54,
                          width: screenwidth * 0.07,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 4,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Opacity(
                      opacity: 0.5,
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
            ],
          ),
          SizedBox(
            height: screenheight * 0.04,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              InkWell(
                  onTap: () => setState(() {
                        if (electricityAmount > 1)
                          electricityAmount = electricityAmount - 1;
                      }),
                  child: Icon(Icons.remove, size: 45)),
              SizedBox(
                width: screenwidth * 0.02,
              ),
              Column(
                children: <Widget>[
                  Text(
                    '$electricityAmount',
                    style: kLightDeviceBottomBar,
                  ),
                  Text(
                    'kWh',
                    style: kLightDeviceBottomBar.copyWith(
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              SizedBox(
                width: screenwidth * 0.02,
              ),
              InkWell(
                  onTap: () => setState(() {
                        if (electricityAmount < 15)
                          electricityAmount = electricityAmount + 1;
                      }),
                  child: Icon(Icons.add, size: 45)),
            ],
          ),
          SizedBox(height: screenheight * 0.03),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  Row(
                    children: <Widget>[
                      Text(
                        '1',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w500),
                      ),
                      Icon(Icons.flash_on, color: Color(0xffe8b313), size: 15),
                    ],
                  ),
                  SizedBox(height: screenheight * 0.01),
                  Container(
                    color: Theme.of(context).accentColor,
                    width: screenwidth * 0.2,
                    height: screenheight * 0.05,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Center(
                          child: Text(
                            'BUY',
                            style: TextStyle(
                                color: Theme.of(context).bottomAppBarColor,
                                fontFamily: 'Montserrat',
                                fontSize: 11,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                        Icon(Icons.flash_on,
                            color: Color(0xffe8b313), size: 15),
                      ],
                    ),
                  )
                ],
              ),
              Column(
                children: [
                  Row(
                    children: <Widget>[
                      Text(
                        '1',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w500),
                      ),
                      SizedBox(width: screenwidth * 0.01),
                      Text(
                        'AED',
                        style: TextStyle(fontSize: 12.5),
                      ),
                    ],
                  ),
                  SizedBox(height: screenheight * 0.01),
                  Container(
                    color: Theme.of(context).accentColor,
                    width: screenwidth * 0.2,
                    height: screenheight * 0.05,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Center(
                          child: Text(
                            'BUY',
                            style: TextStyle(
                                color: Theme.of(context).bottomAppBarColor,
                                fontFamily: 'Montserrat',
                                fontSize: 11,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                        SizedBox(width: screenwidth * 0.01),
                        Icon(
                          FontAwesomeIcons.moneyBillWave,
                          color: Colors.green,
                          size: 12,
                        ),
                      ],
                    ),
                  )
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
