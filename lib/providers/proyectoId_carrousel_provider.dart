import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';

class ProyectoCarrouselProvider extends ChangeNotifier {
  CarouselController propCarrouselCntrl = CarouselController();
  CarouselController proyCarrouselCntrl = CarouselController();
  int currIndxProp = 0;
  int currIndxProy = 0;

  setCurrIndxProp(index) {
    currIndxProp = index;
    notifyListeners();
  }
  setCurrIndxProy(index) {
    currIndxProy = index;
    notifyListeners();
  }

  gotoProp(index) {
    propCarrouselCntrl.animateToPage(index);
    currIndxProp = index;
    notifyListeners();
  }
  gotoProy(index) {
    proyCarrouselCntrl.animateToPage(index);
    currIndxProy = index;
    notifyListeners();
  }
}
