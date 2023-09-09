import 'package:flutter/material.dart';

import '../models/order_model.dart';

class ListOrdersProvider extends ChangeNotifier {
  List<Order> _orders = [];
  List<Order> selectedOrders = [];
  bool _isLoading = false;

  List<Order> get orders => _orders;

  set orders(List<Order> value) {
    _orders = value;
    notifyListeners();
  }


  bool get isLoading => _isLoading;
  
  set isLoading(bool value) {
      _isLoading = value;
      notifyListeners();
  }
}
