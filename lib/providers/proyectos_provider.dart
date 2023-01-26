import 'package:flutter/material.dart';

import 'package:somosproperties/api/somosp_api.dart';

import 'package:somosproperties/models/http/proyectos_response.dart';
import 'package:somosproperties/models/proyecto.dart';

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
}
