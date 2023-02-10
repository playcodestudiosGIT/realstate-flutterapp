import 'package:somosproperties/constants.dart';
import 'package:somosproperties/models/categories.dart';
import 'package:somosproperties/models/propiedad.dart';
import 'package:somosproperties/models/proyecto.dart';
import 'package:somosproperties/providers/propiedades_provides.dart';
import 'package:somosproperties/providers/proyectos_provider.dart';
import 'package:somosproperties/services/navigation_service.dart';
import 'package:somosproperties/ui/cards/propiedad_card.dart';
import 'package:somosproperties/ui/cards/proyecto_card.dart';

import 'package:somosproperties/ui/cards/white_card.dart';

import 'package:somosproperties/ui/shared/links_bar.dart';
import 'package:somosproperties/ui/shared/categorias_slider.dart';

import 'package:somosproperties/ui/shared/widgets/home_banner.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainView extends StatefulWidget {
  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
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

    final List<Propiedad> listProp =
        Provider.of<PropiedadesProvider>(context).listpropiedades;
    final List<Propiedad> listAlq =
        Provider.of<PropiedadesProvider>(context).listEnAlquiler;
    final List<Propiedad> listventa =
        Provider.of<PropiedadesProvider>(context).listEnVentas;
    final size = MediaQuery.of(context).size;
    return ListView(
      physics: ClampingScrollPhysics(),
      children: [
        WhiteCard(
          isDrag: false,
          child: Container(
            width: double.infinity,
            height: (size.width > 600 ? 400 : 300),
            child: CarouselSlider(
                items: [
                  HomeBanner(
                      image:
                          'https://res.cloudinary.com/dnejayiiq/image/upload/v1672430344/banner_2_g7em13.jpg',
                      text: '',
                      textButton: '',
                      corner: 0),
                  HomeBanner(
                      image:
                          'https://res.cloudinary.com/dnejayiiq/image/upload/v1672430344/banner_1_cd2bmn.jpg',
                      text: '',
                      textButton: '',
                      corner: 0),
                  HomeBanner(
                      image:
                          'https://res.cloudinary.com/dnejayiiq/image/upload/v1672765763/banner_3_hsb4j0.jpg',
                      text: '',
                      textButton: '',
                      corner: 0),
                ],
                options: CarouselOptions(
                    enlargeCenterPage: true, viewportFraction: 0.8)),
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
                        padding: const EdgeInsets.only(left: kDefaultPadding),
                        child: Image(
                            fit: BoxFit.cover,
                            width: 150,
                            image: (proyectosProvider.proyectos[index].img ==
                                    '')
                                ? NetworkImage(
                                    'https://res.cloudinary.com/dnejayiiq/image/upload/v1672446892/logo_hnizxp.png')
                                : NetworkImage(
                                    proyectosProvider.proyectos[index].img)),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: kDefaultPadding,
              ),
              Padding(
                  padding: const EdgeInsets.only(left: kDefaultPadding / 2),
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
        SizedBox(height: kDefaultPadding),
        WhiteCard(
          isDrag: false,
          child: Padding(
            padding: const EdgeInsets.only(left: kDefaultPadding / 2),
            child: CategoriasSlider(
              categorias: listCategorias,
            ),
          ),
        ),
        SizedBox(height: kDefaultPadding),
        WhiteCard(
          isDrag: false,
          title: 'PROPIEDADES DESTACADAS',
          child: Builder(builder: (context) {
            final destrProp = listProp.map(
              (e) {
                return PropiedadCard(propiedad: e);
              },
            );
            return Container(
              height: 515,
              child: (destrProp.length == 0)
                  ? CircularProgressIndicator()
                  : ListView(
                      scrollDirection: Axis.horizontal,
                      children: [...destrProp],
                    ),
            );
          }),
        ),
        WhiteCard(
          isDrag: false,
          title: 'PROPIEDADES EN VENTA',
          child: Builder(builder: (context) {
            final destrProp = listventa.map(
              (e) {
                return PropiedadCard(propiedad: e);
              },
            );
            return Container(
              height: 515,
              child: (destrProp.length == 0)
                  ? Center(child: CircularProgressIndicator())
                  : ListView(
                      scrollDirection: Axis.horizontal,
                      children: [...destrProp],
                    ),
            );
          }),
        ),
        WhiteCard(
          isDrag: false,
          title: 'PROPIEDADES EN ALQUILER',
          child: Builder(builder: (context) {
            final destrProp = listAlq.map(
              (e) {
                return PropiedadCard(propiedad: e);
              },
            );
            return Container(
              height: 515,
              child: (destrProp.length == 0)
                  ? CircularProgressIndicator()
                  : ListView(
                      scrollDirection: Axis.horizontal,
                      children: [...destrProp],
                    ),
            );
          }),
        ),
        SizedBox(
          height: 75,
        )
      ],
    );
  }
}
