import 'package:somosproperties/constants.dart';
import 'package:somosproperties/providers/auth_provider.dart';
import 'package:somosproperties/ui/shared/widgets/menu_item.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import 'package:somosproperties/providers/sidemenu_provider.dart';

import 'package:somosproperties/router/router.dart';

import 'package:somosproperties/services/navigation_service.dart';

import 'package:somosproperties/ui/shared/widgets/logo.dart';
import 'package:somosproperties/ui/shared/widgets/text_separator.dart';
import 'package:url_launcher/url_launcher.dart';

class Sidebar extends StatelessWidget {
  void navigateTo(String routeName) {
    NavigationService.navigateTo(routeName);
    SideMenuProvider.closeMenu();
  }

  @override
  Widget build(BuildContext context) {
    final sideMenuProvider = Provider.of<SideMenuProvider>(context);
    final authProvider = Provider.of<AuthProvider>(context);
    Uri urlInstag =
        Uri.parse('https://www.instagram.com/somosproperties/?hl=es');
    Uri urlFb = Uri.parse('https://www.facebook.com/somosproperties/');
    Uri urlTiktok = Uri.parse('https://www.tiktok.com/amp/tag/somosproperties');
    return Container(
      width: 200,
      height: double.infinity,
      decoration: buildBoxDecoration(),
      child: ListView(
        physics: ClampingScrollPhysics(),
        children: [
          Logo(),
          SizedBox(height: 50),
          TextSeparator(text: 'MENU'),
          MenuItemSP(
            text: 'Inicio',
            icon: Icons.home,
            onPressed: () => navigateTo(Flurorouter.rootRoute),
            isActive: sideMenuProvider.currentPage == Flurorouter.rootRoute,
          ),
          MenuItemSP(
            text: 'Propiedades',
            icon: Icons.home_work,
            onPressed: () => navigateTo('${Flurorouter.buscarRoute}/'),
            isActive: sideMenuProvider.currentPage == Flurorouter.buscarRoute,
          ),
          MenuItemSP(
            text: 'Proyectos',
            icon: Icons.location_city,
            onPressed: () => navigateTo(Flurorouter.proyectosRoute),
            isActive:
                sideMenuProvider.currentPage == Flurorouter.proyectosRoute,
          ),
          MenuItemSP(
            text: 'Nosotros',
            icon: Icons.supervised_user_circle,
            onPressed: () => navigateTo('${Flurorouter.nosotrosRoute}'),
            isActive: sideMenuProvider.currentPage == Flurorouter.nosotrosRoute,
          ),
          MenuItemSP(
            text: 'Empleo',
            icon: Icons.work,
            onPressed: () => navigateTo('${Flurorouter.empleoRoute}'),
            isActive: sideMenuProvider.currentPage == Flurorouter.empleoRoute,
          ),
          MenuItemSP(
            text: 'Contacto',
            icon: Icons.contact_mail,
            onPressed: () => navigateTo('${Flurorouter.contactoRoute}'),
            isActive: sideMenuProvider.currentPage == Flurorouter.contactoRoute,
          ),
          SizedBox(height: 30),
          if (authProvider.authStatus == AuthStatus.authenticated) ...[
            TextSeparator(text: 'MI CUENTA'),
            MenuItemSP(
              text: 'Configuración',
              icon: Icons.manage_accounts_outlined,
              onPressed: () => navigateTo(Flurorouter.miconfiguracionRoute),
              isActive: sideMenuProvider.currentPage ==
                  Flurorouter.miconfiguracionRoute,
            ),
            MenuItemSP(
              text: 'Seguridad',
              icon: Icons.security,
              onPressed: () => navigateTo(Flurorouter.seguridadRoute),
              isActive:
                  sideMenuProvider.currentPage == Flurorouter.seguridadRoute,
            ),
          ],
          if (authProvider.authStatus == AuthStatus.authenticated &&
              authProvider.user!.rol == 'ADMIN_ROLE') ...[
            SizedBox(height: 50),
            TextSeparator(text: 'MANTENIMIENTO'),
            MenuItemSP(
                text: 'Usuarios',
                icon: Icons.people,
                isActive:
                    sideMenuProvider.currentPage == Flurorouter.usuariosRoute,
                onPressed: () {
                  navigateTo(Flurorouter.usuariosRoute);
                }),
            MenuItemSP(
                text: 'Propiedades',
                icon: Icons.add_home,
                isActive:
                    sideMenuProvider.currentPage == Flurorouter.propEditRoute,
                onPressed: () {
                  navigateTo(Flurorouter.propEditRoute);
                }),
            MenuItemSP(
                text: 'Proyectos',
                icon: Icons.add_home_work,
                isActive:
                    sideMenuProvider.currentPage == Flurorouter.proyEditRoute,
                onPressed: () {
                  navigateTo(Flurorouter.proyEditRoute);
                }),
          ],
          if (authProvider.authStatus == AuthStatus.authenticated) ...[
            SizedBox(height: 50),
            TextSeparator(text: 'Exit'),
            MenuItemSP(
                text: 'Logout',
                icon: Icons.exit_to_app_outlined,
                onPressed: () {
                  authProvider.logout();
                  navigateTo(Flurorouter.rootRoute);
                }),
          ],
          SizedBox(
            height: 100,
          ),
          Container(
              color: kPrimaryColor,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {
                      launchUrl(urlFb);
                    },
                    icon: (FaIcon(FontAwesomeIcons.facebook)),
                    color: Colors.white,
                  ),
                  IconButton(
                    onPressed: () {
                      launchUrl(urlInstag);
                    },
                    icon: (FaIcon(FontAwesomeIcons.instagram)),
                    color: Colors.white,
                  ),
                  IconButton(
                    onPressed: () {
                      launchUrl(urlTiktok);
                    },
                    icon: (FaIcon(FontAwesomeIcons.tiktok)),
                    color: Colors.white,
                  ),
                ],
              )),
        ],
      ),
    );
  }

  BoxDecoration buildBoxDecoration() => BoxDecoration(
      gradient: LinearGradient(colors: [Color(0xff092042), kPrimaryColor]),
      boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 10)]);
}
