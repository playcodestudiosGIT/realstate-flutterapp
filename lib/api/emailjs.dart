import 'package:dio/dio.dart';
import 'package:somosproperties/services/local_storage.dart';

class SendEmail {
  static Dio dio = new Dio();

  static void configureDio() {
    // Conf Header
    dio.options.headers = {
      'Content-Type': 'application/json',
      'x-token': LocalStorage.prefs.getString('token') ?? ''
    };
  }

  static Future post(Map<String, dynamic> body) async {
    final url = 'https://api.emailjs.com/api/v1.0/email/send';
    try {
      final resp = await dio.post(url, data: body);
      return resp;
    } catch (e) {
      print(e);
      throw ('Error en el POST');
    }
  }
}
