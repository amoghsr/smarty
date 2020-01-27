import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class LineChartSample2 extends StatefulWidget {
  @override
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
    double screenwidth = MediaQuery.of(context).size.width;

    return Center(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Container(
          child: Stack(
            children: <Widget>[
              Align(
                alignment: Alignment.bottomCenter,
                child: AspectRatio(
                  aspectRatio: 1.70,
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(18),
                        ),
                        color: Theme.of(context).scaffoldBackgroundColor),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          right: 18.0, left: 12.0, top: 24, bottom: 12),
                      child: LineChart(
                        showAvg ? avgData() : mainData(),
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

  LineChartData mainData() {
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
      maxX: 11,
      minY: 0,
      maxY: 6,
      lineBarsData: [
        LineChartBarData(
          spots: const [
            FlSpot(0, 3),
            FlSpot(2.6, 2),
            FlSpot(4.9, 5),
            FlSpot(6.8, 3.1),
            FlSpot(8, 4),
            FlSpot(9.5, 3),
            FlSpot(11, 4),
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

  LineChartData avgData() {
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
      maxX: 11,
      minY: 0,
      maxY: 6,
      lineBarsData: [
        LineChartBarData(
          spots: const [
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
