import 'dart:convert';

class OrderLoad {
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

  OrderLoad({
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

  factory OrderLoad.fromRawJson(String str) => OrderLoad.fromJson(json.decode(str));

  static String ordertoRawJson(order) => json.encode(toJson(order));

  factory OrderLoad.fromJson(Map<String, dynamic> json) => OrderLoad(
        orderId: json["orderId"] ?? 'N/A',
        platform: json["platform"] ?? 'N/A',
        businessName: json["businessName"] ?? 'N/A',
        firstName: json["firstName"] ?? 'N/A',
        lastName: json["lastName"] ?? 'N/A',
        ibanWallet: json["ibanWallet"] ?? 'N/A',
        fiatAmount: json["fiatAmount"] ?? 'N/A',
        fiatType: json["fiatType"] ?? 'N/A',
        exchangeRate: json["exchangeRate"] ?? 'N/A',
        totalAssetPurchase: json["totalAssetPurchase"] ?? 'N/A',
        assetType: json["assetType"] ?? 'N/A',
        percent: json["percent"] ?? 'N/A',
        dueDate: json["dueDate"] ?? 'N/A',
      );

  static Map<String, dynamic> toJson(order) => {
        "orderId": order.orderId ?? 'N/A',
        "platform": order.platform ?? 'N/A',
        "businessName": order.businessName ?? 'N/A',
        "firstName": order.firstName ?? 'N/A',
        "lastName": order.lastName ?? 'N/A',
        "ibanWallet": order.ibanWallet ?? 'N/A',
        "fiatAmount": order.fiatAmount ?? 'N/A',
        "fiatType": order.fiatType ?? 'N/A',
        "exchangeRate": order.exchangeRate ?? 'N/A',
        "totalAssetPurchase": order.totalAssetPurchase ?? 'N/A',
        "assetType": order.assetType ?? 'N/A',
        "percent": order.percent ?? 'N/A',
        "dueDate": order.dueDate ?? 'N/A',
      };
}
