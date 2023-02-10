import 'package:somosproperties/constants.dart';
import 'package:somosproperties/models/propiedad.dart';
import 'package:somosproperties/models/proyecto.dart';
import 'package:somosproperties/providers/propiedades_provides.dart';
import 'package:somosproperties/providers/proyectos_provider.dart';
import 'package:somosproperties/router/router.dart';
import 'package:somosproperties/services/navigation_service.dart';
import 'package:somosproperties/ui/buttons/custom_outlined_button.dart';
import 'package:somosproperties/ui/buttons/custom_outlined_button_mini.dart';
import 'package:somosproperties/ui/labels/custom_labels.dart';
import 'package:somosproperties/ui/shared/propiedades_slider.dart';
import 'package:somosproperties/ui/shared/widgets/propiedadid/fotos_baner_proyecto.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:somosproperties/ui/cards/white_card.dart';
import 'package:somosproperties/ui/shared/vertical_list_properties.dart';
import 'package:somosproperties/ui/shared/widgets/propiedadid/fotos_baner_propiedad.dart';
import 'package:somosproperties/ui/shared/widgets/propiedadid/mapa_id.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class PropiedadIDView extends StatefulWidget {
  const PropiedadIDView({
    Key? key,
  }) : super(key: key);

  @override
  State<PropiedadIDView> createState() => _PropiedadIDViewState();
}

class _PropiedadIDViewState extends State<PropiedadIDView> {
  @override
  Widget build(BuildContext context) {
    final Propiedad prop = Provider.of<PropiedadesProvider>(context).propiedad;
    final proy = Provider.of<ProyectosProvider>(context).proyecto;
    final listprop = Provider.of<PropiedadesProvider>(context).listXId;
    return AllBody(
      prop: prop,
      proy: proy,
      listprop: listprop,
    );
  }
}

class AllBody extends StatelessWidget {
  final Propiedad prop;
  final Proyecto proy;
  final List<Propiedad> listprop;

  const AllBody(
      {Key? key,
      required this.prop,
      required this.proy,
      required this.listprop})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    Uri urlInstag =
        Uri.parse('https://www.instagram.com/somosproperties/?hl=es');
    Uri urlFb = Uri.parse('https://www.facebook.com/somosproperties/');
    Uri urlTiktok = Uri.parse('https://www.tiktok.com/amp/tag/somosproperties');
    return Container(
      width: double.infinity,
      height: 200,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: ListView(
              physics: ClampingScrollPhysics(),
              children: [
                WhiteCard(
                    isDrag: false,
                    child: (prop.galeria.length == 0)
                        ? Center(child: CircularProgressIndicator())
                        : FotoBanerPropiedad(
                            fotoBaner: prop.img,
                            galeria: prop.galeria,
                          )),
                WhiteCard(
                    isDrag: false,
                    child: PropiedadNombre(
                      proy: proy,
                      propiedad: prop,
                    )),
                WhiteCard(
                    isDrag: false,
                    child: (prop.galeria.length == 0)
                        ? Center(child: CircularProgressIndicator())
                        : Column(
                            children: [
                              Text(
                                'Imagenes del proyecto',
                                style: CustomLabels.h1ColorPrimary,
                              ),
                              FotoBanerProyecto(
                                fotoBaner: proy.img,
                                galeria: [...proy.galeria],
                              ),
                            ],
                          )),
                if (size.width <= 720)
                  WhiteCard(
                    isDrag: true,
                    child: PropiedadesSlider(
                        sectionName: 'Propiedades relacionadas',
                        propiedades: listprop),
                  ),
                WhiteCard(
                    isDrag: false,
                    child: Container(
                        height: 350,
                        child: getMap(
                            double.parse(proy.lat), double.parse(proy.lon)))),
                WhiteCard(
                    isDrag: false,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          onPressed: () {
                            launchUrl(urlFb);
                          },
                          icon: (FaIcon(FontAwesomeIcons.facebook)),
                          color: kPrimaryColor,
                        ),
                        IconButton(
                          onPressed: () {
                            launchUrl(urlInstag);
                          },
                          icon: (FaIcon(FontAwesomeIcons.instagram)),
                          color: kPrimaryColor,
                        ),
                        IconButton(
                          onPressed: () {
                            launchUrl(urlTiktok);
                          },
                          icon: (FaIcon(FontAwesomeIcons.tiktok)),
                          color: kPrimaryColor,
                        ),
                      ],
                    )),
                SizedBox(
                  height: 100,
                )
              ],
            ),
          ),
          if (size.width > 720)
            Column(
              children: [
                WhiteCard(
                    isDrag: false,
                    child: InfoBar(
                      propiedad: prop,
                      proy: proy,
                    )),
                SizedBox(height: kDefaultPadding / 3),
                WhiteCard(
                    isDrag: false,
                    title: 'Propiedades relacionadas',
                    child: Container(
                      width: 250,
                      child: VerticaListProperties(listPropiedades: listprop),
                    )),
              ],
            ),
        ],
      ),
    );
  }
}

