import 'package:flutter/material.dart';
import 'package:the_link_up/Api/ResetPasswordApi.dart';
import 'package:the_link_up/Component/Email_Inpute.dart';
import 'package:the_link_up/Component/Password_Input.dart';
import 'package:the_link_up/Component/WhiteButton.dart';
import 'package:the_link_up/Constant/APP_Gradient.dart';
import 'package:the_link_up/Constant/Constant_Color.dart';
import 'package:toast/toast.dart';

import '../WaitingPopUp.dart';

class ResetPassword extends StatefulWidget {
  ResetPassword({
    @required this.email,
  });

  final String email;

  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  bool waitingFlag = false;

  FocusNode authCodeNode = FocusNode();
  FocusNode passWordNode = FocusNode();

  String authCode, password;

  GlobalKey<FormState> formKey = GlobalKey<FormState>(debugLabel: 'reset');

  final widgetDistance = 10.0;

  void submit() async {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      print('$authCode');
      print('$password');
      setVisibility(true);

      try {
        var response = await ResetPasswordApi()
            .callResetPasswordApi(password, authCode, widget.email);
        bool b = response['success'];
        makeToast(context, response['message'].toString());

        if (b) {
          Navigator.pop(context);
        }
      } catch (e) {
        print(e);
      }

      setVisibility(false);
    }
  }
  void setVisibility(bool b) {
    setState(() {
      waitingFlag = b;
    });
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
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      ///text:login
                      Container(
                        width: double.infinity,
                        child: Text(
                          'Reset Password',
                          style: Theme.of(context).textTheme.headline,
                        ),
                      ),
                      SizedBox(
                        height: widgetDistance,
                      ),

                      ///text: we miss you
                      /*     Container(
                        width: double.infinity,
                        child: Text(
                          'We missed you!',
                          style: Theme.of(context).textTheme.title,
                        ),
                      ),
                      SizedBox(
                        height: 50,
                      ),*/

                      Form(
                        key: formKey,
                        child: Column(
                          children: <Widget>[
                            /// input : Email Address
                            Container(
                              child: Email_Input(
                                keyboardType: TextInputType.number,
                                focusNode: authCodeNode,
                                onSaved: (v) {
                                  authCode = v.toString();
                                },
                                hint: 'Code',
                                validator: (input) => input.length < 6
                                    ? 'Not a valid Code'
                                    : null,
                                onFieldSubmitted: (v) {
                                  print('from login');
                                  authCode = v.toString();
                                  authCodeNode.unfocus();
                                  passWordNode.requestFocus();
                                },
                              ),
                            ),
                            SizedBox(
                              height: widgetDistance,
                            ),

                            /// input : password Address
                            Container(
                              child: Password_Inpute(
                                validator: (input) => input.length < 2
                                    ? 'You need at least 2 characters'
                                    : null,
                                onFieldSubmitted: (v) {
                                  print('from password');
                                  password = v.toString();
                                },
                                onSaved: (v) {
                                  password = v.toString();
                                },
                                focusNode: passWordNode,
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(
                        height: 40,
                      ),

                      ///Button: Sign in
                      Container(
                        // color: Colors.green,
                        child: WhiteButton(
                          onPress: submit,
                          buttonText: "Reset",
                        ),
                      ),
                      SizedBox(
                        height: 35,
                      ),
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
