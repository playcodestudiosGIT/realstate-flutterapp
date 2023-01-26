import 'package:seo_renderer/seo_renderer.dart';
import 'package:somosproperties/constants.dart';
import 'package:somosproperties/models/propiedad.dart';
import 'package:somosproperties/router/router.dart';

import 'package:somosproperties/services/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class VerticalPropiedadCard extends StatelessWidget {
  final Propiedad propiedad;

  const VerticalPropiedadCard({
    Key? key,
    required this.propiedad,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(0), color: kPrimaryColor),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: () => NavigationService.navigateTo(
              '${Flurorouter.propiedadID}/${propiedad.uid}/${propiedad.proyecto.uid}'),
          child: Container(
            width: 250,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: kDefaultPadding / 2),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(width: 5),
                  ClipRRect(
                      borderRadius: BorderRadius.circular(0),
                      child: Image.network(
                        propiedad.img,
                        width: 80,
                        height: 80,
                        fit: BoxFit.cover,
                      )),
                  SizedBox(width: 5),
                  Container(
                    width: 160,
                    height: 80,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            propiedad.nombreProp,
                            style: GoogleFonts.roboto(
                                fontSize: 14, color: Colors.white),
                            maxLines: 2,
                          ),
                          Text(
                            NumberFormat.simpleCurrency(
                                    locale: 'en_US', decimalDigits: 0)
                                .format(propiedad.precio),
                            style: Theme.of(context)
                                .textTheme
                                .headline4!
                                .copyWith(
                                    color: kSecondaryColor,
                                    fontWeight: FontWeight.w900,
                                    fontSize: 18),
                          ),
                          SizedBox(
                            height: kDefaultPadding / 2,
                          ),
                          Text(
                            propiedad.direccion,
                            style: GoogleFonts.roboto(
                                fontSize: 12, color: Colors.white),
                            maxLines: 2,
                          ),
                          SizedBox(
                            height: kDefaultPadding / 2,
                          ),
                          Row(
                            children: [
                              Icon(Icons.bed_outlined,
                                  size: 14, color: Colors.white),
                              SizedBox(
                                width: kDefaultPadding / 2,
                              ),
                              TextRenderer(
                                style: TextRendererStyle.paragraph,
                                text: '${propiedad.habitaciones} Habitaciones',
                                child: Text(
                                  propiedad.banos,
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.white),
                                ),
                              ),
                              SizedBox(
                                width: kDefaultPadding,
                              ),
                              Icon(Icons.bathtub_outlined,
                                  size: 14, color: Colors.white),
                              SizedBox(
                                width: kDefaultPadding / 2,
                              ),
                              TextRenderer(
                                style: TextRendererStyle.paragraph,
                                text: '${propiedad.banos} Baños',
                                child: Text(propiedad.banos,
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.white)),
                              ),
                              SizedBox(
                                width: kDefaultPadding,
                              ),
                              Icon(Icons.square_foot,
                                  size: 14, color: Colors.white),
                              SizedBox(
                                width: kDefaultPadding / 2,
                              ),
                              TextRenderer(
                                style: TextRendererStyle.paragraph,
                                text: '${propiedad.mts2} Metros Cuadrados',
                                child: Text(
                                  propiedad.mts2,
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.white),
                                ),
                              ),
                            ],
                          )
                        ]),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
