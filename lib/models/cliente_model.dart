import 'dart:convert';

class Cliente {
    String nombre;
    String apellido;
    String correo;
    bool estado;


    Cliente({
        required this.nombre,
        required this.apellido,
        required this.correo,
        required this.estado,
    });

    factory Cliente.fromRawJson(String str) => Cliente.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Cliente.fromJson(Map<String, dynamic> json) => Cliente(
        nombre: json["nombre"],
        apellido: json["apellido"],
        correo: json["correo"],
        estado: json["estado"],

    );

    Map<String, dynamic> toJson() => {
        "nombre": nombre,
        "apellido": apellido,
        "correo": correo,
        "estado": estado,
        
    };
}