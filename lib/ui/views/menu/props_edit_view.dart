import 'package:flutter/material.dart';
import 'package:somosproperties/constants.dart';

import 'package:somosproperties/ui/labels/custom_labels.dart';
import 'package:somosproperties/ui/cards/white_card.dart';

class PropsEditView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(kDefaultPadding),
      child: ListView(
        physics: ClampingScrollPhysics(),
        children: [
          Text('Propiedades', style: CustomLabels.h1),
          SizedBox(height: 10),
          WhiteCard(
              isDrag: false,
              title: 'Lista de Propiedades',
              child: Text('Propiedades'))
        ],
      ),
    );
  }
}
