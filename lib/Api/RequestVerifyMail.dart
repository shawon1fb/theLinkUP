import 'package:dio/dio.dart';

import 'BaseUrl.dart';

class RequestVerifyMail {
  Future CallRequestVerifyMail(email) async {
    var url = '$baseUrl/auth/verify/request';
    Dio dio = new Dio();
    FormData formData = FormData.fromMap({
      "email": "$email",
    });
    Response response;
    try {
      response = await dio.post(url, data: formData);
      print('verify mail request data===================');
      print(response.data);
      return response.data;
    } catch (e) {
      print("execption request verify Email API :::::::::::");
      print(e);
    }
    return null;
  }
}
