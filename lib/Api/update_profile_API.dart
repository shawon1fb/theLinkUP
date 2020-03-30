import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';

import 'BaseUrl.dart';

class UpdateProfileApi {
  callApi(
    name,
    filePath,
    token,
  ) async {
    var url = "$baseUrl/user/profile";

    var fileName = filePath.split('/').last;
    var fileType = fileName.split('.').last;

    Response response;
    Dio dio = new Dio();
    FormData formData = FormData.fromMap({
      "name": "$name",
      "picture": await MultipartFile.fromFile(
        filePath,
        filename: fileName,
        contentType: MediaType('image', '$fileType'),
      ),
    });

    dio.options.headers['Accept'] = 'application/json';
    dio.options.headers["authorization"] = 'Bearer $token';

    try {
      response = await dio.post("$url", data: formData);
    } catch (e) {
      print("update profile DIO execption:::");
      print(e);
    }

    print("Update profile responce");
    print(response.data);
    return response.data;
  }
}
