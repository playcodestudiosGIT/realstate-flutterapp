import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:somosproperties/constants.dart';

class WhiteCard extends StatelessWidget {
  final String? title;
  final Widget child;
  final double? width;
  final bool isDrag;

  const WhiteCard({
    Key? key,
    required this.child,
    required this.isDrag,
    this.title,
    this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      margin: EdgeInsets.all(8),
      padding: EdgeInsets.all(10),
      decoration: buildBoxDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title != null) ...[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title!,
                  style: GoogleFonts.roboto(
                      fontSize: 15, fontWeight: FontWeight.bold),
                ),
                if (isDrag)
                  Icon(
                    Icons.swipe_left_alt_sharp,
                    color: kPrimaryColor,
                    size: 30,
                  )
              ],
            ),
            Divider()
          ],
          child
        ],
      ),
    );
  }

  BoxDecoration buildBoxDecoration() => BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 5)
          ]);
}
