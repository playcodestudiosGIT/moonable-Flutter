import 'dart:convert';

class OperationLoad {
  
    final String? platform;
    final String ibanWallet;
    final double fiatAmount;
    final String fiatType;
    final double? exchangeRate;
    final String? assetType;
    final double? percent;
    final DateTime dueDate;



    OperationLoad({

        this.platform,
        required this.ibanWallet,
        required this.fiatAmount,
        required this.fiatType,
        this.exchangeRate,
        this.assetType,
        this.percent,
        required this.dueDate,

 
    });

    factory OperationLoad.fromRawJson(String str) => OperationLoad.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory OperationLoad.fromJson(Map<String, dynamic> json) => OperationLoad(

        platform: json["platform"],
        ibanWallet: json["ibanWallet"],
        fiatAmount: json["fiatAmount"],
        fiatType: json["fiatType"],
        exchangeRate: json["exchangeRate"],
        assetType: json["assetType"],
        percent: json["percent"]?.toDouble(),
        dueDate: DateTime.parse(json["dueDate"]),


    );

    Map<String, dynamic> toJson() => {
 
        "platform": platform,
        "ibanWallet": ibanWallet,
        "fiatAmount": fiatAmount,
        "fiatType": fiatType,
        "exchangeRate": exchangeRate,
        "assetType": assetType,
        "percent": percent,
        "dueDate": dueDate.toIso8601String(),
 

    };
}