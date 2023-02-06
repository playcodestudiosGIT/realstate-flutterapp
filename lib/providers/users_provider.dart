import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:somosproperties/api/somosp_api.dart';
import 'package:somosproperties/models/http/auth_response.dart';
import 'package:somosproperties/models/http/users_response.dart';
import 'package:somosproperties/models/usuario.dart';
import 'package:somosproperties/providers/auth_provider.dart';

import '../services/notification_service.dart';

class UsersProvider extends ChangeNotifier {
  List<Usuario> users = [];
  int total = 0;
  bool isLoading = false;

  setUsers(newUsers) {
    users = newUsers;
    notifyListeners();
  }

  getPaginatedUsers() async {
    isLoading = true;
    final resp = await SomospApi.httpGet('/usuarios/obtener');
    final userResponse = RespUsers.fromRawJson(jsonEncode(resp));

    users = userResponse.users;
    total = userResponse.total;

    isLoading = false;
    notifyListeners();
  }

  notify() {
    notifyListeners();
  }

  createUser(String? name, String? email, String? password, String? rol) {
    final data = {
      "nombre": name,
      "correo": email,
      "password": password,
      "rol": rol
    };

    // Petición HTTP
    SomospApi.post('/usuarios', data).then((json) {
      final authResponse = AuthResponse.fromMap(json);
      users.add(authResponse.usuario);
      notifyListeners();
    }).catchError((e) {
      print('ERROR USER CREATE $e');
    });
  }

  Future updateUser(String? pass, Usuario user) async {
    final data = {
      "nombre": user.nombre,
      "correo": user.correo,
      "password": pass,
      "rol": user.rol,
    };

    try {
      final json = await SomospApi.put('/usuarios/${user.uid}', data);

      this.users = this.users.map(
        (u) {
          if (u.uid != user.uid) return u;
          u = Usuario.fromMap(json['usuario']);
          return u;
        },
      ).toList();

      notifyListeners();
    } catch (e) {
      print('Error en el update user');
    }
  }

  Future deleteUser(String id) async {
    try {
      final resp = await SomospApi.delete('/usuarios/$id', {});

      users.removeWhere(
        (user) => user.uid == id,
      );

      notifyListeners();
      return true;
    } catch (e) {
      print('Error en el delete user');
    }
    return false;
  }

  Future updateImge(String id, file) async {
    final user =
        await SomospApi.editUserImg('/uploads/usuarios/$id', file.bytes!);

    final Usuario newUser = Usuario.fromMap(jsonDecode(user.toString()));

    this.users = users.map((u) {
      if (u.uid != id) return u;
      u.img = newUser.img;
      return u;
    }).toList();
    notifyListeners();
  }
}
