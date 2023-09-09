import 'package:flutter/material.dart';
import 'package:moonable/providers/list_orders_provider.dart';
import 'package:provider/provider.dart';

import '../models/order_model.dart';

class OrdersUploadDTS extends DataTableSource {
  List<Order?> orders;

  final BuildContext context;
  OrdersUploadDTS({required this.orders, required this.context});

  @override
  DataRow getRow(int index) {
    final listOrdersProvider = Provider.of<ListOrdersProvider>(context);
    final Order? order = orders[index];
    if (order != null) {
      return DataRow(
          selected: listOrdersProvider.selectedOrders.contains(order),
          onSelectChanged: (bool? selected) {
            if (selected != null && selected) listOrdersProvider.selectedOrders.add(order);
            if (selected != null && !selected) listOrdersProvider.selectedOrders.remove(order);
          },
          cells: [
            DataCell(Container(
              alignment: Alignment.centerLeft,
              width: 150,
              height: 50,
              child: Text(order.orderId, style: Theme.of(context).textTheme.bodySmall),
            )),
            DataCell(Container(
              alignment: Alignment.centerLeft,
              width: 80,
              height: 50,
              child: Text(
                order.platform,
                style: Theme.of(context).textTheme.bodySmall,
              ),
            )),
            DataCell(Container(
              alignment: Alignment.centerLeft,
              width: 60,
              height: 50,
              child: Text(
                order.businessName,
                style: Theme.of(context).textTheme.bodySmall,
              ),
            )),
            DataCell(Container(
              alignment: Alignment.centerLeft,
              width: 120,
              height: 50,
              child: Text(
                order.firstName,
                style: Theme.of(context).textTheme.bodySmall,
              ),
            )),
            DataCell(Container(
              alignment: Alignment.centerLeft,
              width: 120,
              height: 50,
              child: Text(
                order.lastName,
                style: Theme.of(context).textTheme.bodySmall,
              ),
            )),
            DataCell(Container(
              alignment: Alignment.centerLeft,
              width: 200,
              height: 50,
              child: Text(
                order.ibanWallet,
                style: Theme.of(context).textTheme.bodySmall,
              ),
            )),
            DataCell(Container(
              alignment: Alignment.centerLeft,
              width: 60,
              height: 50,
              child: Text(
                order.fiatAmount,
                style: Theme.of(context).textTheme.bodySmall,
                overflow: TextOverflow.ellipsis,
              ),
            )),
            DataCell(Container(
              alignment: Alignment.centerLeft,
              width: 60,
              height: 50,
              child: Text(
                order.fiatType,
                style: Theme.of(context).textTheme.bodySmall,
              ),
            )),
            DataCell(Container(
              alignment: Alignment.centerLeft,
              width: 60,
              height: 50,
              child: Text(
                order.exchangeRate,
                style: Theme.of(context).textTheme.bodySmall,
              ),
            )),
            DataCell(Container(
              alignment: Alignment.centerLeft,
              width: 60,
              height: 50,
              child: Text(
                order.totalAssetPurchase,
                style: Theme.of(context).textTheme.bodySmall,
              ),
            )),
            DataCell(Container(
              alignment: Alignment.centerLeft,
              width: 60,
              height: 50,
              child: Text(
                order.assetType,
                style: Theme.of(context).textTheme.bodySmall,
              ),
            )),
            DataCell(Container(
              alignment: Alignment.centerLeft,
              width: 50,
              height: 50,
              child: Text(
                order.percent,
                style: Theme.of(context).textTheme.bodySmall,
              ),
            )),
            DataCell(Container(
              alignment: Alignment.centerLeft,
              width: 70,
              height: 50,
              child: Text(
                order.dueDate.toString(),
                style: Theme.of(context).textTheme.bodySmall,
              ),
            )),
          ]);
    }
    return const DataRow(cells: []);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => orders.length;

  @override
  int get selectedRowCount => 0;
}
