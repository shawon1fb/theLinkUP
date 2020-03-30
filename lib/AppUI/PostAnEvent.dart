import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_link_up/Component/BasicTimeField.dart';
import 'package:the_link_up/Component/CustomAppBar.dart';
import 'package:the_link_up/Component/DatePicker.dart';
import 'package:the_link_up/Component/DropDownList.dart';
import 'package:the_link_up/Component/Email_Inpute.dart';
import 'package:the_link_up/Component/SqureBox.dart';
import 'package:the_link_up/Component/WhiteButton.dart';
import 'package:the_link_up/Constant/APP_Gradient.dart';
import 'package:the_link_up/Controller/PostAnEventController.dart';
import 'package:the_link_up/Fcm/FcmController.dart';

import 'Events.dart';
import 'LeftDrawer.dart';
import 'WaitingPopUp.dart';

class PostAnEvent extends StatefulWidget {
  @override
  _PostAnEventState createState() => _PostAnEventState();
}

class _PostAnEventState extends State<PostAnEvent> {
  final String activityPage = 'PostAnEventPage';
  final widgetDistance = 10.0;
  FocusNode locationNode;
  FocusNode descriptionNode;
  String dropdownValue = 'Party';
  List<String> dropDownList = [
    'Party',
    'Chill',
    'Meet and greet',
    'Food',
    'Other'
  ];
  var listInInt = {
    'Party': 1,
    'Chill': 2,
    'Meet and greet': 3,
    'Food': 4,
    'Other': 5,
  };

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    locationNode = new FocusNode();
    descriptionNode = new FocusNode();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FocusScope.of(context).requestFocus(locationNode);
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    locationNode.dispose();
    descriptionNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<PostAnEventController>(context);
    return Scaffold(
      drawer: LeftDrawer(context, activityPage),
      backgroundColor: Color(0xffF84C88),
      appBar:
          appBar(context: context, title: "What's Going On", newMessage: FcmController.newMessage),
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            Container(
              child: Column(
                children: <Widget>[
                  SqureBox(
                    image: appState.image,
                    onTap: () {
                      appState.newShowModalSheet(context);
                    },
                  ),
                  Expanded(
                    child: Container(
                      // height: double.infinity,
                      padding: EdgeInsets.only(left: 25.0, right: 25.0),
                      decoration: BoxDecoration(
                        gradient: backgroundLinearGradient,
                      ),
                      child: Align(
                        //  alignment: Alignment(0.0, -0.5),
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              SizedBox(
                                height: widgetDistance,
                              ),

                              Form(
                                key: appState.formKey,
                                child: Column(
                                  children: <Widget>[
                                    /// input : Location
                                    Container(
                                      child: Email_Input(
                                        focusNode: locationNode,
                                        hint: 'Location',
                                        onSaved: (v) {
                                          appState.activity = v.toString();
                                        },
                                        validator: (input) => input == null
                                            ? "Feild can't be empty"
                                            : null,
                                        prefixIconData: Icons.location_on,
                                        onFieldSubmitted: (v) {
                                          locationNode.unfocus();
                                          descriptionNode.requestFocus();
                                        },
                                      ),
                                    ),

                                    SizedBox(
                                      height: widgetDistance + 12,
                                    ),
                                    //dropDown List
                                    Container(
                                      child: DropDownList(
                                        itemList: dropDownList,
                                        dropdownValue: dropdownValue,
                                        onChanged: (v) {
                                          setState(() {
                                            dropdownValue = v.toString();
                                            appState.people =
                                                listInInt['$dropdownValue'];
                                          });
                                        },
                                      ),
                                    ),

                                    SizedBox(
                                      height: widgetDistance,
                                    ),

                                    /// input : Description
                                    Container(
                                      child: Email_Input(
                                        focusNode: descriptionNode,
                                        hint: 'Description',
                                        prefixIconData: Icons.description,
                                        onSaved: (v) {
                                          appState.body = v.toString();
                                        },
                                        validator: (input) => input == null
                                            ? "Feild can't be empty"
                                            : null,
                                        onFieldSubmitted: (v) {
                                          descriptionNode.unfocus();
                                          //descriptionNode.requestFocus();
                                        },
                                      ),
                                    ),

                                    SizedBox(
                                      height: widgetDistance,
                                    ),

                                    DatePicker(
                                      hint: 'Event Date',
                                    ),

                                    SizedBox(
                                      height: widgetDistance,
                                    ),
                                    //Start Time
                                    BasicTimeField(
                                      hintText: "Event Time",
                                    ),

                                    SizedBox(
                                      height: widgetDistance,
                                    ),
                                    //End Time
                                    /*        BasicTimeField(
                                      hintText: 'End Time',
                                    ),
                                    SizedBox(
                                      height: 30,
                                    ),*/
                                  ],
                                ),
                              ),

                              ///Button: Sign in
                              Container(
                                child: WhiteButton(
                                  onPress: () {
                                    appState.postEventButton(context);
                                  },
                                  buttonText: "Post",
                                ),
                              ),
                              SizedBox(
                                height: widgetDistance,
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
