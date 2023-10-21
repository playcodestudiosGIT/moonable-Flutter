import 'package:flutter/material.dart';
import '../api/moonable_api.dart';
import '../models/operation_model.dart';
import '../services/notificacion_service.dart';
import 'http/all_operations_response.dart';

class OperationsProvider extends ChangeNotifier {
  List<Operation> _allOperationsDB = [];
  List<Operation> _paginatedOp = [];
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

  List<Operation> get paginatedOp => _paginatedOp;
  set paginatedOp(List<Operation> value) {
    _paginatedOp = value;
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
      final decodeOp = Operation(
        estado: true,
        updatedAt: DateTime.now(),
        createdAt: DateTime.now(),
        client: '',
        ibanWallet: operation.ibanWallet,
        fiatAmount: operation.fiatAmount,
        fiatType: operation.fiatType,
        exchangeRate: operation.exchangeRate,
        assetType: operation.assetType,
        percent: operation.percent,
        platform: operation.platform,
        dueDate: operation.dueDate,
      ).toRawJson();
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

  Future<void> createOperation(Operation op) async {
    final data = op.toJson();
    try {
      await MoonableApi.post('/operaciones', data);
      await getAllOperationsDB();
      NotifServ.showSnackbarError(msg: 'Operacion Agregada', ok: true);
    } catch (e) {
      // print(e);
    }
  }

  Future<void> updateOperation(Operation op) async {
    final data = op.toJson();
    try {
      await MoonableApi.put('/operaciones/${op.uid}', data);
      await getAllOperationsDB();
      NotifServ.showSnackbarError(msg: 'Operacion Actualizada', ok: true);
    } catch (e) {
      // print(e);
    }
  }

  Future<void> getAllOperationsDB({int desde = 0, int limite = 0}) async {
    try {
      final resp =
          await MoonableApi.httpGet('/operaciones?desde=$desde&limite=$limite');
      final operacionesResponse = AllOperationsResponse.fromJson(resp);
      allOperationsDB = operacionesResponse.operations;
    } catch (e) {
      // print(e);
    }
  }

  Future<void> paginatedOperationsDB({int desde = 0, int limite = 0}) async {
    try {
      final resp =
          await MoonableApi.httpGet('/operaciones?desde=$desde&limite=$limite');
      final operacionesResponse = AllOperationsResponse.fromJson(resp);
      paginatedOp = operacionesResponse.operations;
    } catch (e) {
      // print(e);
    }
  }

  Future<void> deleteOperation(Operation operation) async {
    try {
      final resp =
          await MoonableApi.delete('/operaciones/${operation.uid}', {});
      final op = Operation.fromJson(resp);
      allOperationsDB.removeWhere(
        (element) => element.uid == op.uid,
      );
      notifyListeners();
    } catch (e) {
      // print(e);
    }
  }

}
