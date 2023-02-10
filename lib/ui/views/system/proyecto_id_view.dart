import 'package:somosproperties/constants.dart';

import 'package:somosproperties/models/propiedad.dart';
import 'package:somosproperties/models/proyecto.dart';
import 'package:somosproperties/providers/propiedades_provides.dart';
import 'package:somosproperties/providers/proyectos_provider.dart';
import 'package:somosproperties/ui/buttons/custom_outlined_button_mini.dart';
import 'package:somosproperties/ui/labels/custom_labels.dart';
import 'package:somosproperties/ui/shared/propiedades_slider.dart';
import 'package:somosproperties/ui/shared/vertical_list_properties.dart';
import 'package:somosproperties/ui/shared/widgets/video_player_youtube.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:somosproperties/ui/cards/white_card.dart';
import 'package:somosproperties/ui/shared/widgets/propiedadid/fotos_baner_propiedad.dart';
import 'package:somosproperties/ui/shared/widgets/propiedadid/mapa_id.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProyectoIDView extends StatefulWidget {
  const ProyectoIDView({
    Key? key,
  }) : super(key: key);

  @override
  State<ProyectoIDView> createState() => _ProyectoIDViewState();
}

class _ProyectoIDViewState extends State<ProyectoIDView> {
  @override
  Widget build(BuildContext context) {
    Uri urlInstag =
        Uri.parse('https://www.instagram.com/somosproperties/?hl=es');
    Uri urlFb = Uri.parse('https://www.facebook.com/somosproperties/');
    Uri urlTiktok = Uri.parse('https://www.tiktok.com/amp/tag/somosproperties');
    final List<Propiedad> listprop =
        Provider.of<PropiedadesProvider>(context).listXId;
    final Proyecto proyecto = Provider.of<ProyectosProvider>(context).proyecto;
    final size = MediaQuery.of(context).size;
    Future<void> _broshure() async {
      Uri url = Uri.parse(proyecto.brochure);
      if (!await launchUrl(url)) {
        throw 'Could not launch $url';
      }
    }

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
                    title: 'GALERIA',
                    child: FotoBanerPropiedad(
                      fotoBaner: proyecto.img,
                      galeria: [...proyecto.galeria],
                    )),
                WhiteCard(
                  isDrag: false,
                  title: 'INFORMACIÓN DEL PROYECTO',
                  child: PropiedadNombre(proy: proyecto),
                ),
                WhiteCard(
                  isDrag: false,
                  title: 'AMENIDADES',
                  child: Wrap(
                    runSpacing: kDefaultPadding,
                    children: [
                      if (proyecto.piscina)
                        Padding(
                          padding:
                              const EdgeInsets.only(right: kDefaultPadding),
                          child: Column(
                            children: [
                              Icon(
                                Icons.pool,
                                color: kPrimaryColor,
                                size: 35,
                              ),
                              SizedBox(
                                height: kDefaultPadding / 2,
                              ),
                              Text(
                                'Piscina',
                                style: CustomLabels.h3ColorBlack87
                                    .copyWith(fontWeight: FontWeight.w900),
                              )
                            ],
                          ),
                        ),
                      if (proyecto.gym)
                        Padding(
                          padding:
                              const EdgeInsets.only(right: kDefaultPadding),
                          child: Column(
                            children: [
                              Icon(
                                Icons.fitness_center,
                                color: kPrimaryColor,
                                size: 35,
                              ),
                              SizedBox(
                                height: kDefaultPadding / 2,
                              ),
                              Text(
                                'Gimnasio',
                                style: CustomLabels.h3ColorBlack87.copyWith(
                                    fontWeight: FontWeight.w900,
                                    color: kPrimaryColor),
                              )
                            ],
                          ),
                        ),
                      if (proyecto.parque)
                        Padding(
                          padding:
                              const EdgeInsets.only(right: kDefaultPadding),
                          child: Column(
                            children: [
                              Icon(
                                Icons.park,
                                color: kPrimaryColor,
                                size: 35,
                              ),
                              SizedBox(
                                height: kDefaultPadding / 2,
                              ),
                              Text(
                                'Parque',
                                style: CustomLabels.h3ColorBlack87
                                    .copyWith(fontWeight: FontWeight.w900),
                              )
                            ],
                          ),
                        ),
                      if (proyecto.tenis)
                        Padding(
                          padding:
                              const EdgeInsets.only(right: kDefaultPadding),
                          child: Column(
                            children: [
                              Icon(
                                Icons.sports_baseball,
                                color: kPrimaryColor,
                                size: 35,
                              ),
                              SizedBox(
                                height: kDefaultPadding / 2,
                              ),
                              Text(
                                'Tennis',
                                style: CustomLabels.h3ColorBlack87.copyWith(
                                    fontWeight: FontWeight.w900,
                                    color: kPrimaryColor),
                              )
                            ],
                          ),
                        ),
                      if (proyecto.squash)
                        Padding(
                          padding:
                              const EdgeInsets.only(right: kDefaultPadding),
                          child: Column(
                            children: [
                              Icon(
                                Icons.sports_tennis,
                                color: kPrimaryColor,
                                size: 35,
                              ),
                              SizedBox(
                                height: kDefaultPadding / 2,
                              ),
                              Text(
                                'Squash',
                                style: CustomLabels.h3ColorBlack87.copyWith(
                                    fontWeight: FontWeight.w900,
                                    color: kPrimaryColor),
                              )
                            ],
                          ),
                        ),
                      if (proyecto.futbol)
                        Padding(
                          padding:
                              const EdgeInsets.only(right: kDefaultPadding),
                          child: Column(
                            children: [
                              Icon(
                                Icons.sports_soccer,
                                color: kPrimaryColor,
                                size: 35,
                              ),
                              SizedBox(
                                height: kDefaultPadding / 2,
                              ),
                              Text(
                                'Futbol',
                                style: CustomLabels.h3ColorBlack87.copyWith(
                                    fontWeight: FontWeight.w900,
                                    color: kPrimaryColor),
                              )
                            ],
                          ),
                        ),
                      if (proyecto.estac)
                        Padding(
                          padding:
                              const EdgeInsets.only(right: kDefaultPadding),
                          child: Column(
                            children: [
                              Icon(
                                Icons.local_parking_outlined,
                                color: kPrimaryColor,
                                size: 35,
                              ),
                              SizedBox(
                                height: kDefaultPadding / 2,
                              ),
                              Text(
                                'Parking',
                                style: CustomLabels.h3ColorBlack87.copyWith(
                                    fontWeight: FontWeight.w900,
                                    color: kPrimaryColor),
                              )
                            ],
                          ),
                        ),
                      if (proyecto.roomParty)
                        Padding(
                          padding:
                              const EdgeInsets.only(right: kDefaultPadding),
                          child: Column(
                            children: [
                              Icon(
                                Icons.celebration,
                                color: kPrimaryColor,
                                size: 35,
                              ),
                              SizedBox(
                                height: kDefaultPadding / 2,
                              ),
                              Text(
                                'Room Party',
                                style: CustomLabels.h3ColorBlack87.copyWith(
                                    fontWeight: FontWeight.w900,
                                    color: kPrimaryColor),
                              )
                            ],
                          ),
                        ),
                      if (proyecto.roomPlay)
                        Padding(
                          padding:
                              const EdgeInsets.only(right: kDefaultPadding),
                          child: Column(
                            children: [
                              Icon(
                                Icons.games_outlined,
                                color: kPrimaryColor,
                                size: 35,
                              ),
                              SizedBox(
                                height: kDefaultPadding / 2,
                              ),
                              Text(
                                'Room Games',
                                style: CustomLabels.h3ColorBlack87.copyWith(
                                    fontWeight: FontWeight.w900,
                                    color: kPrimaryColor),
                              )
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
                WhiteCard(
                    isDrag: false,
                    title: 'VIDEO DEL PROYECTO',
                    child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 30, vertical: 0),
                        alignment: Alignment.center,
                        child: VideoPlayerYoutube(
                          videoUrl: proyecto.video,
                        ))),
                if (size.width <= 720)
                  WhiteCard(
                    isDrag: false,
                    child: PropiedadesSlider(
                        sectionName: 'Propiedades del proyecto',
                        propiedades: listprop),
                  ),
                WhiteCard(
                    isDrag: false,
                    title: 'UBICACIÓN',
                    child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 30, vertical: 0),
                        height: 350,
                        child: getMap(8.9773845, -79.5116515))),
                WhiteCard(
                    isDrag: false,
                    child: Container(
                      child: Wrap(children: [
                        ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(kPrimaryColor)),
                            onPressed: _broshure,
                            child: Text('Download Brochure')),
                      ]),
                    )),
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
                      proyecto: proyecto,
                    )),
                SizedBox(height: kDefaultPadding / 3),
                WhiteCard(
                    isDrag: false,
                    title: 'PROPIEDADES DEL PROYECTO',
                    child: Container(
                      width: 250,
                      child: VerticaListProperties(listPropiedades: listprop),
                    )),
              ],
            )
        ],
      ),
    );
  }
}

