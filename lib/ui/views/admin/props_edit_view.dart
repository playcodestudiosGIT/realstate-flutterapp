import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:somosproperties/api/somosp_api.dart';
import 'package:somosproperties/constants.dart';
import 'package:somosproperties/datatables/prop_datasource.dart';
import 'package:somosproperties/models/http/propiedad_response.dart';
import 'package:somosproperties/models/propiedad.dart';
import 'package:somosproperties/models/proyecto.dart';

import 'package:somosproperties/providers/propiedades_provides.dart';
import 'package:somosproperties/providers/users_provider.dart';
import 'package:somosproperties/services/notification_service.dart';

import 'package:somosproperties/ui/labels/custom_labels.dart';
import 'package:somosproperties/ui/modals/prop_dialog.dart';

class PropsEditView extends StatefulWidget {
  @override
  State<PropsEditView> createState() => _PropsEditViewState();
}

class _PropsEditViewState extends State<PropsEditView> {
  int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;

  @override
  void initState() {
    super.initState();
    Provider.of<UsersProvider>(context, listen: false).getPaginatedUsers();
  }

  @override
  Widget build(BuildContext context) {
    final propiedadesProvider = Provider.of<PropiedadesProvider>(context);
    final List<Propiedad> propiedades =
        Provider.of<PropiedadesProvider>(context).listpropiedades;
    return Container(
      padding: EdgeInsets.only(
          top: kDefaultPadding,
          left: kDefaultPadding / 2,
          right: kDefaultPadding / 2),
      child: ListView(
        physics: ClampingScrollPhysics(),
        children: [
          Text('Propiedades', style: CustomLabels.h1),
          SizedBox(height: 10),
          PaginatedDataTable(
            horizontalMargin: kDefaultPadding,
            columns: [
              DataColumn(label: Text('Tipo')),
              DataColumn(label: Text('Clase')),
              DataColumn(
                label: Text('Proyecto'),
              ),
              DataColumn(
                label: Text('Foto Destacada'),
              ),
              DataColumn(label: Text('Propiedad')),
              DataColumn(label: Text('Dirección')),
              DataColumn(label: Text('Descripción')),
              DataColumn(label: Text('Detalles')),
              DataColumn(label: Text('Galeria')),
              DataColumn(label: Text('Acciones')),
            ],
            source: PropsDTS(context),
            header: Text(
              'Lista de Propiedades',
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
                    Text('Agregar Propiedad'),
                    SizedBox(
                      width: kDefaultPadding / 2,
                    ),
                    Icon(
                      Icons.add_home_outlined,
                      color: Colors.white,
                    ),
                  ],
                ),
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(kSecondaryColor)),
                onPressed: () {
                  final dialog = AlertDialog(
                    title: Text('Agregar propiedad'),
                    content: Container(
                        child: PropEditDialog(
                      propiedad: null, //
                    )),
                    actions: [
                      TextButton(
                          onPressed: () async {
                            final data = {
                              "nombreProp": propiedadesProvider.prop.nombreProp,
                              "direccion": propiedadesProvider.prop.direccion,
                              "detalles": propiedadesProvider.prop.detalles,
                              "sevendeoalquila":
                                  propiedadesProvider.prop.sevendeoalquila,
                              "tipopropiedad":
                                  propiedadesProvider.prop.tipopropiedad,
                              "mts2": propiedadesProvider.prop.mts2,
                              "proyecto": propiedadesProvider.idProyPropNew,
                              "descripcion":
                                  propiedadesProvider.prop.descripcion,
                              "habitaciones":
                                  propiedadesProvider.prop.habitaciones,
                              "precio": propiedadesProvider.prop.precio,
                              "banos": propiedadesProvider.prop.banos,
                              "estacionamientos":
                                  propiedadesProvider.prop.estacionamientos
                            };
                            // Petición HTTP
                            try {
                              final resp =
                                  await SomospApi.post('/propiedades', data);

                              propiedadesProvider.getPropiedades();
                              propiedadesProvider.notify();
                              setState(() {});
                              NotificationService.showSnackbarError(
                                  msg: 'Propiedad Agregada',
                                  color: Colors.green);
                            } catch (e) {
                              NotificationService.showSnackbarError(
                                  msg: 'Error Agregando Propiedad',
                                  color: Colors.red);
                              print('error agregando prop --- $e');
                            }

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
