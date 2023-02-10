import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:somosproperties/constants.dart';
import 'package:somosproperties/models/proyecto.dart';
import 'package:somosproperties/services/navigation_service.dart';
import 'package:somosproperties/ui/buttons/link_text.dart';
import 'package:somosproperties/ui/labels/custom_labels.dart';
import 'package:flutter/material.dart';

class ProyectoCard extends StatelessWidget {
  final Proyecto proyecto;

  const ProyectoCard({
    Key? key,
    required this.proyecto,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => NavigationService.navigateTo('/proyectos/${proyecto.uid}'),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 15),
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(color: Colors.black.withOpacity(0.3), blurRadius: 10)
            ],
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(0)),
          ),
          width: 300,
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 150,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(0),
                          topRight: Radius.circular(0),
                        ),
                        image: DecorationImage(
                          image: (proyecto.galeria.length == 0)
                              ? NetworkImage(
                                  'https://res.cloudinary.com/dnejayiiq/image/upload/v1672446892/logo_hnizxp.png')
                              : NetworkImage(proyecto.galeria[0]),
                          fit: BoxFit.cover,
                        )),
                  ),
                  SizedBox(
                    height: kDefaultPadding,
                  ),
                  Container(
                    height: 175,
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: kDefaultPadding),
                      child: Column(
                        children: [
                          Container(
                            width: 300,
                            child: Text(
                              proyecto.nombre,
                              style: CustomLabels.h1ColorPrimary
                                  .copyWith(fontSize: 18),
                              maxLines: 2,
                            ),
                          ),
                          SizedBox(height: kDefaultPadding / 2),
                          Row(
                            children: [
                              Icon(
                                Icons.location_on,
                                color: kPrimaryColor,
                              ),
                              LinkText(
                                text: proyecto.direccion,
                                color: kPrimaryColor,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: kDefaultPadding,
                          ),
                          Wrap(
                            children: [
                              if (proyecto.piscina)
                                Padding(
                                  padding: const EdgeInsets.only(
                                      right: kDefaultPadding),
                                  child: Icon(FontAwesomeIcons.personSwimming,
                                      color: kPrimaryColor, size: 14),
                                ),
                              if (proyecto.gym)
                                Padding(
                                  padding: const EdgeInsets.only(
                                      right: kDefaultPadding),
                                  child: Icon(FontAwesomeIcons.dumbbell,
                                      color: kPrimaryColor, size: 14),
                                ),
                              if (proyecto.parque)
                                Padding(
                                  padding: const EdgeInsets.only(
                                      right: kDefaultPadding),
                                  child: Icon(FontAwesomeIcons.tree,
                                      color: kPrimaryColor, size: 14),
                                ),
                              if (proyecto.tenis)
                                Padding(
                                  padding: const EdgeInsets.only(
                                      right: kDefaultPadding),
                                  child: Icon(FontAwesomeIcons.baseball,
                                      color: kPrimaryColor, size: 14),
                                ),
                              if (proyecto.futbol)
                                Padding(
                                  padding: const EdgeInsets.only(
                                      right: kDefaultPadding),
                                  child: Icon(FontAwesomeIcons.futbol,
                                      color: kPrimaryColor, size: 14),
                                ),
                              if (proyecto.squash)
                                Padding(
                                  padding: const EdgeInsets.only(
                                      right: kDefaultPadding),
                                  child: Icon(Icons.sports_handball_outlined,
                                      color: kPrimaryColor, size: 14),
                                ),
                              if (proyecto.raquetball)
                                Padding(
                                  padding: const EdgeInsets.only(
                                      right: kDefaultPadding),
                                  child: Icon(Icons.sports_tennis,
                                      color: kPrimaryColor, size: 14),
                                ),
                              if (proyecto.estac)
                                Padding(
                                  padding: const EdgeInsets.only(
                                      right: kDefaultPadding),
                                  child: Icon(FontAwesomeIcons.squareParking,
                                      color: kPrimaryColor, size: 14),
                                ),
                              if (proyecto.roomParty)
                                Padding(
                                  padding: const EdgeInsets.only(
                                      right: kDefaultPadding),
                                  child: Icon(Icons.celebration,
                                      color: kPrimaryColor, size: 14),
                                ),
                              if (proyecto.roomPlay)
                                Padding(
                                  padding: const EdgeInsets.only(
                                      right: kDefaultPadding),
                                  child: Icon(Icons.gamepad_outlined,
                                      color: kPrimaryColor, size: 14),
                                ),
                            ],
                          ),
                          SizedBox(height: kDefaultPadding),
                          Text(
                            proyecto.descripcion,
                            maxLines: 3,
                            style: CustomLabels.h3ColorBlack87,
                          ),
                          SizedBox(
                            height: kDefaultPadding,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Positioned(
                  top: 10,
                  right: 10,
                  child: CircleAvatar(
                    backgroundColor: kPrimaryColor,
                    radius: 30,
                    backgroundImage: (proyecto.img == '')
                        ? NetworkImage(
                            'https://res.cloudinary.com/dnejayiiq/image/upload/v1672446892/logo_hnizxp.png')
                        : NetworkImage(proyecto.img),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
