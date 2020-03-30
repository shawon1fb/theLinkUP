import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_link_up/Component/Email_Inpute.dart';
import 'package:the_link_up/Component/WhiteButton.dart';
import 'package:the_link_up/Constant/APP_Gradient.dart';
import 'package:the_link_up/Controller/MailVerificationController.dart';

import 'LoginPage.dart';
import 'WaitingPopUp.dart';

class MailVerification extends StatefulWidget {
  @override
  _MailVerificationState createState() => _MailVerificationState();
}

class _MailVerificationState extends State<MailVerification> {
  final widgetDistance = 10.0;
  FocusNode emailNode = FocusNode();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    emailNode = new FocusNode();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FocusScope.of(context).requestFocus(emailNode);
    });
  }

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<MailVerificationController>(context);
    return Scaffold(
      backgroundColor: Color(0xffF84C88),
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            Container(
              height: double.infinity,
              padding: EdgeInsets.only(left: 25.0, right: 25.0),
              decoration: BoxDecoration(
                gradient: backgroundLinearGradient,
              ),
              child: Align(
                alignment: Alignment(0.0, -0.5),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      ///text: Confirm mail
                      Container(
                        width: double.infinity,
                        child: Text(
                          'Confirm Mail',
                          style: Theme.of(context).textTheme.headline,
                        ),
                      ),
                      SizedBox(
                        height: 90,
                      ),

                      /// input : Email Address
                      Form(
                        key: appState.formKey,
                        child: Container(
                          child: Email_Input(
                            keyboardType: TextInputType.number,
                            onSaved: (v) {
                              appState.code = v.toString();
                            },
                            focusNode: emailNode,
                            hint: 'Auth  Code',
                            onFieldSubmitted: (v) {
                              emailNode.unfocus();
                            },
                          ),
                        ),
                      ),

                      SizedBox(
                        height: widgetDistance,
                      ),
                      SizedBox(
                        height: widgetDistance,
                      ),
                      SizedBox(
                        height: widgetDistance,
                      ),
                      SizedBox(
                        height: widgetDistance * 0.5,
                      ),

                      ///Button: Reset button
                      Container(
                        child: WhiteButton(
                          onPress: () {
                            appState.confirmButton(context);
                          },
                          buttonText: "Confirm",
                        ),
                      ),

                      SizedBox(
                        height: 25,
                      ),

                      ///text:New User? Create account
                      /*   Container(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text('or'),
                            InkWell(
                              onTap: () {},
                              child: Container(
                                child: Text(
                                  ' Create account',
                                  style: Theme.of(context).textTheme.body1.copyWith(
                                      color: Color(0xffFFFFFF),
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )*/
                    ],
                  ),
                ),
              ),
            ),
            Visibility(
              visible: appState.waitingFlag,
              child: WaitingPopUp(),
            ),
          ],
        ),
      ),
    );
  }
}
