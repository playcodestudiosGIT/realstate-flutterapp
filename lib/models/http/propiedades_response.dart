// To parse this JSON data, do
//
//     final propiedadesResponse = propiedadesResponseFromMap(jsonString);


import 'dart:convert';

import 'package:somosproperties/models/propiedad.dart';

class PropiedadesResponse {
    PropiedadesResponse({
        required this.total,
        required this.propiedades,
    });

    int total;
    List<Propiedad> propiedades;

    factory PropiedadesResponse.fromJson(String str) => PropiedadesResponse.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory PropiedadesResponse.fromMap(Map<String, dynamic> json) => PropiedadesResponse(
        total: json["total"],
        propiedades: List<Propiedad>.from(json["propiedades"].map((x) => Propiedad.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "total": total,
        "propiedades": List<dynamic>.from(propiedades.map((x) => x.toMap())),
    };
}

