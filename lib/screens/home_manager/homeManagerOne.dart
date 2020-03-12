import 'package:flutter/material.dart';

class Red extends StatefulWidget {
  @override
  _RedState createState() => _RedState();
}

class _RedState extends State<Red> {
  @override

  String title = 'Red';

  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
    );
  }
}