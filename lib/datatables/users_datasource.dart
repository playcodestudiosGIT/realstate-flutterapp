import 'dart:convert';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:somosproperties/api/somosp_api.dart';
import 'package:somosproperties/constants.dart';
import 'package:somosproperties/models/usuario.dart';
import 'package:somosproperties/providers/users_provider.dart';
import 'package:somosproperties/services/notification_service.dart';
import 'package:somosproperties/ui/cards/white_card.dart';
import 'package:somosproperties/ui/modals/users_modal.dart';

class UsersDTS extends DataTableSource {
  List<Usuario> users;
  final BuildContext context;

  UsersDTS(this.users, this.context);

  @override
  DataRow getRow(int index) {
    final user = this.users[index];

    return DataRow.byIndex(index: index, cells: [
      DataCell(
        Stack(
          children: [
            Positioned(
                bottom: 0,
                right: 0,
                child: Icon(
                  Icons.edit_outlined,
                  size: 15,
                  color: kPrimaryColor,
                )),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(
                radius: 25,
                backgroundColor: kSecondaryColor,
                backgroundImage: NetworkImage(user.img ??
                    'https://res.cloudinary.com/dnejayiiq/image/upload/v1671851591/no-image_xb946x.jpg'),
              ),
            ),
          ],
        ),
        onTap: () => pickImage(context, user.uid.toString()),
      ),
      DataCell(Text(user.nombre)),
      DataCell(Text(user.correo)),
      DataCell(Text(user.rol)),
      DataCell(Row(
        children: [
          IconButton(
              onPressed: () {
                showModalBottomSheet(
                  backgroundColor: Colors.transparent,
                  context: context,
                  builder: (context) => UsersModal(user: user),
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
                      'Borrar definitivamente el usuario "${user.nombre}"'),
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text('No')),
                    TextButton(
                        onPressed: () async {
                          //BORRAR USUARIO
                          final isDelete = await Provider.of<UsersProvider>(
                                  context,
                                  listen: false)
                              .deleteUser(user.uid.toString());
                          Navigator.of(context).pop();
                          if (isDelete) {
                            NotificationService.showSnackbarError(
                                msg: 'Usuario "${user.nombre}" Eliminado',
                                color: Colors.green);
                          } else {
                            NotificationService.showSnackbarError(
                                msg: 'Error Eliminando Usuario',
                                color: Colors.red);
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
  int get rowCount => users.length;

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

      final user =
          await SomospApi.editUserImg('/uploads/usuarios/$id', file.bytes!);
      final Usuario newUser = Usuario.fromMap(jsonDecode(user.toString()));
      this.users = users.map((u) {
        if (u.uid != id) return u;
        u.img = newUser.img;
        return u;
      }).toList();
      notifyListeners();
      NotificationService.showSnackbarError(
          msg: 'Imagen cambiada con exito', color: Colors.green);
    } else {
      // User canceled the picker
    }
  }
}
