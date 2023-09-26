import 'dart:convert';

import '../../models/operation_model.dart';

class AllOperationsResponse {
    final int total;
    final List<Operation> operations;

    AllOperationsResponse({
        required this.total,
        required this.operations,
    });

    factory AllOperationsResponse.fromRawJson(String str) => AllOperationsResponse.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory AllOperationsResponse.fromJson(Map<String, dynamic> json) => AllOperationsResponse(
        total: json["total"],
        operations: List<Operation>.from(json["operations"].map((x) => Operation.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "total": total,
        "operations": List<dynamic>.from(operations.map((x) => toJson())),
    };
}