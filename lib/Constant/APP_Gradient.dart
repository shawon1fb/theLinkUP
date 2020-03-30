import 'package:flutter/material.dart';

final backgroundLinearGradient = LinearGradient(
  // Where the linear gradient begins and ends
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
  // Add one stop for each color. Stops should increase from 0 to 1
  stops: [0.3, /*0.3, 0.5, 0.7,*/ 0.7],
  colors: [
    // Colors are easy thanks to Flutter's Colors class.
    Color(0xffFD8E73), //lightOrange
    /*Color(0xffFF617E).withOpacity(0.6), //deepOrange
    Color(0xffFF617E).withOpacity(0.8), //deepOrange
    Color(0xffFF617E).withOpacity(0.9), //deepOrange*/
    Color(0xffFF617E), //deepOrange
  ],
);
final leftToRightLinearGradient = LinearGradient(
  // Where the linear gradient begins and ends
  begin: Alignment.centerLeft,
  end: Alignment.centerRight,
  // Add one stop for each color. Stops should increase from 0 to 1
  stops: [0.1, 0.9],
  colors: [
    // Colors are easy thanks to Flutter's Colors class.
    Color(0xffFF617E), //deepOrange
    Color(0xffFD8E73), //lightOrange
  ],
);
