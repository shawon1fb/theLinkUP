import 'BaseUrl.dart';
import 'package:dio/dio.dart';

class GetNearByPostApi {
  var url = '$baseUrl/posts/nearby';

  Future callGetNearByPostApi(page, limit, lat, lng, token) async {
    var data;
    try {
      Dio dio = new Dio();

      /*FormData formData = FormData.fromMap({
        "page": "1",
        "limit": "10",
        "lat": "23.90",
        "lng": "90.23",
      });*/

      dio.options.headers["authorization"] = 'Bearer $token';
      Response response = await dio.get(url, queryParameters: {
        "page": "$page",
        "limit": "$limit",
        "lat": "$lat",
        "lng": "$lng",
      });
      print(response.data['data']);
      data = response.data['data'];
      return data;
    } catch (e) {
      print(e);
    }

    return null;

    /* for (var i in data) {
      print(i['creator']['id']);
      print(i['creator']['name']);
      print(i['images'][0]['url']);
    }*/
  }
}
