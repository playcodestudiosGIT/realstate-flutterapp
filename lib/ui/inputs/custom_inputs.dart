import 'package:somosproperties/constants.dart';
import 'package:flutter/material.dart';

class CustomInputs {
  static InputDecoration loginInputDecoration({
    required String hint,
    required String label,
    required IconData icon,
  }) {
    return InputDecoration(
      border: OutlineInputBorder(borderSide: BorderSide(color: kPrimaryColor)),
      enabledBorder:
          OutlineInputBorder(borderSide: BorderSide(color: kPrimaryColor)),
      hintText: hint,
      labelText: label,
      focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: kPrimaryColor, width: 3)),
      prefixIcon: Icon(icon, color: kPrimaryColor),
      labelStyle: TextStyle(color: kPrimaryColor),
      hintStyle: TextStyle(color: kPrimaryColor.withOpacity(0.4)),
    );
  }

  static InputDecoration searchInputDecoration(
      {required String hint, required IconData icon}) {
    return InputDecoration(
        border: InputBorder.none,
        enabledBorder: InputBorder.none,
        hintText: hint,
        prefixIcon: Icon(icon, color: kPrimaryColor),
        labelStyle: TextStyle(color: kPrimaryColor),
        hintStyle: TextStyle(color: kPrimaryColor));
  }

  static InputDecoration formInputDecoration({
    required String hint,
    required String label,
    required IconData icon,
  }) {
    return InputDecoration(
      border: OutlineInputBorder(borderSide: BorderSide(color: kPrimaryColor)),
      enabledBorder:
          OutlineInputBorder(borderSide: BorderSide(color: kPrimaryColor)),
      hintText: hint,
      labelText: label,
      focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: kSecondaryColor, width: 3)),
      prefixIcon: Icon(icon, color: kPrimaryColor.withOpacity(0.4)),
      labelStyle: TextStyle(color: kPrimaryColor.withOpacity(0.4)),
      hintStyle: TextStyle(color: kPrimaryColor.withOpacity(0.4)),
    );
  }

  static InputDecoration formDark({
    required String hint,
    required String label,
    required IconData icon,
  }) {
    return InputDecoration(
      fillColor: Colors.black.withOpacity(0.3),
      filled: true,
      border: OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
      enabledBorder:
          OutlineInputBorder(borderSide: BorderSide(color: kPrimaryColor)),
      hintText: hint,
      labelText: label,
      focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white, width: 3)),
      prefixIcon: Icon(icon, color: Colors.white.withOpacity(0.4)),
      labelStyle: TextStyle(color: Colors.white.withOpacity(0.4)),
      hintStyle: TextStyle(color: Colors.white.withOpacity(0.4)),
    );
  }
}
