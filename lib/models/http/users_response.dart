// To parse this JSON data, do
//
//     final respUsers = respUsersFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

import 'package:somosproperties/models/usuario.dart';

class RespUsers {
  RespUsers({
    required this.total,
    required this.users,
  });

  int total;
  List<Usuario> users;

  factory RespUsers.fromRawJson(String str) =>
      RespUsers.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory RespUsers.fromJson(Map<String, dynamic> json) => RespUsers(
        total: json["total"],
        users: List<Usuario>.from(json["users"].map((x) => Usuario.fromMap(x))),
      );

  Map<String, dynamic> toJson() => {
        "total": total,
        "users": List<dynamic>.from(users.map((x) => x.toJson())),
      };
}
