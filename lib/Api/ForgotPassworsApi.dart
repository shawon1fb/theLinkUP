import 'package:dio/dio.dart';

import 'BaseUrl.dart';

class ForgotPasswordApi {
  var url = '$baseUrl/auth/forgot';

  Future callForgotPasswordApi(email) async {
    Dio dio = new Dio();
    Response response;

    FormData formData = FormData.fromMap({
      "email": "$email",
    });
    print(formData.toString());
    dio.options.headers['Accept'] = 'application/json';

    try {
      response = await dio.post(
        url,
        data: formData,
      );

      return response.data;
    } catch (e) {
      print(' Forgot password Api  Error:::::::::');
      print(e);
      return null;
    }
  }
}
