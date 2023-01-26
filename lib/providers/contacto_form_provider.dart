import 'package:flutter/material.dart';
import 'package:somosproperties/api/emailjs.dart';
import 'package:somosproperties/services/notification_service.dart';

enum SendingStatus { hold, sending, ok }

class ContactoFormProvider extends ChangeNotifier {
  GlobalKey<FormState> contactoKey = new GlobalKey<FormState>();
  String nombre = '';
  String correo = '';
  String asunto = 'web: Contacto';
  String mensaje = '';

  SendingStatus isSending = SendingStatus.hold;

  Future sendEmail() async {
    isSending = SendingStatus.sending;
    notifyListeners();
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
        'user_subject': asunto,
        'message': mensaje
      }
    });

    if (response.toString() == 'OK') {
      isSending = SendingStatus.ok;
      notifyListeners();
    } else {}
  }

  validateForm() async {
    if (contactoKey.currentState!.validate()) {
      await sendEmail();
      if (isSending == SendingStatus.ok)
        NotificationService.showSnackbarError(
            msg: 'Enviado', color: Colors.green);
    } else {}
  }
}
