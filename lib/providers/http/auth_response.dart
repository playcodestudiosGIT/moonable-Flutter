import 'dart:convert';

import 'package:moonable/models/usuario_model.dart';

class AuthResponse {
    final Usuario user;
    final String token;

    AuthResponse({
        required this.user,
        required this.token,
    });

    factory AuthResponse.fromRawJson(String str) => AuthResponse.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory AuthResponse.fromJson(Map<String, dynamic> json) => AuthResponse(
        user: Usuario.fromJson(json["user"]),
        token: json["token"],
    );

    Map<String, dynamic> toJson() => {
        "user": user.toJson(),
        "token": token,
    };
}
