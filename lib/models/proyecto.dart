import 'dart:convert';

class Proyecto {
  Proyecto({
    required this.nombre,
    required this.direccion,
    required this.amenidades,
    required this.descripcion,
    required this.detalles,
    required this.ciudadPais,
    required this.usuario,
    required this.img,
    required this.brochure,
    required this.video,
    required this.galeria,
    required this.lat,
    required this.lon,
    required this.piscina,
    required this.estac,
    required this.roomParty,
    required this.gym,
    required this.roomPlay,
    required this.parque,
    required this.tenis,
    required this.squash,
    required this.raquetball,
    required this.futbol,
    required this.uid,
    required bool estado,
  });

  String nombre;
  String direccion;
  String ciudadPais;
  String descripcion;
  String detalles;
  String amenidades;
  String usuario;
  String img;
  String brochure;
  String video;
  List<dynamic> galeria;
  String lat;
  String lon;
  bool piscina;
  bool estac;
  bool roomParty;
  bool gym;
  bool roomPlay;
  bool parque;
  bool tenis;
  bool squash;
  bool raquetball;
  bool futbol;
  String uid;

  factory Proyecto.fromJson(String str) => Proyecto.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Proyecto.fromMap(Map<String, dynamic> json) => Proyecto(
        nombre: json["nombre"] ?? 'nombre' ?? '-0',
        direccion: json["direccion"] ?? 'Direccion del Proyecto',
        ciudadPais: json["ciudadPais"] ?? 'ciudad',
        descripcion: json["descripcion"] ?? 'Descripción del proyecto',
        detalles: json["descripcion"] ?? 'Detalles del proyecto',
        amenidades: json["amenidades"] ?? 'Amenidades',
        usuario: json["usuario"] ?? 'usuario',
        img: json["img"] ?? '',
        brochure: json["brochure"] ?? '',
        video: json["video"] ?? '',
        galeria: List<String>.from(json["galeria"].map((x) => x)),
        lat: json["lat"] ?? '0',
        lon: json["lon"] ?? '-0',
        piscina: json["piscina"] ?? false,
        estac: json["estac"] ?? false,
        roomParty: json["roomParty"] ?? false,
        gym: json["gym"] ?? false,
        roomPlay: json["roomPlay"] ?? false,
        parque: json["parque"] ?? false,
        tenis: json["tenis"] ?? false,
        squash: json["squash"] ?? false,
        raquetball: json["raquetball"] ?? false,
        futbol: json["futbol"] ?? false,
        uid: json["uid"] ?? '-0',
        estado: false,
      );

  Map<String, dynamic> toMap() => {
        "nombre": nombre,
        "direccion": direccion,
        "descripcion": descripcion,
        "detalles": detalles,
        "amenidades": amenidades,
        "ciudad": ciudadPais,
        "usuario": usuario,
        "img": img,
        "video": video,
        "brochure": brochure,
        "galeria": List<dynamic>.from(galeria.map((x) => x)),
        "lat": lat,
        "lon": lon,
        "uid": uid,
        "estac": estac,
        "piscina": piscina,
        "roomParty": roomParty,
        "gym": gym,
        "roomPlay": roomPlay,
        "parque": parque,
        "tenis": tenis,
        "squash": squash,
        "raquetball": raquetball,
        "futbol": futbol,
      };
}
