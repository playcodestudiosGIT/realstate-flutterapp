import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:seo_renderer/seo_renderer.dart';
import 'package:somosproperties/models/propiedad.dart';
import 'package:somosproperties/services/navigation_service.dart';
import 'package:somosproperties/ui/buttons/custom_outlined_button_mini.dart';
import 'package:somosproperties/ui/buttons/link_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:somosproperties/constants.dart';
import 'package:somosproperties/ui/shared/widgets/tag_project.dart';
import 'package:intl/intl.dart';

class PropiedadCard extends StatefulWidget {
  const PropiedadCard({
    Key? key,
    required this.propiedad,
  }) : super(key: key);
  final Propiedad propiedad;
  @override
  State<PropiedadCard> createState() => _PropiedadCardState();
}

class _PropiedadCardState extends State<PropiedadCard> {
  @override
  Widget build(BuildContext context) {
    String textTipo;
    if (widget.propiedad.tipopropiedad == 'Apartamento') {
      textTipo = 'APARTAMENTO';
    } else if (widget.propiedad.tipopropiedad == 'Casa') {
      textTipo = 'CASA';
    } else if (widget.propiedad.tipopropiedad == 'Local') {
      textTipo = 'LOCAL';
    } else if (widget.propiedad.tipopropiedad == 'Lote') {
      textTipo = 'LOTE';
    } else {
      textTipo = 'OFICINA';
    }

    return Builder(builder: (context) {
      return Container(
        width: 320,
        margin: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.3), blurRadius: 5)
          ],
          borderRadius: BorderRadius.circular(0),
          color: Colors.white,
        ),
        padding: EdgeInsets.all(10),
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 350,
                  height: 290,
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(0),
                        topRight: Radius.circular(0)),
                    child: Container(
                        child: FadeInImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(widget.propiedad.img),
                            placeholder: NetworkImage(
                                'https://res.cloudinary.com/dnejayiiq/image/upload/v1672446892/logo_hnizxp.png'))),
                  ),
                ),
                SizedBox(height: kDefaultPadding / 2),
                Row(
                  children: [
                    Container(
                      width: 230,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextRenderer(
                            style: TextRendererStyle.header1,
                            child: Text(
                              '${widget.propiedad.nombreProp}',
                              style: GoogleFonts.roboto(
                                  color: kPrimaryColor,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w800),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            ),
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.location_on,
                                color: kPrimaryColor,
                              ),
                              LinkText(
                                  text: '${widget.propiedad.proyecto.nombre}',
                                  color: kPrimaryColor),
                            ],
                          ),
                          Container(
                            constraints: BoxConstraints(maxWidth: 250),
                            child: TextRenderer(
                              style: TextRendererStyle.paragraph,
                              child: Text(
                                widget.propiedad.descripcion,
                                style: Theme.of(context)
                                    .textTheme
                                    .headline6!
                                    .copyWith(
                                        color: Colors.black
                                            .withOpacity(kBodyTextOpacity),
                                        fontWeight: FontWeight.w900,
                                        fontSize: 14),
                                maxLines: 2,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    CircleAvatar(
                      backgroundImage:
                          NetworkImage(widget.propiedad.proyecto.img),
                      backgroundColor: kPrimaryColor,
                      radius: 30,
                    )
                  ],
                ),
                SizedBox(height: kDefaultPadding / 2),
                Container(
                    width: 400,
                    child: Row(
                      children: [
                        if (widget.propiedad.mts2 != '') ...[
                          SizedBox(
                            width: kDefaultPadding,
                          ),
                          Icon(
                            FontAwesomeIcons.ruler,
                            size: 20,
                            color: kBodyTextColor,
                          ),
                          SizedBox(
                            width: kDefaultPadding / 2,
                          ),
                          TextRenderer(
                              style: TextRendererStyle.paragraph,
                              child: Text('${widget.propiedad.mts2} m2',
                                  style:
                                      TextStyle(fontWeight: FontWeight.w800))),
                        ],
                        if (widget.propiedad.habitaciones != '') ...[
                          SizedBox(
                            width: kDefaultPadding,
                          ),
                          Icon(
                            FontAwesomeIcons.bed,
                            size: 20,
                            color: kBodyTextColor,
                          ),
                          SizedBox(
                            width: kDefaultPadding / 2,
                          ),
                          Text(
                            '${widget.propiedad.habitaciones}',
                            style: TextStyle(fontWeight: FontWeight.w800),
                          ),
                        ],
                        if (widget.propiedad.banos != '') ...[
                          SizedBox(
                            width: kDefaultPadding,
                          ),
                          Icon(
                            FontAwesomeIcons.bath,
                            size: 20,
                            color: kBodyTextColor,
                          ),
                          SizedBox(
                            width: kDefaultPadding / 2,
                          ),
                          Text('${widget.propiedad.banos}',
                              style: TextStyle(fontWeight: FontWeight.w800)),
                        ],
                        if (widget.propiedad.estacionamientos != '') ...[
                          SizedBox(
                            width: kDefaultPadding,
                          ),
                          Icon(
                            FontAwesomeIcons.squareParking,
                            size: 20,
                            color: kBodyTextColor,
                          ),
                          SizedBox(
                            width: kDefaultPadding / 2,
                          ),
                          Text('${widget.propiedad.estacionamientos}',
                              style: TextStyle(fontWeight: FontWeight.w800)),
                        ]
                      ],
                    )),
                SizedBox(height: kDefaultPadding / 2),
                Row(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextRenderer(
                          style: TextRendererStyle.header2,
                          child: Text(
                            (widget.propiedad.sevendeoalquila == 'Alquiler')
                                ? 'Alquiler'
                                : 'Venta',
                            style: GoogleFonts.roboto(
                                fontSize: 12, color: kBodyTextColor),
                          ),
                        ),
                        Text(
                          NumberFormat.simpleCurrency(
                                  locale: 'en_US', decimalDigits: 0)
                              .format(widget.propiedad.precio),
                          style: GoogleFonts.roboto(
                              color: kPrimaryColor,
                              fontSize: 29,
                              fontWeight: FontWeight.w800),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ],
                    ),
                    Spacer(),
                    ElevatedButton(
                      style: ButtonStyle(
                        side: MaterialStateProperty.all(
                            BorderSide(color: kSecondaryColor)),
                        backgroundColor:
                            MaterialStateProperty.all(kSecondaryColor),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Ver',
                            style: TextStyle(fontSize: 12, color: Colors.white),
                          ),
                          SizedBox(
                            width: kDefaultPadding / 2,
                          ),
                          Icon(
                            Icons.arrow_forward,
                            color: Colors.white,
                            size: 18,
                          )
                        ],
                      ),
                      onPressed: () {
                        NavigationService.navigateTo(
                            '/propiedad/${widget.propiedad.uid}/${widget.propiedad.proyecto.uid}');
                      },
                    ),
                  ],
                ),
              ],
            ),
            Positioned(
                top: 25,
                left: 10, // siguiente left 80
                child: TagProject(
                  width: 90,
                  textTipo: textTipo,
                )),
            Positioned(
                top: 25,
                left: 110, // siguiente left 80
                child: TagProject(
                  width: 70,
                  textTipo: (widget.propiedad.sevendeoalquila == 'Alquiler')
                      ? 'ALQUILER'
                      : 'VENTA',
                )),
            // if (false)
            //   Positioned(
            //       top: 50,
            //       left: 10, // siguiente left 80
            //       child: TagDestacado()),
          ],
        ),
      );
    });
  }
}
