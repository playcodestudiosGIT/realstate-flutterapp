import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:somosproperties/constants.dart';
import 'package:somosproperties/providers/proyectos_provider.dart';
import 'package:somosproperties/services/navigation_service.dart';
import 'package:somosproperties/ui/cards/proyecto_card.dart';
import 'package:somosproperties/ui/cards/white_card.dart';

import 'package:somosproperties/ui/labels/custom_labels.dart';

class NosotrosView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final proyectosProvider = Provider.of<ProyectosProvider>(context);

    final destrProy = proyectosProvider.proyectos.map(
      (e) => Padding(
        padding: const EdgeInsets.only(
            right: kDefaultPadding, left: kDefaultPadding),
        child: ProyectoCard(proyecto: e),
      ),
    );
    return Container(
      width: double.infinity,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
        child: ListView(
          physics: ClampingScrollPhysics(),
          children: [
            SizedBox(height: kDefaultPadding),
            // Text(
            //   'En Construccion',
            //   style: CustomLabels.h1,
            // ),
            Column(
              children: [
                WhiteCard(
                  isDrag: false,
                  child: Container(
                    constraints: BoxConstraints(
                        maxWidth: 800,
                        minWidth: 350,
                        maxHeight: 300,
                        minHeight: 300),
                    decoration: BoxDecoration(
                        color: kPrimaryColor,
                        borderRadius: BorderRadius.circular(0)),
                    child: Center(
                        child: Image(
                      image: NetworkImage(
                          'https://res.cloudinary.com/dnejayiiq/image/upload/v1672446892/logo_hnizxp.png'),
                    )),
                  ),
                ),
                SizedBox(
                  height: kDefaultPadding * 2,
                ),
                WhiteCard(
                  isDrag: false,
                  child: Container(
                    margin: EdgeInsets.all(kDefaultPadding),
                    constraints: BoxConstraints(maxWidth: 800),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'QUIENES SOMOS',
                          style: CustomLabels.h1
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: kDefaultPadding,
                        ),
                        Text(
                          'Somos Properties es una empresa líder en el desarrollo y venta de apartamentos lujosos, locales, oficinas en Panamá, Con más de 5 años de experiencia en el sector inmobiliario. Nos enfocamos en la innovación, ubicación y acabados de cada uno de nuestros proyectos.\n\nSomos Properties es reconocida por la unión de proyectos inmobiliarios exclusivos alrededor delpaís y la región. Brindando promociones de adquisición con las mejores tasas de interés del mercado debido a las alianzas estratégicas con el sector bancario.',
                          style: CustomLabels.h3ColorBlack87,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: kDefaultPadding * 2,
                ),
                WhiteCard(
                  isDrag: false,
                  child: Container(
                    margin: EdgeInsets.all(kDefaultPadding),
                    constraints: BoxConstraints(maxWidth: 800),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'FILOSOFÍA',
                          style: CustomLabels.h1
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: kDefaultPadding,
                        ),
                        Text(
                          'Nos comprometemos con el cliente a mantener el alto estándar e innovación de propiedades, protegiendo nuestros valores:\n\nTransparencia: Fomentamos acciones organizacionales que promueven la comunicación clara, comprensible y precisa a nuestros clientes, protegiendo sus objetivos.\n\nInnovación: Promovemos la introducción de novedades en cada una de nuestras propiedades para alcanzar calidad en atención y satisfacción al cliente.\n\nTrabajo en Equipo: Multiplica nuestra productividad empresarial contribuyendo al desarrollo eficaz de las actividades dentro del equipo, compartiendo información y conocimientos para la mejora continua de nuestros procesos.\n\nPara así, superar las expectativas del cliente cada día; desarrollando estratégicamente en presente y en el largo plazo.',
                          style: CustomLabels.h3ColorBlack87,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: kDefaultPadding * 2,
                ),
                WhiteCard(
                  isDrag: false,
                  child: Container(
                    margin: EdgeInsets.all(kDefaultPadding),
                    constraints: BoxConstraints(maxWidth: 800),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'VISIÓN',
                          style: CustomLabels.h1
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: kDefaultPadding,
                        ),
                        Text(
                          'Ser empresa líder en el desarrollo y venta de apartamentos lujosos a nivel latinoamericano mediante el establecimiento de alianzas comerciales estratégicas, basado en los 3 pilares comerciales: innovación, ubicación y acabados',
                          style: CustomLabels.h3ColorBlack87,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: kDefaultPadding * 2,
                ),
                WhiteCard(
                  isDrag: false,
                  child: Container(
                    margin: EdgeInsets.all(kDefaultPadding),
                    constraints: BoxConstraints(maxWidth: 800),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'MISIÓN',
                          style: CustomLabels.h1
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: kDefaultPadding,
                        ),
                        Text(
                          'Somos una empresa dedicada a ofrecer soluciones inmobiliarias en la venta y alquiler de apartamentos lujosos, locales, terrenos, oficinas en Panamá buscando satisfacer a nuestros clientes y preservando el patrimonio con profesionalismo e integridad.',
                          style: CustomLabels.h3ColorBlack87,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: kDefaultPadding),
                WhiteCard(
                  isDrag: false,
                  title: 'PROYECTOS',
                  child: Column(
                    children: [
                      Container(
                        height: 150,
                        child: ListView.builder(
                          itemCount: destrProy.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) => GestureDetector(
                            onTap: () {
                              NavigationService.navigateTo(
                                  '/proyectos/${proyectosProvider.proyectos[index].uid}');
                            },
                            child: MouseRegion(
                              cursor: SystemMouseCursors.click,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: kDefaultPadding),
                                child: Image(
                                    fit: BoxFit.cover,
                                    width: 150,
                                    image: (proyectosProvider
                                                .proyectos[index].img ==
                                            '')
                                        ? NetworkImage(
                                            'https://res.cloudinary.com/dnejayiiq/image/upload/v1672446892/logo_hnizxp.png')
                                        : NetworkImage(proyectosProvider
                                            .proyectos[index].img)),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: kDefaultPadding,
                      ),
                      Padding(
                          padding:
                              const EdgeInsets.only(left: kDefaultPadding / 2),
                          child: Container(
                            height: 370,
                            child: ListView(
                              scrollDirection: Axis.horizontal,
                              children: [...destrProy],
                            ),
                          )),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 100,
            )
          ],
        ),
      ),
    );
  }
}
