import 'package:somosproperties/ui/cards/vertical_propertie_card.dart';
import 'package:flutter/material.dart';

class VerticaListProperties extends StatelessWidget {
  final List listPropiedades;

  const VerticaListProperties({
    Key? key,
    required this.listPropiedades,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
        height: size.height - 400,
        child: ListView.builder(
            itemCount: listPropiedades.length,
            itemBuilder: ((context, index) => VerticalPropiedadCard(
                  propiedad: listPropiedades[index],
                ))));
  }
}
