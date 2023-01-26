// To parse this JSON data, do
//
//     final proyectosResponse = proyectosResponseFromMap(jsonString);

import 'dart:convert';

import 'package:somosproperties/models/proyecto.dart';

class ProyectosResponse {
    ProyectosResponse({
        required this.total,
        required this.proyectos,
    });

    int total;
    List<Proyecto> proyectos;

    factory ProyectosResponse.fromJson(String str) => ProyectosResponse.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory ProyectosResponse.fromMap(Map<String, dynamic> json) => ProyectosResponse(
        total: json["total"],
        proyectos: List<Proyecto>.from(json["proyectos"].map((x) => Proyecto.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "total": total,
        "proyectos": List<dynamic>.from(proyectos.map((x) => x.toMap())),
    };
}

