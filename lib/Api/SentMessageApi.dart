import 'package:dio/dio.dart';
import 'package:the_link_up/Api/BaseUrl.dart';

class SentMessageAPi {
  Future callSentMessage(token, message, userId) async {
    Dio dio = new Dio();
    Response response;
    var data;
    var url = "$baseUrl/messages";
    try {
      dio.options.headers["authorization"] = 'Bearer $token';
      response = await dio.post(url, queryParameters: {
        "user_id": "$userId",
        "message": "$message",
      });
      print(response.data['data']);
      data = response.data;
      return data;
    } catch (e) {
      print(e);
    }
  }
}
