import 'package:somosproperties/constants.dart';
import 'package:somosproperties/providers/busqueda_provider.dart';
import 'package:somosproperties/providers/propiedades_provides.dart';
import 'package:somosproperties/ui/cards/propiedad_card.dart';
import 'package:somosproperties/ui/labels/custom_labels.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PropiedadesSearchDelegate extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(onPressed: () => this.query = '', icon: Icon(Icons.clear)),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () => this.close(context, null),
        icon: Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    final busquedasProvider =
        Provider.of<BusquedasProvider>(context, listen: false);
    busquedasProvider.getSearchList();
    final lista = Provider.of<BusquedasProvider>(context).lista;

    final destrct = lista.map((e) {
      return PropiedadCard(
        propiedad: e,
      );
    }).toList();

    if (query.trim().length == 0) {
      return Text('Ingrese una palabra para buscar');
    }

    return Container(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
        child: ListView(
          physics: ClampingScrollPhysics(),
          children: [
            SizedBox(height: kDefaultPadding),
            Text(
              'Propiedades',
              style: CustomLabels.h1,
            ),
            SizedBox(height: kDefaultPadding),
            Container(
              child: Wrap(children: [...destrct]),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final propiedadesProvider =
        Provider.of<PropiedadesProvider>(context, listen: false);
    final lista = propiedadesProvider.listpropiedades;

    final destrct = lista.map((e) {
      return PropiedadCard(
        propiedad: e,
      );
    }).toList();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
      child: ListView(
        physics: ClampingScrollPhysics(),
        children: [
          SizedBox(height: kDefaultPadding),
          Text(
            'Sugerencias',
            style: CustomLabels.h1,
          ),
          SizedBox(height: kDefaultPadding),
          Container(
            child: Wrap(children: [...destrct]),
          )
        ],
      ),
    );
  }
}
