import 'package:dio/dio.dart';

import 'BaseUrl.dart';

class ResetPasswordApi {
  var url = '$baseUrl/auth/reset';

  Future callResetPasswordApi(password, code, email) async {
    Dio dio = new Dio();
    Response response;

    FormData formData = FormData.fromMap({
      "password": "$password",
      "code": "$code",
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
      print(' Reset password Api  Error:::::::::');
      print(e);
      return null;
    }
  }
}
