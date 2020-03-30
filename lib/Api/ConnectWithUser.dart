import 'package:dio/dio.dart';

import 'BaseUrl.dart';

class ConnectWithUser {
  Future callConnectWithUser(userId, token) async {
    var url = "$baseUrl/connections/connect";
    Dio dio = new Dio();
    Response response;
    dio.options.headers['Accept'] = 'application/json';
    dio.options.headers["authorization"] = 'Bearer $token';
    print('==============================');
    print("User Id : "+userId.toString());
    print(token);

    try {
      response = await dio.post(
        url,
        queryParameters: {
          'user_id': '$userId',
        },
      );
    } catch (e) {
      print('Dio execption ===== Connect With User Api =======');
      print(e);
    }
    print(response.statusCode);
    var body = response.data;
    print('Connect With User Api Called Succesfully ==========');
    print(body);
    return body;
  }
}
