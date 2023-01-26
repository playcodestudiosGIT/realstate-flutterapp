import 'package:somosproperties/constants.dart';
import 'package:flutter/material.dart';

class CustomOutlinedButtonMini extends StatelessWidget {
  final Function onPressed;
  final String text;
  final Color color;
  final bool isFilled;
  final IconData icon;

  const CustomOutlinedButtonMini(
      {Key? key,
      required this.onPressed,
      required this.text,
      this.color = kSecondaryColor,
      this.isFilled = false, required this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
        style: ButtonStyle(
          shape: MaterialStateProperty.all(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))),
          side: MaterialStateProperty.all(BorderSide(color: color)),
          backgroundColor: MaterialStateProperty.all(
              isFilled ? color : Colors.transparent),
        ),
        onPressed: () => onPressed(),
        child: Row(
          children: [
            Icon(icon, size: 12, color: isFilled ? Colors.white : kSecondaryColor,),
            SizedBox(width: kDefaultPadding /2,),
            Text(
              text,
              style: TextStyle(fontSize: 12, color: isFilled ? Colors.white : kSecondaryColor),
            ),
          ],
        ));
  }
}
