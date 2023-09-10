import 'package:flutter/material.dart';

import '../models/order_model.dart';

class ListClientsProvider extends ChangeNotifier {
  List<Order> _clients = [];
  List<Order> selectedClients = [];
  bool _isLoading = false;

  // List<Cliente> get clients => _clients;

  set orders(List<Order> value) {
    _clients = value;
    notifyListeners();
  }


  bool get isLoading => _isLoading;
  
  set isLoading(bool value) {
      _isLoading = value;
      notifyListeners();
  }
}
