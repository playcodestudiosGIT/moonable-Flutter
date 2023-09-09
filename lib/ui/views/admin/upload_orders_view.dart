import 'package:flutter/material.dart';
import 'package:moonable/providers/list_orders_provider.dart';
import 'package:moonable/ui/widgets/datatables/upload_order_dtt_view.dart';
import 'package:provider/provider.dart';

import '../../../models/order_model.dart';
import '../../widgets/botones/floating_button_csv_orders.dart';

class UploadOrdersView extends StatelessWidget {
  const UploadOrdersView({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Order?> orders = Provider.of<ListOrdersProvider>(context).orders;
    return Scaffold(
      floatingActionButton: const FloatingButtonCsvOrders(),
      body: UploadOrdersDTT(orders: orders),
    );
  }
}
