import 'package:dio/dio.dart';

import 'BaseUrl.dart';

class GetMessageWithUser {
  Future callGetMessageWithUser(token, friendId) async {
    print('========GetMessageWithUser API===========');
    print(token);
    print(friendId);

    var url = '$baseUrl/messages/$friendId';
    Dio dio = new Dio();
    Response response;
    // headers
    dio.options.headers['Accept'] = 'application/json';
    dio.options.headers["authorization"] = 'Bearer $token';
    // api call
    try {
      response = await dio.get(url);
      print('Get User Message Api :::::::::');
      //  print(response.data);
      var data = response.data['data'];
      print(data);
      return data;
    } catch (e) {
      print("execption Get user message  API :::::::::::");
      print(e);
    }
    return null;
  }
}
