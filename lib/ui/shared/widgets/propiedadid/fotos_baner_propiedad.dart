import 'package:seo_renderer/renderers/image_renderer/image_renderer_vm.dart';
import 'package:somosproperties/constants.dart';
import 'package:somosproperties/providers/proyectoId_carrousel_provider.dart';
import 'package:somosproperties/ui/cards/white_card.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FotoBanerPropiedad extends StatefulWidget {
  final String fotoBaner;
  final List<String> galeria;

  const FotoBanerPropiedad({
    Key? key,
    required this.fotoBaner,
    required this.galeria,
  }) : super(key: key);

  @override
  State<FotoBanerPropiedad> createState() => _FotoBanerPropiedadState();
}

class _FotoBanerPropiedadState extends State<FotoBanerPropiedad> {
  @override
  Widget build(BuildContext context) {
    final _carrContr = Provider.of<ProyectoCarrouselProvider>(context).propCarrouselCntrl;
    final carrProvider = Provider.of<ProyectoCarrouselProvider>(context);
    return (widget.galeria.length == 0) 
    
    ? Container(
      height: 300,
      child: Center(child: CircularProgressIndicator()))
    
    : Column(
      children: [
        WhiteCard(
          isDrag: true,
            child: CarouselSlider.builder(
                carouselController: _carrContr,
                itemCount: widget.galeria.length,
                itemBuilder: (context, index, realIndex) => ImageRenderer(
                  alt: 'Galeria de Propiedad',
                  src: widget.galeria[index],
                  child: Image(
                      fit: BoxFit.cover,
                      image: NetworkImage(widget.galeria[index])),
                ),
                options: CarouselOptions(
                  viewportFraction: 1,
                  enlargeCenterPage: true,
                  initialPage: carrProvider.currIndxProp,
                  onPageChanged: (index, reason) => index,
                ))),
        WhiteCard(
          isDrag: true,
            child: Container(
                height: 100,
                child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: widget.galeria.length,
                itemBuilder: (context, index) => Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                  child: MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: GestureDetector(
                        onTap: () {
                          carrProvider.gotoProp(index);
                        },
                        child: Image(
                            fit: BoxFit.cover,
                            image: NetworkImage(widget.galeria[index]))),
                  ),
                ),
              ),))
      ],
    );
  }
}




