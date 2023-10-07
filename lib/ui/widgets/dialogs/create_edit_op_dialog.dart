import 'package:flutter/material.dart';
import 'package:moonable/models/cliente_model.dart';
import 'package:moonable/models/operation_model.dart';
import 'package:moonable/providers/operations_provider.dart';
import 'package:provider/provider.dart';

import '../../../providers/conf/imputs_decoration.dart';
import '../../../providers/clients_provider.dart';
import '../../../settings/constants.dart';
import '../flag_country_widget.dart';

// ignore: must_be_immutable
class CreateEditOperationDialog extends StatefulWidget {
  Operation? operation;
  CreateEditOperationDialog({super.key, required this.operation});

  @override
  State<CreateEditOperationDialog> createState() =>
      _CreateEditOperationDialogState();
}

class _CreateEditOperationDialogState extends State<CreateEditOperationDialog> {
  late bool isDarkMode;
  late Operation op;
  TextEditingController editingController = TextEditingController();
  Client clientSelected = Client(
    businessName: '',
    firstName: '',
    lastName: '',
    ibanWallet: [],
    operations: [],
    tier: 'Tier - 0',
    tierStatus: 'Pending',
    clientType: 'Individual',
    registryDate: '',
    countryResidency: '',
    nationality: '',
    birth: '',
    documentNumber: '',
    expirationDate: '',
    residenceLand: '',
    nationalityLand: '',
    userAge: '',
    auxRiesgo: '',
    estado: true,
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
    uid: '',
  );
  late int seconds;
  @override
  void initState() {
    super.initState();
    if (widget.operation == null) {
      op = operationDummy;
    } else {
      op = widget.operation!;
      clientSelected = Provider.of<ClientsProvider>(context, listen: false)
          .getClientById(id: widget.operation!.client)!;
    }
    seconds = DateTime.now().difference(op.dueDate).inSeconds;
  }

