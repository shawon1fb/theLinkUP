import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:the_link_up/Api/RegisterApi.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:the_link_up/Api/RequestVerifyMail.dart';
import 'package:the_link_up/AppUI/MailVerifacation.dart';
import 'package:toast/toast.dart';

class RegisterController with ChangeNotifier {
  final formKey = GlobalKey<FormState>();
  final storage = new FlutterSecureStorage();
  String email, password, name;
  String filePath, fileName;
  int gender = 1;
  File image;
  bool waitingFlag = false;
  RegisterApi ra = new RegisterApi();

  void _submit(context) async {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      print(name);
      print(email);
      print(gender);
      print(password);

      if (image != null) {
        filePath = image.path;
        fileName = image.path.split('/').last;
      } else {
        makeToast(context, 'Image required');
        filePath = '';
        fileName = '';
        return;
      }

      waitingFlag = true;
      notifyListeners();
      var body = await ra.callRegister(
          name, email, password, gender, filePath, fileName);
      waitingFlag = false;
      notifyListeners();
      print("Api called::::::::: ...");
      print(body);
      if (body != null) {
        bool success = body['success'];
        if (success) {
          print("Api call Successfull ...");
          await storage.write(key: 'email', value: email);
          RequestVerifyMail verifyMail = new RequestVerifyMail();
          verifyMail.CallRequestVerifyMail(email);
          // navigate route
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => MailVerification()),
          );
        } else {
          var txt;
          try {
            txt = body['errors'][0]['message'];
          } catch (e) {
            txt = 'something wrong';
          }
          makeToast(context, '$txt');
        }
      } else {
        // alertMessage(context, 'ERROR!!', "Network Problem.");
        makeToast(context, 'Network Problem.');
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
