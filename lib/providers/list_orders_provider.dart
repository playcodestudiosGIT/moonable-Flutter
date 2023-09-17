import 'package:flutter/material.dart';
import 'package:moonable/providers/http/all_orders_response.dart';

import '../api/moonable_api.dart';
import '../models/order_load_model.dart';
import '../models/order_model.dart';
import '../services/notificacion_service.dart';

class ListOrdersProvider extends ChangeNotifier {
  List<Order> _allOrdersDB = [];
  int _totalAllOrdersDB = 0;
  List<OrderLoad> _ordersLoad = [];
  List<OrderLoad> selectedOrders = [];
  bool _isLoading = false;

  int get totalAllOrdersDB => _totalAllOrdersDB;

  set totalAllOrdersDB(int value) {
    _totalAllOrdersDB = value;
    notifyListeners();
  }

  List<Order> get allOrdersDB => _allOrdersDB;

  set allOrdersDB(List<Order> value) {
    _allOrdersDB = value;
    notifyListeners();
  }

  List<OrderLoad> get orders => _ordersLoad;

  set orders(List<OrderLoad> value) {
     _ordersLoad = value;
    notifyListeners();
  }

  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<void> guardarMultiplesOrdenes({required List<OrderLoad> orders}) async {
    List data = [];

    for (OrderLoad order in orders) {
      final decodeOder = OrderLoad.ordertoRawJson(order);
      data.add(decodeOder);
    }

    try {
      final resp = await MoonableApi.post('/ordenes/bulk', {"ordenes": "$data"});
      NotifServ.showSnackbarError(msg: resp["msg"], ok: true);
    } catch (e) {
      // print(e);
    }
  }

  Future<void> getAllOrdersDB() async {
    try {
      final resp = await MoonableApi.httpGet('/ordenes');

      final ordenesResponse = AllOrdersResponse.fromJson(resp);

      allOrdersDB = ordenesResponse.orders.map((e) => Order.fromJson(e)).toList();
      
    } catch (e) {
      // print(e);
    }
  }
}
