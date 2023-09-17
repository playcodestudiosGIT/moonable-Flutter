import 'package:flutter/material.dart';
import 'package:moonable/providers/list_orders_provider.dart';
import 'package:moonable/settings/constants.dart';
import 'package:provider/provider.dart';

import '../../widgets/order_item.dart';

class OrdersAdminView extends StatefulWidget {
  const OrdersAdminView({super.key});

  @override
  State<OrdersAdminView> createState() => _OrdersAdminViewState();
}

class _OrdersAdminViewState extends State<OrdersAdminView> {
  @override
  void initState() {
    Provider.of<ListOrdersProvider>(context, listen: false).getAllOrdersDB();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ordersProvider = Provider.of<ListOrdersProvider>(context);

    final List<OrderItem> ordersDB = ordersProvider.allOrdersDB
        .map(
          (e) => OrderItem(order: e),
        )
        .toList();

    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 30),
          Row(
            children: [
              const SizedBox(width: 30),
              Text('Lista de ordenes', style: text32Headline(context)),
            ],
          ),
          const SizedBox(height: 30),
    
          Column(
          children: [...ordersDB],
          ),
          const SizedBox(height: 100)
        ],
      ),
    );
  }
}


