import 'dart:convert';

class Order {
    final String ordenId;
    final String platform;
    final String businessName;
    final String firstName;
    final String lastName;
    final List<String> ibanWallet;
    final String fiatAmount;
    final String fiatType;
    final String exchangeRate;
    final String totalAssetPurchase;
    final String assetType;
    final String percent;
    final String dueDate;
    final bool estado;
    final DateTime createdAt;
    final DateTime updatedAt;
    final String uid;

    Order({
        required this.ordenId,
        required this.platform,
        required this.businessName,
        required this.firstName,
        required this.lastName,
        required this.ibanWallet,
        required this.fiatAmount,
        required this.fiatType,
        required this.exchangeRate,
        required this.totalAssetPurchase,
        required this.assetType,
        required this.percent,
        required this.dueDate,
        required this.estado,
        required this.createdAt,
        required this.updatedAt,
        required this.uid,
    });

    factory Order.fromRawJson(String str) => Order.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Order.fromJson(Map<String, dynamic> json) => Order(
        ordenId: json["ordenId"],
        platform: json["platform"],
        businessName: json["businessName"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        ibanWallet: List<String>.from(json["ibanWallet"].map((x) => x)),
        fiatAmount: json["fiatAmount"],
        fiatType: json["fiatType"],
        exchangeRate: json["exchangeRate"],
        totalAssetPurchase: json["totalAssetPurchase"],
        assetType: json["assetType"],
        percent: json["percent"],
        dueDate: json["dueDate"],
        estado: json["estado"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        uid: json["uid"],
    );

    Map<String, dynamic> toJson() => {
        "ordenId": ordenId,
        "platform": platform,
        "businessName": businessName,
        "firstName": firstName,
        "lastName": lastName,
        "ibanWallet": List<dynamic>.from(ibanWallet.map((x) => x)),
        "fiatAmount": fiatAmount,
        "fiatType": fiatType,
        "exchangeRate": exchangeRate,
        "totalAssetPurchase": totalAssetPurchase,
        "assetType": assetType,
        "percent": percent,
        "dueDate": dueDate,
        "estado": estado,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "uid": uid,
    };
}