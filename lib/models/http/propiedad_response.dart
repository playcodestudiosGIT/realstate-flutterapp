// To parse this JSON data, do
//
//     final propiedadResponse = propiedadResponseFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

class PropiedadResponse {
  PropiedadResponse({
    required this.nombreProp,
    required this.direccion,
    required this.detalles,
    required this.sevendeoalquila,
    required this.tipopropiedad,
    required this.mts2,
    required this.proyecto,
    required this.usuario,
    required this.descripcion,
    required this.disponible,
    required this.img,
    required this.habitaciones,
    required this.precio,
    required this.banos,
    required this.altura,
    required this.estacionamientos,
    required this.galeria,
    required this.uid,
  });

  String nombreProp;
  String direccion;
  String detalles;
  String sevendeoalquila;
  String tipopropiedad;
  String mts2;
  String proyecto;
  String usuario;
  String descripcion;
  bool disponible;
  String img;
  String habitaciones;
  int precio;
  String banos;
  String altura;
  String estacionamientos;
  List<String> galeria;
  String uid;

  factory PropiedadResponse.fromRawJson(String str) =>
      PropiedadResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PropiedadResponse.fromJson(Map<String, dynamic> json) =>
      PropiedadResponse(
        nombreProp: json["nombreProp"],
        direccion: json["direccion"],
        detalles: json["detalles"],
        sevendeoalquila: json["sevendeoalquila"],
        tipopropiedad: json["tipopropiedad"],
        mts2: json["mts2"],
        proyecto: json["proyecto"],
        usuario: json["usuario"],
        descripcion: json["descripcion"],
        disponible: json["disponible"],
        img: json["img"],
        habitaciones: json["habitaciones"],
        precio: json["precio"],
        banos: json["banos"],
        altura: json["altura"],
        estacionamientos: json["estacionamientos"],
        galeria: List<String>.from(json["galeria"].map((x) => x)),
        uid: json["uid"],
      );

  Map<String, dynamic> toJson() => {
        "nombreProp": nombreProp,
        "direccion": direccion,
        "detalles": detalles,
        "sevendeoalquila": sevendeoalquila,
        "tipopropiedad": tipopropiedad,
        "mts2": mts2,
        "proyecto": proyecto,
        "usuario": usuario,
        "descripcion": descripcion,
        "disponible": disponible,
        "img": img,
        "habitaciones": habitaciones,
        "precio": precio,
        "banos": banos,
        "altura": altura,
        "estacionamientos": estacionamientos,
        "galeria": List<dynamic>.from(galeria.map((x) => x)),
        "uid": uid,
      };
}
