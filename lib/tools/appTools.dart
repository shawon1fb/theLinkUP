import 'package:flutter/material.dart';

showSnackBar(String message, final scaffoldKey) {
  scaffoldKey.currentState.showSnackBar(new SnackBar(
    backgroundColor: Colors.red[600],
    behavior: SnackBarBehavior.floating,
    content: new Text(
      message,
      style: new TextStyle(color: Colors.white),
    ),
  ));
}


showSnackBarWithButton(
    String message, String label, Function onPress, final scaffoldKey) {
  scaffoldKey.currentState.showSnackBar(new SnackBar(
    backgroundColor: Colors.red[600],
    behavior: SnackBarBehavior.floating,
    content: new Text(
      message,
      style: new TextStyle(color: Colors.white),
    ),
    action: SnackBarAction(
      label: label,
      onPressed: onPress,
    ),
  ));
}
