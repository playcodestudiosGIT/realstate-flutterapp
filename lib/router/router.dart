import 'package:somosproperties/router/propiedades_handlers.dart';
import 'package:somosproperties/router/proyectos_handlers.dart';
import 'package:somosproperties/router/user_handlers.dart';
import 'package:somosproperties/router/no_page_found_handlers.dart';
import 'package:fluro/fluro.dart';
import 'package:somosproperties/router/admin_handlers.dart';

class Flurorouter {
  static final FluroRouter router = new FluroRouter();

  // Publicas
  static String rootRoute = '/';
  static String buscarRoute = '/buscar';
  static String buscarQueryRoute = '/buscar/:query';
  static String nosotrosRoute = '/nosotros';
  static String empleoRoute = '/empleo';
  static String contactoRoute = '/contacto';
  static String proyectosRoute = '/proyectos';
  static String proyectosIdRoute = '/proyectos/:id';

  // Auth Router
  static String loginRoute = '/auth/login';
  static String registerRoute = '/auth/register';
  static String usuariosRoute = '/usuarios';
  static String seguridadRoute = '/seguridad';
  static String proyEditRoute = '/editproy';
  static String propEditRoute = '/editprop';

  // Usuarios
  static String miconfiguracionRoute = '/micuenta/configuracion';
  static String milistaRoute = '/micuenta/milista';

  // Propiedades
  static String propiedadIDRoute = '/propiedad/:propid/:proyid';
  static String propiedadID = '/propiedad';

  static void configureRoutes() {
    // Auth Routes
    router.define(loginRoute,
        handler: AdminHandlers.login, transitionType: TransitionType.none);
    router.define(registerRoute,
        handler: AdminHandlers.register, transitionType: TransitionType.none);
    router.define(usuariosRoute,
        handler: AdminHandlers.usuarios, transitionType: TransitionType.none);

    router.define(propEditRoute,
        handler: AdminHandlers.propEdit, transitionType: TransitionType.none);
    router.define(proyEditRoute,
        handler: AdminHandlers.proyEdit, transitionType: TransitionType.none);

    // Public Handlers
    router.define(rootRoute,
        handler: UserHandlers.root, transitionType: TransitionType.none);
    router.define(nosotrosRoute,
        handler: UserHandlers.nosotros, transitionType: TransitionType.none);
    router.define(empleoRoute,
        handler: UserHandlers.empleo, transitionType: TransitionType.fadeIn);
    router.define(contactoRoute,
        handler: UserHandlers.contacto, transitionType: TransitionType.fadeIn);
    router.define(buscarRoute,
        handler: UserHandlers.buscar, transitionType: TransitionType.fadeIn);
    router.define(buscarQueryRoute,
        handler: UserHandlers.buscarQuery,
        transitionType: TransitionType.fadeIn);
    router.define(proyectosRoute,
        handler: UserHandlers.proyectos, transitionType: TransitionType.fadeIn);
    router.define(proyectosIdRoute,
        handler: ProyectosHandlers.proyectoid,
        transitionType: TransitionType.fadeIn);

    // Usuarios Handlers
    router.define(miconfiguracionRoute,
        handler: AdminHandlers.miconfiguracion,
        transitionType: TransitionType.fadeIn);
    router.define(seguridadRoute,
        handler: AdminHandlers.seguridad, transitionType: TransitionType.none);

    // Propiedades Handlers
    router.define(propiedadIDRoute,
        handler: PropiedadesHandlers.propiedadid,
        transitionType: TransitionType.none);
    router.define(propiedadID,
        handler: PropiedadesHandlers.propiedadid,
        transitionType: TransitionType.none);

    // 404
    router.notFoundHandler = NoPageFoundHandlers.noPageFound;
  }
}
