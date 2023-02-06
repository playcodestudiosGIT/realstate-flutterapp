import 'package:somosproperties/models/http/auth_response.dart';
import 'package:somosproperties/models/http/propiedades_response.dart';
import 'package:somosproperties/models/propiedad.dart';
import 'package:flutter/material.dart';

import 'package:somosproperties/api/somosp_api.dart';
import 'package:somosproperties/services/notification_service.dart';

class PropiedadesProvider extends ChangeNotifier {
  List<Propiedad> listpropiedades = [];
  List<Propiedad> listEnAlquiler = [];
  List<Propiedad> listEnVentas = [];
  List<Propiedad> listCasas = [];
  List<Propiedad> listApartamentos = [];
  List<Propiedad> listOficinas = [];
  List<Propiedad> listLotes = [];
  List<Propiedad> listLocales = [];
  List<Propiedad> listXId = [];

  Propiedad propiedad = Propiedad(
      nombreProp: '',
      direccion: '',
      detalles: '',
      sevendeoalquila: '',
      tipopropiedad: '',
      mts2: '',
      proyecto: ProyectoDePropiedad(
        uid: '',
        nombre: '',
        estado: false,
        ciudadPais: '',
        descripcion: '',
        amenidades: '',
        usuario: '',
        img: '',
        galeria: [],
        lat: '',
        lon: '',
        piscina: false,
        estac: false,
        roomParty: false,
        gym: false,
        roomPlay: false,
        parque: false,
        tenis: false,
        squash: false,
        raquetball: false,
        futbol: false,
        video: '',
        direccion: '',
      ),
      usuario: '',
      descripcion: '',
      disponible: true,
      habitaciones: '',
      precio: 0,
      banos: '',
      altura: '',
      estacionamientos: '0',
      galeria: [],
      uid: '',
      img: '');

  int total = 0;

  late Propiedad prop = Propiedad(
      nombreProp: '',
      direccion: '',
      detalles: '',
      sevendeoalquila: 'Alquiler',
      tipopropiedad: 'Casa',
      mts2: '',
      proyecto: ProyectoDePropiedad(
        uid: '',
        nombre: '',
        estado: false,
        ciudadPais: '',
        descripcion: '',
        amenidades: '',
        usuario: '',
        img: '',
        galeria: [],
        lat: '',
        lon: '',
        piscina: false,
        estac: false,
        roomParty: false,
        gym: false,
        roomPlay: false,
        parque: false,
        tenis: false,
        squash: false,
        raquetball: false,
        futbol: false,
        video: '',
        direccion: '',
      ),
      usuario: '',
      descripcion: '',
      disponible: true,
      habitaciones: '',
      precio: 0,
      banos: '',
      altura: '',
      estacionamientos: '',
      galeria: [],
      uid: '',
      img: '');

  late String idProyPropNew;

  getPropiedades() async {
    final resp = await SomospApi.httpGet('/propiedades/obtener');
    final list = PropiedadesResponse(
        propiedades: List<Propiedad>.from(
            resp["propiedades"].map((x) => Propiedad.fromMap(x))),
        total: resp['total']);

    listpropiedades = list.propiedades;
    total = list.total;
    idProyPropNew = listpropiedades[0].proyecto.uid;
    getPropiedadesAlquiler();

    getPropiedadesVenta();
    getPropiedadesCasas();
    getPropiedadesApto();
    getPropiedadesOfic();
    getPropiedadesLotes();
    getPropiedadesLocales();

    notifyListeners();

    return list.propiedades;
  }

  refreshProp(id) async {
    await getPropiedades();
    await setPropiedadView(id);
  }

  notify() {
    notifyListeners();
  }

  setPropiedadView(id) async {
    final resp = await SomospApi.httpGet('/propiedades/$id');

    final Propiedad prop = Propiedad.fromMap(resp["propiedad"]);
    this.propiedad = prop;

    notifyListeners();
  }

  getPropiedadesAlquiler() {
    final List<Propiedad> alquileres = listpropiedades
        .where((prop) => prop.sevendeoalquila == 'Alquiler')
        .toList();
    this.listEnAlquiler = alquileres;
  }

  getPropiedadesVenta() {
    final List<Propiedad> ventas = listpropiedades
        .where((prop) => prop.sevendeoalquila == 'Venta')
        .toList();
    this.listEnVentas = ventas;
  }

  getPropiedadesCasas() {
    final List<Propiedad> casas =
        listpropiedades.where((prop) => prop.tipopropiedad == 'Casa').toList();
    this.listCasas = casas;
  }

  getPropiedadesApto() {
    final List<Propiedad> aptos = listpropiedades
        .where((prop) => prop.tipopropiedad == 'Apartamento')
        .toList();
    this.listApartamentos = aptos;
  }

  getPropiedadesOfic() {
    final List<Propiedad> ofic = listpropiedades
        .where((prop) => prop.tipopropiedad == 'Oficina')
        .toList();
    this.listOficinas = ofic;
  }

  getPropiedadesLotes() {
    final List<Propiedad> lotes =
        listpropiedades.where((prop) => prop.tipopropiedad == 'Lote').toList();
    this.listLotes = lotes;
  }

  getPropiedadesLocales() {
    final List<Propiedad> locales =
        listpropiedades.where((prop) => prop.tipopropiedad == 'Local').toList();
    this.listLocales = locales;
  }

  getPropiedadesProy(id) async {
    final resp = await SomospApi.httpGet('/propiedades/obtener');
    final respList = List<Propiedad>.from(
        resp["propiedades"].map((x) => Propiedad.fromMap(x)));
    this.listXId = respList.where((prop) => prop.proyecto.uid == id).toList();
    notifyListeners();
    // notifyListeners();
  }

  Future updateGaleria(String id, List galeria) async {
    final data = {"galeria": galeria};

    try {
      final json = await SomospApi.put('/propiedades/$id', data);
      notifyListeners();
      return json;
    } catch (e) {
      print('Error en el update user');
    }
  }

  Future deleteFotoGaleriaProp(String id, int index) async {
    try {
      await SomospApi.deleteImageGalery(
          '/uploads/delete/propiedades/$id/$index');
      notifyListeners();
      return;
    } catch (e) {
      print('Error en deleTE foto galeria user');
    }
  }

  Future deleteProp(String id) async {
    try {
      final resp = await SomospApi.delete('/propiedades/$id', {});

      listpropiedades.removeWhere(
        (user) => user.uid == id,
      );

      notifyListeners();
    } catch (e) {
      print('Error en el delete prop');
    }
  }

  Future updateProp() async {
    final data = {
      "nombreProp": prop.nombreProp,
      "direccion": prop.direccion,
      "detalles": prop.detalles,
      "sevendeoalquila": prop.sevendeoalquila,
      "tipopropiedad": prop.tipopropiedad,
      "mts2": prop.mts2,
      "proyecto": idProyPropNew,
      "descripcion": prop.descripcion,
      "habitaciones": prop.habitaciones,
      "precio": prop.precio,
      "banos": prop.banos,
      "altura": prop.altura,
      "estacionamientos": prop.estacionamientos,
    };
    print(data);
    // Petición HTTP
    await SomospApi.put('/propiedades', data).then((json) {
      final resp = Propiedad.fromMap(json);
      print(resp);
    }).catchError((e) {
      print('ERROR USER CREATE $e');
    });
  }
}