  @override
  Widget build(BuildContext context) {
    if (Theme.of(context).brightness == Brightness.dark) {
      setState(() {
        isDarkMode = true;
      });
    } else {
      setState(() {
        isDarkMode = false;
      });
    }
    final listClientsProvider = Provider.of<ClientsProvider>(context);
    List<Client> clients = listClientsProvider.tmpClientsDB;

    bool empty = clientSelected.ibanWallet.isEmpty;

    var items = clientSelected.ibanWallet.map((e) {
      return DropdownMenuItem(
        value: e,
        child: Text(
          e,
          style: text14BodyM(context),
        ),
      );
    }).toList();
    DateTime newTime = DateTime.now().add(const Duration(hours: 24));
    return AlertDialog(
      content: SizedBox(
        height: 450,
        width: 340,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Agregar operación',
              style: text22Title(context),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  margin: const EdgeInsets.only(right: 15),
                  child: Column(
                    children: [
                      Column(
                        children: [
                          if (clientSelected.ibanWallet.isEmpty)
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                onChanged: (value) {
                                  Provider.of<ClientsProvider>(context,
                                          listen: false)
                                      .filterSearchResults(value);
                                  setState(() {});
                                },
                                controller: editingController,
                                decoration: InputDecoration(
                                    labelText: "Buscar Cliente",
                                    hintText: "Buscar por nombre o iban",
                                    prefixIcon: const Icon(Icons.search),
                                    suffixIcon: (!clients.isNotEmpty)
                                        ? null
                                        : IconButton(
                                            onPressed: () {
                                              Provider.of<ClientsProvider>(
                                                      context,
                                                      listen: false)
                                                  .tmpClientsDB = [];
                                              editingController.clear();
                                            },
                                            icon: const Icon(
                                              Icons.clear,
                                              color: Colors.red,
                                            )),
                                    border: const OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(25.0)))),
                              ),
                            ),
                          Container(
                            padding: const EdgeInsets.only(right: 15),
                            width: double.infinity,
                            constraints: const BoxConstraints(maxHeight: 200),
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: clients.length,
                              itemBuilder: (context, index) {
                                return ListTile(
                                  title: MouseRegion(
                                    cursor: SystemMouseCursors.click,
                                    child: GestureDetector(
                                      onTap: () {
                                        clientSelected = clients[index];
                                        Provider.of<ClientsProvider>(context,
                                                listen: false)
                                            .tmpClientsDB = [];
                                        editingController.clear();
                                        // setState(() {});
                                      },
                                      child: Column(
                                        children: [
                                          Text(
                                            '${clients[index].firstName} ${clients[index].lastName} / ${clients[index].ibanWallet[0]}',
                                            style: text10mini(context),
                                          ),
                                          const Divider()
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                      if (!empty) ...[
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            Expanded(
                                flex: 7,
                                child: Row(
                                  children: [
                                    FlagWCountryWidget(
                                        country: clientSelected.ibanWallet[0]
                                            .substring(0, 2)),
                                    const SizedBox(width: 25),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        (clientSelected.clientType ==
                                                "Individual")
                                            ? Text(
                                                '${clientSelected.firstName} ${clientSelected.lastName}')
                                            : Text(clientSelected.businessName),
                                        Text(clientSelected.ibanWallet[0],
                                            style: text10mini(context)),
                                      ],
                                    )
                                  ],
                                )),
                            if(widget.operation == null)
                            Expanded(
                                flex: 1,
                                child: IconButton(
                                    icon: const Icon(
                                      Icons.remove,
                                      color: Colors.red,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        clientSelected = clienteDummy;
                                        items = [];
                                      });
                                    })),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            Expanded(
                                flex: 5,
                                child: DropdownButtonFormField(
                                  focusColor: Colors.transparent,
                                  value: (clientSelected.ibanWallet
                                          .contains(op.ibanWallet))
                                      ? op.ibanWallet
                                      : '',
                                  decoration: InputsDeco.textFormDeco(
                                      isDarkMode: isDarkMode,
                                      icon: Icons.assured_workload,
                                      context: context,
                                      label: 'Iban Wallet'),
                                  items: [
                                    const DropdownMenuItem(
                                        value: '',
                                        child: Text('Seleccione Iban/Wallet')),
                                    ...items
                                  ],
                                  onChanged: (value) => op.ibanWallet = value!,
                                )),
                          ],
                        ),
                      ],
                      const SizedBox(height: 20),
                      DropdownButtonFormField(
                        focusColor: Colors.transparent,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                        value: op.platform,
                        decoration: InputsDeco.textFormDeco(
                            isDarkMode: isDarkMode,
                            icon: Icons.display_settings_sharp,
                            context: context,
                            label: 'Platform'),
                        items: [
                          const DropdownMenuItem(
                            value: '',
                            child: Padding(
                              padding: EdgeInsets.only(left: 8.0),
                              child: Text('Seleccione Platform'),
                            ),
                          ),
                          DropdownMenuItem(
                            value: 'OKX',
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Text(
                                'OKX',
                                style: text14BodyM(context),
                              ),
                            ),
                          ),
                          DropdownMenuItem(
                              value: 'Binance',
                              child: Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Text(
                                  'Binance',
                                  style: text14BodyM(context),
                                ),
                              ))
                        ],
                        onChanged: (value) {
                          setState(() {
                            op.platform = value.toString();
                          });
                        },
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: TextFormField(
                              initialValue: op.fiatAmount.toString(),
                              keyboardType: TextInputType.number,
                              decoration: InputsDeco.textFormDeco(
                                  isDarkMode: isDarkMode,
                                  context: context,
                                  label: 'Amount',
                                  icon: Icons.money),
                              onChanged: (value) =>
                                  op.fiatAmount = double.parse(value),
                            ),
                          ),
                          const SizedBox(width: 15),
                          Expanded(
                            flex: 3,
                            child: DropdownButtonFormField(
                              focusColor: Colors.transparent,
                              value: op.fiatType,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10)),
                              isExpanded: false,
                              decoration: InputsDeco.textFormDeco(
                                  isDarkMode: isDarkMode,
                                  context: context,
                                  label: 'Fiat type'),
                              items: const [
                                DropdownMenuItem(
                                  value: '',
                                  child: Padding(
                                    padding: EdgeInsets.only(left: 8.0),
                                    child: Text('Fiat type'),
                                  ),
                                ),
                                DropdownMenuItem(
                                  value: 'USDT',
                                  child: Padding(
                                    padding: EdgeInsets.only(left: 8.0),
                                    child: Text('USDT'),
                                  ),
                                ),
                                DropdownMenuItem(
                                    value: 'EUR',
                                    child: Padding(
                                      padding: EdgeInsets.only(left: 8.0),
                                      child: Text('EUR'),
                                    ))
                              ],
                              onChanged: (value) {
                                setState(() {
                                  op.fiatType = value.toString();
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: TextFormField(
                              initialValue: op.exchangeRate.toString(),
                              keyboardType: TextInputType.number,
                              decoration: InputsDeco.textFormDeco(
                                  isDarkMode: isDarkMode,
                                  context: context,
                                  label: 'Rate',
                                  icon: Icons.currency_exchange),
                              onChanged: (value) =>
                                  op.exchangeRate = double.parse(value),
                            ),
                          ),
                          const SizedBox(width: 15),
                          Expanded(
                            flex: 3,
                            child: DropdownButtonFormField(
                              focusColor: Colors.transparent,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10)),
                              value: op.assetType,
                              isExpanded: false,
                              decoration: InputsDeco.textFormDeco(
                                  isDarkMode: isDarkMode,
                                  context: context,
                                  label: 'Asset type'),
                              items: const [
                                DropdownMenuItem(
                                  value: '',
                                  child: Padding(
                                    padding: EdgeInsets.only(left: 8.0),
                                    child: Text('Asset type'),
                                  ),
                                ),
                                DropdownMenuItem(
                                  value: 'USDT',
                                  child: Padding(
                                    padding: EdgeInsets.only(left: 8.0),
                                    child: Text('USDT'),
                                  ),
                                ),
                                DropdownMenuItem(
                                    value: 'EUR',
                                    child: Padding(
                                      padding: EdgeInsets.only(left: 8.0),
                                      child: Text('EUR'),
                                    ))
                              ],
                              onChanged: (value) {
                                setState(() {
                                  op.assetType = value.toString();
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: TextFormField(
                              initialValue: op.percent.toString(),
                              keyboardType: TextInputType.number,
                              decoration: InputsDeco.textFormDeco(
                                  isDarkMode: isDarkMode,
                                  context: context,
                                  label: '%',
                                  icon: Icons.percent),
                              onChanged: (value) =>
                                  op.percent = double.parse(value),
                            ),
                          ),
                          const SizedBox(width: 15),
                          Expanded(
                              flex: 3,
                              child: Row(
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      if (!seconds.isNegative && seconds != 0)
                                        Text('EXPIRED AGO',
                                            style: text10miniOp(context)),
                                      if (seconds.isNegative && seconds != 0)
                                        Text('DUE TIME',
                                            style: text10miniOp(context)),
                                      if (seconds == 0)
                                        Text('EXPIRE TOMORROW',
                                            style: text10miniOp(context)),
                                      if (seconds.isNegative && seconds != 0)
                                        Builder(builder: (context) {
                                          return Text(
                                            '${op.dueDate.difference(DateTime.now()).inHours} horas',
                                            // ${dateTime.minute.toString().padLeft(2, '0')}min ${dateTime.second.toString().padLeft(2, '0')}sec',
                                            style: text10mini(context),
                                          );
                                        }),
                                      if (!seconds.isNegative && seconds != 0)
                                        Text(
                                          '${op.dueDate.day}-${op.dueDate.month}-${op.dueDate.year}',
                                          style: text10mini(context),
                                        ),
                                      if (seconds == 0)
                                        Text(
                                          '${newTime.day + 1}-${newTime.month}-${newTime.year} at ${newTime.hour}:${newTime.minute}:${newTime.second}',
                                          style: text10mini(context),
                                        ),
                                    ],
                                  ),
                                  if(seconds == 0)
                                  ...[
                                    const Spacer(),
                                    IconButton(onPressed: ()=> setState(() {}), icon: const Icon(Icons.refresh, size: 15,)),]
                                ],
                              )),
                          if (!seconds.isNegative && seconds != 0)
                            Expanded(
                              flex: 1,
                              child: IconButton(
                                icon: const Icon(Icons.more_time),
                                onPressed: () async {
                                  final isOk = await showDialog(
                                    context: context,
                                    builder: (context) => Center(
                                        child: AlertDialog(
                                      content: SizedBox(
                                        width: 320,
                                        height: 50,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Text(
                                                'Desea reabrir la operacion?'),
                                            Text(
                                              'Se añadiran 24 h mas a partir de ahora',
                                              style: text10miniOp(context),
                                            ),
                                            const Divider()
                                          ],
                                        ),
                                      ),
                                      actions: [
                                        OutlinedButton(
                                            onPressed: () =>
                                                Navigator.pop(context, false),
                                            child: const Text('No')),
                                        FilledButton(
                                            onPressed: () =>
                                                Navigator.pop(context, true),
                                            child: const Text('Si'))
                                      ],
                                    )),
                                  );

                                  if (isOk) {
                                    setState(() {
                                      seconds = DateTime.now()
                                          .difference(op.dueDate)
                                          .inSeconds;
                                      op.dueDate = DateTime.now()
                                          .add(const Duration(hours: 24));
                                    });
                                  }
                                },
                              ),
                            )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
      actions: [
        OutlinedButton(
            onPressed: () {
              Navigator.pop(context, false);
            },
            child: const Text('Cancelar')),
        if(clientSelected.ibanWallet.isNotEmpty)
        FilledButton(
            onPressed: (widget.operation != null)
                ? () async {
                    final newOp = Operation(
                        uid: op.uid,
                        client: clientSelected.uid,
                        createdAt: DateTime.now(),
                        updatedAt: DateTime.now(),
                        estado: true,
                        assetType: op.assetType,
                        platform: op.platform,
                        percent: op.percent,
                        exchangeRate: op.exchangeRate,
                        ibanWallet: op.ibanWallet,
                        fiatAmount: op.fiatAmount,
                        fiatType: op.fiatType,
                        dueDate: op.dueDate);
                    await Provider.of<OperationsProvider>(context,
                            listen: false)
                        .updateOperation(newOp);
                    if (context.mounted) {
                      Navigator.pop(context, true);
                    }
                  }
                : () async {
                    final newOp = Operation(
                        client: clientSelected.uid,
                        createdAt: DateTime.now(),
                        updatedAt: DateTime.now(),
                        estado: true,
                        assetType: op.assetType,
                        platform: op.platform,
                        percent: op.percent,
                        exchangeRate: op.exchangeRate,
                        ibanWallet: op.ibanWallet,
                        fiatAmount: op.fiatAmount,
                        fiatType: op.fiatType,
                        dueDate: DateTime.now().add(const Duration(hours: 24)));

                    await Provider.of<OperationsProvider>(context,
                            listen: false)
                        .createOperation(newOp);
                    if (context.mounted) {
                      Navigator.pop(context, true);
                    }
                  },
            child: (widget.operation != null)
                ? const Text('Actualizar')
                : const Text('Agregar')),
      ],
    );
  }
}
