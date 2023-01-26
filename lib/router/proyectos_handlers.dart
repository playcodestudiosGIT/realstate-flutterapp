import 'package:somosproperties/providers/propiedades_provides.dart';
import 'package:somosproperties/providers/proyectos_provider.dart';
import 'package:somosproperties/providers/sidemenu_provider.dart';
import 'package:somosproperties/ui/views/system/blank_view.dart';
import 'package:somosproperties/ui/views/system/proyecto_id_view.dart';
import 'package:fluro/fluro.dart';
import 'package:provider/provider.dart';

class ProyectosHandlers {
  static Handler proyecto = Handler(handlerFunc: (context, params) {
    Provider.of<SideMenuProvider>(context!, listen: false)
        .setCurrentPageUrl('');

    return BlankView();
  });

  static Handler proyectoid = Handler(handlerFunc: (context, params) {
    final id = params['id']!.first;
    Provider.of<SideMenuProvider>(context!, listen: false)
        .setCurrentPageUrl('');
    Provider.of<PropiedadesProvider>(context, listen: false).getPropiedades();
    Provider.of<PropiedadesProvider>(context, listen: false)
        .getPropiedadesProy(id);
    Provider.of<ProyectosProvider>(context, listen: false).refreshProy(id);

    return ProyectoIDView();
  });
}
