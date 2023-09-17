import 'package:flutter/material.dart';
import 'package:moonable/models/cliente_load_model.dart';

import '../api/moonable_api.dart';
import '../models/cliente_model.dart';
import '../services/notificacion_service.dart';
import 'http/all_clients_response.dart';

class ListClientsProvider extends ChangeNotifier {
  List<Cliente> _allClientsDB = [];
  int _totalAllClientsDB = 0;
  List<ClienteLoad> _clientsLoad = [];
  List<ClienteLoad> selectedClients = [];
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

  List<ClienteLoad> get clientsLoad => _clientsLoad;

  set clientsLoad(List<ClienteLoad> value) {
    _clientsLoad = value;
    notifyListeners();
  }

  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<void> guardarMultiplesClientes({required List<ClienteLoad> clients}) async {
    List data = [];

    for (ClienteLoad client in clients) {
      final decodeClient = ClienteLoad.clientetoRawJson(client);
      data.add(decodeClient);
    }

    try {
      final resp = await MoonableApi.post('/clientes/bulk', {"clientes": "$data"});
      NotifServ.showSnackbarError(msg: resp["msg"], ok: true);
    } catch (e) {
      // print(e);
    }
  }

  Future<void> getAllClientsDB() async {
    try {
      final resp = await MoonableApi.httpGet('/clientes');

      final clientesResponse = AllClientsResponse.fromJson(resp);

      for (var client in clientesResponse.clients) {
        _allClientsDB.add(Cliente(
            clientId: client.clientId,
            businessName: client.businessName,
            firstName: client.firstName,
            lastName: client.lastName,
            ibanWallet: client.ibanWallet,
            tier: client.tier,
            tierStatus: client.tierStatus,
            clientType: client.clientType,
            registryDate: client.registryDate,
            countryResidency: client.countryResidency,
            nationality: client.nationality,
            birth: client.birth,
            documentNumber: client.documentNumber,
            expirationDate: client.expirationDate,
            tierRisk: client.tierRisk,
            residenceLand: client.residenceLand,
            nationalityLand: client.nationalityLand,
            ibanLand: client.ibanLand,
            residenceRisk: client.residenceRisk,
            nationalityRisk: client.nationalityRisk,
            ibanGeoRisk: client.ibanGeoRisk,
            userAge: client.userAge,
            userAgeRisk: client.userAgeRisk,
            userTypeRisk: client.userTypeRisk,
            concatenacionIban: client.concatenacionIban,
            concatenacionBusinessNameIban: client.concatenacionBusinessNameIban,
            auxRiesgo: client.auxRiesgo,
            estado: client.estado,
            createdAt: client.createdAt,
            updatedAt: client.updatedAt,
            uid: client.uid));
      }
      notifyListeners();
    } catch (e) {
      // print(e)
    }
  }
}
