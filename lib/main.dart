import 'package:somosproperties/api/emailjs.dart';
import 'package:somosproperties/api/somosp_api.dart';
import 'package:somosproperties/providers/busqueda_provider.dart';
import 'package:somosproperties/providers/contacto_form_provider.dart';
import 'package:somosproperties/providers/empleo_form_provider.dart';
import 'package:somosproperties/providers/propiedades_provides.dart';
import 'package:somosproperties/providers/proyectoId_carrousel_provider.dart';
import 'package:somosproperties/providers/proyectos_provider.dart';
import 'package:somosproperties/providers/register_form_provider.dart';
import 'package:somosproperties/providers/users_provider.dart';
import 'package:somosproperties/services/notification_service.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:somosproperties/ui/layouts/dashboard/dashboard_layout.dart';
import 'package:somosproperties/ui/layouts/splash/splash_layout.dart';

import 'package:somosproperties/router/router.dart';

import 'package:somosproperties/providers/auth_provider.dart';
import 'package:somosproperties/providers/sidemenu_provider.dart';

import 'package:somosproperties/services/local_storage.dart';
import 'package:somosproperties/services/navigation_service.dart';
import 'package:seo_renderer/seo_renderer.dart';

void main() async {
  await LocalStorage.configurePrefs();
  SomospApi.configureDio();
  SendEmail.configureDio();
  Flurorouter.configureRoutes();
  runApp(AppState());
}

class AppState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            lazy: false, create: (_) => RegisterFormProvider()),
        ChangeNotifierProvider(lazy: false, create: (_) => AuthProvider()),
        ChangeNotifierProvider(lazy: false, create: (_) => SideMenuProvider()),
        ChangeNotifierProvider(create: (_) => UsersProvider()),
        ChangeNotifierProvider(create: (_) => ContactoFormProvider()),
        ChangeNotifierProvider(create: (_) => EmpleoFormProvider()),
        ChangeNotifierProvider(create: (_) => ProyectosProvider()),
        ChangeNotifierProvider(create: (_) => PropiedadesProvider()),
        ChangeNotifierProvider(create: (_) => BusquedasProvider()),
        ChangeNotifierProvider(create: (_) => ProyectoCarrouselProvider()),
      ],
      child: MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RobotDetector(
      debug: true,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Somos Properties - Venta y Alquiler de propiedades',
        initialRoute: '/',
        onGenerateRoute: Flurorouter.router.generator,
        navigatorKey: NavigationService.navigatorKey,
        navigatorObservers: [seoRouteObserver],
        scaffoldMessengerKey: NotificationService.msgKey,
        builder: (_, child) {
          final authProvider = Provider.of<AuthProvider>(context);
          Provider.of<PropiedadesProvider>(context, listen: false)
              .getPropiedades();
          Provider.of<ProyectosProvider>(context, listen: false).getProyectos();
          if (authProvider.authStatus == AuthStatus.checking)
            return SplashLayout();

          if (authProvider.authStatus == AuthStatus.authenticated) {
            return DashboardLayout(child: child!);
          } else {
            return DashboardLayout(child: child!);
          }
        },
        scrollBehavior: MyCustomScrollBehavior(),
        theme: ThemeData.light().copyWith(
            hoverColor: Colors.transparent,
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            scrollbarTheme: ScrollbarThemeData().copyWith(
                thumbColor:
                    MaterialStateProperty.all(Colors.grey.withOpacity(0.5)))),
      ),
    );
  }
}

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  // Override behavior methods and getters like dragDevices
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
        // etc.
      };
}
