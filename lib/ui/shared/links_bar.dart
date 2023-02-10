import 'package:somosproperties/constants.dart';
import 'package:somosproperties/router/router.dart';
import 'package:somosproperties/services/navigation_service.dart';
import 'package:somosproperties/ui/buttons/link_text.dart';
import 'package:flutter/material.dart';

class LinksBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
        color: kPrimaryColor,
        width: size.width,
        height: (size.width > 1323) ? size.height * 0.07 : null,
        child: Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          alignment: WrapAlignment.center,
          children: [
            Container(
              height: 40,
              width: 200,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image(
                    image: NetworkImage(
                        'https://res.cloudinary.com/dnejayiiq/image/upload/v1672611233/somospisoblanco_rl0zca.png'),
                    width: (size.width < 400) ? 30 : 40,
                  ),
                  LinkText(
                      text: 'Somos Properties',
                      color: Colors.white,
                      onPressed: () => NavigationService.navigateTo(
                          Flurorouter.nosotrosRoute)),
                ],
              ),
            ),
            LinkText(
                text:
                    'Calle 50, Av. Elvira Mendez,\nPH El Ejecutivo, Ofic. 303',
                color: Colors.white,
                onPressed: () =>
                    NavigationService.navigateTo(Flurorouter.nosotrosRoute)),
            //TODO: politicas
            // LinkText( text: 'Centro de ayuda', color: kSecondaryColor, onPressed: () => 'Centro de ayuda') ),
            // LinkText( text: 'Terminos y condiciones', color: kSecondaryColor, onPressed: () => print('Terminos y condiciones') ),
            // LinkText( text: 'Politicas de Privacidad', color: kSecondaryColor, onPressed: () => print('Politicas de Privacidad') ),
            // LinkText( text: 'Politica de Cookies', color: kSecondaryColor, onPressed: () => print('Politica de Cookies') ),
            // LinkText( text: 'información de Ads', color: kSecondaryColor, onPressed: () => print('información de Ads') ),
            // LinkText( text: 'Trabaja con nosotros', color: kSecondaryColor, onPressed: () => print('Trabaja con nosotros') ),
          ],
        ));
  }
}
