import 'package:dio/dio.dart';
import 'BaseUrl.dart';

class verifiEmailApi {
  Future CallVerifiEmailApi(email, code) async {
    var url = '$baseUrl/auth/verify';
    Dio dio = new Dio();
    FormData formData = FormData.fromMap({
      "email": "$email",
      "code": "$code",
    });
    Response response;
    try {
      response = await dio.post(url, data: formData);
      return response.data;
    } catch (e) {
      print("execption verify Email API :::::::::::");
      print(e);
    }
    return null;
  }
}
