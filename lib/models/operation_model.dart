import 'dart:convert';

class Operation {
    final String? client;
    final String? platform;
    final String ibanWallet;
    final double fiatAmount;
    final String fiatType;
    final double? exchangeRate;
    final String? assetType;
    final double? percent;
    final DateTime dueDate;
    final dynamic estado;
    final String? id;
    final DateTime? createdAt;
    final DateTime? updatedAt;


    Operation({
        this.client,
        this.platform,
        required this.ibanWallet,
        required this.fiatAmount,
        required this.fiatType,
        this.exchangeRate,
        this.assetType,
        this.percent,
        required this.dueDate,
        this.estado,
        this.id,
        this.createdAt,
        this.updatedAt,
 
    });

    factory Operation.fromRawJson(String str) => Operation.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Operation.fromJson(Map<String, dynamic> json) => Operation(
        client: json["client"],
        platform: json["platform"],
        ibanWallet: json["ibanWallet"],
        fiatAmount: json["fiatAmount"].toDouble(),
        fiatType: json["fiatType"],
        exchangeRate: json["exchangeRate"].toDouble(),
        assetType: json["assetType"],
        percent: json["percent"]?.toDouble(),
        dueDate: DateTime.parse(json["dueDate"]),
        estado: json["estado"],
        id: json["_id"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),

    );

    Map<String, dynamic> toJson() => {
        "client": client,
        "platform": platform,
        "ibanWallet": ibanWallet,
        "fiatAmount": fiatAmount,
        "fiatType": fiatType,
        "exchangeRate": exchangeRate,
        "assetType": assetType,
        "percent": percent,
        "dueDate": dueDate.toIso8601String(),
        "estado": estado,
        "_id": id,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),

    };
}