import 'package:somosproperties/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TagProject extends StatelessWidget {
  final String textTipo;
  final double width;
  const TagProject({Key? key, required this.textTipo, required this.width});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(50))),
      width: width,
      height: 20,
      child: Center(
        child: Text(
          '$textTipo',
          style: GoogleFonts.roboto(
              color: kPrimaryColor, fontWeight: FontWeight.bold, fontSize: 12),
        ),
      ),
    );
  }
}
