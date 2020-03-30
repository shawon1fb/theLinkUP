import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart' as l;
import 'package:the_link_up/Api/postAnEventApi.dart';
import 'package:geolocator/geolocator.dart';
import 'package:the_link_up/AppUI/Events.dart';
import 'package:toast/toast.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:app_settings/app_settings.dart';

class PostAnEventController with ChangeNotifier {
  File image;
  final storage = new FlutterSecureStorage();
  var filePath, body, lat, lng, activity, plus, token;
  final formKey = GlobalKey<FormState>();
  var people = 1;
  bool waitingFlag = false;

  void makeToast(context, text) {
    Toast.show("$text", context,
        duration: Toast.LENGTH_LONG, gravity: Toast.CENTER);
  }

  PostAnEventController() {
    getlocation();
  }

  void getlocation() async {
    var location = new l.Location();
    bool lo = await location.serviceEnabled();
    bool requestService = await location.requestService();

    try {
      Position position = await Geolocator()
          .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    } catch (e) {
      print("location execption ::::::");
      print(e);
    }
    GeolocationStatus geolocationStatus =
        await Geolocator().checkGeolocationPermissionStatus();
    bool isLocationEnabled = await Geolocator().isLocationServiceEnabled();
    print('==================================================');
    print("isLocationEnabled ::::::::");
    print(isLocationEnabled);
    print("======");
    print(geolocationStatus);

    if (geolocationStatus == GeolocationStatus.granted) {
      print("permision Greanted");
    } else {
      AppSettings.openLocationSettings();
    }
  }

  void Submit(context) async {
    Position position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    var defoultToken =
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1aWQiOjQxLCJpYXQiOjE1ODE3NjgxMDR9.QhZP34rzFh0J2k-lixRf5pl6hVlkBEKP486VMorDoK8';
    String value = await storage.read(key: 'token');
    if (value == null) {
      print('user not authintatic');
      Navigator.of(context).pop();
      return;
    }
    //value = value == null ? "$defoultToken" : value;

    print('token :: $value');
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      lat = position.latitude.toString();
      lng = position.longitude.toString();
      if (image != null) {
        filePath = image.path;
      } else {
        makeToast(context, 'Image Not Selected.');
        return;
      }
      plus = 'true';

      /// should be updated
      if (people > 2) {
        plus = 'true';
      }
      token = value;
      print(filePath);
      print(body);
      print(lat);
      print(lng);
      print(people);
      print(plus);
      print(token);
    }

    waitingFlag = true;
    notifyListeners();
    PostAnEventApi api = new PostAnEventApi();
    var jsonBody = await api.callPostEventApi(
        filePath, body, lat, lng, activity, people, plus, token);

    waitingFlag = false;
    notifyListeners();

    print('=====Form Submit =======');
    print('Json Body ::::');
    print(jsonBody);
    if (jsonBody != null) {
      bool success = jsonBody['success'];
      print(success);
      if (success == true) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => EventsPage(),
          ),
        );
      } else {
        makeToast(context, jsonBody['message'].toString());
      }
    } else {
      makeToast(context, 'Network Problem');
    }
  }

  void postEventButton(context) async {
    print('event button pressed =============');

    Submit(context);
  }

  ///====================Image Section ========================

  Future<File> croppedImage(File imagee) async {
    File croppedFile = await ImageCropper.cropImage(
        sourcePath: imagee.path,
        aspectRatioPresets: [
          /*CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.ratio4x3,*/
          CropAspectRatioPreset.ratio16x9,
        ],
        androidUiSettings: AndroidUiSettings(
          toolbarTitle: 'Cropper',
          toolbarColor: Colors.deepOrange,
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.ratio16x9,
          lockAspectRatio: true,
        ),
        iosUiSettings: IOSUiSettings(
          minimumAspectRatio: 1.0,
        ));
    print("=================Croped Image Size=========================");
    print(croppedFile.lengthSync());

    return croppedFile;
  }

  Future getImageGallery(context) async {
    var imagee = await ImagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 50);
    image = imagee;

    print("=================Initial  Image Size=========================");
    print(imagee.lengthSync());
    print("=================Orginal  Image Size=========================");
    print(image.lengthSync());
    notifyListeners();
    image = await croppedImage(imagee);

    Navigator.of(context).pop();
  }

  Future getImage(context) async {
    var imagee = await ImagePicker.pickImage(
        source: ImageSource.camera, imageQuality: 50);
    image = await croppedImage(imagee);
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
}
