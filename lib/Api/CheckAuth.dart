import 'package:dio/dio.dart';

import 'BaseUrl.dart';

class CheckAuth {
  Future callCheckAuth(token) async {
    var url = "$baseUrl/auth/check";
    print('call Check Auth  ::::::::');
    Dio dio = new Dio();
    Response response;
    dio.options.headers['Accept'] = 'application/json';
    dio.options.headers["authorization"] = 'Bearer $token';

    try {
      response = await dio.post(url);
      print('print responce from Auth api::::::::::');
      print(response.data);
      var data = response.data['user'];
      print(data);
      return data;
    } catch (e) {
      print('Error:::::::::');
      print(e);
      return null;
    }
  }
}
