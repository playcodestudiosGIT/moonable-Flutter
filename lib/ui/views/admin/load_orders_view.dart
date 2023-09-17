import 'package:flutter/material.dart';
import 'package:moonable/settings/constants.dart';
import 'package:provider/provider.dart';

import '../../../models/order_load_model.dart';
import '../../../providers/list_orders_provider.dart';
import '../../widgets/botones/floating_button_csv_orders.dart';

/// Flutter code sample for [DataTable].

class LoadOrdersView extends StatefulWidget {
  const LoadOrdersView({super.key});

  @override
  State<LoadOrdersView> createState() => _LoadOrdersViewState();
}

class _LoadOrdersViewState extends State<LoadOrdersView> {
  @override
  Widget build(BuildContext context) {
    final orders = Provider.of<ListOrdersProvider>(context).orders;
    return Scaffold(
      
      floatingActionButton: const FloatingButtonCsvOrders(),
      body: (orders.isEmpty)
          ? SizedBox(
              width: wSize(context),
              height: hSize(context),
              child: const Center(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(width: 25, height: 25, child: CircularProgressIndicator()),
                  Text('Esperando Archivo'),
                ],
              )))
          : const Padding(
              padding: EdgeInsets.only(bottom: 0, left: 10, right: 10, top: 10),
              child: DataTableExample(),
            ),
    );
  }
}

class DataTableExample extends StatefulWidget {
  const DataTableExample({super.key});

  @override
  State<DataTableExample> createState() => _DataTableExampleState();
}

class _DataTableExampleState extends State<DataTableExample> {
  static List<OrderLoad> orders = [];
  List<bool> selected = [];
  static List<OrderLoad> selectedOrders = [];

  @override
  void initState() {
    orders = Provider.of<ListOrdersProvider>(context, listen: false).orders;
    selected = List<bool>.generate(orders.length, (int index) => false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final listOrdersProvider = Provider.of<ListOrdersProvider>(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: wSize(context),
          height: hSize(context) - 138,
          alignment: Alignment.center,
          child: ListView(
            children: [
              Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  child: Row(children: [
                    Text(
                      'Lista de Ordenes',
                      style: text32Headline(context),
                    )
                  ])),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  columns: const <DataColumn>[
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
                  rows: List<DataRow>.generate(
                    orders.length,
                    (int index) => DataRow(
                      color: MaterialStateProperty.resolveWith<Color?>((Set<MaterialState> states) {
                        // All rows will have the same selected color.
                        if (states.contains(MaterialState.selected)) {
                          return Theme.of(context).colorScheme.primary.withOpacity(0.08);
                        }
                        // Even rows will have a grey color.
                        if (index.isEven) {
                          return Colors.grey.withOpacity(0.3);
                        }
                        return null; // Use default value for other states and odd rows.
                      }),
                      cells: <DataCell>[
                        DataCell(Container(
                          alignment: Alignment.centerLeft,
                          width: 150,
                          height: 50,
                          child: Text(orders[index].orderId, style: Theme.of(context).textTheme.bodySmall),
                        )),
                        DataCell(Container(
                          alignment: Alignment.centerLeft,
                          width: 80,
                          height: 50,
                          child: Text(
                            orders[index].platform,
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        )),
                        DataCell(Container(
                          alignment: Alignment.centerLeft,
                          width: 60,
                          height: 50,
                          child: Text(
                            orders[index].businessName,
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        )),
                        DataCell(Container(
                          alignment: Alignment.centerLeft,
                          width: 120,
                          height: 50,
                          child: Text(
                            orders[index].firstName,
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        )),
                        DataCell(Container(
                          alignment: Alignment.centerLeft,
                          width: 120,
                          height: 50,
                          child: Text(
                            orders[index].lastName,
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        )),
                        DataCell(Container(
                          alignment: Alignment.centerLeft,
                          width: 200,
                          height: 50,
                          child: Text(
                            orders[index].ibanWallet,
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        )),
                        DataCell(Container(
                          alignment: Alignment.centerLeft,
                          width: 60,
                          height: 50,
                          child: Text(
                            orders[index].fiatAmount,
                            style: Theme.of(context).textTheme.bodySmall,
                            overflow: TextOverflow.ellipsis,
                          ),
                        )),
                        DataCell(Container(
                          alignment: Alignment.centerLeft,
                          width: 60,
                          height: 50,
                          child: Text(
                            orders[index].fiatType,
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        )),
                        DataCell(Container(
                          alignment: Alignment.centerLeft,
                          width: 60,
                          height: 50,
                          child: Text(
                            orders[index].exchangeRate,
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        )),
                        DataCell(Container(
                          alignment: Alignment.centerLeft,
                          width: 60,
                          height: 50,
                          child: Text(
                            orders[index].totalAssetPurchase,
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        )),
                        DataCell(Container(
                          alignment: Alignment.centerLeft,
                          width: 60,
                          height: 50,
                          child: Text(
                            orders[index].assetType,
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        )),
                        DataCell(Container(
                          alignment: Alignment.centerLeft,
                          width: 50,
                          height: 50,
                          child: Text(
                            orders[index].percent,
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        )),
                        DataCell(Container(
                          alignment: Alignment.centerLeft,
                          width: 70,
                          height: 50,
                          child: Text(
                            orders[index].dueDate.toString(),
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        )),
                      ],
                      selected: selected[index],
                      onSelectChanged: (bool? value) {
                        setState(() {
                          if (value!) {
                            selectedOrders.add(orders[index]);
                          } else {
                            selectedOrders.remove(orders[index]);
                          }
                          selected[index] = value;
                        });
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          // padding: const EdgeInsets.only(bottom: 10),
          width: double.infinity,
          height: 50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextButton.icon(
                label: const Text('Limpiar lista'),
                onPressed: () {
                  setState(() {
                    orders = [];
                  });
                },
                icon: Icon(Icons.clear, color: Theme.of(context).colorScheme.error),
              ),
              if (selectedOrders.isNotEmpty) ...[
                TextButton.icon(
                  label: const Text('Guardar ordenes'),
                  onPressed: () async {
                    await listOrdersProvider.guardarMultiplesOrdenes(orders: selectedOrders);
            
                    for (var order in selectedOrders) {
                      listOrdersProvider.orders.removeWhere((orderDB) => orderDB == order);
                    }
                    selectedOrders = [];
                    selected = List<bool>.generate(orders.length, (int index) => false);
                    
                    setState(() {});
                  },
                  icon: const Icon(Icons.save, color: Colors.green),
                ),
              ],
              const SizedBox(width: 80)
            ],
          ),
        )
      ],
    );
  }
}
