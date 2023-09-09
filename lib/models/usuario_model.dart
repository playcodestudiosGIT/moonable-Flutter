import 'dart:convert';

class Usuario {
    String nombre;
    String apellido;
    String correo;
    String rol;
    bool estado;


    Usuario({
        required this.nombre,
        required this.apellido,
        required this.correo,
        required this.rol,
        required this.estado,
    });

    factory Usuario.fromRawJson(String str) => Usuario.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Usuario.fromJson(Map<String, dynamic> json) => Usuario(
        nombre: json["nombre"],
        apellido: json["apellido"],
        correo: json["correo"],
        rol: json["rol"],
        estado: json["estado"],

    );

    Map<String, dynamic> toJson() => {
        "nombre": nombre,
        "apellido": apellido,
        "correo": correo,
        "rol": rol,
        "estado": estado,
        
    };
}