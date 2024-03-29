import 'dart:convert';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:somosproperties/api/somosp_api.dart';
import 'package:somosproperties/constants.dart';
import 'package:somosproperties/models/http/propiedad_response.dart';
import 'package:somosproperties/models/propiedad.dart';

import 'package:somosproperties/providers/propiedades_provides.dart';
import 'package:somosproperties/providers/users_provider.dart';
import 'package:somosproperties/services/notification_service.dart';
import 'package:somosproperties/ui/cards/white_card.dart';
import 'package:somosproperties/ui/modals/galery_edit.dart';
import 'package:somosproperties/ui/modals/prop_dialog.dart';

class PropsDTS extends DataTableSource {
  final BuildContext context;

  PropsDTS(this.context);

  @override
  DataRow getRow(int index) {
    final propiedadesProvider = Provider.of<PropiedadesProvider>(this.context);
    final propiedad = propiedadesProvider.listpropiedades[index];

    return DataRow.byIndex(index: index, cells: [
      DataCell(Text(propiedad.sevendeoalquila)),
      DataCell(Text(propiedad.tipopropiedad)),
      DataCell(Text(propiedad.proyecto.nombre)),

      DataCell(
        Container(
          margin: EdgeInsets.all(4),
          width: 70,
          child: Image(
              fit: BoxFit.cover,
              width: 50,
              image: NetworkImage(propiedad.img ??
                  'https://res.cloudinary.com/dnejayiiq/image/upload/v1671851591/no-image_xb946x.jpg')),
        ),
        showEditIcon: true,
        onTap: () async => await pickImage(context, propiedad.uid.toString()),
      ),
      DataCell(
        Text(propiedad.nombreProp),
      ),
      DataCell(Container(
          constraints: BoxConstraints(minWidth: 100, maxWidth: 300),
          child: Text(propiedad.direccion))),
      // DataCell(Text(propiedad.direccion)),
      DataCell(Container(
          constraints: BoxConstraints(minWidth: 150, maxWidth: 400),
          child: Text(
            propiedad.descripcion,
            maxLines: 3,
          ))),
      DataCell(Container(
          constraints: BoxConstraints(minWidth: 150, maxWidth: 400),
          child: Text(
            propiedad.detalles,
            maxLines: 3,
          ))),
      DataCell(
        Row(
          children: [
            Icon(
              Icons.add_a_photo,
              color: kPrimaryColor,
              size: 20,
            ),
            SizedBox(
              width: kDefaultPadding,
            ),
            Text('${propiedad.galeria.length.toString()} '),
          ],
        ),
        showEditIcon: true,
        onTap: () {
          showDialog(
            context: context,
            builder: (context) => GaleryEdit(propiedad: propiedad),
          );
        },
      ),
      DataCell(Row(
        children: [
          IconButton(
              onPressed: () {
                final dialog = AlertDialog(
                  title: Text('Editar propiedad'),
                  content: Container(
                      child: PropEditDialog(
                    propiedad: propiedad, //
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
                            "descripcion": propiedadesProvider.prop.descripcion,
                            "habitaciones":
                                propiedadesProvider.prop.habitaciones,
                            "precio": propiedadesProvider.prop.precio,
                            "banos": propiedadesProvider.prop.banos,
                            "altura": propiedadesProvider.prop.altura,
                            "estacionamientos":
                                propiedadesProvider.prop.estacionamientos,
                          };
                          try {
                            final resp = await SomospApi.put(
                                '/propiedades/${propiedad.uid}', data);

                            Navigator.of(context).pop();
                            propiedadesProvider.notifyListeners();
                            NotificationService.showSnackbarError(
                                msg: 'Propiedad Editada', color: Colors.green);
                          } catch (e) {
                            NotificationService.showSnackbarError(
                                msg: 'ERROR Editando Propiedad',
                                color: Colors.red);
                          }
                        },
                        child: Text('Editar')),
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
              icon: Icon(
                Icons.edit_outlined,
                size: 16,
                color: kPrimaryColor,
              )),
          IconButton(
              onPressed: () {
                final dialog = AlertDialog(
                  title: Text('Esta seguro de borrar'),
                  content: Text(
                      'Borrar definitivamente la propiedad "${propiedad.nombreProp}"'),
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text('No')),
                    TextButton(
                        onPressed: () async {
                          //BORRAR propiedad
                          try {
                            await Provider.of<PropiedadesProvider>(context,
                                    listen: false)
                                .deleteProp(propiedad.uid.toString());
                            Provider.of<PropiedadesProvider>(context,
                                    listen: false)
                                .notify();
                            Navigator.of(context).pop();
                            NotificationService.showSnackbarError(
                                msg:
                                    'Propiedad "${propiedad.nombreProp}" eliminada',
                                color: Colors.green);
                          } catch (e) {
                            NotificationService.showSnackbarError(
                                msg:
                                    'ERROR eliminando "${propiedad.nombreProp}"',
                                color: Colors.red);
                            print(e);
                          }
                        },
                        child: Text('Si, Borrar'))
                  ],
                );
                showDialog(
                  context: context,
                  builder: (context) => dialog,
                );
              },
              icon: Icon(
                Icons.delete_outline,
                size: 16,
                color: Colors.red.withOpacity(0.8),
              )),
        ],
      )),
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount =>
      Provider.of<PropiedadesProvider>(context).listpropiedades.length;

  @override
  int get selectedRowCount => 0;

  pickImage(BuildContext context, String id) async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(type: FileType.any);

    if (result != null) {
      PlatformFile file = result.files.first;

      if (file.extension!.toLowerCase() != 'jpg' &&
          file.extension!.toLowerCase() != 'jpeg' &&
          file.extension!.toLowerCase() != 'png') {
        showDialog(
          context: context,
          builder: (context) => Center(
              child: Container(
                  width: 200,
                  height: 200,
                  child: WhiteCard(
                      isDrag: false,
                      title: 'Extension invalida',
                      child: Center(
                          child: Column(
                        children: [
                          Text('La extension debe ser "PNG, JPG ó JPEG"'),
                          SizedBox(
                            height: 60,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              ElevatedButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: Text('Entendido'))
                            ],
                          )
                        ],
                      ))))),
        );
      }
      if (file.size > 1000000) {
        showDialog(
            context: context,
            builder: (context) => Center(
                child: Container(
                    width: 200,
                    height: 200,
                    child: WhiteCard(
                        isDrag: false,
                        title: 'Tamaño invalido',
                        child: Center(
                            child: Column(
                          children: [
                            Text('La imagen debe pesar menos de 1 MB'),
                            SizedBox(
                              height: 60,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                ElevatedButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: Text('Entendido'))
                              ],
                            )
                          ],
                        ))))));
      }

      final lista = Provider.of<PropiedadesProvider>(context, listen: false)
          .listpropiedades;
      final resp =
          await SomospApi.editPropImg('/uploads/propiedades/$id', file.bytes!);
      final prop = PropiedadResponse.fromJson(jsonDecode(resp.toString()));
      final newList = lista.map(
        (p) {
          if (p.uid != id) return p;
          p.img = prop.img;
          return p;
        },
      ).toList();

      Provider.of<PropiedadesProvider>(context, listen: false).listpropiedades =
          newList;
      Provider.of<PropiedadesProvider>(context, listen: false).notify();
      NotificationService.showSnackbarError(
          msg: 'Imagen cambiada con exito', color: Colors.green);
    } else {
      // User canceled the picker
    }
  }
}
