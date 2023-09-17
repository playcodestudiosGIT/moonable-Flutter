import 'dart:convert';

class AllOrdersResponse {
    final int total;
    final List<dynamic> orders;

    AllOrdersResponse({
        required this.total,
        required this.orders,
    });

    factory AllOrdersResponse.fromRawJson(String str) => AllOrdersResponse.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory AllOrdersResponse.fromJson(Map<String, dynamic> json) => AllOrdersResponse(
        total: json["total"],
        orders: List<dynamic>.from(json["orders"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "total": total,
        "orders": List<dynamic>.from(orders.map((x) => x)),
    };
}