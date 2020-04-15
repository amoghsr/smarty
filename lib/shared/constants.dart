/*
This file stores styling for some of the components needed in the UI
 */

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const kNavigationBarTextStyle = TextStyle(
  fontSize: 11,
);

const kAppBarTextStyle = TextStyle(
  fontSize: 16,
  fontWeight: FontWeight.bold,
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

const kSubtitleText = TextStyle(
  fontSize: 10,
  fontWeight: FontWeight.w600,
);

const kUserDataText = TextStyle(
  fontSize: 14,
);

const kUserTypeText = TextStyle(
  fontSize: 19,
  fontWeight: FontWeight.w600,
);
