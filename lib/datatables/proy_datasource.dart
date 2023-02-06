import 'dart:convert';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:somosproperties/api/somosp_api.dart';
import 'package:somosproperties/constants.dart';
import 'package:somosproperties/models/http/proyectos_response.dart';
import 'package:somosproperties/models/proyecto.dart';

import 'package:somosproperties/providers/proyectos_provider.dart';
import 'package:somosproperties/services/notification_service.dart';
import 'package:somosproperties/ui/cards/white_card.dart';
import 'package:somosproperties/ui/modals/galery_edit_proy.dart';
import 'package:somosproperties/ui/modals/proy_dialog.dart';

class ProysDTS extends DataTableSource {
  final BuildContext context;

  ProysDTS(this.context);

  @override
  DataRow getRow(int index) {
    final proyectosProvider = Provider.of<ProyectosProvider>(context);
    final Proyecto proyecto = proyectosProvider.proyectos[index];

    return DataRow.byIndex(index: index, cells: [
      DataCell(Text(proyecto.nombre)),
      DataCell(Text(proyecto.direccion)),
      DataCell(Text(proyecto.ciudadPais)),

      DataCell(
        Container(
          margin: EdgeInsets.all(4),
          width: 70,
          child: Image(
              fit: BoxFit.cover, width: 50, image: NetworkImage(proyecto.img)),
        ),
        showEditIcon: true,
        onTap: () async => await pickImage(context, proyecto.uid.toString()),
      ),
      DataCell(Container(
          constraints: BoxConstraints(minWidth: 100, maxWidth: 300),
          child: Text(proyecto.descripcion))),
      DataCell(Container(
          constraints: BoxConstraints(minWidth: 100, maxWidth: 300),
          child: Text(proyecto.detalles))),
      // DataCell(Text(propiedad.direccion)),
      DataCell(Container(
          constraints: BoxConstraints(minWidth: 150, maxWidth: 400),
          child: Text(
            proyecto.amenidades,
            maxLines: 3,
          ))),
      DataCell(Container(
          constraints: BoxConstraints(minWidth: 150, maxWidth: 400),
          child: Text(
            proyecto.video,
            maxLines: 3,
          ))),
      DataCell(Container(
          constraints: BoxConstraints(minWidth: 150, maxWidth: 400),
          child: Text(
            proyecto.brochure,
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
            Text('${proyecto.galeria.length.toString()} '),
          ],
        ),
        showEditIcon: true,
        onTap: () {
          showDialog(
            context: context,
            builder: (context) => GaleryEditProy(proyecto: proyecto),
          );
        },
      ),
      DataCell(Row(
        children: [
          IconButton(
              onPressed: () {
                final dialog = AlertDialog(
                  title: Text('Editar proyecto'),
                  content: Container(
                      child: ProyEditDialog(
                    proyecto: proyecto, //
                  )),
                  actions: [
                    TextButton(
                        onPressed: () async => proyectosProvider
                            .updateProy(proyecto.uid)
                            .then((_) => Navigator.of(context).pop())
                            .then((_) => proyectosProvider.notifyListeners()),
                        child: Text('Editar')),
                    TextButton(
                        onPressed: () {
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
                      'Borrar definitivamente la propiedad "${proyecto.nombre}"'),
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text('No')),
                    TextButton(
                        onPressed: () async {
                          //BORRAR USUARIO
                          await Provider.of<ProyectosProvider>(context,
                                  listen: false)
                              .deleteProy(proyecto.uid.toString());
                          // Provider.of<ProyectosProvider>(context,
                          //         listen: false)
                          //     .notify();
                          Navigator.of(context).pop();
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
  int get rowCount => Provider.of<ProyectosProvider>(context).proyectos.length;

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

      final lista =
          Provider.of<ProyectosProvider>(context, listen: false).proyectos;
      final resp =
          await SomospApi.editPropImg('/uploads/proyectos/$id', file.bytes!);
      final proy = Proyecto.fromMap(resp);
      print(proy);

      final newList = lista.map(
        (p) {
          if (p.uid != id) return p;
          p.img = proy.img;
          return p;
        },
      ).toList();

      Provider.of<ProyectosProvider>(context, listen: false).proyectos =
          newList;
      Provider.of<ProyectosProvider>(context, listen: false).notifyListeners();
      NotificationService.showSnackbarError(
          msg: 'Imagen cambiada con exito', color: Colors.green);
    } else {
      // User canceled the picker
    }
  }
}
