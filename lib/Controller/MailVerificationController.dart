import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:the_link_up/Api/verifiEmailApi.dart';
import 'package:the_link_up/AppUI/LoginPage.dart';
import 'package:toast/toast.dart';

class MailVerificationController with ChangeNotifier {
  final formKey = GlobalKey<FormState>();
  final storage = new FlutterSecureStorage();
  String verificationCode = r"";
  verifiEmailApi api = new verifiEmailApi();
  String email, code;
  bool waitingFlag = false;

  bool isEmail(String em) {
    String p =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = new RegExp(p);

    return regExp.hasMatch(em);
  }

  void makeToast(context, text) {
    Toast.show("$text", context,
        duration: Toast.LENGTH_LONG, gravity: Toast.CENTER);
  }

  void _submit(context) async {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      email = await storage.read(key: 'email');
      // email = 'admin4@admin.com';
      // code = '408366';
      print('Email verifation =================');
      print(email);
      print(code);

      waitingFlag = true;
      notifyListeners();
      var body = await api.CallVerifiEmailApi(email, code);
      waitingFlag = false;
      notifyListeners();

      print('Mail Verify Api from controller ::::');
      print(body);
      if (body != null) {
        bool success = body['success'];
        if (success) {
          print("Api call Successfull ...");
          await storage.write(key: 'email', value: email);
          // navigate route
          /*Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => LoginPage()),
              (Route<dynamic> route) => false);*/
          Navigator.pop(context);
        } else {
          makeToast(context, body['message'].toString());
        }
      } else {
        makeToast(context, 'Network Problem.');
      }
    }
  }

  void confirmButton(context) {
    _submit(context);
    /*Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => LoginPage(),
      ),
    );*/
  }
}
