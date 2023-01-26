import 'dart:ui';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:somosproperties/constants.dart';
import 'package:somosproperties/providers/sidemenu_provider.dart';
import 'package:flutter/material.dart';

import 'package:somosproperties/ui/shared/navbar.dart';
import 'package:somosproperties/ui/shared/sidebar.dart';
import 'package:url_launcher/url_launcher.dart';

class DashboardLayout extends StatefulWidget {
  final Widget child;

  const DashboardLayout({Key? key, required this.child}) : super(key: key);

  @override
  _DashboardLayoutState createState() => _DashboardLayoutState();
}

class _DashboardLayoutState extends State<DashboardLayout>
    with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();

    SideMenuProvider.menuController = new AnimationController(
        vsync: this, duration: Duration(milliseconds: 300));
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final Widget isChild = widget.child;
    Future<void> _launchUrl() async {
      Uri url = Uri.parse(
          'https://wa.me/50766770577?text=Me%20Gustaria%20recibir%20información%20sobre:%20');
      if (!await launchUrl(url)) {
        throw 'Could not launch $url';
      }
    }

    return Scaffold(
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(right: 20, bottom: 60),
          child: FloatingActionButton(
            backgroundColor: Color(0xff66B900),
            child: Icon(
              FontAwesomeIcons.whatsapp,
              size: 35,
            ),
            onPressed: _launchUrl,
          ),
        ),
        backgroundColor: Color(0xffEDF1F2),
        body: Stack(
          children: [
            Row(
              children: [
                if (size.width >= kDefaultBreak) Sidebar(),

                Expanded(
                  child: Stack(
                    children: [
                      // View
                      Container(
                        margin: EdgeInsets.only(top: 40),
                        child: isChild,
                      ),
                      // Navbar

                      Navbar(),
                    ],
                  ),
                )
                // Contenedor de nuestro view
              ],
            ),
            if (size.width < kDefaultBreak)
              AnimatedBuilder(
                  animation: SideMenuProvider.menuController,
                  builder: (context, _) => Stack(
                        children: [
                          if (SideMenuProvider.isOpen)
                            Opacity(
                              opacity: SideMenuProvider.opacity.value,
                              child: GestureDetector(
                                onTap: () => SideMenuProvider.closeMenu(),
                                child: Container(
                                  child: BackdropFilter(
                                    filter: ImageFilter.blur(
                                        sigmaX: 2.0, sigmaY: 2.0),
                                    child: Container(
                                      width: size.width,
                                      height: size.height,
                                      decoration: BoxDecoration(
                                          color: kDarkColor.withOpacity(0.5)),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          Transform.translate(
                            offset: Offset(SideMenuProvider.movement.value, 0),
                            child: Sidebar(),
                          )
                        ],
                      ))
          ],
        ));
  }
}
