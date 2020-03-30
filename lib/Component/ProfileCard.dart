import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:the_link_up/Api/GetNearByPostApi.dart';
import 'package:the_link_up/AppUI/Chats.dart';
import 'package:the_link_up/Constant/APP_Gradient.dart';

import 'ConnectButton.dart';
import 'CustomCardView.dart';
import 'CustomNetworkImageViewer.dart';
import 'CustomeEmptyCard.dart';
import 'RoundButton.dart';

class ProfileCard extends StatefulWidget {
  ProfileCard({
    this.address,
    this.imageUrl,
    this.userName,
    this.onPress,
  });

  final String imageUrl;
  final String userName;
  final String address;
  final Function onPress;

  @override
  _ProfileCardState createState() => _ProfileCardState();
}

class _ProfileCardState extends State<ProfileCard> {
  @override
  Widget build(BuildContext context) {
    var SkinHeight = MediaQuery.of(context).size.height;
    return Container(
      child: InkWell(
        onTap: widget.onPress,
        child: Container(
          child: Stack(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(left: 5, right: 5),
                child: Stack(
                  children: <Widget>[
                    Align(
                      alignment: Alignment(0, -1),
                      child: CustomCardView(
                        elevation: 5,
                        borderRadius: 10,
                        child: CustomNetworkImageViewer(
                          height: 360,
                          boxFit: BoxFit.fitHeight,
                          borderRadius: 10,
                          url: '${widget.imageUrl}',
                        ),
                      ),
                    ),

                    ///============
                    Positioned(
                      // alignment: Alignment(0, 0),
                      top: 265,
                      child: CustomCardView(
                        borderRadius: 10,
                        elevation: 0,
                        child: Container(
                          height: 120,
                          width: MediaQuery.of(context).size.width * .98,
                          //color: Colors.white,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Color(0xffFFFBFB),
                            //  color: Colors.red
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(10),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  '${widget.userName}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline
                                      .copyWith(color: Colors.black),
                                ),
                                Text(
                                  widget.address.length > 100
                                      ? widget.address.substring(0, 99) +
                                          ". . ."
                                      : widget.address,
                                  style: Theme.of(context)
                                      .textTheme
                                      .subhead
                                      .copyWith(
                                        color: Colors.black.withOpacity(0.5),
                                      ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BackgroundWhiteCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var SkinHeight = MediaQuery.of(context).size.height;
    return Container(
      child: Align(
        alignment: Alignment(0, 1),
        child: Container(
          color: Color(0xffF4F3F3),
          height: SkinHeight * .4,
        ),
      ),
    );
  }
}

class ProfileBottomButton extends StatelessWidget {
  ProfileBottomButton({
    this.crossButton,
    this.connectButton,
    this.loveButton,
    this.connectButtonText,
  });

  final Function crossButton;
  final Function connectButton;
  final String connectButtonText;
  final Function loveButton;

  @override
  Widget build(BuildContext context) {
    return Container(
      child:

          /// bottom button
          Align(
        alignment: Alignment(0, .95),
        child: Container(
          // color: Colors.white,
          height: 80,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              //Button : cross button
              RoundButton(
                onPress: crossButton,
                iconData: Icons.arrow_back_ios,
                gradient: leftToRightLinearGradient,
                boxSize: 70.0,
                iconSize: 40,
              ),

              //Sutton : sync Button
              /* RoundButton(
                onPress: syncButton,
                iconData: FontAwesomeIcons.sync,
                iconColor: Color(0xff535252),
                backgroundColor: Colors.white,
                boxSize: 40.0,
                iconSize: 20,
              ),*/
              ConnectButton(
                backgroundColor: connectButtonText == 'connect'
                    ? Colors.white
                    : Colors.deepOrange,
                onPress: connectButton,
                buttonText: connectButtonText,
              ),
              // Button : love button
              RoundButton(
                onPress: loveButton,
                iconData: Icons.arrow_forward_ios,
                gradient: leftToRightLinearGradient,
                boxSize: 70.0,
                iconSize: 40,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

//