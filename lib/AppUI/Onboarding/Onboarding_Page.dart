import 'package:flutter/material.dart';
import 'package:the_link_up/Constant/RestrudentAppConstatant.dart';

class onBoardingPage extends StatelessWidget {

  onBoardingPage({this.imagePath,this.header,this.body});
  final imagePath;
  final header;
  final body;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Center(
              child: Padding(
                padding: EdgeInsets.only(
                    left: 30.0, right: 30.0,  bottom: 60.0),
                child: Image(
                  image: AssetImage('$imagePath'),
                ),
              ),
            ),
          ),
          Expanded(
              child: Container(
                child: Padding(
                  padding: EdgeInsets.only(left: 15.0, right: 15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        '$header',
                        style: KOnboarding_Header,
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        '$body',
                        textAlign: TextAlign.center,
                        style: KOnboard_body,
                      ),
                    ],
                  ),
                ),
              ))
        ],
      ),
    );
  }
}