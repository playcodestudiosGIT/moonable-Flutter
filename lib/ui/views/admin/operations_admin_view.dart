import 'package:flutter/material.dart';
import 'package:moonable/providers/list_operations_provider.dart';
import 'package:moonable/settings/constants.dart';
import 'package:provider/provider.dart';

import '../../../providers/conf/imputs_decoration.dart';
import '../../widgets/operation_item.dart';

class OperationsAdminView extends StatefulWidget {
  const OperationsAdminView({super.key});

  @override
  State<OperationsAdminView> createState() => _OperationsAdminViewState();
}

class _OperationsAdminViewState extends State<OperationsAdminView> {
  @override
  void initState() {
    Provider.of<ListOperationsProvider>(context, listen: false)
        .getAllOperationsDB();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final operationsProvider = Provider.of<ListOperationsProvider>(context);

    final List<OperationItem> operationsDB = operationsProvider.allOperationsDB
        .map(
          (e) => OperationItem(operation: e),
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
              const Spacer(),
              IconButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) => DialogOperation());
                  },
                  icon: const Icon(Icons.add_chart_rounded)),
              const SizedBox(width: 30)
            ],
          ),
          const SizedBox(height: 30),
          Column(
            children: [...operationsDB],
          ),
          const SizedBox(height: 100)
        ],
      ),
    );
  }
}

// ignore: must_be_immutable
class DialogOperation extends StatefulWidget {
  DialogOperation({super.key});
  String clientType = 'Individual';
  String platform = 'OKX';
  String fiatType = 'EUR';
  String rate = 'EUR';
  double fiatAmount = 0;
  String assetType = 'USDT';
  @override
  State<DialogOperation> createState() => _DialogOperationState();
}

class _DialogOperationState extends State<DialogOperation> {
  @override
  Widget build(BuildContext context) {
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
                child: Column(
                  children: [
                    TextField(
                        decoration: InputsDeco.textFormDeco(
                            label: 'Client', icon: Icons.person)),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        const SizedBox(
                          width: 40,
                          child: Icon(Icons.assured_workload),
                        ),
                        Expanded(
                          flex: 4,
                          child: DropdownButtonFormField(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                            value: widget.platform,
                            isExpanded: false,
                            decoration: InputsDeco.textFormDeco(label: 'Label'),
                            items: const [
                              DropdownMenuItem(
                                value: 'OKX',
                                child: Padding(
                                  padding: EdgeInsets.only(left: 8.0),
                                  child: Text('OKX'),
                                ),
                              ),
                              DropdownMenuItem(
                                  value: 'Binance',
                                  child: Padding(
                                    padding: EdgeInsets.only(left: 8.0),
                                    child: Text('Binance'),
                                  ))
                            ],
                            onChanged: (value) {
                              setState(() {
                                widget.platform = value.toString();
                              });
                            },
                          ),
                        ),
                        const SizedBox(width: 15),
                        Expanded(
                          flex: 5,
                          child: TextField(
                              decoration: InputsDeco.textFormDeco(
                            label: 'IBAN Wallet',
                          )),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: TextField(
                              keyboardType: TextInputType.number,
                              decoration: InputsDeco.textFormDeco(
                                  label: 'Amount', icon: Icons.money)),
                        ),
                        const SizedBox(width: 15),
                        Expanded(
                          flex: 3,
                          child: DropdownButtonFormField(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                            value: widget.fiatType,
                            isExpanded: false,
                            decoration:
                                InputsDeco.textFormDeco(label: 'Fiat type'),
                            items: const [
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
                                widget.fiatType = value.toString();
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
                          child: TextField(
                              keyboardType: TextInputType.number,
                              decoration: InputsDeco.textFormDeco(
                                  label: 'Rate',
                                  icon: Icons.currency_exchange)),
                        ),
                        const SizedBox(width: 15),
                        Expanded(
                          flex: 3,
                          child: DropdownButtonFormField(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                            value: widget.fiatType,
                            isExpanded: false,
                            decoration:
                                InputsDeco.textFormDeco(label: 'Asset type'),
                            items: const [
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
                                widget.fiatType = value.toString();
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
                          flex: 1,
                          child: TextField(
                              keyboardType: TextInputType.number,
                              decoration: InputsDeco.textFormDeco(
                                  label: '%', icon: Icons.percent)),
                        ),
                        const SizedBox(width: 15),
                        Expanded(
                            flex: 3,
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Checkbox(
                                        value: false, onChanged: (value) {}),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    const Text('24h a partir de creada')
                                  ],
                                ),
                                Text(DateTime.now().toString())
                              ],
                            )),
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
      actions: [
        OutlinedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Cancelar')),
        FilledButton(onPressed: () {}, child: const Text('Agregar')),
      ],
    );
  }
}
