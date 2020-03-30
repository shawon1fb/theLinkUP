import 'package:flutter/material.dart';
import 'package:the_link_up/Api/UpdateFcmToken.dart';
import 'package:the_link_up/AppUI/Events.dart';
import 'package:the_link_up/Fcm/FcmController.dart';
import 'package:the_link_up/Helper/StaticMemory.dart';
import '../Api/LoginApi.dart';
import 'package:toast/toast.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LoginController with ChangeNotifier {
  GlobalKey<FormState> formKey = GlobalKey<FormState>(debugLabel: 'Backdrop');
  final storage = new FlutterSecureStorage();
  String email, password;
  static BuildContext context;
  LoginApi lg;
  bool waitingFlag = false;

  LoginController() {
    print('Login Controller Created');
  }

  void _submit(context) async {
    lg = LoginApi();

    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      print('login details :::::');
      print(email);
      print(password);
      waitingFlag = true;
      notifyListeners();
      var body = await lg.callLogin(email, password);
      waitingFlag = false;
      notifyListeners();

      if (body == null) {
        Toast.show("Network Problem", context,
            duration: Toast.LENGTH_LONG,
            gravity: Toast.CENTER,
            backgroundColor: Colors.red);
        return;
      }

      bool success = body['success'];

      print(StaticTempMemory.userName);
      if (success) {
        String token = body['token'];
        String userName = body['user']['name'];
        StaticTempMemory.userName = userName;
        print('=================== token =================');
        print(token);

        await storage.write(key: 'token', value: token);
        await storage.write(key: 'userName', value: userName);
        print('rout successfull');
        try {
          UpdateFcmTokenApi fcmTokenApi = new UpdateFcmTokenApi();
          var fcmToken = await FcmController().getFcmToken();
          print(
              "fcmToken in Login :::::::::::::::::::::::::::::::::::::::::::::");
          print(fcmToken);
          fcmTokenApi.callUpdateFcmTokenApi(token, fcmToken);
        } catch (e) {
          print("FCM Execption Login page =============================");
          print(e);
        }
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => EventsPage()));
      } else {
        Toast.show("Username or Password Incorrect.", context,
            duration: Toast.LENGTH_LONG, gravity: Toast.CENTER);
      }
    }
    notifyListeners();
  }

  void loginButton(context) {
    _submit(context);
  }
}
