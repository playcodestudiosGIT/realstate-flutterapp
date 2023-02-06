import 'dart:convert';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:somosproperties/api/somosp_api.dart';
import 'package:somosproperties/constants.dart';
import 'package:somosproperties/models/http/propiedad_response.dart';
import 'package:somosproperties/models/propiedad.dart';
import 'package:somosproperties/providers/propiedades_provides.dart';
import 'package:somosproperties/services/notification_service.dart';
import 'package:somosproperties/ui/cards/white_card.dart';

class GaleryEdit extends StatefulWidget {
  final Propiedad propiedad;
  const GaleryEdit({required this.propiedad});

  @override
  State<GaleryEdit> createState() => _GaleryEditState();
}

class _GaleryEditState extends State<GaleryEdit> {
  @override
  Widget build(BuildContext context) {
    List galeria = widget.propiedad.galeria;
    final propiedadesProvider = Provider.of<PropiedadesProvider>(context);
    List<Widget> fotos = galeria.map((foto) {
      onPress(foto) {
        final newListFotos = widget.propiedad.galeria.map(
          (f) {
            if (f != foto) {
              return f;
            } else {
              return '';
            }
          },
        ).toList();

        setState(() {
          newListFotos.remove('');
          widget.propiedad.galeria = newListFotos;
          final int index =
              propiedadesProvider.listpropiedades.indexOf(widget.propiedad);
          propiedadesProvider.listpropiedades.removeAt(index);
          propiedadesProvider.listpropiedades.insert(index, widget.propiedad);
        });
      }

      return Container(
        padding: EdgeInsets.all(kDefaultPadding),
        child: Stack(
          children: [
            Image(
              image: NetworkImage(foto),
              fit: BoxFit.cover,
              width: 120,
              height: 120,
            ),
            Positioned(
                right: 0,
                child: IconButton(
                    icon: Icon(
                      Icons.close,
                      size: 20,
                      color: Colors.red,
                    ),
                    onPressed: () async {
                      onPress(foto);
                    })),
          ],
        ),
      );
    }).toList();

    return AlertDialog(
      content: Container(
        width: 500,
        height: 500,
        child: Stack(
          children: [
            Text(
                'Galeria de ${widget.propiedad.nombreProp} - ${widget.propiedad.proyecto.nombre}'),
            Padding(
              padding: const EdgeInsets.only(top: kDefaultPadding),
              child: Wrap(
                children: [
                  if (fotos.length == 0)
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Text('NO FOTOS'),
                    ),
                  if (fotos.length > 0) ...fotos,
                ],
              ),
            ),
            Positioned(
                bottom: 10,
                right: kDefaultPadding,
                child: IconButton(
                  icon: Icon(
                    Icons.add_a_photo,
                    size: 40,
                    color: kSecondaryColor,
                  ),
                  onPressed: () async {
                    final photo = await pickImage(context);
                    widget.propiedad.galeria.add(photo);
                    setState(() {});
                  },
                ))
          ],
        ),
      ),
      actions: [
        TextButton(
            onPressed: () async {
              await propiedadesProvider.updateGaleria(
                  widget.propiedad.uid, widget.propiedad.galeria);
              Navigator.of(context).pop();
            },
            child: Text('Guardar')),
        TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Descartar')),
      ],
    );
  }

  pickImage(BuildContext context) async {
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

      try {
        final resp =
            await SomospApi.addPhoto('/uploads/cargar-img', file.bytes!);

        NotificationService.showSnackbarError(
            msg: 'Imagen cambiada con exito', color: Colors.green);
        return resp.data['url'];
      } catch (e) {
        print(e);
      }
    } else {
      // User canceled the picker
    }
  }
}
