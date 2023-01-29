import 'package:somosproperties/providers/auth_provider.dart';
import 'package:somosproperties/providers/sidemenu_provider.dart';
import 'package:somosproperties/router/router.dart';
import 'package:somosproperties/ui/views/admin/proys_edit_view.dart';
import 'package:somosproperties/ui/views/admin/usuarios_view.dart';
import 'package:somosproperties/ui/views/mi_cuenta/seguridad_view.dart';
import 'package:somosproperties/ui/views/admin/props_edit_view.dart';
import 'package:somosproperties/ui/views/mi_cuenta/configuracion_view.dart';
import 'package:somosproperties/ui/views/system/main_view.dart';
import 'package:fluro/fluro.dart';

import 'package:somosproperties/ui/views/auth/login_view.dart';
import 'package:somosproperties/ui/views/auth/register_view.dart';
import 'package:provider/provider.dart';

class AdminHandlers {
  static Handler login = Handler(handlerFunc: (context, params) {
    Provider.of<SideMenuProvider>(context!, listen: false)
        .setCurrentPageUrl('');
    final authProvider = Provider.of<AuthProvider>(context);

    if (authProvider.authStatus == AuthStatus.notAuthenticated)
      return LoginView();
    else
      return MainView();
  });

  static Handler register = Handler(handlerFunc: (context, params) {
    Provider.of<SideMenuProvider>(context!, listen: false)
        .setCurrentPageUrl('');

    final authProvider = Provider.of<AuthProvider>(context);

    if (authProvider.authStatus == AuthStatus.notAuthenticated)
      return RegisterView();
    else
      return MainView();
  });

  static Handler miconfiguracion = Handler(handlerFunc: (context, params) {
    final authProvider = Provider.of<AuthProvider>(context!);
    Provider.of<SideMenuProvider>(context, listen: false)
        .setCurrentPageUrl(Flurorouter.miconfiguracionRoute);

    if (authProvider.authStatus == AuthStatus.authenticated)
      return ConfiguracionView();
    else
      return LoginView();
  });

  static Handler seguridad = Handler(handlerFunc: (context, params) {
    final authProvider = Provider.of<AuthProvider>(context!);
    Provider.of<SideMenuProvider>(context, listen: false)
        .setCurrentPageUrl(Flurorouter.seguridadRoute);

    if (authProvider.authStatus == AuthStatus.authenticated)
      return SeguridadView();
    else
      return LoginView();
  });

  static Handler propEdit = Handler(handlerFunc: (context, params) {
    final authProvider = Provider.of<AuthProvider>(context!);
    Provider.of<SideMenuProvider>(context, listen: false)
        .setCurrentPageUrl(Flurorouter.propEditRoute);

    if (authProvider.authStatus == AuthStatus.authenticated &&
        authProvider.user!.rol == 'ADMIN_ROLE')
      return PropsEditView();
    else
      return LoginView();
  });

  static Handler proyEdit = Handler(handlerFunc: (context, params) {
    final authProvider = Provider.of<AuthProvider>(context!);
    Provider.of<SideMenuProvider>(context, listen: false)
        .setCurrentPageUrl(Flurorouter.proyEditRoute);

    if (authProvider.authStatus == AuthStatus.authenticated &&
        authProvider.user!.rol == 'ADMIN_ROLE')
      return ProysEditView();
    else
      return LoginView();
  });

  static Handler usuarios = Handler(handlerFunc: (context, params) {
    final authProvider = Provider.of<AuthProvider>(context!);
    Provider.of<SideMenuProvider>(context, listen: false)
        .setCurrentPageUrl(Flurorouter.usuariosRoute);

    if (authProvider.authStatus == AuthStatus.authenticated &&
        authProvider.user!.rol == 'ADMIN_ROLE')
      return UsuariosView();
    else
      return LoginView();
  });
}
