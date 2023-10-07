import 'dart:convert';

class Operation {
    String client;
    String platform;
    String ibanWallet;
    double fiatAmount;
    String fiatType;
    double exchangeRate;
    String assetType;
    double percent;
    DateTime dueDate;
    dynamic estado;
    String? uid;
    DateTime createdAt;
    DateTime updatedAt;


    Operation({
        required this.client,
        required this.platform,
        required this.ibanWallet,
        required this.fiatAmount,
        required this.fiatType,
        required this.exchangeRate,
        required this.assetType,
        required this.percent,
        required this.dueDate,
        required this.estado,
        this.uid,
        required this.createdAt,
        required this.updatedAt,
 
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
        uid: json["uid"],
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
        "uid": uid,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),

    };
}