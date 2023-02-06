import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:somosproperties/constants.dart';
import 'package:somosproperties/models/usuario.dart';
import 'package:somosproperties/providers/users_provider.dart';
import 'package:somosproperties/services/notification_service.dart';
import 'package:somosproperties/ui/inputs/custom_inputs.dart';
import 'package:somosproperties/ui/labels/custom_labels.dart';

class UsersModal extends StatefulWidget {
  final Usuario? user;
  const UsersModal({Key? key, this.user}) : super(key: key);

  @override
  State<UsersModal> createState() => _UsersModalState();
}

class _UsersModalState extends State<UsersModal> {
  late String? nombre;
  late String? correo;
  late String? clave;
  late String? rol;
  String? id;

  @override
  void initState() {
    super.initState();
    id = widget.user?.uid;
    nombre = widget.user?.nombre;
    correo = widget.user?.correo;
    clave = '';
    rol = widget.user?.rol;
  }

  @override
  Widget build(BuildContext context) {
    final usersProvider = Provider.of<UsersProvider>(context);
    return Container(
      padding: EdgeInsets.all(kDefaultPadding),
      height: 500,
      width: 300, // expande
      decoration: buildBoxDecoration(),
      child: ListView(children: [
        Column(
          children: [
            Row(
              children: [
                Text(
                  (this.id != null)
                      ? 'Editar: ${widget.user?.nombre}'
                      : 'Nuevo Usuario',
                  style: CustomLabels.h1ColorPrimary
                      .copyWith(fontWeight: FontWeight.w500),
                ),
                Spacer(),
                IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: Icon(
                      Icons.close,
                      color: kBodyTextColor,
                    ))
              ],
            ),
            Divider(
              color: kBodyTextColor.withOpacity(0.3),
            ),
            SizedBox(
              height: kDefaultPadding / 2,
            ),
            Wrap(
              alignment: WrapAlignment.center,
              spacing: kDefaultPadding / 2,
              runSpacing: kDefaultPadding / 2,
              children: [
                Container(
                  width: 200,
                  child: TextFormField(
                    style: TextStyle(color: kPrimaryColor),
                    initialValue: widget.user?.nombre ?? '',
                    onChanged: (value) => nombre = value,
                    decoration: CustomInputs.loginInputDecoration(
                        hint: 'Nombre',
                        label: 'Nombre de usuario',
                        icon: Icons.perm_identity_sharp),
                  ),
                ),
                Container(
                  width: 200,
                  child: TextFormField(
                    style: TextStyle(color: kPrimaryColor),
                    initialValue: widget.user?.correo ?? '',
                    onChanged: (value) {
                      correo = value;
                    },
                    decoration: CustomInputs.loginInputDecoration(
                        hint: 'Correo',
                        label: 'Correo de usuario',
                        icon: Icons.email_outlined),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: kDefaultPadding / 2,
            ),
            Wrap(
              alignment: WrapAlignment.center,
              spacing: kDefaultPadding / 2,
              runSpacing: kDefaultPadding / 2,
              children: [
                Container(
                  width: 200,
                  child: TextFormField(
                    style: TextStyle(color: kPrimaryColor),
                    onChanged: (value) => clave = value,
                    decoration: CustomInputs.loginInputDecoration(
                        hint: 'Contraseña',
                        label: 'Contraseña',
                        icon: Icons.password),
                  ),
                ),
                Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(color: kPrimaryColor)),
                    width: 200,
                    child: DropdownButton(
                      value: this.rol,
                      underline: Container(),
                      isExpanded: true,
                      onChanged: (value) {
                        rol = value.toString();
                        setState(() {});
                      },
                      items: [
                        DropdownMenuItem(
                          value: 'USER_ROLE',
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8),
                            child: Text(
                              'USUARIO',
                              style: CustomLabels.h2ColorPrimary,
                            ),
                          ),
                        ),
                        DropdownMenuItem(
                          value: 'AGENTE_ROLE',
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8),
                            child: Text(
                              'AGENTE',
                              style: CustomLabels.h2ColorPrimary,
                            ),
                          ),
                        ),
                        DropdownMenuItem(
                          value: 'ADMIN_ROLE',
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8),
                            child: Text(
                              'ADMIN',
                              style: CustomLabels.h2ColorPrimary,
                            ),
                          ),
                        )
                      ],
                    )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 20),
                      alignment: Alignment.center,
                      child: ElevatedButton(
                        onPressed: () async {
                          if (id == null) {
                            // Crear
                            await usersProvider.createUser(
                                this.nombre, this.correo, this.clave, this.rol);
                            NotificationService.showSnackbarError(
                                msg: 'Usuario Creado con exito',
                                color: Colors.green);
                          } else {
                            // Actualizar
                            final user = Usuario(
                              uid: this.id,
                              nombre: this.nombre ?? '',
                              correo: this.correo ?? '',
                              rol: this.rol ?? 'USER_ROLE',
                            );
                            await usersProvider.updateUser(this.clave, user);
                            NotificationService.showSnackbarError(
                                msg: 'Usuario actualizado con exito',
                                color: Colors.green);
                          }

                          Navigator.of(context).pop();
                        },
                        child: Text('Crear'),
                      ),
                    ),
                    SizedBox(
                      width: kDefaultPadding,
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 20),
                      alignment: Alignment.center,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text('Descartar'),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
      ]),
    );
  }

  BoxDecoration buildBoxDecoration() => BoxDecoration(
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20), topRight: Radius.circular(20)),
      color: kBgColor,
      boxShadow: [BoxShadow(color: Colors.black)]);
}
