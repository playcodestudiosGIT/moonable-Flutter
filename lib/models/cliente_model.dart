import 'dart:convert';

import 'package:moonable/models/operation_model.dart';

class Cliente {
  final String? businessName;
  final String? firstName;
  final String? lastName;
  final List<String> ibanWallet;
  final List<Operation>? operations;
  final String? tier;
  final String? tierStatus;
  final String? clientType;
  final String? registryDate;
  final String? countryResidency;
  final String? nationality;
  final String? birth;
  final String? documentNumber;
  final String? expirationDate;
  final String? residenceLand;
  final String? nationalityLand;
  final String? userAge;
  final String? auxRiesgo;
  final bool? estado;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? uid;

  Cliente({
    this.businessName,
    this.firstName,
    this.lastName,
    required this.ibanWallet,
    this.operations,
    this.tier,
    this.tierStatus,
    this.clientType,
    this.registryDate,
    this.countryResidency,
    this.nationality,
    this.birth,
    this.documentNumber,
    this.expirationDate,
    this.residenceLand,
    this.nationalityLand,
    this.userAge,
    this.auxRiesgo,
    this.estado,
    this.createdAt,
    this.updatedAt,
    this.uid,
  });

  factory Cliente.fromRawJson(String str) => Cliente.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Cliente.fromJson(Map<String, dynamic> json) => Cliente(
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
        estado: json["estado"] ?? true,
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        uid: json["uid"],
      );

  Map<String, dynamic> toJson() => {
        "businessName": businessName,
        "firstName": firstName,
        "lastName": lastName,
        "ibanWallet": List<dynamic>.from(ibanWallet.map((x) => x)),
        "operations": List<dynamic>.from(operations!.map((x) => x.toJson())),
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
        "estado": estado ?? true,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "uid": uid,
      };
}
