import 'dart:convert';

import 'package:file_picker/file_picker.dart';

import 'package:somosproperties/api/somosp_api.dart';
import 'package:somosproperties/constants.dart';
import 'package:somosproperties/models/usuario.dart';
import 'package:somosproperties/providers/auth_provider.dart';
import 'package:somosproperties/providers/users_provider.dart';
import 'package:somosproperties/services/notification_service.dart';
import 'package:somosproperties/ui/inputs/custom_inputs.dart';
import 'package:flutter/material.dart';

import 'package:somosproperties/ui/labels/custom_labels.dart';
import 'package:somosproperties/ui/cards/white_card.dart';
import 'package:provider/provider.dart';

class ConfiguracionView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AuthProvider>(context).user!;
    return Container(
      padding: EdgeInsets.only(left: kDefaultPadding),
      child: ListView(
        physics: ClampingScrollPhysics(),
        children: [
          SizedBox(
            height: kDefaultPadding,
          ),
          Row(
            children: [
              Text('Configuración', style: CustomLabels.h1),
              Text(' (En construcción)')
            ],
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
            child: _UserConfigurationBody(usuario: user),
          ),
          SizedBox(
            height: 30,
          )
        ],
      ),
    );
  }
}

class _UserConfigurationBody extends StatelessWidget {
  final Usuario usuario;

  const _UserConfigurationBody({Key? key, required this.usuario})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Wrap(
      alignment: WrapAlignment.center,
      children: [
        _Avatar(usuario: usuario),
        // form
        _UserForm(usuario: usuario)
      ],
    ));
  }
}

class _UserForm extends StatelessWidget {
  final Usuario usuario;
  const _UserForm({
    Key? key,
    required this.usuario,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    return WhiteCard(
      isDrag: false,
      width: 350,
      title: 'Información General',
      child: Form(
        autovalidateMode: AutovalidateMode.always,
        child: Column(
          children: [
            TextFormField(
              initialValue: usuario.nombre,
              decoration: CustomInputs.formInputDecoration(
                hint: 'Nombre del Usuario',
                icon: Icons.supervised_user_circle_outlined,
                label: 'Nombre',
              ),
              onChanged: (value) {
                authProvider.user!.nombre = value;
                authProvider.updateListeners();
              },
              validator: ((value) {
                if (value == null || value.isEmpty) return 'Ingrese un nombre';
                if (value.length <= 2)
                  return 'El nombre debe contener mas de 3 caracteres';
                return null;
              }),
            ),
            SizedBox(
              height: kDefaultPadding,
            ),
            TextFormField(
              enabled: false,
              initialValue: usuario.correo,
              decoration: CustomInputs.formInputDecoration(
                hint: 'Correo Electrónico',
                icon: Icons.email_outlined,
                label: 'El correo no se puede cambiar',
              ),
            ),
            SizedBox(
              height: kDefaultPadding,
            ),
            ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 120),
              child: ElevatedButton(
                onPressed: () async {
                  final saved = await authProvider.updateUser();
                  if (saved) {
                    NotificationService.showSnackbarError(
                        msg: 'Usuario Actualizado', color: Colors.green);
                  } else {
                    NotificationService.showSnackbarError(
                        msg: 'No se pudo actualizar', color: Colors.red);
                  }
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(kSecondaryColor),
                  shadowColor: MaterialStateProperty.all(Colors.transparent),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.save_outlined,
                      color: Colors.white,
                    ),
                    Text(
                      '  Guardar',
                      style: TextStyle(color: Colors.white),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _Avatar extends StatefulWidget {
  final Usuario usuario;
  const _Avatar({Key? key, required this.usuario}) : super(key: key);

  @override
  State<_Avatar> createState() => _AvatarState();
}

class _AvatarState extends State<_Avatar> {
  @override
  Widget build(BuildContext context) {
    // final usersProvider = Provider.of<UsersProvider>(context);
    // final users = Provider.of<UsersProvider>(context).users;
    final authProvider = Provider.of<AuthProvider>(context);

    return WhiteCard(
      isDrag: false,
      title: 'Perfil',
      width: 350,
      child: Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: kDefaultPadding,
            ),
            Container(
              width: 150,
              height: 160,
              child: Stack(
                children: [
                  ClipOval(
                      child: Image(
                          image: NetworkImage(widget.usuario.img ??
                              'https://res.cloudinary.com/dnejayiiq/image/upload/v1671851591/no-image_xb946x.jpg'))),
                  Positioned(
                    bottom: 5,
                    right: 5,
                    child: Container(
                      width: 45,
                      height: 45,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          border: Border.all(color: Colors.white, width: 5)),
                      child: FloatingActionButton(
                        child: Icon(
                          Icons.camera_alt_outlined,
                          size: 20,
                          color: Colors.white,
                        ),
                        elevation: 0,
                        backgroundColor: kSecondaryColor,
                        onPressed: () async {
                          FilePickerResult? result = await FilePicker.platform
                              .pickFiles(type: FileType.any);

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
                                                Text(
                                                    'La extension debe ser "PNG, JPG ó JPEG"'),
                                                SizedBox(
                                                  height: 60,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    ElevatedButton(
                                                        onPressed: () =>
                                                            Navigator.pop(
                                                                context),
                                                        child:
                                                            Text('Entendido'))
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
                                                  Text(
                                                      'La imagen debe pesar menos de 1 MB'),
                                                  SizedBox(
                                                    height: 60,
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    children: [
                                                      ElevatedButton(
                                                          onPressed: () =>
                                                              Navigator.pop(
                                                                  context),
                                                          child:
                                                              Text('Entendido'))
                                                    ],
                                                  )
                                                ],
                                              ))))));
                            }

                            final resp = await SomospApi.editUserImg(
                                '/uploads/usuarios/${widget.usuario.uid}',
                                file.bytes!);

                            final Usuario newUser =
                                Usuario.fromMap(jsonDecode(resp.toString()));

                            authProvider.setUsuario(newUser);
                            NotificationService.showSnackbarError(
                                msg: 'Imagen cambiada con exito',
                                color: Colors.green);
                          } else {
                            // User canceled the picker
                          }
                        },
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: kDefaultPadding,
            ),
            Container(
              width: 244,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.usuario.nombre,
                    style: CustomLabels.h2ColorPrimary,
                  ),
                  SizedBox(
                    height: kDefaultPadding,
                  ),
                  Text(
                    widget.usuario.correo,
                    style: CustomLabels.h2ColorPrimary,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
