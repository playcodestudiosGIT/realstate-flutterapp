import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:somosproperties/constants.dart';
import 'package:somosproperties/datatables/users_datasource.dart';
import 'package:somosproperties/models/usuario.dart';
import 'package:somosproperties/providers/users_provider.dart';
import 'package:somosproperties/services/picker_image.dart';

import 'package:somosproperties/ui/labels/custom_labels.dart';
import 'package:somosproperties/ui/modals/users_modal.dart';

class UsuariosView extends StatefulWidget {
  @override
  State<UsuariosView> createState() => _UsuariosViewState();
}

class _UsuariosViewState extends State<UsuariosView> {
  int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;

  @override
  void initState() {
    super.initState();
    Provider.of<UsersProvider>(context, listen: false).getPaginatedUsers();
  }

  @override
  Widget build(BuildContext context) {
    // final usersProvider = Provider.of<UsersProvider>(context);
    final List<Usuario> users = Provider.of<UsersProvider>(context).users;
    return Container(
      padding: EdgeInsets.only(
          top: kDefaultPadding,
          left: kDefaultPadding / 2,
          right: kDefaultPadding / 2),
      child: ListView(
        physics: ClampingScrollPhysics(),
        children: [
          Text('Usuarios', style: CustomLabels.h1),
          SizedBox(height: 10),
          PaginatedDataTable(
            columns: [
              DataColumn(
                label: Text('Foto'),
              ),
              DataColumn(label: Text('Nombre')),
              DataColumn(label: Text('Email')),
              DataColumn(label: Text('Rol')),
              DataColumn(label: Text('Acciones')),
            ],
            source: UsersDTS(users, context),
            header: Text(
              'Lista de usuarios',
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
                child: Icon(
                  Icons.person_add,
                  color: Colors.white,
                ),
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(kSecondaryColor)),
                onPressed: () {
                  showModalBottomSheet(
                    backgroundColor: Colors.transparent,
                    context: context,
                    builder: (context) => UsersModal(
                      user: null,
                    ),
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
