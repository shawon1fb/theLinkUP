import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:geolocator/geolocator.dart';
import 'package:the_link_up/Api/GetNearByPostApi.dart';
import 'package:toast/toast.dart';

class EventsController with ChangeNotifier {
  var controller = new PageController();

  var page, limit, lat, lng, token;
  final storage = new FlutterSecureStorage();

  void nextPage() {
    controller.nextPage(
        duration: Duration(milliseconds: 10), curve: Curves.easeInOut);
  }

  void previousPage() {
    controller.previousPage(
        duration: Duration(milliseconds: 10), curve: Curves.easeInOut);
  }

  void makeToast(context, text) {
    Toast.show("$text", context,
        duration: Toast.LENGTH_LONG, gravity: Toast.CENTER);
  }

  void callProfile(context) async {
    GetNearByPostApi Api = new GetNearByPostApi();
    String value = await storage.read(key: 'token');
    if (value == null) {
      print('user not authintatic');
      Navigator.of(context).pop();
      return;
    }
    Position position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    page = 1;
    limit = 10;
    lat = position.latitude;
    lng = position.latitude;
    token = value;
    Api.callGetNearByPostApi(page, limit, lat, lng, token);
  }

  void previousButton(context) {
    previousPage();
  }

  void nextButton(context) {
    nextPage();
  }
}
