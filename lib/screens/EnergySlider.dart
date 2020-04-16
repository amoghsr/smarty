import 'package:flutter/material.dart';

import 'dart:math' as math;
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

import 'package:flutter/material.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

double currCons = 23;
double currGen = 30;
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
  // final double currCons = 20;
  // final double currGen = 30;

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
    CustomSliderWidths(trackWidth: 1, progressBarWidth: 13, shadowWidth: 10);
final customColors03 = CustomSliderColors(
    trackColor: HexColor('#93a5cf'),
    progressBarColors: [HexColor('#13547a'), HexColor('#80d0c7')],
    shadowColor: HexColor('#5FC7B0'),
    shadowMaxOpacity: 0.05);



final info03 = InfoProperties(
    topLabelStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
    topLabelText: 'Consumed',
    mainLabelStyle: TextStyle(fontSize: 11.0, fontWeight: FontWeight.w400),

    modifier: (double value) {
//      final time = printDuration(Duration(seconds: value.toInt()));
//        int consumption = 20;
      return '$currCons kWh';
    });
final CircularSliderAppearance appearance03 = CircularSliderAppearance(
  customWidths: customWidth03,
  customColors: customColors03,
  infoProperties: info03,
  size: 150.0,
  startAngle: 270,
  angleRange: 360,
);
final viewModel03 = ExampleViewModel(
    appearance: appearance03,
    min: 0,
    max: 48,
    value: currGen,
    pageColors: [Colors.transparent, Colors.transparent]);
final example03 = ExamplePage(
  viewModel: viewModel03,
);

/// Example 05
final customWidth05 =
    CustomSliderWidths(trackWidth: 1, progressBarWidth: 13, shadowWidth: 10);
final customColors05 = CustomSliderColors(
    trackColor: HexColor('#93a5cf'),
    progressBarColors: [
      Colors.lightGreenAccent,
      Colors.lightGreen,
      Colors.green,
      Colors.teal,
      Colors.tealAccent,
    ],
    shadowColor: HexColor('#5FC7B0'),
    shadowMaxOpacity: 0.05);

final info05 = InfoProperties(
    topLabelStyle: TextStyle(
        color: Colors.white, fontSize: 14, fontWeight: FontWeight.w600),
    topLabelText: 'Generated',
    mainLabelStyle: TextStyle(
        color: Colors.white, fontSize: 11.0, fontWeight: FontWeight.w400),
    modifier: (double value) {
//      final time = printDuration(Duration(seconds: value.toInt()));
//        int consumption = 20;
      return '$currGen kWh';
    });
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
    max: 48,
    value: currCons,
    pageColors: [
      Colors.transparent,
      Colors.transparent,
    ]);
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

double degreeToRadians(double degree) {
  return (math.pi / 180) * degree;
}
