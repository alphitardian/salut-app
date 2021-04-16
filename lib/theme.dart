import 'package:flutter/material.dart';

Color mainColor = Color(0xFFfdd835);
Color mainLightColor = Color(0xFFffff6b);
Color mainDarkColor = Color(0xFFc6a700);
Color secondaryColor = Color(0xFFffa726);
Color secondaryLightColor = Color(0xFFffd95b);
Color secondaryDarkColor = Color(0xFFc77800);

// Text
TextStyle kAppBarrTextStyle = TextStyle(
  color: Colors.black,
  fontWeight: FontWeight.bold,
);
TextStyle kInfoTextStyle = TextStyle(
  fontSize: 14,
  fontStyle: FontStyle.italic,
  color: Colors.grey,
);

//Button
ButtonStyle kElevatedButtonStyle = ElevatedButton.styleFrom(
  padding: EdgeInsets.all(16),
  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
  primary: secondaryColor,
  onPrimary: Colors.white,
);

ButtonStyle kOutlineButtonStyle = OutlinedButton.styleFrom(
  padding: EdgeInsets.all(16),
  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
  primary: secondaryColor,
);
