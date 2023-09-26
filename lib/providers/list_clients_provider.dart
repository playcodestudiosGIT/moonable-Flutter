import 'package:flutter/material.dart';

import '../api/moonable_api.dart';
import '../models/cliente_model.dart';
import '../services/notificacion_service.dart';
import 'http/all_clients_response.dart';

class ListClientsProvider extends ChangeNotifier {
  List<Cliente> _allClientsDB = [];
  int _totalAllClientsDB = 0;
  List<Cliente> _clientsLoad = [];
  List<Cliente> selectedClients = [];
  bool _isLoading = false;

  int get totalAllOrdersDB => _totalAllClientsDB;

  set totalAllClientsDB(int value) {
    _totalAllClientsDB = value;
    notifyListeners();
  }

  List<Cliente> get allClientsDB => _allClientsDB;

  set allClientsDB(List<Cliente> value) {
    _allClientsDB = value;
    notifyListeners();
  }

  List<Cliente> get clientsLoad => _clientsLoad;

  set clientsLoad(List<Cliente> value) {
    _clientsLoad = value;
    notifyListeners();
  }

  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<void> guardarMultiplesClientes(
      {required List<Cliente> clients}) async {
    List data = [];

    for (Cliente client in clients) {
      final decodeClient = client.toRawJson();
      data.add(decodeClient);
    }

    try {
      final resp =
          await MoonableApi.post('/clientes/bulk', {"clientes": "$data"});
      NotifServ.showSnackbarError(
          msg: "${resp["msg"]} \n ${resp["duplicados"]}", ok: true);
    } catch (e) {
      // print(e);
    }
  }

  Future<void> getAllClientsDB() async {
    try {
      final resp = await MoonableApi.httpGet('/clientes');
      final allClientsResponse = AllClientsResponse.fromJson(resp);

      allClientsDB = allClientsResponse.clients;
      totalAllClientsDB = allClientsResponse.total;
    } catch (e) {
      // print(e);
    }
  }

  Cliente? getClientByIban({required String iban}) {
    final client = allClientsDB
        .where((element) => element.ibanWallet.contains(iban))
        .firstOrNull;

    return client;
  }

  Cliente? getClientById({required String id}) {
    final client =
        allClientsDB.where((element) => element.uid == id).firstOrNull;
    return client;
  }
}
