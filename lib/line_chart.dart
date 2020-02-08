import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'statsGeneration.dart';

class LineChartSample2 extends StatefulWidget {
  @override
  String groupby;
  double aspect;
  double maxX;
  LineChartSample2(this.groupby, this.aspect, this.maxX);

  State<LineChartSample2> createState() => _LineChartSample2State();
}

class _LineChartSample2State extends State<LineChartSample2> {
  List<Color> gradientColors = [
    Colors.lightGreenAccent,
    Colors.lightGreenAccent,
  ];
  // List<Color> gradientColors2 = [
  //   Colors.white,
  //   Colors.white,
  // ];
  bool showAvg = false;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Container(
          child: Stack(
            children: <Widget>[
              Align(
                alignment: Alignment.bottomCenter,
                child: AspectRatio(
                  aspectRatio: widget.aspect,
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(18),
                        ),
                        color: Theme.of(context).scaffoldBackgroundColor),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          right: 18.0, left: 12.0, top: 24, bottom: 12),
                      child: StreamBuilder(
                        stream: Firestore.instance.collection('consumed_energy').snapshots(),
                        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                          return LineChart(
                        showAvg
                            ? avgData(widget.groupby, snapshot)
                            : mainData(widget.groupby, snapshot),
                          );
                        }
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 60,
                height: 34,
                child: FlatButton(
                  onPressed: () {
                    setState(() {
                      showAvg = !showAvg;
                    });
                  },
                  child: Text(
                    'AVG',
                    style: TextStyle(
                        fontSize: 11,
                        color: showAvg
                            ? Colors.white.withOpacity(0.5)
                            : Colors.white.withOpacity(0.5)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  LineChartData mainData(String groupby, AsyncSnapshot<QuerySnapshot> snapshot) {
    Map<String, int> hours = Generation().hourlyData(snapshot, 0, '1');
    List<int> hourData = hours.values.toList();
    return LineChartData(
      gridData: FlGridData(
        show: true,
        drawVerticalLine: true,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: Theme.of(context).scaffoldBackgroundColor,
            strokeWidth: 0,
          );
        },
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: Color(0xFFD3CECE).withOpacity(0.3),
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
          showTitles: true,
          reservedSize: 22,
          textStyle: TextStyle(
              color: const Color(0xff68737d),
              fontWeight: FontWeight.normal,
              fontSize: 10),
          getTitles: (value) {
            if (groupby == "Day")
              switch (value.toInt()) {
                case 1:
                  return '12 AM';
                case 3:
                  return '1 AM';
                case 5:
                  return '2 AM';
                case 7:
                  return '3 AM';
                case 9:
                  return '4 AM';
                case 11:
                  return '5 AM';
                case 13:
                  return '6 AM';
                case 15:
                  return '7 AM';
                case 17:
                  return '8 AM';
                case 19:
                  return '9 AM';
                case 21:
                  return '10 AM';
                case 23:
                  return '11 AM';
                case 25:
                  return '12 PM';
                case 27:
                  return '1 PM';
                case 29:
                  return '2 PM';
                case 31:
                  return '3 PM';
                case 33:
                  return '4 PM';
                case 35:
                  return '5 PM';
                case 37:
                  return '6 PM';
                case 39:
                  return '7 PM';
                case 41:
                  return '8 PM';
                case 43:
                  return '9 PM';
                case 45:
                  return '10 PM';
                case 47:
                  return '11 PM';
                case 49:
                  return '12 PM';
              }
            else if (groupby == "Week")
              switch (value.toInt()) {
                case 1:
                  return 'SUN';
                case 3:
                  return 'MON';
                case 5:
                  return 'TUE';
                case 7:
                  return 'WED';
                case 9:
                  return 'THU';
                case 11:
                  return 'FRI';
                case 13:
                  return 'SAT';
              }
            else
              switch (value.toInt()) {
                case 1:
                  return 'JAN';
                case 3:
                  return 'FEB';
                case 5:
                  return 'MAR';
                case 7:
                  return 'APR';
                case 9:
                  return 'MAY';
                case 11:
                  return 'JUN';
                case 13:
                  return 'JUL';
                case 15:
                  return 'AUG';
                case 17:
                  return 'SEP';
                case 19:
                  return 'OCT';
                case 21:
                  return 'NOV';
                case 23:
                  return 'DEC';
              }
            return '';
          },
          margin: 8,
        ),
        leftTitles: SideTitles(
          showTitles: true,
          textStyle: TextStyle(
            color: const Color(0xff67727d),
            fontWeight: FontWeight.normal,
            fontSize: 10,
          ),
          getTitles: (value) {
            switch (value.toInt()) {
              case 1:
                return '10kWh';
              case 3:
                return '30kWh';
              case 5:
                return '50kWh';
            }
            return '';
          },
          reservedSize: 28,
          margin: 12,
        ),
      ),
      borderData: FlBorderData(
          show: true,
          border: Border.all(color: const Color(0xff37434d), width: 0)),
      minX: 0,
      maxX: widget.maxX,
      minY: 0,
      maxY: 6,
      lineBarsData: [
        LineChartBarData(
          spots: [
            FlSpot(0, hourData[0]%5.toDouble()),
            FlSpot(1, hourData[0]%5.toDouble()),
            FlSpot(3, hourData[1]%5.toDouble()),
            FlSpot(5, hourData[2]%5.toDouble()),
            FlSpot(7, hourData[3]%5.toDouble()),
            FlSpot(9, hourData[4]%5.toDouble()),
            FlSpot(11, hourData[5]%5.toDouble()),
            FlSpot(13, hourData[6]%5.toDouble()),
            FlSpot(15, hourData[7]%5.toDouble()),
            FlSpot(17, hourData[8]%5.toDouble()),  
            FlSpot(19, hourData[9]%5.toDouble()), 
            FlSpot(21, hourData[10]%5.toDouble()), 
            FlSpot(23, hourData[11]%5.toDouble()), 
            FlSpot(25, hourData[12]%5.toDouble()),
            FlSpot(27, hourData[13]%5.toDouble()), 
            FlSpot(29, hourData[14]%5.toDouble()), 
            FlSpot(31, hourData[15]%5.toDouble()), 
            FlSpot(33, hourData[16]%5.toDouble()), 
            FlSpot(35, hourData[17]%5.toDouble()), 
            FlSpot(37, hourData[18]%5.toDouble()), 
            FlSpot(39, hourData[19]%5.toDouble()), 
            FlSpot(41, hourData[20]%5.toDouble()),
            FlSpot(43, hourData[21]%5.toDouble()), 
            FlSpot(45, hourData[22]%5.toDouble()), 
            FlSpot(47, hourData[23]%5.toDouble()), 
            FlSpot(49, hourData[23]%5.toDouble()),  
          ],
          isCurved: true,
          colors: gradientColors,
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: const FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            colors:
                gradientColors.map((color) => color.withOpacity(0.3)).toList(),
          ),
        ),
      ],
    );
  }

  
  LineChartData avgData(String groupby, AsyncSnapshot<QuerySnapshot> snapshot) {
    return LineChartData(
      lineTouchData: const LineTouchData(enabled: false),
      gridData: FlGridData(
        show: true,
        drawHorizontalLine: true,
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: Color(0xFFD3CECE).withOpacity(0.3),
            strokeWidth: 1,
          );
        },
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: Color(0xFFD3CECE).withOpacity(0.3),
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
          showTitles: true,
          reservedSize: 22,
          textStyle: TextStyle(
            color: const Color(0xff67727d),
            fontWeight: FontWeight.normal,
            fontSize: 10,
          ),
          getTitles: (value) {
            if (groupby == "Day")
              switch (value.toInt()) {
                case 1:
                  return '12 AM';
                case 3:
                  return '1 AM';
                case 5:
                  return '2 AM';
                case 7:
                  return '3 AM';
                case 9:
                  return '4 AM';
                case 11:
                  return '5 AM';
                case 13:
                  return '6 AM';
                case 15:
                  return '7 AM';
                case 17:
                  return '8 AM';
                case 19:
                  return '9 AM';
                case 21:
                  return '10 AM';
                case 23:
                  return '11 AM';
                case 25:
                  return '12 PM';
                case 27:
                  return '1 PM';
                case 29:
                  return '2 PM';
                case 31:
                  return '3 PM';
                case 33:
                  return '4 PM';
                case 35:
                  return '5 PM';
                case 37:
                  return '6 PM';
                case 39:
                  return '7 PM';
                case 41:
                  return '8 PM';
                case 43:
                  return '9 PM';
                case 45:
                  return '10 PM';
                case 47:
                  return '11 PM';
                case 49:
                  return '12 PM';
              }
            else if (groupby == "Week")
              switch (value.toInt()) {
                case 1:
                  return 'SUN';
                case 3:
                  return 'MON';
                case 5:
                  return 'TUE';
                case 7:
                  return 'WED';
                case 9:
                  return 'THU';
                case 11:
                  return 'FRI';
                case 13:
                  return 'SAT';
              }
            else
              switch (value.toInt()) {
                case 1:
                  return 'JAN';
                case 3:
                  return 'FEB';
                case 5:
                  return 'MAR';
                case 7:
                  return 'APR';
                case 9:
                  return 'MAY';
                case 11:
                  return 'JUN';
                case 13:
                  return 'JUL';
                case 15:
                  return 'AUG';
                case 17:
                  return 'SEP';
                case 19:
                  return 'OCT';
                case 21:
                  return 'NOV';
                case 23:
                  return 'DEC';
              }
            return '';
          },
          margin: 8,
        ),
        leftTitles: SideTitles(
          showTitles: true,
          textStyle: TextStyle(
            color: const Color(0xff67727d),
            fontWeight: FontWeight.normal,
            fontSize: 10,
          ),
          getTitles: (value) {
            switch (value.toInt()) {
              case 1:
                return '10kWh';
              case 3:
                return '30kWh';
              case 5:
                return '50kWh';
            }
            return '';
          },
          reservedSize: 28,
          margin: 12,
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: Border.all(
            color: Theme.of(context).scaffoldBackgroundColor, width: 100),
      ),
      minX: 0,
      maxX: widget.maxX,
      minY: 0,
      maxY: 6,
      lineBarsData: [
        LineChartBarData(
          spots: [
            FlSpot(0, 3.44),
            FlSpot(2.6, 3.44),
            FlSpot(4.9, 3.44),
            FlSpot(6.8, 3.44),
            FlSpot(8, 3.44),
            FlSpot(9.5, 3.44),
            FlSpot(11, 3.44),
          ],
          isCurved: true,
          colors: [
            ColorTween(begin: gradientColors[0], end: gradientColors[1])
                .lerp(0.2),
            ColorTween(begin: gradientColors[0], end: gradientColors[1])
                .lerp(0.2),
          ],
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: const FlDotData(
            dotColor: Color(0XFF3BFCF2),
            show: true,
          ),
          belowBarData: BarAreaData(show: true, colors: [
            ColorTween(begin: gradientColors[0], end: gradientColors[1])
                .lerp(0.2)
                .withOpacity(0),
            ColorTween(begin: gradientColors[0], end: gradientColors[1])
                .lerp(0.2)
                .withOpacity(0),
          ]),
        ),
      ],
    );
  }
}