class PropiedadNombre extends StatelessWidget {
  final Propiedad propiedad;
  final Proyecto proy;
  const PropiedadNombre({
    Key? key,
    required this.propiedad,
    required this.proy,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    Uri urlWsp = Uri.parse(
        'https://wa.me/50766770577?text=Me%20gustaria%20recibir%20mas%20información%20sobre%20Propiedad:%20${propiedad.nombreProp}%20Proyecto:%20${proy.nombre}ID:%20${propiedad.uid}%20');

    Future<void> _launchUrl() async {
      final Uri _url = urlWsp;
      if (!await launchUrl(_url)) {
        throw 'Could not launch $_url';
      }
    }

    return Column(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              propiedad.nombreProp,
              style: Theme.of(context)
                  .textTheme
                  .headline4!
                  .copyWith(color: kPrimaryColor, fontWeight: FontWeight.w900),
            ),
            SizedBox(
              height: kDefaultPadding / 2,
            ),
            GestureDetector(
              onTap: () => NavigationService.navigateTo(
                  '${Flurorouter.proyectosRoute}/${proy.uid}'),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundColor: kPrimaryColor,
                    radius: 20,
                    backgroundImage: NetworkImage(proy.img),
                  ),
                  SizedBox(
                    width: kDefaultPadding,
                  ),
                  Text(proy.nombre,
                      style: TextStyle(color: kPrimaryColor, fontSize: 22)),
                ],
              ),
            ),
            SizedBox(height: kDefaultPadding),
            Row(
              children: [
                Icon(
                  Icons.location_on,
                  color: kPrimaryColor,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  propiedad.direccion,
                  style: Theme.of(context).textTheme.headline6!.copyWith(
                      color: Colors.black.withOpacity(kBodyTextOpacity),
                      fontWeight: FontWeight.w900,
                      fontSize: 14),
                ),
              ],
            ),
            SizedBox(height: kDefaultPadding / 2),
            Row(
              children: [
                Icon(
                  Icons.map,
                  color: kPrimaryColor,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  proy.ciudadPais,
                  style: Theme.of(context).textTheme.headline6!.copyWith(
                      color: Colors.black.withOpacity(kBodyTextOpacity),
                      fontWeight: FontWeight.w900,
                      fontSize: 14),
                ),
              ],
            ),
            SizedBox(height: kDefaultPadding),
            Container(
                width: 400,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    if (propiedad.mts2 != '') ...[
                      SizedBox(
                        width: kDefaultPadding,
                      ),
                      Icon(
                        FontAwesomeIcons.ruler,
                        size: 20,
                        color: kBodyTextColor,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text('${propiedad.mts2} m2',
                          style: TextStyle(fontWeight: FontWeight.w800)),
                    ],
                    if (propiedad.habitaciones != '') ...[
                      SizedBox(
                        width: kDefaultPadding,
                      ),
                      Icon(
                        FontAwesomeIcons.bed,
                        size: 20,
                        color: kBodyTextColor,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        '${propiedad.habitaciones}',
                        style: TextStyle(fontWeight: FontWeight.w800),
                      ),
                    ],
                    if (propiedad.banos != '') ...[
                      SizedBox(
                        width: kDefaultPadding,
                      ),
                      Icon(
                        FontAwesomeIcons.bath,
                        size: 20,
                        color: kBodyTextColor,
                      ),
                      Text('${propiedad.banos}',
                          style: TextStyle(fontWeight: FontWeight.w800)),
                    ],
                    if (propiedad.estacionamientos != '') ...[
                      SizedBox(
                        width: kDefaultPadding,
                      ),
                      Icon(
                        FontAwesomeIcons.squareParking,
                        size: 20,
                        color: kBodyTextColor,
                      ),
                      Text('${propiedad.estacionamientos}',
                          style: TextStyle(fontWeight: FontWeight.w800)),
                    ]
                  ],
                )),
            SizedBox(
              height: kDefaultPadding * 2,
            ),
            Wrap(
              children: [
                Column(
                  children: [
                    Text(
                      NumberFormat.simpleCurrency(
                              locale: 'en_US', decimalDigits: 0)
                          .format(propiedad.precio),
                      style: Theme.of(context).textTheme.headline4!.copyWith(
                          color: kPrimaryColor, fontWeight: FontWeight.w900),
                    ),
                    SizedBox(
                      width: kDefaultPadding,
                    ),
                    Text(
                      'Precio de venta',
                      style: Theme.of(context).textTheme.headline6!.copyWith(
                          color: Colors.black.withOpacity(kBodyTextOpacity),
                          fontWeight: FontWeight.w900,
                          fontSize: 14),
                    ),
                    SizedBox(
                      height: kDefaultPadding,
                    )
                  ],
                ),
                if (size.width <= 720)
                  ConstrainedBox(
                      constraints: BoxConstraints(maxWidth: 200, minWidth: 50)),
                if (size.width <= 720)
                  Container(
                    child: Row(
                      mainAxisAlignment: (size.width <= 476)
                          ? MainAxisAlignment.start
                          : MainAxisAlignment.end,
                      children: [
                        Row(
                          children: [
                            ElevatedButton(
                              onPressed: _launchUrl,
                              child: Row(
                                children: [
                                  Icon(Icons.whatsapp),
                                  SizedBox(
                                    width: kDefaultPadding / 2,
                                  ),
                                  Text('Agente especializado'),
                                ],
                              ),
                              style: ButtonStyle(
                                side: MaterialStateProperty.all(
                                    BorderSide(color: kSecondaryColor)),
                                backgroundColor:
                                    MaterialStateProperty.all(kSecondaryColor),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  )
              ],
            ),
          ],
        ),
        SizedBox(
          height: kDefaultPadding,
        ),
        Container(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Descripción',
                style: Theme.of(context).textTheme.headline6!.copyWith(
                    color: kPrimaryColor,
                    fontWeight: FontWeight.w900,
                    fontSize: 18),
              ),
              SizedBox(
                height: kDefaultPadding,
              ),
              Text(
                propiedad.descripcion,
                style: Theme.of(context).textTheme.headline6!.copyWith(
                    color: Colors.black.withOpacity(kBodyTextOpacity),
                    fontWeight: FontWeight.w900,
                    fontSize: 14),
              ),
              SizedBox(
                height: kDefaultPadding * 2,
              ),
              Text(
                'Detalles de la propiedad',
                style: Theme.of(context).textTheme.headline6!.copyWith(
                    color: kPrimaryColor,
                    fontWeight: FontWeight.w900,
                    fontSize: 18),
              ),
              SizedBox(
                height: kDefaultPadding,
              ),
              Text(propiedad.detalles,
                  style: Theme.of(context).textTheme.headline6!.copyWith(
                      color: Colors.black.withOpacity(kBodyTextOpacity),
                      fontWeight: FontWeight.w900,
                      fontSize: 14)),
              SizedBox(
                height: kDefaultPadding * 2,
              ),
              Text(
                'Detalles del proyecto o zona',
                style: Theme.of(context).textTheme.headline6!.copyWith(
                    color: kPrimaryColor,
                    fontWeight: FontWeight.w900,
                    fontSize: 18),
              ),
              SizedBox(
                height: kDefaultPadding,
              ),
              Text(proy.descripcion,
                  style: Theme.of(context).textTheme.headline6!.copyWith(
                      color: Colors.black.withOpacity(kBodyTextOpacity),
                      fontWeight: FontWeight.w900,
                      fontSize: 14)),
            ],
          ),
        ),
      ],
    );
  }
}
//'https://wa.link/9u8ec5'

