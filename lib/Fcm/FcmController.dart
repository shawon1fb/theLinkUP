import 'dart:async';

import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart';
import 'Message.dart';

class FcmController with ChangeNotifier {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  final List<Message> messages = [];
  static bool newMessage = false;

  final storage = new FlutterSecureStorage();
  final streamController = StreamController<String>();
  final messageController = StreamController<bool>();

  Stream<String> get stream => streamController.stream.asBroadcastStream();

  Stream<bool> get newMessageStream =>
      messageController.stream.asBroadcastStream();

  FcmController() {
    print('Fcm Called :::::::::::::::::');
    /*Stream<String> fcmStream = _firebaseMessaging.onTokenRefresh;
    fcmStream.listen((token) {
      // saveToken(token);
      print("FCM TOKEN :::::::::::::::::::::::");
      print(token);
    });*/
    getFcmToken();
    fcmConfig();
  }

  setNewMessage() {
    print("set new Message Called -------->>>>>>-------");
    newMessage = true;
    print(newMessage);
    notifyListeners();
  }

  Future getFcmToken() async {
    var token = await _firebaseMessaging.getToken();
    return token;
  }

  Future GetToken() async {
    String value = await storage.read(key: 'token');
    if (value == null) {
      print('user not authintatic');
      return;
    }
    return value;
  }

  void fcmConfig() {
    print("TEST FCM ::::::::::::::::::::::::::::::::::::::::::::::::");
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("====================<< onMessage >>====================");
        print(" onMessage:---->> $message");
        setNewMessage();
        bool b = true;
        // streamController.sink.add(message['notification']['body'].toString());
        messageController.sink.add(b);

        final notification = message['notification'];
        messages.add(
            Message(title: notification['title'], body: notification['body']));
      },
      onLaunch: (Map<String, dynamic> message) async {
        print("===================<< on Launch >>===================");
        print("onLaunch:---->> $message");
        final notification = message['data'];

        messages.add(Message(
          title: '${notification['title']}',
          body: '${notification['body']}',
        ));
      },
      onResume: (Map<String, dynamic> message) async {
        print("====================<< onResume >>====================");
        print("onResume:-->> $message");
      },
    );
    _firebaseMessaging.requestNotificationPermissions(
        const IosNotificationSettings(sound: true, badge: true, alert: true));
  }
}

//
