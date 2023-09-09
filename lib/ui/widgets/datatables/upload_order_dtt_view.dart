import 'package:flutter/material.dart';
import 'package:moonable/providers/list_orders_provider.dart';
import 'package:provider/provider.dart';

import '../../../data/orders_upload_dts.dart';
import '../../../models/order_model.dart';

class UploadOrdersDTT extends StatelessWidget {
  final List<Order?> orders;
  const UploadOrdersDTT({super.key, required this.orders});

  @override
  Widget build(BuildContext context) {
    final wSize = MediaQuery.of(context).size.width;
    final hSize = MediaQuery.of(context).size.height;
    final listOrdersProvider = Provider.of<ListOrdersProvider>(context);
    return Column(
      children: [
        SizedBox(
          height: hSize - 138,
          width: wSize,
          child: ListView(
            children: [
              if (listOrdersProvider.isLoading) SizedBox(
                width: wSize, height: hSize - 138,
                child: const Center(child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(width: 25, height: 25, child: CircularProgressIndicator()),
                    Text('Por favor espere...')
                  ],
                ))),
              if (!listOrdersProvider.isLoading)
                PaginatedDataTable(
                  showCheckboxColumn: true,
                  actions: [
                    IconButton(onPressed: () {}, icon: const Icon(Icons.filter_alt_sharp)),
                    IconButton(onPressed: () {}, icon: const Icon(Icons.list)),
                    IconButton(onPressed: () {}, icon: const Icon(Icons.view_module_rounded)),
                  ],
                  arrowHeadColor: Theme.of(context).colorScheme.primary,
                  rowsPerPage: 30,
                  dataRowMaxHeight: 50,
                  checkboxHorizontalMargin: 24,
                  header: Text(
                    'Lista de ordenes',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  columns: const [
                    DataColumn(label: Text('ORDER Nro')),
                    DataColumn(label: Text('PLATFORM')),
                    DataColumn(label: Text('BUSINESS NAME')),
                    DataColumn(label: Text('FIRST NAME')),
                    DataColumn(label: Text('LAST NAME')),
                    DataColumn(label: Text('IBAN / WALLET')),
                    DataColumn(label: Text('FIAT AMOUNT')),
                    DataColumn(label: Text('FIAT TYPE')),
                    DataColumn(label: Text('EXCHANGE RATE')),
                    DataColumn(label: Text('TOTAL ASSET PURCHASE')),
                    DataColumn(label: Text('ASSET TYPE')),
                    DataColumn(label: Text('%')),
                    DataColumn(label: Text('DUE DATE')),
                  ],
                  source: OrdersUploadDTS(context: context, orders: orders),
                ),
            ],
          ),
        ),
        // Container(width: wSize, height: 60, color: Colors.red)//Theme.of(context).colorScheme.background)
      ],
    );
  }
}
