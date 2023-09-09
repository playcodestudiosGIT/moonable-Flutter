import 'dart:convert';

class Order {
  final String orderId;
  final String platform;
  final String businessName;
  final String firstName;
  final String lastName;
  final String ibanWallet;
  final String fiatAmount;
  final String fiatType;
  final String exchangeRate;
  final String totalAssetPurchase;
  final String assetType;
  final String percent;
  final String dueDate;

  Order({
    required this.orderId,
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
  });

  factory Order.fromRawJson(String str) => Order.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Order.fromJson(Map<String, dynamic> json) => Order(
        orderId: json["orderId"],
        platform: json["platform"],
        businessName: json["businessName"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        ibanWallet: json["ibanWallet"],
        fiatAmount: json["fiatAmount"],
        fiatType: json["fiatType"],
        exchangeRate: json["exchangeRate"],
        totalAssetPurchase: json["totalAssetPurchase"],
        assetType: json["assetType"],
        percent: json["percent"],
        dueDate: json["dueDate"],
      );

  Map<String, dynamic> toJson() => {
        "orderId": orderId,
        "platform": platform,
        "businessName": businessName,
        "firstName": firstName,
        "lastName": lastName,
        "ibanWallet": ibanWallet,
        "fiatAmount": fiatAmount,
        "fiatType": fiatType,
        "exchangeRate": exchangeRate,
        "totalAssetPurchase": totalAssetPurchase,
        "assetType": assetType,
        "percent": percent,
        "dueDate": dueDate,
      };
}
