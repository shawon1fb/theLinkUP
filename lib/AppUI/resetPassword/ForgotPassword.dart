import 'package:flutter/material.dart';
import 'package:the_link_up/Api/ForgotPassworsApi.dart';
import 'package:the_link_up/Component/Email_Inpute.dart';
import 'package:the_link_up/Component/Password_Input.dart';
import 'package:the_link_up/Component/WhiteButton.dart';
import 'package:the_link_up/Constant/APP_Gradient.dart';
import 'package:toast/toast.dart';

import '../WaitingPopUp.dart';
import 'ResetPassword.dart';

class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final widgetDistance = 10.0;
  FocusNode emailNode = FocusNode();
  FocusNode passWordNode = FocusNode();
  GlobalKey<FormState> formKey = GlobalKey<FormState>(debugLabel: 'reset');
  bool waitingFlag = false;
  String Email = null;

  void setVisibility(bool b) {
    setState(() {
      waitingFlag = b;
    });
  }

  void resetPassword() async {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      setVisibility(true);
      try {
        print(
            "From Forget Password ==========================================");
        print(Email);
        var response = await ForgotPasswordApi().callForgotPasswordApi(Email);
        bool b = response['success'];
        setVisibility(false);
        makeToast(context, response['message'].toString());
        if (b) {
          /// todo nevegation to new page
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => ResetPassword(
                      email: Email,
                    )),
          );
        }
      } catch (e) {
        print(e);
      }
      setVisibility(false);
    }
  }

  void makeToast(context, text) {
    Toast.show(
      "$text",
      context,
      duration: Toast.LENGTH_LONG,
      gravity: Toast.CENTER,
    );
  }

  @override
  Widget build(BuildContext context) {
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
                      Container(
                        width: double.infinity,
                        child: Text(
                          'Reset Password',
                          style: Theme.of(context).textTheme.headline,
                        ),
                      ),
                      SizedBox(
                        height: 90,
                      ),

                      Form(
                        key: formKey,
                        child: Container(
                          child: Email_Input(
                            focusNode: emailNode,
                            onSaved: (v) {
                              Email = v.toString();
                            },
                            validator: (input) => !input.contains('@')
                                ? 'Not a valid Email'
                                : null,
                            onFieldSubmitted: (v) {
                              print('from Reset Password ');
                              Email = v.toString();
                              emailNode.unfocus();
                            },
                          ),
                        ),
                      ),

                      /// input : Email Address

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
                          buttonText: "Reset",
                          onPress: resetPassword,
                        ),
                      ),

                      SizedBox(
                        height: 25,
                      ),

                      ///text:New User? Create account
                      Container(
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
                                  style: Theme.of(context)
                                      .textTheme
                                      .body1
                                      .copyWith(
                                          color: Color(0xffFFFFFF),
                                          fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Visibility(
              visible: waitingFlag,
              child: WaitingPopUp(),
            ),
          ],
        ),
      ),
    );
  }
}
