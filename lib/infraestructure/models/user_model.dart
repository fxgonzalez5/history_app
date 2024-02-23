import 'dart:convert';

import 'package:history_app/infraestructure/models/hito_model.dart';

class UserModel {
    final String id;
    final String? photo;
    final String email;
    final String name;
    final List<HitoModel> hitos;

    UserModel({
        required this.id,
        required this.photo,
        required this.email,
        required this.name,
        required this.hitos,
    });

    factory UserModel.fromJson(String str) => UserModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory UserModel.fromMap(Map<String, dynamic> json) => UserModel(
        id: json["id"],
        photo: json["photo"],
        email: json["email"],
        name: json["name"],
        hitos: List<HitoModel>.from(json["hitos"].map((x) => HitoModel.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "photo": photo,
        "email": email,
        "name": name,
        "hitos": List<HitoModel>.from(hitos.map((x) => x.toMap())),
    };
}
