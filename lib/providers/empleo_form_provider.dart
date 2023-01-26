import 'dart:convert';
import 'dart:html';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:somosproperties/api/emailjs.dart';
import 'package:somosproperties/api/somosp_api.dart';
import 'package:somosproperties/models/http/pdf_response.dart';
import 'package:somosproperties/services/notification_service.dart';

enum SendingStatus { hold, sending, ok }

class EmpleoFormProvider extends ChangeNotifier {
  GlobalKey<FormState> empleoKey = new GlobalKey<FormState>();
  String nombre = '';
  String correo = '';
  String telfono = '';
  Uint8List file = Uint8List.fromList([]);

  String fileSize = '';
  String fileName = '';

  notify() {
    notifyListeners();
  }

  resetFileName() {
    fileName = '';
    notifyListeners();
  }

  SendingStatus isSending = SendingStatus.hold;

  Future sendPdf() async {
    isSending = SendingStatus.sending;
    notifyListeners();

    // subir archivo

    final resp = await SomospApi.uploadPdf('/uploads/cargar-pdf', file);

    // OJO CON ESTA LINEA SALVA VIDA //

    PdfResponse data = PdfResponse.fromJson(resp.toString());

    //Send Email

    final serviceId = 'service_2yw1c08';
    final templateId = 'template_rzmkk25';
    final userId = '96-kcBMtufKW7IiZ9';
    final response = await SendEmail.post({
      'service_id': serviceId,
      'template_id': templateId,
      'user_id': userId,
      'template_params': {
        'from_name': nombre,
        'user_email': correo,
        'user_subject': 'Nuevo CV: $nombre',
        'message': 'Teléfono: $telfono\bEnlace de descarga: ${data.url}'
      }
    });

    if (response.toString() == 'OK') {
      isSending = SendingStatus.ok;
      notifyListeners();
    } else {}
  }

  validateForm() async {
    if (empleoKey.currentState!.validate()) {
      await sendPdf();
      NotificationService.showSnackbarError(
          msg: 'Mensaje enviado correctamente', color: Colors.green);
    } else {}
  }
}
