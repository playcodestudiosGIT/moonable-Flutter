
import 'package:flutter/material.dart';
import 'package:moonable/models/operation_load_model.dart';

import '../api/moonable_api.dart';
import '../models/operation_model.dart';
import '../services/notificacion_service.dart';
import 'http/all_operations_response.dart';

class ListOperationsProvider extends ChangeNotifier {
  List<Operation> _allOperationsDB = [];
  int _totalAllOperationsDB = 0;
  List<Operation> _operationsLoad = [];
  List<Operation> selectedOperations = [];
  bool _isLoading = false;

  int get totalAllOperationsDB => _totalAllOperationsDB;

  set totalAllOperationsDB(int value) {
    _totalAllOperationsDB = value;
    notifyListeners();
  }

  List<Operation> get allOperationsDB => _allOperationsDB;

  set allOperationsDB(List<Operation> value) {
    _allOperationsDB = value;
    notifyListeners();
  }

  List<Operation> get operationsLoad => _operationsLoad;

  set operationsLoad(List<Operation> value) {
    _operationsLoad = value;
    notifyListeners();
  }

  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<void> guardarMultiplesOperaciones(
      {required List<Operation> operations}) async {
    List data = [];

    for (Operation operation in operations) {
      final decodeOp = OperationLoad(
          ibanWallet: operation.ibanWallet,
          fiatAmount: operation.fiatAmount,
          fiatType: operation.fiatType,
          exchangeRate: operation.exchangeRate,
          assetType: operation.assetType,
          percent: operation.percent,
          platform: operation.platform,
          dueDate: operation.dueDate).toRawJson();
      data.add(decodeOp);
    }
    try {
      final resp =
          await MoonableApi.post('/operaciones/bulk', {"operations": "$data"});

      NotifServ.showSnackbarError(msg: resp["msg"], ok: true);
    } catch (e) {
      NotifServ.showSnackbarError(msg: e.toString(), ok: true);
      // print(e);
    }
  }

  Future<void> getAllOperationsDB() async {
    try {
      final resp = await MoonableApi.httpGet('/operaciones');

      final operacionesResponse = AllOperationsResponse.fromJson(resp);

      allOperationsDB = operacionesResponse.operations;
    } catch (e) {
      // print(e);
    }
  }
}
