import 'package:flutter/material.dart';
import 'package:moonable/models/operation_model.dart';
import 'package:moonable/settings/constants.dart';
import 'package:provider/provider.dart';

import '../../../providers/list_clients_provider.dart';
import '../../../providers/list_operations_provider.dart';
import '../../widgets/botones/floating_button_csv_operations.dart';
import '../../widgets/flag_country_widget.dart';

/// Flutter code sample for [DataTable].

class LoadOperationsView extends StatefulWidget {
  const LoadOperationsView({super.key});

  @override
  State<LoadOperationsView> createState() => _LoadOperationsViewState();
}

class _LoadOperationsViewState extends State<LoadOperationsView> {
  @override
  void initState() {
    super.initState();
    Provider.of<ListClientsProvider>(context, listen: false).getAllClientsDB();
  }

  @override
  Widget build(BuildContext context) {
    final operationsLoad =
        Provider.of<ListOperationsProvider>(context).operationsLoad;
    return Scaffold(
      floatingActionButton: const FloatingButtonCsvOp(),
      body: (operationsLoad.isEmpty)
          ? SizedBox(
              width: wSize(context),
              height: hSize(context),
              child: const Center(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                      width: 25,
                      height: 25,
                      child: CircularProgressIndicator()),
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
  static List<Operation> operations = [];
  List<bool> selected = [];
  static List<Operation> selectedOp = [];

  @override
  void initState() {
    final operationsProvider =
        Provider.of<ListOperationsProvider>(context, listen: false);
    operations = operationsProvider.operationsLoad.where((element) {
      final cli = Provider.of<ListClientsProvider>(context, listen: false)
          .getClientByIban(iban: element.ibanWallet);

      return element.ibanWallet != "000000" && cli != null;
    }).toList();
    selected = List<bool>.generate(operations.length, (int index) => false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final listOperationsProvider = Provider.of<ListOperationsProvider>(context);
    final listClientsProvider = Provider.of<ListClientsProvider>(context);

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
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  child: Row(children: [
                    Text(
                      'Lista de Operaciones',
                      style: text32Headline(context),
                    )
                  ])),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  columns: const <DataColumn>[
                    DataColumn(label: Text('Operaciones')),
                  ],
                  rows: List<DataRow>.generate(
                    operations.length,
                    (int index) => DataRow(
                      color: MaterialStateProperty.resolveWith<Color?>(
                          (Set<MaterialState> states) {
                        // All rows will have the same selected color.
                        if (states.contains(MaterialState.selected)) {
                          return Theme.of(context)
                              .colorScheme
                              .primary
                              .withOpacity(0.08);
                        }
                        // Even rows will have a grey color.
                        if (index.isEven) {
                          return Colors.grey.withOpacity(0.3);
                        }
                        return null; // Use default value for other states and odd rows.
                      }),
                      cells: <DataCell>[
                        DataCell(Builder(
                          builder: (context) {
                            final client = listClientsProvider.getClientByIban(
                                iban: operations[index].ibanWallet);
                            if (client == null) {
                              listOperationsProvider.operationsLoad
                                  .remove(operations[index]);
                            }

                            return Container(
                              alignment: Alignment.centerLeft,
                              width: 700,
                              height: 100,
                              child: Row(
                                children: [
                                  const SizedBox(width: 20),
                                  Column(
                                    children: [
                                      Text(
                                        operations[index].platform ?? 'N/A',
                                        style: text10mini(context),
                                      ),
                                      FlagWCountryWidget(
                                          country: operations[index]
                                              .ibanWallet
                                              .substring(0, 2)),
                                    ],
                                  ),
                                  const SizedBox(width: 30),
                                  SizedBox(
                                    width: 250,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        if (client == null)
                                          Text(
                                            'NO EXISTE CLIENTE',
                                            style: text10mini(context).copyWith(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .error),
                                          ),
                                        if (client != null) ...[
                                          Text(
                                            client.firstName ?? 'N/A',
                                            style: text10mini(context),
                                          ),
                                          Text(
                                            client.lastName ?? 'N/A',
                                            style: text10mini(context),
                                          ),
                                        ],
                                        Text(
                                          operations[index].ibanWallet,
                                          style: text10mini(context),
                                        )
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 30),
                                  SizedBox(
                                    width: 80,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                                '${operations[index].fiatAmount.toString()} ${operations[index].fiatType.toString()}')
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              '${operations[index].percent.toString()} %',
                                              style: text10mini(context),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 30),
                                  Text(operations[index].dueDate.toString())
                                ],
                              ),
                            );
                          },
                        )),
                      ],
                      selected: selected[index],
                      onSelectChanged: (bool? value) {
                        setState(() {
                          if (value!) {
                            selectedOp.add(operations[index]);
                          } else {
                            selectedOp.remove(operations[index]);
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
                    listOperationsProvider.operationsLoad = [];
                    operations = [];
                  });
                },
                icon: Icon(Icons.clear,
                    color: Theme.of(context).colorScheme.error),
              ),
              if (selectedOp.isNotEmpty) ...[
                TextButton.icon(
                  label: const Text('Guardar'),
                  onPressed: () async {
                    listOperationsProvider.guardarMultiplesOperaciones(
                        operations: selectedOp);

                    for (var op in selectedOp) {
                      listOperationsProvider.allOperationsDB.removeWhere(
                          (opDB) => opDB.ibanWallet == op.ibanWallet);
                    }
                    selectedOp = [];
                    selected = List<bool>.generate(
                        operations.length, (int index) => false);

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