class InfoBar extends StatelessWidget {
  final Propiedad propiedad;
  final Proyecto proy;

  const InfoBar({Key? key, required this.propiedad, required this.proy})
      : super(key: key);
  Future<void> _launchUrl() async {
    Uri _urlWsp = Uri.parse(
        'https://wa.me/50766770577?text=Me%20gustaria%20recibir%20mas%20información%20sobre%20Propiedad:%20${propiedad.nombreProp}%20Proyecto:%20${proy.nombre}ID:%20${propiedad.uid}%20');
    if (!await launchUrl(_urlWsp)) {
      throw 'Could not launch $_urlWsp';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
        width: 250,
        height: 180,
        child: Center(
            child: CircleAvatar(
          backgroundColor: kPrimaryColor,
          radius: 80,
          child: Image(
              image: NetworkImage(
                  'https://res.cloudinary.com/dnejayiiq/image/upload/v1672446892/logo_hnizxp.png')),
        )),
      ),
      SizedBox(height: kDefaultPadding / 2),
      Row(
        children: [
          ElevatedButton(
            onPressed: _launchUrl,
            child: Row(
              children: [
                Icon(Icons.whatsapp),
                SizedBox(
                  width: kDefaultPadding / 2,
                ),
                Text('Agente especializado'),
              ],
            ),
            style: ButtonStyle(
              side:
                  MaterialStateProperty.all(BorderSide(color: kSecondaryColor)),
              backgroundColor: MaterialStateProperty.all(kSecondaryColor),
            ),
          )
        ],
      )
    ]);
  }
}
