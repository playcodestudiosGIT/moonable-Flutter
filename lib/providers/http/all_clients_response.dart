import 'dart:convert';

import '../../models/cliente_model.dart';

class AllClientsResponse {
    final int total;
    final List<Client> clients;

    AllClientsResponse({
        required this.total,
        required this.clients,
    });

    factory AllClientsResponse.fromRawJson(String str) => AllClientsResponse.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory AllClientsResponse.fromJson(Map<String, dynamic> json) => AllClientsResponse(
        total: json["total"],
        clients: List<Client>.from(json["clients"].map((x) => Client.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "total": total,
        "clients": List<dynamic>.from(clients.map((x) => x.toJson())),
    };
}