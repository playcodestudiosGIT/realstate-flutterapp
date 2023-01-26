import 'package:somosproperties/providers/propiedades_provides.dart';
import 'package:somosproperties/ui/views/menu/buscar_view.dart';
import 'package:somosproperties/ui/views/menu/contacto_view.dart';
import 'package:somosproperties/ui/views/menu/empleo_view.dart';
import 'package:somosproperties/ui/views/menu/nosotros_view.dart';
import 'package:somosproperties/ui/views/menu/proyectos_view.dart';
import 'package:fluro/fluro.dart';
import 'package:provider/provider.dart';

import 'package:somosproperties/router/router.dart';

import 'package:somosproperties/providers/sidemenu_provider.dart';

import 'package:somosproperties/ui/views/system/main_view.dart';

class UserHandlers {
  static Handler root = Handler(handlerFunc: (context, params) {
    Provider.of<SideMenuProvider>(context!, listen: false)
        .setCurrentPageUrl(Flurorouter.rootRoute);

    return MainView();
  });

  static Handler nosotros = Handler(handlerFunc: (context, params) {
    Provider.of<SideMenuProvider>(context!, listen: false)
        .setCurrentPageUrl(Flurorouter.nosotrosRoute);

    return NosotrosView();
  });

  static Handler empleo = Handler(handlerFunc: (context, params) {
    Provider.of<SideMenuProvider>(context!, listen: false)
        .setCurrentPageUrl(Flurorouter.empleoRoute);

    return EmpleoView();
  });

  static Handler contacto = Handler(handlerFunc: (context, params) {
    Provider.of<SideMenuProvider>(context!, listen: false)
        .setCurrentPageUrl(Flurorouter.contactoRoute);

    return ContactoView();
  });

  static Handler buscar = Handler(handlerFunc: (context, params) {
    Provider.of<SideMenuProvider>(context!, listen: false)
        .setCurrentPageUrl(Flurorouter.buscarRoute);


    return BuscarView();
  });

  static Handler buscarQuery = Handler(handlerFunc: (context, params) {
    Provider.of<SideMenuProvider>(context!, listen: false)
        .setCurrentPageUrl(Flurorouter.buscarRoute);
    final query = params['query']!.first;

    Provider.of<PropiedadesProvider>(context, listen: false).getPropiedades();

    return BuscarView();
  });

  static Handler proyectos = Handler(handlerFunc: (context, params) {
    Provider.of<SideMenuProvider>(context!, listen: false)
        .setCurrentPageUrl(Flurorouter.proyectosRoute);
    return ProyectosView();
  });
}
