import 'package:somosproperties/providers/propiedades_provides.dart';
import 'package:somosproperties/providers/proyectos_provider.dart';
import 'package:somosproperties/providers/sidemenu_provider.dart';
import 'package:somosproperties/ui/views/system/blank_view.dart';
import 'package:somosproperties/ui/views/system/propiedad_id_view.dart';
import 'package:fluro/fluro.dart';

import 'package:provider/provider.dart';

class PropiedadesHandlers {
  static Handler propiedad = Handler(handlerFunc: (context, params) {
    Provider.of<SideMenuProvider>(context!, listen: false)
        .setCurrentPageUrl('');

    return BlankView();
  });

  static Handler propiedadid = Handler(handlerFunc: (context, params) {
    Provider.of<SideMenuProvider>(context!, listen: false)
        .setCurrentPageUrl('');

    final propid = params['propid']!.first;
    final proyid = params['proyid']!.first;

    Provider.of<PropiedadesProvider>(context, listen: false).getPropiedades();
    Provider.of<PropiedadesProvider>(context, listen: false)
        .setPropiedadView(propid);
    Provider.of<PropiedadesProvider>(context, listen: false)
        .getPropiedadesProy(proyid);
    Provider.of<ProyectosProvider>(context, listen: false)
        .setProyectoView(proyid);
    Provider.of<ProyectosProvider>(context, listen: false).refreshProy(proyid);

    return PropiedadIDView();
  });
}
