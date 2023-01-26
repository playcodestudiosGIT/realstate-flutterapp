import 'package:somosproperties/api/somosp_api.dart';
import 'package:somosproperties/models/propiedad.dart';
import 'package:flutter/material.dart';

class BusquedasProvider extends ChangeNotifier {
  bool isOpen = false;
  List<Propiedad> lista = [];

  String query = '';
  String comer = ''; // Venta o Alquiler
  String tipo = ''; // Casa, Apartamento, Local, Lote, Oficina
  String hab = '';
  String banos = '';
  String precio = '5000000';
  String mts2 = '5000';

  setAll() {
    query = '';
    comer = '';
    tipo = '';
    hab = '';
    banos = '';
    precio = '5000000';
    mts2 = '5000';
    notifyListeners();
  }

  setIsOpen() {
    isOpen = !isOpen;
    notifyListeners();
  }

  setPrecio(String value) {
    precio = value;
    notifyListeners();
  }

  setMts2(String value) {
    mts2 = value;
    notifyListeners();
  }

  setBanos(String value) {
    banos = value.toLowerCase();
    notifyListeners();
  }

  setHab(String value) {
    hab = value.toLowerCase();
    notifyListeners();
  }

  setTipo(String value) {
    tipo = value.toLowerCase();
    notifyListeners();
  }

  setComer(String value) {
    comer = value.toLowerCase();
    notifyListeners();
  }

  setQuery(String value) {
    query = value.toLowerCase();
    notifyListeners();
  }

  Future<List<Propiedad>> getSearchList() async {
    final resp = await SomospApi.httpGet('/propiedades/obtener');
    final List<Propiedad> list = List<Propiedad>.from(
        resp["propiedades"].map((x) => Propiedad.fromMap(x)));

    this.lista = list;
    notifyListeners();
    return list;
  }

  searchProp() async {
    if (query == '' || query.length == 0) {
      await getSearchList();
    }
    final List<Propiedad> results = lista.where((prop) {
      final compareTitulo = prop.nombreProp.toLowerCase();
      final compareDesc = prop.descripcion.toLowerCase();
      final compareProy = prop.proyecto.nombre.toLowerCase();
      final compareTipo = prop.tipopropiedad.toLowerCase();
      final compareHab = '${prop.habitaciones.toLowerCase()}';
      final compareBanos = prop.banos.toString().toLowerCase();
      final compareComer = prop.sevendeoalquila.toLowerCase();
      final comparePrecio = prop.precio.toString();
      final compareMts2 = prop.mts2;

      if (compareTitulo.contains(query) ||
          compareDesc.contains(query) ||
          compareProy.contains(query) ||
          compareTipo.contains(query)) {
        if (compareComer.contains(comer)) {
          if (compareTipo.contains(tipo)) {
            if (compareHab.contains(hab)) {
              if (compareBanos.contains(banos)) {
                if (int.parse(comparePrecio) <= double.parse(precio)) {
                  if (double.parse(compareMts2) <= double.parse(mts2)) {
                    return true;
                  }
                }
              }
            }
          }
        }
      }
      return false;
    }).toList();
    this.lista = results;
    notifyListeners();
  }
}
