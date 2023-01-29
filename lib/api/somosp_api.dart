import 'package:flutter/foundation.dart';
import 'package:somosproperties/services/local_storage.dart';
import 'package:dio/dio.dart';

class SomospApi {
  static Dio _dio = new Dio();

  static void configureDio() {
    //Base URL
    _dio.options.baseUrl = 'https://www.somosproperties.com/api';
    // 'http://localhost:8080/api';

    // Conf Header
    _dio.options.headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'x-token': LocalStorage.prefs.getString('token') ?? ''
    };

    _dio.options.validateStatus = ((status) => true);
  }

  static Future httpGet(String path) async {
    try {
      final resp = await _dio.get(path);
      return resp.data;
    } catch (e) {
      throw ('Error en el GET');
    }
  }

  static Future post(String path, Map<String, dynamic> data) async {
    final formData = FormData.fromMap(data);
    try {
      final resp = await _dio.post(path, data: formData);

      return resp.data;
    } catch (e) {
      print(e);
      throw ('Error en el POST');
    }
  }

  static Future put(String path, Map<String, dynamic> data) async {
    final formData = FormData.fromMap(data);

    try {
      final resp = await _dio.put(path, data: formData);

      return resp.data;
    } on DioError catch (e) {
      print(e);
      throw ('Error en el PUT $e');
    }
  }

  static Future delete(String path, Map<String, dynamic> data) async {
    final formData = FormData.fromMap(data);

    try {
      final resp = await _dio.delete(path, data: formData);

      return resp.data;
    } on DioError catch (e) {
      print(e);
      throw ('Error en el DELETE $e');
    }
  }

  static Future uploadPdf(String path, Uint8List bytes) async {
    final formData =
        FormData.fromMap({'archivo': MultipartFile.fromBytes(bytes)});

    try {
      final resp = await _dio.post(path, data: formData);
      return resp;
    } on DioError catch (e) {
      print(e);
      throw ('Error en el PUT $e');
    }
  }

  static Future editUserImg(String path, Uint8List bytes) async {
    final formData =
        FormData.fromMap({'archivo': MultipartFile.fromBytes(bytes)});

    try {
      final resp = await _dio.put(path, data: formData);
      return resp;
    } on DioError catch (e) {
      print(e);
      throw ('Error en el PUT $e');
    }
  }
}
