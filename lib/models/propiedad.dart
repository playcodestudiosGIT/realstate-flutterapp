import 'dart:convert';


class Propiedad {
  Propiedad({
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
  ProyectoDePropiedad proyecto;
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

  factory Propiedad.fromJson(String str) => Propiedad.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Propiedad.fromMap(Map<String, dynamic> json) => Propiedad(
        nombreProp: json["nombreProp"],
        direccion: json["direccion"],
        detalles: json["detalles"],
        sevendeoalquila: json["sevendeoalquila"],
        tipopropiedad: json["tipopropiedad"],
        mts2: json["mts2"],
        proyecto: ProyectoDePropiedad.fromMap(json["proyecto"]),
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

  Map<String, dynamic> toMap() => {
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


class ProyectoDePropiedad {
    ProyectoDePropiedad({
        required this.nombre,
        required this.direccion,
        required this.amenidades,
        required this.descripcion,
        required this.ciudadPais,
        required this.usuario,
        required this.img,
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
        required this.uid, required bool estado,
        
    });

    String nombre;
    String direccion;
    String ciudadPais;
    String descripcion;
    String amenidades;
    String usuario;
    String img;
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

    factory ProyectoDePropiedad.fromJson(String str) => ProyectoDePropiedad.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory ProyectoDePropiedad.fromMap(Map<String, dynamic> json) => ProyectoDePropiedad(
        nombre: json["nombre"] ?? 'nombre' ?? '-0',
        direccion: json["direccion"] ?? 'dir',
        ciudadPais: json["ciudadPais"] ?? 'ciudad',
        descripcion: json["descripcion"] ?? 'Des',
        amenidades: json["amenidades"] ?? 'Amenidades',
        usuario: json["usuario"] ?? 'usuario',
        img: json["img"] ?? '',
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
        uid: json["_id"] ?? '0', estado: false,
    );

    Map<String, dynamic> toMap() => {
        "nombre": nombre,
        "direccion": direccion,
        "descripcion": descripcion,
        "amenidades": amenidades,
        "ciudad": ciudadPais,
        "usuario": usuario,
        "img": img,
        "video": video,
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