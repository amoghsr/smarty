import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import 'package:smarty/line_chart.dart';
import 'package:smarty/screens/allDevices.dart';
import 'package:smarty/screens/p2pPanel.dart';
import 'package:smarty/screens/EnergySlider.dart';
import 'package:smarty/shared/constants.dart';

class EnergyStats extends StatefulWidget {
  String energyType;

  EnergyStats({this.energyType});

  _EnergyStatsState createState() => _EnergyStatsState();
}

//energy statistics
var now = new DateTime.now();
var date = new DateFormat('dd');
String formattedDate = date.format(now);
var day = new DateFormat('EEEEE');
String formattedDay = day.format(now);
var month = new DateFormat('MMMM');
String formattedMonth = month.format(now);

class ExampleViewModel {
  final List<Color> pageColors;
  final CircularSliderAppearance appearance;
  final double min;
  final double max;
  final double value;
  final InnerWidget innerWidget;
  ExampleViewModel(
      {@required this.pageColors,
      @required this.appearance,
      this.min,
      this.max,
      this.value,
      this.innerWidget});
}

class _EnergyStatsState extends State<EnergyStats> {
  @override
  final controller = PageController(initialPage: 0);

  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: DefaultTabController(
        length: 3,
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxisScrolled) {
            return <Widget>[
              SliverAppBar(
                pinned: true,
                floating: false,
                title: TabBar(
                  labelColor: Theme.of(context).accentColor,
                  unselectedLabelColor: Theme.of(context).backgroundColor,
                  indicatorColor: Colors.transparent,
                  indicatorSize: TabBarIndicatorSize.tab,
                  tabs: [
                    Tab(
                      child: Text(
                        'Day',
                        // style: TextStyle(color: Theme.of(context).cardColor),
                      ),
                    ),
                    Tab(
                      child: Text(
                        'Week',
                        // style: TextStyle(color: Theme.of(context).cardColor)
                      ),
                    ),
                    Tab(
                      child: Text(
                        'Month',
                        // style: TextStyle(color: Theme.of(context).cardColor),
                      ),
                    ),
                  ],
                ),
              ),
            ];
          },
          body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: <Widget>[
                SizedBox(height: screenheight * 0.01),
                Text(
                  'Energy ' + widget.energyType,
                  style: TextStyle(
                    color: Theme.of(context).accentColor,
                    fontSize: 20,
                    fontFamily: 'Montserrat',
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: screenheight * 0.01),
                Container(
                  height: screenheight * 0.35,
                  width: screenwidth,
                  child: TabBarView(
                    children: widget.energyType == 'Generation'
                        ? [
                            LineChartSample2('Generation', 'Day', 5, 49),
                            LineChartSample2('Generation', 'Week', 1.7, 13),
                            LineChartSample2('Generation', 'Month', 2.8, 23),
                          ]
                        : [
                            LineChartSample2('Consumption', 'Day', 5, 49),
                            LineChartSample2('Consumption', 'Week', 1.7, 13),
                            LineChartSample2('Consumption', 'Month', 2.8, 23),
                          ],
                  ),
                ),
                SizedBox(height: screenheight * 0.01),
                Container(
                  child: Container(
                    height: screenheight * 0.1,
                    child: Row(
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(width: screenwidth * 0.13),
                        widget.energyType == 'Consumption'
                            ? Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      '$formattedDay, $formattedDate $formattedMonth',
                                      style: TextStyle(
                                        fontFamily: 'Montserrat',
                                        color: Theme.of(context).accentColor,
                                        fontSize: 13,
                                      ),
                                    ),
                                    SizedBox(
                                      height: screenheight * 0.01,
                                    ),
                                    Text(
                                      '76 kWh',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontFamily: 'Montserrat',
                                        color: Theme.of(context).primaryColor,
                                        fontSize: 20,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : Expanded(
                                child: InkWell(
                                  child: Container(
                                    color: Theme.of(context).accentColor,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: <Widget>[
                                        Center(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: <Widget>[
                                              Text(
                                                'Peer to Peer',
                                                style: TextStyle(
                                                    color: Theme.of(context)
                                                        .bottomAppBarColor,
                                                    fontFamily: 'Montserrat',
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                              Text(
                                                'Energy Sharing',
                                                style: TextStyle(
                                                    color: Theme.of(context)
                                                        .bottomAppBarColor,
                                                    fontFamily: 'Montserrat',
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Image.asset(
                                          "assets/images/energy-sharing.png",
                                          height: screenheight * 0.13,
                                          width: screenwidth * 0.13,
                                        ),
                                      ],
                                    ),
                                  ),
                                  onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => P2P()),
                                  ),
                                ),
                              ),
                        SizedBox(width: screenwidth * 0.13),
                        Column(
                          children: <Widget>[
                            widget.energyType == 'Consumption'
                                ? InkWell(
                                    onTap: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => AllDevices()),
                                    ),
                                    child: Container(
                                      color: Theme.of(context).accentColor,
                                      width: screenwidth * 0.35,
                                      height: screenheight * 0.05,
                                      child: Center(
                                        child: Text(
                                          'SEE ALL DEVICES',
                                          style: TextStyle(
                                              color: Theme.of(context)
                                                  .bottomAppBarColor,
                                              fontFamily: 'Montserrat',
                                              fontSize: 10,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                    ),
                                  )
                                : Container()
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Divider(),
                Row(
                  children: <Widget>[
                    SizedBox(width: screenwidth * 0.07),
                    Expanded(
                      child: Container(
                        height: screenheight * 0.3,
                        child: ExamplePage(
                          viewModel: viewModel05,
                        ),
                      ),
                    ),
                    SizedBox(width: screenwidth * 0.2),
                    Expanded(
                      child: Container(
                        height: screenheight * 0.3,
                        child: ExamplePage(
                          viewModel: viewModel03,
                        ),
                      ),
                    ),
                    SizedBox(width: screenwidth * 0.07),
                  ],
                ),
                Container(
                  height: screenheight * 0.2,
                  child: Center(
                    child: Transform.scale(
                      scale: 2,
                      child: Padding(
                        padding: EdgeInsets.only(
                          left: screenwidth * 0.25,
                          right: screenwidth * 0.25,
                        ),
                        child: LiquidCustomProgressIndicator(
                          center: Text(
                            '50%',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 12,
                                fontWeight: FontWeight.w500),
                          ),
                          value: 0.5,
                          valueColor: AlwaysStoppedAnimation(Colors.green),
                          backgroundColor: Colors.white,
                          direction: Axis.horizontal,
                          shapePath: _buildBattery(),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Path _buildBattery() {
    return Path()
      ..addRect(Rect.fromLTWH(0, 0, 80, 40))
      ..addRect(Rect.fromLTWH(80, 10, 10, 20))
      ..close();
  }
}
