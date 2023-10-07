import 'package:flutter/material.dart';
import 'package:moonable/settings/constants.dart';

import '../api/moonable_api.dart';
import '../models/cliente_model.dart';
import '../services/notificacion_service.dart';
import 'http/all_clients_response.dart';

class ClientsProvider extends ChangeNotifier {
  List<Client> _allClientsDB = [];
  List<Client> _tmpClientsDB = [];
  int _totalAllClientsDB = 0;
  List<Client> _clientsLoad = [];
  List<Client> selectedClients = [];
  bool _isLoading = false;

  List<Client> get tmpClientsDB => _tmpClientsDB;

  set tmpClientsDB(List<Client> value) {
    _tmpClientsDB = value;
    notifyListeners();
  }

  int get totalAllOrdersDB => _totalAllClientsDB;

  set totalAllClientsDB(int value) {
    _totalAllClientsDB = value;
    notifyListeners();
  }

  List<Client> get allClientsDB => _allClientsDB;

  set allClientsDB(List<Client> value) {
    _allClientsDB = value;
    notifyListeners();
  }

  List<Client> get clientsLoad => _clientsLoad;

  set clientsLoad(List<Client> value) {
    _clientsLoad = value;
    notifyListeners();
  }

  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<void> guardarMultiplesClientes({required List<Client> clients}) async {
    List data = [];

    for (Client client in clients) {
      final decodeClient = client.toRawJson();
      data.add(decodeClient);
    }

    try {
      final resp =
          await MoonableApi.post('/clientes/bulk', {"clientes": "$data"});
      NotifServ.showSnackbarError(msg: "${resp["msg"]}", ok: true);
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

  Client? getClientByIban({required String iban}) {
    final client = allClientsDB
        .where((element) => element.ibanWallet.contains(iban))
        .firstOrNull;

    return client;
  }

  Client? getClientById({required String id}) {
    final clientTmp =
        allClientsDB.where((element) => element.uid == id).firstOrNull;
    if (clientTmp == null) return clienteDummy;
    return clientTmp;
  }

  void filterSearchResults(String query) {
    if (query.isEmpty) return;
    if (query.length < 2) return;

    tmpClientsDB = allClientsDB.where((client) {
      bool contiene = false;
      for (var iban in client.ibanWallet) {
        if (iban.toLowerCase().contains(query.toLowerCase())) {
          contiene = true;
        }
      }
      if (client.firstName.toLowerCase().contains(query.toLowerCase()) ||
          client.lastName.toLowerCase().contains(query.toLowerCase()) ||
          contiene) {
        return true;
      } else {
        return false;
      }
    }).toList();
    notifyListeners();
  }

  Future<void> createNewClient(Client client) async {
    final data = client.toJson();

    try {
      await MoonableApi.post('/clientes', data);
      allClientsDB.add(client);
      NotifServ.showSnackbarError(msg: 'Cliente agregado', ok: true);
    } catch (e) {
      NotifServ.showSnackbarError(
          msg: 'Algo salio mal agregando cliente', ok: false);
    }
  }

  Future<void> updateClient(Client client) async {
    final data = client.toJson();
    try {
      final resp = await MoonableApi.put('/clientes/${client.uid}', data);

      final newClient = Client.fromJson(resp);
      allClientsDB.remove(client);
      allClientsDB.add(newClient);
      NotifServ.showSnackbarError(msg: 'Cliente actualizado', ok: true);
    } catch (e) {
      NotifServ.showSnackbarError(
          msg: 'Algo salio mal actualizando cliente', ok: false);
    }
  }

  Future<void> deleteClient(Client client) async {
    try {
      await MoonableApi.delete('/clientes/${client.uid}', {});
      allClientsDB.remove(client);
      notifyListeners();
      NotifServ.showSnackbarError(msg: 'Cliente borrado', ok: true);
    } catch (e) {
      // print(e);
    }
  }
}
