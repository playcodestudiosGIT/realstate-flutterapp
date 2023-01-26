import 'package:flutter/material.dart';

class RegisterFormProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = new GlobalKey<FormState>();

  String email = '';
  String password = '';
  String name = '';
  String rol = 'USER_ROLE';

  validateForm() {
    if (formKey.currentState!.validate()) {

    } else {

    }
  }
}
