import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:the_link_up/Component/CustomAppBar.dart';
import 'package:the_link_up/Component/Email_Inpute.dart';
import 'package:the_link_up/Component/Password_Input.dart';
import 'package:the_link_up/Component/ReadioButton.dart';
import 'package:the_link_up/Component/RoundImageLoader.dart';
import 'package:the_link_up/Component/WhiteButton.dart';
import 'package:the_link_up/Constant/APP_Gradient.dart';
import 'package:the_link_up/Controller/ProfilePageController.dart';

import 'LeftDrawer.dart';
import 'WaitingPopUp.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final String activityPage = 'updateProfile';
  final widgetDistance = 10.0;
  int gender = 1;
  FocusNode nameNode;

  FocusNode emailNode;

  FocusNode passWordNode;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    nameNode = FocusNode();
    emailNode = new FocusNode();
    passWordNode = new FocusNode();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      FocusScope.of(context).requestFocus(nameNode);
    });
  }

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<ProfilePageController>(context);
    return Scaffold(
      appBar:
          appBar(context: context, title: "activityPage", newMessage: false),
      drawer: LeftDrawer(context, activityPage),
      key: appState.scaffoldKey,
      backgroundColor: Color(0xffF84C88),
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height,
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
                      ///text:Register
                      Container(
                        width: double.infinity,
                        child: Text(
                          'Profile',
                          style: Theme.of(context).textTheme.headline,
                        ),
                      ),
                      SizedBox(
                        height: 35.0,
                      ),

                      /// Round Image
                      RoundImageLoader(
                        image: appState.image,
                        onTap: () {
                          appState.newShowModalSheet(context);
                        },
                      ),

                      Form(
                        key: appState.formKey,
                        child: Column(
                          children: <Widget>[
                            /// Name
                            Container(
                              child: Email_Input(
                                hint: 'Name',
                                prefixIconData: Icons.person,
                                focusNode: nameNode,
                                onSaved: (v) {
                                  appState.name = v.toString();
                                },
                                validator: (input) =>
                                    input == "" ? "Name can't be empty" : null,
                                onFieldSubmitted: (v) {
                                  appState.name = v.toString();
                                  nameNode.unfocus();
                                  emailNode.requestFocus();
                                },
                              ),
                            ),
                            SizedBox(
                              height: widgetDistance,
                            ),

                            /*     ///gender
                            Container(
                              child: Row(
                                children: <Widget>[
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Icon(FontAwesomeIcons.venusMars),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  Text(
                                    'Gender',
                                    style: TextStyle(
                                      color: Colors.white.withOpacity(0.8),
                                      fontSize: 18.0,
                                      fontFamily: 'Quicksand',
                                      fontStyle: FontStyle.normal,
                                    ),
                                  ),
                                ],
                              ),
                            ),*/
                            /*       SizedBox(
                              height: 10,
                            ),
                            Container(
                              child: RadioButton(
                                gender: gender,
                                onChange: (v) {
                                  setState(() {
                                    appState.gender = v;
                                    gender = v;
                                  });
                                },
                              ),
                            ),*/

                            /*  /// input : Email Address
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
                                  appState.email = v.toString();
                                  emailNode.unfocus();
                                  passWordNode.requestFocus();
                                },
                              ),
                            ),*/
                            SizedBox(
                              height: widgetDistance,
                            ),

                            /*   /// input : password Address
                            Container(
                              child: Password_Inpute(
                                focusNode: passWordNode,
                                validator: (input) => input.length < 2
                                    ? 'You need at least 2 characters'
                                    : null,
                                onSaved: (v) {
                                  appState.password = v.toString();
                                },
                                onFieldSubmitted: (v) {
                                  passWordNode.unfocus();
                                },
                              ),
                            ),*/
                          ],
                        ),
                      ),

                      SizedBox(
                        height: 40,
                      ),

                      /// Button: Login with Facebook
                      Container(
                        child: WhiteButton(
                          onPress: () {
                            appState.registerButton(context);
                          },
                          buttonText: "Update",
                          backgroundColor: Color(0xffFFFFFF),
                          textColor: Colors.black,
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
