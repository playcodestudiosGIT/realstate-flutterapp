import 'package:somosproperties/constants.dart';
import 'package:somosproperties/providers/proyectos_provider.dart';
import 'package:somosproperties/ui/cards/proyecto_card.dart';

import 'package:somosproperties/ui/labels/custom_labels.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class ProyectosView extends StatefulWidget {
  @override
  State<ProyectosView> createState() => _ProyectosViewState();
}

class _ProyectosViewState extends State<ProyectosView> {
  @override
  void initState() {
    super.initState();
    Provider.of<ProyectosProvider>(context, listen: false).getProyectos();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final proyectos = Provider.of<ProyectosProvider>(context).proyectos;
    final lista = proyectos.map(
      (e) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
          child: ProyectoCard(
            proyecto: e,
          ),
        );
      },
    );
    return Container(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
        child: ListView(
          physics: ClampingScrollPhysics(),
          children: [
            SizedBox(height: kDefaultPadding),
            Text(
              'Proyectos',
              style: CustomLabels.h1,
            ),
            SizedBox(height: kDefaultPadding),
            Container(
              child:
                  Wrap(alignment: WrapAlignment.center, children: [...lista]),
            ),
            SizedBox(
              height: (size.width < 412) ? 130 : 75,
            )
          ],
        ),
      ),
    );
  }
}
