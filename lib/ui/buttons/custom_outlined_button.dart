import 'package:somosproperties/constants.dart';
import 'package:flutter/material.dart';

class CustomOutlinedButton extends StatelessWidget {
  final Function onPressed;
  final String text;
  final Color color;
  final bool isFilled;
  final IconData icon;
  final bool isMini = false;

  const CustomOutlinedButton(
      {Key? key,
      required this.onPressed,
      required this.text,
      this.color = kPrimaryColor,
      this.isFilled = false,
      required this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
        style: ButtonStyle(
          shape: MaterialStateProperty.all(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))),
          side: MaterialStateProperty.all(BorderSide(color: color)),
          backgroundColor:
              MaterialStateProperty.all(isFilled ? color : Colors.transparent),
        ),
        onPressed: () => onPressed(),
        child: Center(
          child: Padding(
            padding:
                EdgeInsets.symmetric( vertical: 10),
            child: Row(
              children: [
                if (icon != Icons.abc)
                  Icon(
                    icon,
                    color: isFilled ? Colors.white : kPrimaryColor,
                  ),
                SizedBox(
                  width: kDefaultPadding / 2,
                ),
                Text(
                  text,
                  style: TextStyle(
                    fontSize: 16,
                    color: isFilled ? Colors.white : kPrimaryColor,
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
