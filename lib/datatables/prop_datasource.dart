import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:somosproperties/api/somosp_api.dart';
import 'package:somosproperties/constants.dart';
import 'package:somosproperties/models/propiedad.dart';
import 'package:somosproperties/providers/users_provider.dart';
import 'package:somosproperties/services/notification_service.dart';
import 'package:somosproperties/ui/cards/white_card.dart';

class PropsDTS extends DataTableSource {
  List<Propiedad> propiedades;
  final BuildContext context;

  PropsDTS(this.propiedades, this.context);

  @override
  DataRow getRow(int index) {
    final propiedad = this.propiedades[index];

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
        onTap: () => pickImage(context, propiedad.uid.toString()),
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
          final List<Widget> fotos = propiedad.galeria
              .map((foto) => Container(
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
                              onPressed: () {},
                            )),
                      ],
                    ),
                  ))
              .toList();
          final dialog = AlertDialog(
            content: Container(
              width: 500,
              height: 500,
              child: Column(
                children: [
                  Text(
                      'Galeria de ${propiedad.nombreProp} - ${propiedad.proyecto.nombre}'),
                  Wrap(
                    children: [
                      if (fotos.length == 0) Text('NO FOTOS'),
                      if (fotos.length > 0) ...fotos,
                      Container(
                          width: 120,
                          height: 120,
                          padding: EdgeInsets.all(kDefaultPadding),
                          child: Center(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                IconButton(
                                  icon: Icon(
                                    Icons.add_a_photo,
                                    size: 40,
                                    color: Colors.grey,
                                  ),
                                  onPressed: () {},
                                ),
                              ],
                            ),
                          ))
                    ],
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('si')),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('no')),
            ],
          );
          showDialog(
            context: context,
            builder: (context) => dialog,
          );
        },
      ),
      DataCell(Row(
        children: [
          IconButton(
              onPressed: () {
                final dialog = AlertDialog(
                  title: Text('Editar Propiedad'),
                  content: Text(
                    'Formulario',
                  ),
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text('Crear')),
                    TextButton(
                        onPressed: () async {
                          //BORRAR USUARIO
                          // await Provider.of<UsersProvider>(context,
                          //         listen: false)
                          //     .deleteUser(user.uid.toString());
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
                      'Borrar definitivamente el usuario "${propiedad.nombreProp}"'),
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text('No')),
                    TextButton(
                        onPressed: () async {
                          //BORRAR USUARIO
                          await Provider.of<UsersProvider>(context,
                                  listen: false)
                              .deleteUser(propiedad.uid.toString());
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
  int get rowCount => propiedades.length;

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
        // print('extension no permitida');
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

      final img =
          await SomospApi.editUserImg('/uploads/propiedades/$id', file.bytes!);

      print(img);
      this.propiedades.map(
        (prop) {
          if (prop.uid != id) return prop;
          prop.img = img;
          return prop;
        },
      ).toList();
      notifyListeners();
      NotificationService.showSnackbarError(
          msg: 'Imagen cambiada con exito', color: Colors.green);
    } else {
      // User canceled the picker
    }
  }
}
