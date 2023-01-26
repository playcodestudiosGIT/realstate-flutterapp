import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NotificationService {
  static GlobalKey<ScaffoldMessengerState> msgKey =
      GlobalKey<ScaffoldMessengerState>();

  static showSnackbarError({ required String msg, required Color color}) {

    final snackbar = new SnackBar(
        backgroundColor: color,
        content: Text(
          msg,
          style: GoogleFonts.roboto(color: Colors.white),
        ));
    msgKey.currentState!.showSnackBar(snackbar);
  }
}
