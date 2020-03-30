import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:the_link_up/Api/update_profile_API.dart';
import 'package:the_link_up/tools/appTools.dart';
import 'package:toast/toast.dart';

class ProfilePageController with ChangeNotifier {
  ProfilePageController() {
    print("ProfilePageController created ;;;;;;");
  }

  final formKey = GlobalKey<FormState>();
  final scaffoldKey = new GlobalKey<ScaffoldState>();

  final storage = new FlutterSecureStorage();
  String email, password, name;
  String filePath, fileName, token;
  int gender = 1;
  File image;
  bool waitingFlag = false;

  void _submit(context) async {
    String value = await storage.read(key: 'token');
    if (value == null) {
      print('user not authintatic');
      Navigator.of(context).pop();
      return;
    }

    token = value;

    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      print(name);

      if (image != null) {
        filePath = image.path;
        fileName = image.path.split('/').last;
      } else {
        makeToast(context, 'Image required');
        filePath = '';
        fileName = '';
        return;
      }
      var response;
      try {
        UpdateProfileApi api = new UpdateProfileApi();
        response = await api.callApi(name, filePath, token);
      } catch (e) {
        print("update profile execption ::::");
        print(e);
      }

      if (response != null) {
        showSnackBar(response['message'], scaffoldKey);
      }
    } else {}
  }

  void registerButton(context) async {
    _submit(context);
    waitingFlag = false;
    notifyListeners();

    //ra.checkAuth();

    print("REGISTER BUTTON ::::::::::::::");
  }

  ///====================Image Section ========================

  Future getImageGallery(context) async {
    var _imagee = await ImagePicker.pickImage(source: ImageSource.gallery);
    image = _imagee;
    notifyListeners();
    Navigator.of(context).pop();
  }

  Future getImage(context) async {
    var _imagee = await ImagePicker.pickImage(source: ImageSource.camera);
    image = _imagee;
    notifyListeners();
    Navigator.of(context).pop();
  }

  void newShowModalSheet(BuildContext context) {
    final leftToRightLinearGradient = LinearGradient(
      // Where the linear gradient begins and ends
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
      // Add one stop for each color. Stops should increase from 0 to 1
      stops: [0.1, 0.9],
      colors: [
        // Colors are easy thanks to Flutter's Colors class.
        Color(0xffFD8E73), //lightOrange
        // Color(0xffFF617E).withOpacity(0.9), //deepOrange
        Color(0xffFF617E), //deepOrange
      ],
    );

    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      isDismissible: true,
      context: context,
      builder: (builder) {
        return DraggableScrollableSheet(
          initialChildSize: 0.3,
          maxChildSize: 1,
          minChildSize: 0.25,
          builder: (BuildContext context, ScrollController scrollController) {
            return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
                color: Colors.white,
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: <Widget>[
                    // pick from Gallery
                    Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        gradient: leftToRightLinearGradient,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      width: double.infinity,
                      child: FlatButton(
                        onPressed: () {
                          getImageGallery(context);
                        },
                        child: Center(
                          child: Text(
                            'Pick Image From Gallery',
                            style: Theme.of(context).textTheme.body1.copyWith(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.w700,
                                ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),

                    /// picked from camera
                    Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        gradient: leftToRightLinearGradient,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      width: double.infinity,
                      child: FlatButton(
                        onPressed: () {
                          getImage(context);
                        },
                        child: Center(
                          child: Text(
                            'Capture Image',
                            style: Theme.of(context).textTheme.body1.copyWith(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.w700,
                                ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  void makeToast(context, text) {
    Toast.show("$text", context,
        duration: Toast.LENGTH_LONG, gravity: Toast.CENTER);
  }
}
