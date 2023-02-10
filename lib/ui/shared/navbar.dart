import 'package:somosproperties/constants.dart';
import 'package:somosproperties/providers/auth_provider.dart';
import 'package:somosproperties/providers/propiedades_provides.dart';
import 'package:somosproperties/providers/sidemenu_provider.dart';
import 'package:somosproperties/router/router.dart';
import 'package:somosproperties/services/navigation_service.dart';

import 'package:flutter/material.dart';

import 'package:somosproperties/ui/shared/widgets/navbar_avatar.dart';
import 'package:somosproperties/ui/shared/widgets/notifications_indicator.dart';
import 'package:provider/provider.dart';

class Navbar extends StatefulWidget {
  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  @override
  void initState() {
    super.initState();
    Provider.of<PropiedadesProvider>(context, listen: false).getPropiedades();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final authProvider = Provider.of<AuthProvider>(context);

    return Container(
      width: double.infinity,
      height: 50,
      decoration: buildBoxDecoration(),
      child: Row(
        children: [
          if (size.width <= kDefaultBreak)
            IconButton(
                color: kBgColor,
                icon: Icon(Icons.menu_outlined),
                onPressed: () => SideMenuProvider.openMenu()),
          SizedBox(width: 5),
          if (Provider.of<SideMenuProvider>(context).currentPage !=
              Flurorouter.buscarRoute)
            if (Provider.of<SideMenuProvider>(context).currentPage !=
                Flurorouter.rootRoute)
              IconButton(
                  onPressed: () {
                    NavigationService.navigateTo('${Flurorouter.rootRoute}');
                  },
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  )),
          if (Provider.of<SideMenuProvider>(context).currentPage !=
              Flurorouter.buscarRoute)
            IconButton(
                onPressed: () {
                  NavigationService.navigateTo('${Flurorouter.buscarRoute}/');
                },
                icon: Icon(
                  Icons.search_outlined,
                  color: Colors.white,
                )),
          Spacer(),
          if (authProvider.authStatus == AuthStatus.authenticated) ...[
            // NotificationsIndicator(),
            SizedBox(width: 10),
            NavbarAvatar(),
            SizedBox(width: 10)
          ],
          if (authProvider.authStatus == AuthStatus.notAuthenticated)
            ElevatedButton(
              style: ButtonStyle(
                side: MaterialStateProperty.all(
                    BorderSide(color: kSecondaryColor)),
                backgroundColor: MaterialStateProperty.all(kSecondaryColor),
              ),
              child: Text(
                'LOG IN',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
              onPressed: () =>
                  NavigationService.navigateTo(Flurorouter.loginRoute),
            ),
          SizedBox(
            width: kDefaultPadding,
          )
        ],
      ),
    );
  }

  BoxDecoration buildBoxDecoration() => BoxDecoration(
      color: kPrimaryColor,
      boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 5)]);
}
