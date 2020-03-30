import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class WaitingPopUp extends StatefulWidget {
  @override
  _WaitingPopUpState createState() => _WaitingPopUpState();
}

class _WaitingPopUpState extends State<WaitingPopUp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent.withOpacity(0.3),
      body: SafeArea(
        child: Container(
          child: Center(
            child: SpinKitDoubleBounce(
              color: Color(0xffFD8E73),
              size: 150.0,
            ),
          ),
        ),
      ),
    );
  }
}
