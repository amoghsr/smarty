
/*
This file stores styling for some of the components needed in the UI
 */

import 'package:flutter/material.dart';

const kNavigationBarTextStyle = TextStyle(
  fontSize: 11,
);

const kAppBarTextStyle = TextStyle(
  fontSize: 16,
);

const kLightDeviceTopBar = TextStyle(
  fontFamily: 'Montserrat',
  color: Colors.white,
  fontSize: 11,
);

const kLightDeviceBottomBar = TextStyle(
  fontFamily: 'Montserrat',
  fontWeight: FontWeight.w800,
  fontSize: 22,
);

const kTextInputDecoration = InputDecoration(
  filled: true,
  contentPadding: EdgeInsets.all(12.0),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.white, width: 2.0),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.pink, width: 2.0),
  ),
);