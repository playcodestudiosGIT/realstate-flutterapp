import 'package:somosproperties/constants.dart';
import 'package:somosproperties/models/propiedad.dart';

import 'package:somosproperties/ui/cards/propiedad_card.dart';
import 'package:flutter/material.dart';

class PropiedadesSlider extends StatelessWidget {
  final String sectionName;
  final List<Propiedad> propiedades;
  const PropiedadesSlider(
      {Key? key, required this.sectionName, required this.propiedades})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
        padding: EdgeInsets.symmetric(vertical: kDefaultPadding),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Text(
              sectionName,
              style: Theme.of(context).textTheme.headline4!.copyWith(
                  color: kPrimaryColor,
                  fontWeight: FontWeight.w900,
                  fontSize: (size.width > 570) ? 35 : 22),
            ),
          ),
          SizedBox(height: kDefaultPadding),
          Container(
              child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                      children: propiedades.map<Widget>((item) {
                    return Padding(
                      padding: EdgeInsets.only(right: kDefaultPadding),
                      child: PropiedadCard(
                        propiedad: item,
                      ),
                    );
                  }).toList()))),
        ]));
  }
}
