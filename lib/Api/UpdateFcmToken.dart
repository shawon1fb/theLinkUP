import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'BaseUrl.dart';

class UpdateFcmTokenApi {
  var url = '$baseUrl/user/fcm';

  Future callUpdateFcmTokenApi(token, fcmToken) async {
    Dio dio = new Dio();
    Response response;
    dio.options.headers['Accept'] = 'application/json';
    dio.options.headers["authorization"] = 'Bearer $token';
    FormData formData = FormData.fromMap({
      "fcm_token": "$fcmToken",
    });

    print(
        'Fcm token before api call =====================================================');
    print(fcmToken);

    try {
      response = await dio.post(
        url,
        data: formData,
      );
    } catch (e) {
      print('Error  FCM Token ::::::::::::');
      print(e);
      return null;
    }
    print('FCM response data ===================================');
    print(response.data);
  }
}
