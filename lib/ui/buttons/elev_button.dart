import 'package:somosproperties/constants.dart';
import 'package:flutter/material.dart';

class ElevButton extends StatelessWidget {
  final String textButton;
  const ElevButton({Key? key, required this.textButton});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      child: Text(
        textButton,
        style: TextStyle(
          color: Colors.white,
        ),
      ),
      style: TextButton.styleFrom(
        backgroundColor: kSecondaryColor,
        padding: EdgeInsets.symmetric(
          horizontal: kDefaultPadding
        ),
      ),
    );
  }
}