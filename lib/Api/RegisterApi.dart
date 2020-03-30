import 'package:flutter/material.dart';
import 'BaseUrl.dart';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:fancy_alert_dialog/fancy_alert_dialog.dart';

class RegisterApi {
  Future callRegister(
    name,
    email,
    password,
    gender,
    filePath,
    fileName,
  )
  // Future callRegister(filePath, fileName)
  async {
    var url = "$baseUrl/auth/register/";
    print('Login Api Called From callLogin Metod ::::::');

    //File file;
    Response response;
    Dio dio = new Dio();
    //String fileName = file.path.split('/').last;
    FormData formData = FormData.fromMap({
      "name": "$name",
      "email": "$email",
      "password": "$password",
      "gender": gender,
      "picture": await MultipartFile.fromFile(filePath, filename: fileName),
    });
    print("FormData::::");
    print(formData.toString());

    try {
      response = await dio.post("$url", data: formData);
    } catch (e) {
      print("register DIO execption:::");
      print(e);
    }

    return response.data;
  }
}
