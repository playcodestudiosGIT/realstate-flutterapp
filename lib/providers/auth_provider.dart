import 'package:somosproperties/api/somosp_api.dart';
import 'package:somosproperties/models/http/auth_response.dart';
import 'package:somosproperties/models/usuario.dart';
import 'package:somosproperties/router/router.dart';
import 'package:somosproperties/services/local_storage.dart';
import 'package:somosproperties/services/navigation_service.dart';
import 'package:somosproperties/services/notification_service.dart';
import 'package:flutter/material.dart';

enum AuthStatus { checking, authenticated, notAuthenticated }

class AuthProvider extends ChangeNotifier {
  AuthStatus authStatus = AuthStatus.checking;
  Usuario? user;

  setUsuario(newUser) {
    user = newUser;
    notifyListeners();
  }

  AuthProvider() {
    this.isAuthenticated();
  }

  login(String email, String password) {
    final Map<String, dynamic> data = {
      'correo': email,
      'password': password,
    };

    // Petición HTTP
    SomospApi.post('/auth/login', data).then((json) {
      final authResponse = AuthResponse.fromMap(json);
      this.user = authResponse.usuario;
      authStatus = AuthStatus.authenticated;
      LocalStorage.prefs.setString('token', authResponse.token);
      NavigationService.replaceTo(Flurorouter.miconfiguracionRoute);
      SomospApi.configureDio();
      notifyListeners();
    }).catchError((e) {
      NotificationService.showSnackbarError(
          msg: 'Credenciales no validas', color: Colors.red);
    });
  }

  Future<bool> isAuthenticated() async {
    final token = LocalStorage.prefs.getString('token');

    if (token == null) {
      authStatus = AuthStatus.notAuthenticated;
      notifyListeners();
      return false;
    }

    try {
      final resp = await SomospApi.httpGet('/auth');
      final authResponse = AuthResponse.fromMap(resp);
      this.user = authResponse.usuario;
      authStatus = AuthStatus.authenticated;
      notifyListeners();
      return true;
    } catch (e) {
      authStatus = AuthStatus.notAuthenticated;
      notifyListeners();
      return false;
    }
  }

  register(String name, String email, String password) {
    final data = {
      "nombre": name,
      "correo": email,
      "password": password,
      "rol": "USER_ROLE"
    };

    // Petición HTTP
    SomospApi.post('/usuarios', data).then((json) {
      final authResponse = AuthResponse.fromMap(json);
      this.user = authResponse.usuario;
      authStatus = AuthStatus.authenticated;
      LocalStorage.prefs.setString('token', authResponse.token);
      SomospApi.configureDio();
      NavigationService.replaceTo(Flurorouter.miconfiguracionRoute);
      notifyListeners();
    }).catchError((e) {
      NotificationService.showSnackbarError(
          msg: 'Credenciales no validas', color: Colors.red);
    });
  }

  logout() {
    LocalStorage.prefs.clear();
    authStatus = AuthStatus.notAuthenticated;
    notifyListeners();
  }

  void updateListeners() {
    notifyListeners();
  }

  Future updateUser() async {
    final data = {'nombre': user!.nombre};
    try {
      // final resp = await SomospApi.put('/usuarios/${user!.uid}', data);
    } catch (e) {
      print('Error en $e');
    }
  }
}
