import 'dart:convert';

import 'operation_model.dart';

class Client {
    String businessName;
    String firstName;
    String lastName;
    List<String> ibanWallet;
    List<Operation> operations;
    String tier;
    String tierStatus;
    String clientType;
    String registryDate;
    String countryResidency;
    String nationality;
    String birth;
    String documentNumber;
    String expirationDate;
    String residenceLand;
    String nationalityLand;
    String userAge;
    String auxRiesgo;
    bool estado;
    DateTime createdAt;
    DateTime updatedAt;
    String uid;

    Client({
        required this.businessName,
        required this.firstName,
        required this.lastName,
        required this.ibanWallet,
        required this.operations,
        required this.tier,
        required this.tierStatus,
        required this.clientType,
        required this.registryDate,
        required this.countryResidency,
        required this.nationality,
        required this.birth,
        required this.documentNumber,
        required this.expirationDate,
        required this.residenceLand,
        required this.nationalityLand,
        required this.userAge,
        required this.auxRiesgo,
        required this.estado,
        required this.createdAt,
        required this.updatedAt,
        required this.uid,
    });

    factory Client.fromRawJson(String str) => Client.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Client.fromJson(Map<String, dynamic> json) => Client(
        businessName: json["businessName"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        ibanWallet: List<String>.from(json["ibanWallet"].map((x) => x)),
        operations: List<Operation>.from(json["operations"].map((x) => Operation.fromJson(x))),
        tier: json["tier"],
        tierStatus: json["tierStatus"],
        clientType: json["clientType"],
        registryDate: json["registryDate"],
        countryResidency: json["countryResidency"],
        nationality: json["nationality"],
        birth: json["birth"],
        documentNumber: json["documentNumber"],
        expirationDate: json["expirationDate"],
        residenceLand: json["residenceLand"],
        nationalityLand: json["nationalityLand"],
        userAge: json["userAge"],
        auxRiesgo: json["auxRiesgo"],
        estado: json["estado"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        uid: json["uid"],
    );

    Map<String, dynamic> toJson() => {
        "businessName": businessName,
        "firstName": firstName,
        "lastName": lastName,
        "ibanWallet": List<dynamic>.from(ibanWallet.map((x) => x)),
        "operations": List<dynamic>.from(operations.map((x) => x.toJson())),
        "tier": tier,
        "tierStatus": tierStatus,
        "clientType": clientType,
        "registryDate": registryDate,
        "countryResidency": countryResidency,
        "nationality": nationality,
        "birth": birth,
        "documentNumber": documentNumber,
        "expirationDate": expirationDate,
        "residenceLand": residenceLand,
        "nationalityLand": nationalityLand,
        "userAge": userAge,
        "auxRiesgo": auxRiesgo,
        "estado": estado,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "uid": uid,
    };
}