class InfoBar extends StatelessWidget {
  final Proyecto proyecto;

  const InfoBar({Key? key, required this.proyecto}) : super(key: key);
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
                      'https://res.cloudinary.com/dnejayiiq/image/upload/v1672446892/logo_hnizxp.png'),
                  width: 200,
                ))),
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

  Future<void> _launchUrl() async {
    Uri url = Uri.parse(
        'https://wa.me/50766770577?text=Me%20Gustaria%20recibir%20información%20sobre%20el%20Proyecto:%20${proyecto.nombre}%20ID:%20${proyecto.uid}');
    if (!await launchUrl(url)) {
      throw 'Could not launch $url';
    }
  }
}

class PropiedadNombre extends StatelessWidget {
  final Proyecto proy;
  const PropiedadNombre({
    Key? key,
    required this.proy,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    Future<void> _launchUrl() async {
      Uri url = Uri.parse(
          'https://wa.me/50766770577?text=Me%20Gustaria%20recibir%20información%20sobre%20el%20Proyecto:%20${proy.nombre}%20ID:%20${proy.uid}');
      if (!await launchUrl(url)) {
        throw 'Could not launch $url';
      }
    }

    Future<void> _broshure() async {
      Uri url = Uri.parse(proy.brochure);
      if (!await launchUrl(url)) {
        throw 'Could not launch $url';
      }
    }

    return Stack(
      children: [
        Positioned(
          top: 0,
          right: 0,
          child: ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(kPrimaryColor)),
              onPressed: _broshure,
              child: Container(
                width: 90,
                child: Row(
                  children: [
                    Icon(
                      Icons.download,
                      size: 14,
                    ),
                    SizedBox(
                      width: 6,
                    ),
                    Text('Brochure'),
                  ],
                ),
              )),
        ),
        if (size.width < 720)
          Positioned(
            top: 40,
            right: 0,
            child: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(kPrimaryColor)),
                onPressed: _launchUrl,
                child: Container(
                  width: 90,
                  child: Row(
                    children: [
                      Icon(
                        Icons.whatsapp,
                        size: 14,
                      ),
                      SizedBox(
                        width: 6,
                      ),
                      Text('Chat'),
                    ],
                  ),
                )),
          ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (proy.nombre == 'nombre')
              Center(
                child: CircularProgressIndicator(),
              ),
            if (proy.nombre != 'nombre')
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        proy.nombre,
                        style: Theme.of(context).textTheme.headline4!.copyWith(
                            color: kPrimaryColor,
                            fontWeight: FontWeight.w900,
                            fontSize: (size.width < 500) ? 20 : 32),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: kDefaultPadding / 2,
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
                        proy.direccion,
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
                  SizedBox(height: kDefaultPadding / 2),
                ],
              ),
            SizedBox(
              height: kDefaultPadding,
            ),
            SizedBox(
              height: kDefaultPadding * 2,
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
                    proy.descripcion,
                    style: Theme.of(context).textTheme.headline6!.copyWith(
                        color: Colors.black.withOpacity(kBodyTextOpacity),
                        fontWeight: FontWeight.w900,
                        fontSize: 14),
                  ),
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
                  Text(proy.amenidades,
                      style: Theme.of(context).textTheme.headline6!.copyWith(
                          color: Colors.black.withOpacity(kBodyTextOpacity),
                          fontWeight: FontWeight.w900,
                          fontSize: 14)),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
