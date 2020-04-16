import 'package:flutter/material.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

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

String printDuration(Duration duration) {
  String twoDigits(int n) {
    if (n >= 10) return "$n";
    return "0$n";
  }
}

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

final customWidth05 =
    CustomSliderWidths(trackWidth: 4, progressBarWidth: 45, shadowWidth: 70);
final customColors05 = CustomSliderColors(
    dotColor: HexColor('#FFB1B2'),
    trackColor: HexColor('#E9585A'),
    progressBarColors: [HexColor('#FB9967'), HexColor('#E9585A')],
    shadowColor: HexColor('#FFB1B2'),
    shadowMaxOpacity: 0.05);
final info05 = InfoProperties(
    topLabelStyle: TextStyle(
        color: Colors.white, fontSize: 16, fontWeight: FontWeight.w400),
    topLabelText: 'Elapsed',
    bottomLabelStyle: TextStyle(
        color: Colors.white, fontSize: 16, fontWeight: FontWeight.w400),
    bottomLabelText: 'time',
    mainLabelStyle: TextStyle(
        color: Colors.white, fontSize: 50.0, fontWeight: FontWeight.w600),
    modifier: (double value) {
      final time = printDuration(Duration(seconds: value.toInt()));
      return '$time';
    });
final CircularSliderAppearance appearance05 = CircularSliderAppearance(
    customWidths: customWidth05,
    customColors: customColors05,
    infoProperties: info05,
    startAngle: 270,
    angleRange: 360,
    size: 350.0);
final viewModel05 = ExampleViewModel(
    appearance: appearance05,
    min: 0,
    max: 86400,
    value: 67459,
    pageColors: [Colors.black, Colors.black87]);
