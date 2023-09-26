import 'package:flutter/material.dart';
import 'package:moonable/models/cliente_model.dart';
import 'package:moonable/settings/constants.dart';
import 'package:moonable/ui/widgets/botones/floating_button_csv_clients.dart';
import 'package:provider/provider.dart';

import '../../../providers/list_clients_provider.dart';

/// Flutter code sample for [DataTable].

class LoadClientsView extends StatefulWidget {
  const LoadClientsView({super.key});

  @override
  State<LoadClientsView> createState() => _LoadClientsViewState();
}

class _LoadClientsViewState extends State<LoadClientsView> {
  @override
  Widget build(BuildContext context) {
    final clients = Provider.of<ListClientsProvider>(context).clientsLoad;
    return Scaffold(
      floatingActionButton: const FloatingButtonCsvClients(),
      body: (clients.isEmpty)
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
  static List<Cliente> clients = [];
  List<bool> selected = [];
  static List<Cliente> selectedClients = [];

  @override
  void initState() {
    final clientsProvider =
        Provider.of<ListClientsProvider>(context, listen: false);
    clients = clientsProvider.clientsLoad
        .where((element) =>
            element.firstName != "N/A" && !element.ibanWallet.contains(""))
        .toList();
    selected = List<bool>.generate(clients.length, (int index) => false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                      'Lista de Clientes',
                      style: text32Headline(context),
                    )
                  ])),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  dataRowMinHeight: 48,
                  columns: const <DataColumn>[
                    DataColumn(label: Text('Business Name')),
                    DataColumn(label: Text('First Name')),
                    DataColumn(label: Text('Last Name')),
                    DataColumn(label: Text('Iban / Wallet')),
                    DataColumn(label: Text('Tier IBAN')),
                    DataColumn(label: Text('Status')),
                    DataColumn(label: Text('User Type')),
                    DataColumn(label: Text('Registry date')),
                    DataColumn(label: Text('Country of residency')),
                    DataColumn(label: Text('Nationality')),
                    DataColumn(label: Text('Date of birth')),
                    DataColumn(label: Text('Document number')),
                    DataColumn(label: Text('Expiration Date')),
                    DataColumn(label: Text('Residence land')),
                    DataColumn(label: Text('Nationality land')),
                    DataColumn(label: Text('User age')),
                    DataColumn(label: Text('Aux Riesgo')),
                  ],
                  rows: List<DataRow>.generate(
                    clients.length,
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
                        DataCell(Container(
                          alignment: Alignment.centerLeft,
                          width: 100,
                          child: Text(clients[index].businessName ?? 'N/A',
                              style: Theme.of(context).textTheme.bodySmall),
                        )),
                        DataCell(Container(
                          alignment: Alignment.centerLeft,
                          width: 80,
                          child: Text(clients[index].firstName ?? 'N/A',
                              style: Theme.of(context).textTheme.bodySmall),
                        )),
                        DataCell(Container(
                          alignment: Alignment.centerLeft,
                          width: 80,
                          child: Text(clients[index].lastName ?? 'N/A',
                              style: Theme.of(context).textTheme.bodySmall),
                        )),
                        DataCell(Container(
                          alignment: Alignment.centerLeft,
                          width: 200,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ...clients[index].ibanWallet.map((e) {
                                if (e == "") {
                                  // print(true);
                                }
                                return Text(e,
                                    overflow: TextOverflow.fade,
                                    style:
                                        Theme.of(context).textTheme.bodySmall);
                              })
                            ],
                          ),
                        )),
                        DataCell(Container(
                          alignment: Alignment.centerLeft,
                          width: 50,
                          child: Text(clients[index].tier ?? 'N/A',
                              style: Theme.of(context).textTheme.bodySmall),
                        )),
                        DataCell(Container(
                          alignment: Alignment.centerLeft,
                          width: 80,
                          child: Text(clients[index].tierStatus ?? 'N/A',
                              style: Theme.of(context).textTheme.bodySmall),
                        )),
                        DataCell(Container(
                          alignment: Alignment.centerLeft,
                          width: 80,
                          child: Text(clients[index].clientType ?? 'N/A',
                              style: Theme.of(context).textTheme.bodySmall),
                        )),
                        DataCell(Container(
                          alignment: Alignment.centerLeft,
                          width: 80,
                          child: Text(clients[index].registryDate ?? 'N/A',
                              style: Theme.of(context).textTheme.bodySmall),
                        )),
                        DataCell(Container(
                          alignment: Alignment.centerLeft,
                          width: 100,
                          child: Text(clients[index].countryResidency ?? 'N/A',
                              style: Theme.of(context).textTheme.bodySmall),
                        )),
                        DataCell(Container(
                          alignment: Alignment.centerLeft,
                          width: 100,
                          child: Text(clients[index].nationality ?? 'N/A',
                              style: Theme.of(context).textTheme.bodySmall),
                        )),
                        DataCell(Container(
                          alignment: Alignment.centerLeft,
                          width: 80,
                          child: Text(clients[index].birth ?? 'N/A',
                              style: Theme.of(context).textTheme.bodySmall),
                        )),
                        DataCell(Container(
                          alignment: Alignment.centerLeft,
                          width: 100,
                          child: Text(clients[index].documentNumber ?? 'N/A',
                              style: Theme.of(context).textTheme.bodySmall),
                        )),
                        DataCell(Container(
                          alignment: Alignment.centerLeft,
                          width: 80,
                          child: Text(clients[index].expirationDate ?? 'N/A',
                              style: Theme.of(context).textTheme.bodySmall),
                        )),
                        DataCell(Container(
                          alignment: Alignment.centerLeft,
                          width: 100,
                          child: Text(clients[index].residenceLand ?? 'N/A',
                              style: Theme.of(context).textTheme.bodySmall),
                        )),
                        DataCell(Container(
                          alignment: Alignment.centerLeft,
                          width: 50,
                          child: Text(clients[index].nationalityLand ?? 'N/A',
                              style: Theme.of(context).textTheme.bodySmall),
                        )),
                        DataCell(Container(
                          alignment: Alignment.centerLeft,
                          width: 50,
                          child: Text(clients[index].userAge ?? 'N/A',
                              style: Theme.of(context).textTheme.bodySmall),
                        )),
                        DataCell(Container(
                          alignment: Alignment.centerLeft,
                          width: 80,
                          child: Text(clients[index].auxRiesgo ?? 'N/A',
                              style: Theme.of(context).textTheme.bodySmall),
                        )),
                      ],
                      selected: selected[index],
                      onSelectChanged: (bool? value) {
                        setState(() {
                          if (value!) {
                            selectedClients.add(clients[index]);
                          } else {
                            selectedClients.remove(clients[index]);
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
                    listClientsProvider.clientsLoad = [];
                    clients = [];
                    selected = [];
                    selectedClients = [];
                  });
                },
                icon: Icon(Icons.clear,
                    color: Theme.of(context).colorScheme.error),
              ),
              if (selectedClients.isNotEmpty) ...[
                TextButton.icon(
                  label: const Text('Guardar Clientes'),
                  onPressed: () async {
                    await listClientsProvider.guardarMultiplesClientes(
                        clients: selectedClients);

                    for (var order in selectedClients) {
                      listClientsProvider.clientsLoad
                          .removeWhere((orderDB) => orderDB == order);
                    }
                    selectedClients = [];
                    selected = List<bool>.generate(
                        clients.length, (int index) => false);

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
