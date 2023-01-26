import 'dart:convert';

class Usuario {
  Usuario({
    required this.nombre,
    required this.correo,
    required this.rol,
    this.estado,
    this.google,
    this.img,
    this.uid,
  });

  String nombre;
  String correo;
  String rol;
  bool? estado = true;
  bool? google = false;
  String? img;
  String? uid = '';

  factory Usuario.fromJson(String str) => Usuario.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Usuario.fromMap(Map<String, dynamic> json) => Usuario(
        nombre: json["nombre"],
        correo: json["correo"],
        rol: json["rol"],
        estado: json["estado"],
        google: json["google"],
        img: json["img"] ??
            'https://res.cloudinary.com/dnejayiiq/image/upload/v1671851591/no-image_xb946x.jpg',
        uid: json["uid"],
      );

  Map<String, dynamic> toMap() => {
        "nombre": nombre,
        "correo": correo,
        "rol": rol,
        "estado": estado,
        "google": google,
        "img": img,
        "uid": uid,
      };
}
