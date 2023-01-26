import 'package:somosproperties/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomLabels {

  static TextStyle h1 = GoogleFonts.roboto(
    fontSize: 30,
    fontWeight: FontWeight.w400,
    color: kPrimaryColor
  );
  static TextStyle h1ColorPrimary = GoogleFonts.roboto(
    fontSize: 22,
    fontWeight: FontWeight.w800,
    color: kPrimaryColor
  );
  static TextStyle h2ColorPrimary = GoogleFonts.roboto(
    fontSize: 18,
    fontWeight: FontWeight.w400,
    color: kPrimaryColor.withOpacity(0.8)
  );
  static TextStyle h3ColorBlack87 = GoogleFonts.roboto(
    fontSize: 14,
    fontWeight: FontWeight.w800,
    color: kBodyTextColor.withOpacity(0.7)
  );

}