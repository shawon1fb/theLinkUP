import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_link_up/AppUI/PostAnEvent.dart';
import 'package:the_link_up/Component/Email_Inpute.dart';
import 'package:the_link_up/Component/Password_Input.dart';
import 'package:the_link_up/Component/WhiteButton.dart';
import 'package:the_link_up/Constant/APP_Gradient.dart';
import 'package:the_link_up/Constant/AppTextStyle.dart';
import 'package:the_link_up/Constant/Constant_Color.dart';
import 'package:the_link_up/Controller/LoginController.dart';
import 'package:the_link_up/Fcm/FcmController.dart';

import 'Register.dart';
import 'resetPassword/ForgotPassword.dart';
import 'WaitingPopUp.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final widgetDistance = 10.0;
  FocusNode emailNode;
  FocusNode passWordNode;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    emailNode = new FocusNode();
    passWordNode = new FocusNode();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FocusScope.of(context).requestFocus(emailNode);
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailNode.dispose();
    passWordNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<LoginController>(context);
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
                          'Log In',
                          style: Theme.of(context).textTheme.headline,
                        ),
                      ),
                      SizedBox(
                        height: widgetDistance,
                      ),

                      ///text: we miss you
                      Container(
                        width: double.infinity,
                        child: Text(
                          'We missed you!',
                          style: Theme.of(context).textTheme.title,
                        ),
                      ),
                      SizedBox(
                        height: 50,
                      ),

                      Form(
                        key: appState.formKey,
                        child: Column(
                          children: <Widget>[
                            /// input : Email Address
                            Container(
                              child: Email_Input(
                                focusNode: emailNode,
                                onSaved: (v) {
                                  appState.email = v.toString();
                                },
                                validator: (input) => !input.contains('@')
                                    ? 'Not a valid Email'
                                    : null,
                                onFieldSubmitted: (v) {
                                  print('from login');
                                  appState.email = v.toString();
                                  emailNode.unfocus();
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
                                  appState.password = v.toString();
                                },
                                onSaved: (v) {
                                  appState.password = v.toString();
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
                          onPress: () {
                            appState.loginButton(context);
                          },
                          buttonText: "Login",
                        ),
                      ),
                      SizedBox(
                        height: 35,
                      ),

                      ///text: forgot password
                      Container(
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            highlightColor: buttonHorColor,
                            borderRadius: BorderRadius.circular(10),
                            onHover: (v) {
                              print('On hover ================');
                              print(v.toString());
                            },
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ForgotPassword(),
                                ),
                              );
                            },
                            child: Text(
                              'Forgot Password?',
                              style: Theme.of(context).textTheme.body1,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),

                      ///text:New User? Create account
                      Container(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text('New User?'),
                            Material(
                              color: Colors.transparent,
                              child: InkWell(
                                highlightColor: buttonHorColor,
                                borderRadius: BorderRadius.circular(10),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Register(),
                                    ),
                                  );
                                },
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
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 35,
                      ),

                      /// Button: Login with Facebook
                      Container(
                        child: WhiteButton(
                          buttonText: "Login with Facebook",
                          backgroundColor: Color(0xff4267B2),
                          textColor: Colors.white,
                          //  onPress: (){},
                        ),
                      ),
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
