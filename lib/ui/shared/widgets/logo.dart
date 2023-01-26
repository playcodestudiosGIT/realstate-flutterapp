import 'package:seo_renderer/renderers/text_renderer/text_renderer_style.dart';
import 'package:seo_renderer/renderers/text_renderer/text_renderer_vm.dart';
import 'package:somosproperties/constants.dart';
import 'package:somosproperties/providers/sidemenu_provider.dart';
import 'package:somosproperties/router/router.dart';
import 'package:somosproperties/services/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:somosproperties/ui/labels/custom_labels.dart';

class Logo extends StatefulWidget {
  @override
  State<Logo> createState() => _LogoState();
}

class _LogoState extends State<Logo> with SingleTickerProviderStateMixin {
  late AnimationController controller;
  bool isOpen = SideMenuProvider.isOpen;

  @override
  void initState() {
    super.initState();

    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 200));
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
        padding: EdgeInsets.only(top: 30),
        child: Stack(children: [
          GestureDetector(
            onTap: () => NavigationService.navigateTo(Flurorouter.rootRoute),
            child: MouseRegion(
              cursor: SystemMouseCursors.click,
              child: Padding(
                padding: const EdgeInsets.all(kDefaultPadding),
                child: Column(
                  children: [
                    Image.network('https://res.cloudinary.com/dnejayiiq/image/upload/v1672446892/logo_hnizxp.png'),
                    SizedBox(height: kDefaultPadding,),
                    TextRenderer(
                      style: TextRendererStyle.paragraph,
                      child: Text('Calle 50, Av. Elvira Mendez\nPh El Ejecutivo, Ofic 303\nCiudad de Panamá', style: CustomLabels.h3ColorBlack87.copyWith(fontSize: 12, fontWeight: FontWeight.w400, color: Colors.white.withOpacity(0.5)), textAlign: TextAlign.center,))
                  ],
                ),
              ),
            ),
          ),
          if(size.width < kDefaultBreak)
          Positioned(
              top: 0,
              right: 10,
              child: GestureDetector(
                onTap: () {
                  if (isOpen) {
                    controller.forward();
                  } else {
                    controller.reverse();
                  }
                  setState(() {
                    isOpen = !isOpen;
                    SideMenuProvider.toggleMenu();
                  });
                },
                child: MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: AnimatedIcon(
                    size: 25,
                    icon: AnimatedIcons.close_menu,
                    color: kBgColor,
                    progress: controller,
                  ),
                ),
              )),
        ]));
  }
}
