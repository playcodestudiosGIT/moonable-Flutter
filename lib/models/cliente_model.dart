class Cliente {
    final String clientId;
    final String businessName;
    final String firstName;
    final String lastName;
    final List<String> ibanWallet;
    final String tier;
    final String tierStatus;
    final String clientType;
    final String registryDate;
    final String countryResidency;
    final String nationality;
    final String birth;
    final String documentNumber;
    final String expirationDate;
    final String tierRisk;
    final String residenceLand;
    final String nationalityLand;
    final String ibanLand;
    final String residenceRisk;
    final String nationalityRisk;
    final String ibanGeoRisk;
    final String userAge;
    final String userAgeRisk;
    final String userTypeRisk;
    final List<String> concatenacionIban;
    final List<String> concatenacionBusinessNameIban;
    final String auxRiesgo;
    final bool estado;
    final DateTime createdAt;
    final DateTime updatedAt;
    final String uid;

    Cliente({
        required this.clientId,
        required this.businessName,
        required this.firstName,
        required this.lastName,
        required this.ibanWallet,
        required this.tier,
        required this.tierStatus,
        required this.clientType,
        required this.registryDate,
        required this.countryResidency,
        required this.nationality,
        required this.birth,
        required this.documentNumber,
        required this.expirationDate,
        required this.tierRisk,
        required this.residenceLand,
        required this.nationalityLand,
        required this.ibanLand,
        required this.residenceRisk,
        required this.nationalityRisk,
        required this.ibanGeoRisk,
        required this.userAge,
        required this.userAgeRisk,
        required this.userTypeRisk,
        required this.concatenacionIban,
        required this.concatenacionBusinessNameIban,
        required this.auxRiesgo,
        required this.estado,
        required this.createdAt,
        required this.updatedAt,
        required this.uid,
    });

    factory Cliente.fromJson(Map<String, dynamic> json) => Cliente(
        clientId: json["clientId"],
        businessName: json["businessName"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        ibanWallet: List<String>.from(json["ibanWallet"].map((x) => x)),
        tier: json["tier"],
        tierStatus: json["tierStatus"],
        clientType: json["clientType"],
        registryDate: json["registryDate"],
        countryResidency: json["countryResidency"],
        nationality: json["nationality"],
        birth: json["birth"],
        documentNumber: json["documentNumber"],
        expirationDate: json["expirationDate"],
        tierRisk: json["tierRisk"],
        residenceLand: json["residenceLand"],
        nationalityLand: json["nationalityLand"],
        ibanLand: json["ibanLand"],
        residenceRisk: json["residenceRisk"],
        nationalityRisk: json["nationalityRisk"],
        ibanGeoRisk: json["ibanGeoRisk"],
        userAge: json["userAge"],
        userAgeRisk: json["userAgeRisk"],
        userTypeRisk: json["userTypeRisk"],
        concatenacionIban: List<String>.from(json["concatenacionIban"].map((x) => x)),
        concatenacionBusinessNameIban: List<String>.from(json["concatenacionBusinessNameIban"].map((x) => x)),
        auxRiesgo: json["auxRiesgo"],
        estado: json["estado"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        uid: json["uid"],
    );

    Map<String, dynamic> toJson() => {
        "clientId": clientId,
        "businessName": businessName,
        "firstName": firstName,
        "lastName": lastName,
        "ibanWallet": List<dynamic>.from(ibanWallet.map((x) => x)),
        "tier": tier,
        "tierStatus": tierStatus,
        "clientType": clientType,
        "registryDate": registryDate,
        "countryResidency": countryResidency,
        "nationality": nationality,
        "birth": birth,
        "documentNumber": documentNumber,
        "expirationDate": expirationDate,
        "tierRisk": tierRisk,
        "residenceLand": residenceLand,
        "nationalityLand": nationalityLand,
        "ibanLand": ibanLand,
        "residenceRisk": residenceRisk,
        "nationalityRisk": nationalityRisk,
        "ibanGeoRisk": ibanGeoRisk,
        "userAge": userAge,
        "userAgeRisk": userAgeRisk,
        "userTypeRisk": userTypeRisk,
        "concatenacionIban": List<dynamic>.from(concatenacionIban.map((x) => x)),
        "concatenacionBusinessNameIban": List<dynamic>.from(concatenacionBusinessNameIban.map((x) => x)),
        "auxRiesgo": auxRiesgo,
        "estado": estado,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "uid": uid,
    };
}