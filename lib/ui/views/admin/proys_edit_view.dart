import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:somosproperties/constants.dart';
import 'package:somosproperties/datatables/prop_datasource.dart';
import 'package:somosproperties/datatables/proy_datasource.dart';
import 'package:somosproperties/models/propiedad.dart';
import 'package:somosproperties/models/proyecto.dart';
import 'package:somosproperties/providers/auth_provider.dart';

import 'package:somosproperties/providers/propiedades_provides.dart';
import 'package:somosproperties/providers/proyectos_provider.dart';
import 'package:somosproperties/providers/users_provider.dart';

import 'package:somosproperties/ui/labels/custom_labels.dart';
import 'package:somosproperties/ui/modals/prop_dialog.dart';
import 'package:somosproperties/ui/modals/proy_dialog.dart';

class ProysEditView extends StatefulWidget {
  @override
  State<ProysEditView> createState() => _ProysEditViewState();
}

class _ProysEditViewState extends State<ProysEditView> {
  int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;

  @override
  void initState() {
    super.initState();
    Provider.of<UsersProvider>(context, listen: false).getPaginatedUsers();
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    return Container(
      padding: EdgeInsets.only(
          top: kDefaultPadding,
          left: kDefaultPadding / 2,
          right: kDefaultPadding / 2),
      child: ListView(
        physics: ClampingScrollPhysics(),
        children: [
          Text('Proyectos', style: CustomLabels.h1),
          SizedBox(height: 10),
          PaginatedDataTable(
            horizontalMargin: kDefaultPadding,
            columns: [
              DataColumn(label: Text('Nombre')),
              DataColumn(label: Text('Dirección')),
              DataColumn(
                label: Text('Ciudad'),
              ),
              DataColumn(
                label: Text('Logotipo'),
              ),
              DataColumn(label: Text('Descripción')),
              DataColumn(label: Text('Detalles')),
              DataColumn(label: Text('Amenidades')),
              DataColumn(label: Text('Video')),
              DataColumn(label: Text('Brochure')),
              DataColumn(label: Text('Galeria')),
              DataColumn(label: Text('Acciones')),
            ],
            source: ProysDTS(context),
            header: Text(
              'Lista de Proyectos',
              style: CustomLabels.h2ColorPrimary,
              maxLines: 2,
            ),
            rowsPerPage: _rowsPerPage,
            onRowsPerPageChanged: (value) {
              setState(() {
                _rowsPerPage = value ?? 10;
              });
            },
            actions: [
              ElevatedButton(
                child: Row(
                  children: [
                    Text('Agregar Proyecto'),
                    SizedBox(
                      width: kDefaultPadding / 2,
                    ),
                    Icon(
                      Icons.add_home_work,
                      color: Colors.white,
                    ),
                  ],
                ),
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(kSecondaryColor)),
                onPressed: () {
                  final dialog = AlertDialog(
                    title: Text('Agregar Proyecto'),
                    content: Container(
                        child: ProyEditDialog(
                      proyecto: null, //
                    )),
                    actions: [
                      TextButton(
                          onPressed: () async {
                            await Provider.of<ProyectosProvider>(context,
                                    listen: false)
                                .createProy(authProvider.user!.uid.toString());
                            Navigator.of(context).pop();
                          },
                          child: Text('Agregar')),
                      TextButton(
                          onPressed: () async {
                            Navigator.of(context).pop();
                          },
                          child: Text('Descartar'))
                    ],
                  );
                  showDialog(
                    context: context,
                    builder: (context) => dialog,
                  );
                },
              )
            ],
          )
        ],
      ),
    );
  }
}
