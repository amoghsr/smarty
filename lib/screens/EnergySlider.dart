import 'package:flutter/material.dart';

import 'dart:math' as math;
import 'package:sleek_circular_slider/sleek_circular_slider.dart';


import 'package:flutter/material.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

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

class ExamplePage extends StatelessWidget {
  final ExampleViewModel viewModel;
  const ExamplePage({
    Key key,
    @required this.viewModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: viewModel.pageColors,
                begin: Alignment.bottomLeft,
                end: Alignment.topRight,
                tileMode: TileMode.clamp)),
        child: SafeArea(
          child: Center(
              child: SleekCircularSlider(
                onChangeStart: (double value) {
                  print(value);
                },
                onChangeEnd: (double value) {
                  print(value);
                },
                innerWidget: viewModel.innerWidget,
                appearance: viewModel.appearance,
                min: viewModel.min,
                max: viewModel.max,
                initialValue: viewModel.value,
              )),
        ),
      ),
    );
  }
}
class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll('#', '');
    if (hexColor.length == 6) {
      hexColor = 'FF' + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}


/// Example 03
final customWidth03 =
    CustomSliderWidths(trackWidth: 1, progressBarWidth: 20, shadowWidth: 50);
final customColors03 = CustomSliderColors(
    trackColor: HexColor('#90E3D0'),
    progressBarColors: [HexColor('#FFC84B'), HexColor('#00BFD5')],
    shadowColor: HexColor('#5FC7B0'),
    shadowMaxOpacity: 0.05);

final info03 = InfoProperties(
    bottomLabelStyle: TextStyle(
        color: HexColor('#002D43'), fontSize: 20, fontWeight: FontWeight.w700),
    bottomLabelText: 'Goal',
    mainLabelStyle: TextStyle(
        color: Color.fromRGBO(97, 169, 210, 1),
        fontSize: 30.0,
        fontWeight: FontWeight.w200),
    modifier: (double value) {
      final kcal = value.toInt();
      return '$kcal kCal';
    });
final CircularSliderAppearance appearance03 = CircularSliderAppearance(
    customWidths: customWidth03,
    customColors: customColors03,
    infoProperties: info03,
    size: 250.0,
    startAngle: 180,
    angleRange: 340);
final viewModel03 = ExampleViewModel(
    appearance: appearance03,
    min: 500,
    max: 2300,
    value: 1623,
    pageColors: [HexColor('#D9FFF7'), HexColor('#FFFFFF')]);
final example03 = ExamplePage(
  viewModel: viewModel03,
);

/// Example 05
final customWidth05 =
CustomSliderWidths(trackWidth: 1, progressBarWidth: 15, shadowWidth: 20);
final customColors05 = CustomSliderColors(
    trackColor: HexColor('#93a5cf'),
    progressBarColors: [Colors.lightGreenAccent, Colors.lightGreen, Colors.green, Colors.teal, Colors.tealAccent, ],
    shadowColor: HexColor('#5FC7B0'),
    shadowMaxOpacity: 0.05);


final info05 = InfoProperties(
    topLabelStyle: TextStyle(
        color: Colors.white, fontSize: 17, fontWeight: FontWeight.w600),
    topLabelText: 'Consuming',
    mainLabelStyle: TextStyle(
        color: Colors.white, fontSize: 2.0, fontWeight: FontWeight.w200),
      bottomLabelText: '20 kWh',
    bottomLabelStyle: TextStyle(
        color: Colors.white, fontSize: 12.0, fontWeight: FontWeight.w400),
    modifier: (double value) {
//      final time = printDuration(Duration(seconds: value.toInt()));
//        int consumption = 20;
      return '';
    }
    );
final CircularSliderAppearance appearance05 = CircularSliderAppearance(
    customWidths: customWidth05,
    customColors: customColors05,
    infoProperties: info05,
    startAngle: 270,
    angleRange: 360,
    size: 150.0);
final viewModel05 = ExampleViewModel(
    appearance: appearance05,
    min: 0,
    max: 27,
    value: 20,
    pageColors: [Colors.black, Colors.black87]);
final example05 = ExamplePage(
  viewModel: viewModel05,
);

String printDuration(Duration duration) {
  String twoDigits(int n) {
    if (n >= 10) return "$n";
    return "0$n";
  }

  String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
  String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
  return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
}

class EnergySlider extends StatefulWidget {
  EnergySlider({Key key}) : super(key: key);

  _EnergySliderState createState() => _EnergySliderState();
}

class _EnergySliderState extends State<EnergySlider> {
  final controller = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: PageView(
      controller: controller,
      children: <Widget>[

        example05,
        example03,


      ],
    ));
  }
}

double degreeToRadians(double degree) {
  return (math.pi / 180) * degree;
}
