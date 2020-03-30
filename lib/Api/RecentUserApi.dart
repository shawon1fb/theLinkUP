import 'package:dio/dio.dart';
import 'BaseUrl.dart';

class RecentUserApi {
  Future CallRecentUserApi(token) async {
    var url = "$baseUrl/messages/recent";
    print('Api Called ::::::::');
    Dio dio = new Dio();
    Response response;
    dio.options.headers['Accept'] = 'application/json';
    dio.options.headers["authorization"] = 'Bearer $token';

    try {
      response = await dio.get(url);
      print('print responce  from Recent User api::::::::::');
      print(response.data);
      var data = response.data['data'];

      print(data);
      print(data[0]['picture']);
      return data;
    } catch (e) {
      print('Error:::::::::');
      print(e);
      return null;
    }
  }
}
