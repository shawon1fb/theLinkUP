import 'BaseUrl.dart';
import 'package:http/http.dart';
import 'dart:convert';

class LoginApi {
  Future callLogin(email, password) async {
    var url = "$baseUrl/auth/login/";
    try {
      print('Login Api Called From callLogin Metod ::::::');
      Response response = await post(
        url,
        headers: headers,
        body: {'email': '$email', 'password': '$password'},
      );
      print('login response ============');
      print(response.body);
      return jsonDecode(response.body);
    } catch (e) {
      print(e);
      return null;
    }
  }
}
