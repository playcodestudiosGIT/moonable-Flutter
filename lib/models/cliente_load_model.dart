import 'dart:convert';

class ClienteLoad {
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

    ClienteLoad({
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

    });

    factory ClienteLoad.fromRawJson(String str) => ClienteLoad.fromJson(json.decode(str));

    static String clientetoRawJson(cliente) => json.encode(toJson(cliente));

    factory ClienteLoad.fromJson(Map<String, dynamic> json) => ClienteLoad(
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

    );

    static Map<String, dynamic> toJson(cliente) => {
        "clientId": cliente.clientId,
        "businessName": cliente.businessName,
        "firstName": cliente.firstName,
        "lastName": cliente.lastName,
        "ibanWallet": List<dynamic>.from(cliente.ibanWallet.map((x) => x)),
        "tier": cliente.tier,
        "tierStatus": cliente.tierStatus,
        "clientType": cliente.clientType,
        "registryDate": cliente.registryDate,
        "countryResidency": cliente.countryResidency,
        "nationality": cliente.nationality,
        "birth": cliente.birth,
        "documentNumber": cliente.documentNumber,
        "expirationDate": cliente.expirationDate,
        "tierRisk": cliente.tierRisk,
        "residenceLand": cliente.residenceLand,
        "nationalityLand": cliente.nationalityLand,
        "ibanLand": cliente.ibanLand,
        "residenceRisk": cliente.residenceRisk,
        "nationalityRisk": cliente.nationalityRisk,
        "ibanGeoRisk": cliente.ibanGeoRisk,
        "userAge": cliente.userAge,
        "userAgeRisk": cliente.userAgeRisk,
        "userTypeRisk": cliente.userTypeRisk,
        "concatenacionIban": List<dynamic>.from(cliente.concatenacionIban.map((x) => x)),
        "concatenacionBusinessNameIban": List<dynamic>.from(cliente.concatenacionBusinessNameIban.map((x) => x)),
        "auxRiesgo": cliente.auxRiesgo,

    };
}