import 'dart:convert';

import 'package:moonable/models/cliente_model.dart';

class AllClientsResponse {
    final int total;
    final List<dynamic> clients;

    AllClientsResponse({
        required this.total,
        required this.clients,
    });

    factory AllClientsResponse.fromRawJson(String str) => AllClientsResponse.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory AllClientsResponse.fromJson(Map<String, dynamic> json) => AllClientsResponse(
        total: json["total"],
        clients: List<Cliente>.from(json["clients"].map((x) => Cliente.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "total": total,
        "clients": List<dynamic>.from(clients.map((x) => x.toJson())),
    };
}