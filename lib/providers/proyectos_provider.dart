import 'package:flutter/material.dart';

import 'package:somosproperties/api/somosp_api.dart';

import 'package:somosproperties/models/http/proyectos_response.dart';
import 'package:somosproperties/models/proyecto.dart';
import 'package:somosproperties/services/notification_service.dart';

class ProyectosProvider extends ChangeNotifier {
  List<Proyecto> proyectos = [];
  Proyecto proyecto = new Proyecto(
    nombre: 'nombre',
    direccion: 'direccion',
    descripcion: 'descripcion',
    amenidades: 'amenidades',
    ciudadPais: 'ciudad',
    img: 'img',
    video: '',
    brochure: '',
    galeria: [],
    usuario: '',
    lat: '0',
    lon: '-1',
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
    uid: 'uid',
    estado: false,
    detalles: '',
  );

  Proyecto proy = new Proyecto(
    nombre: '',
    direccion: '',
    descripcion: '',
    amenidades: '',
    ciudadPais: '',
    img: '',
    video: '',
    brochure: '',
    galeria: [],
    usuario: '',
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
    uid: 'uid',
    estado: false,
    detalles: '',
  );

  getProyectos() async {
    final resp = await SomospApi.httpGet('/proyectos/obtener');

    final proyectosResp = ProyectosResponse.fromMap(resp);

    final List<Proyecto> list = proyectosResp.proyectos;

    this.proyectos = list;
    notifyListeners();
  }

  setProyectoView(String id) async {
    final resp = await SomospApi.httpGet('/proyectos/$id');
    final Proyecto proy = Proyecto.fromMap(resp["proyecto"]);
    this.proyecto = proy;
    notifyListeners();
  }

  Future<void> refreshProy(id) async {
    await getProyectos();
    await setProyectoView(id);
  }

  getProyecto(id) {
    final Proyecto proy = proyectos.firstWhere((element) => element.uid == id);
    return proy;
  }

  Future updateGaleria(String id, List galeria) async {
    final data = {"galeria": galeria};

    try {
      final json = await SomospApi.put('/proyectos/$id', data);
      notifyListeners();
      return json;
    } catch (e) {
      print('Error en el update proy');
    }
  }

  Future deleteProy(String id) async {
    try {
      await SomospApi.delete('/proyectos/$id', {});

      proyectos.removeWhere(
        (user) => user.uid == id,
      );

      notifyListeners();
    } catch (e) {
      print('Error en el delete prop');
    }
  }

  Future<void> updateProy(String uid) async {
    final data = {
      "nombre": proy.nombre,
      "direccion": proy.direccion,
      "descripcion": proy.descripcion,
      "amenidades": proy.amenidades,
      "ciudadPais": proy.ciudadPais,
      "video": proy.video,
      "brochure": proy.brochure,
      "usuario": proy.usuario,
      "lat": proy.lat,
      "lon": proy.lon,
      "piscina": proy.piscina,
      "estac": proy.estac,
      "roomParty": proy.roomParty,
      "gym": proy.gym,
      "roomPlay": proy.roomPlay,
      "parque": proy.parque,
      "tenis": proy.tenis,
      "squash": proy.squash,
      "raquetball": proy.raquetball,
      "futbol": proy.futbol,
      "uid": proy.uid,
      "detalles": proy.detalles,
    };
    // Petición HTTP
    try {
      await SomospApi.put('/proyectos/$uid', data);
      NotificationService.showSnackbarError(
          msg: 'Proyecto Editado ', color: Colors.green);
    } catch (e) {
      NotificationService.showSnackbarError(
          msg: 'Error editando proyecto ', color: Colors.red);
      print('ERROR update proy $e');
    }
  }

  Future<void> createProy(String userid) async {
    final data = {
      "nombre": proy.nombre,
      "direccion": proy.direccion,
      "descripcion": proy.descripcion,
      "amenidades": proy.amenidades,
      "ciudadPais": proy.ciudadPais,
      "usuario": userid,
      "video": proy.video,
      "brochure": proy.brochure,
      "lat": proy.lat,
      "lon": proy.lon,
      "piscina": proy.piscina,
      "estac": proy.estac,
      "roomParty": proy.roomParty,
      "gym": proy.gym,
      "roomPlay": proy.roomPlay,
      "parque": proy.parque,
      "tenis": proy.tenis,
      "squash": proy.squash,
      "raquetball": proy.raquetball,
      "futbol": proy.futbol,
      "uid": proy.uid,
      "detalles": proy.detalles,
    };
    // Petición HTTP
    try {
      final json = await SomospApi.post('/proyectos', data);
      final newProy = Proyecto.fromMap(json["proyecto"]);
      this.proyectos.add(newProy);
      getProyectos();
      NotificationService.showSnackbarError(
          msg: 'Propiedad Agregada', color: Colors.green);
    } catch (e) {
      NotificationService.showSnackbarError(
          msg: 'Error Agregando Propiedad', color: Colors.red);
      print('error agregando prop --- $e');
    }
  }
}
