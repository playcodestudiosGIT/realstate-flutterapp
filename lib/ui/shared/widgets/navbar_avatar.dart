import 'package:somosproperties/providers/auth_provider.dart';
import 'package:somosproperties/router/router.dart';
import 'package:somosproperties/services/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NavbarAvatar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () =>
            NavigationService.navigateTo(Flurorouter.miconfiguracionRoute),
        child: Row(
          children: [
            ClipOval(
              child: Container(
                child: Image.network(authProvider.user!.img ??
                    'https://res.cloudinary.com/dnejayiiq/image/upload/v1671851591/no-image_xb946x.jpg'),
                width: 30,
                height: 30,
              ),
            ),
            // SizedBox(
            //   width: kDefaultPadding / 2,
            // ),
            // // Text(
            // //   authProvider.user!.nombre,
            // //   style: GoogleFonts.roboto(
            // //       color: kSecondaryColor,
            // //       fontSize: 14,
            // //       fontWeight: FontWeight.w500),
            // // ),
          ],
        ),
      ),
    );
  }
}
