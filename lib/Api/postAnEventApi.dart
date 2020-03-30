import 'dart:io';
import 'package:dio/dio.dart';
import 'BaseUrl.dart';
import 'package:mime/mime.dart';
import 'dart:io';
import 'dart:convert';
import 'package:http_parser/http_parser.dart';

class PostAnEventApi {
  var url = '$baseUrl/posts';

  Future callPostEventApi(
    filePath,
    body,
    lat,
    lng,
    activity,
    people,
    plus,
    token,
  ) async {
    print('Api Called ::::::::');

    Dio dio = new Dio();
    Response response;

    var fileName = filePath.split('/').last;
    var fileType = fileName.split('.').last;
    print(fileName);
    print(fileType);
    FormData formData = FormData.fromMap({
      "body": "$body",
      "lat": "$lat",
      "lng": "$lng",
      "activity": '$activity',
      "people": "$people",
      'plus': "$plus",
      "image": await MultipartFile.fromFile(
        filePath,
        filename: fileName,
        contentType: MediaType('image', '$fileType'),
      ),
    });
    print(formData.toString());
    dio.options.headers['Accept'] = 'application/json';
//eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1aWQiOjQxLCJpYXQiOjE1ODE3NjgxMDR9.QhZP34rzFh0J2k-lixRf5pl6hVlkBEKP486VMorDoK8
    dio.options.headers["authorization"] = 'Bearer $token';
    try {
      response = await dio.post(
        url,
        data: formData,
      );
    } catch (e) {
      print('Error:::::::::');
      print(e);
      return null;
    }
    //print(response);

    return response.data;
  }
}
