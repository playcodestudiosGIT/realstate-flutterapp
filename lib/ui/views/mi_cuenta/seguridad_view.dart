import 'package:flutter/material.dart';
import 'package:somosproperties/constants.dart';

import 'package:somosproperties/ui/labels/custom_labels.dart';
import 'package:somosproperties/ui/cards/white_card.dart';

class SeguridadView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(kDefaultPadding),
      child: ListView(
        physics: ClampingScrollPhysics(),
        children: [
          Text('Seguridad', style: CustomLabels.h1),
          SizedBox(height: 10),
          WhiteCard(
              isDrag: false,
              title: 'En construcción',
              child: Text('Disculpe las molestias'))
        ],
      ),
    );
  }
}
