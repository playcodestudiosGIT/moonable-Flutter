import 'package:flutter/material.dart';
import 'package:moonable/providers/clients_provider.dart';
import 'package:moonable/providers/operations_provider.dart';
import 'package:moonable/settings/constants.dart';
import 'package:provider/provider.dart';

import '../../widgets/dialogs/create_edit_op_dialog.dart';
import '../../widgets/operation_item.dart';

class OperationsAdminView extends StatefulWidget {
  const OperationsAdminView({super.key});

  @override
  State<OperationsAdminView> createState() => _OperationsAdminViewState();
}

class _OperationsAdminViewState extends State<OperationsAdminView> {
  int limite = 10;
  int desde = 0;
  late List<OperationItem> operationsDB;
  @override
  void initState() {
    Provider.of<OperationsProvider>(context, listen: false)
        .paginatedOperationsDB(desde: desde, limite: limite);
    Provider.of<ClientsProvider>(context, listen: false).getAllClientsDB();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final operationsProvider = Provider.of<OperationsProvider>(context);
    operationsDB = operationsProvider.paginatedOp
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
              Text('Lista de operaciones', style: text32Headline(context)),
              const Spacer(),
              IconButton(
                  onPressed: () async {
                    final ok = await showDialog(
                        context: context,
                        builder: (context) =>
                            CreateEditOperationDialog(operation: null));
                    if (ok) {
                      setState(() {});
                    }
                  },
                  icon: const Icon(Icons.add_chart_rounded)),
              const SizedBox(width: 30)
            ],
          ),
          const SizedBox(height: 30),
          Column(
            children: [if (operationsDB.isNotEmpty) ...operationsDB,
            const SizedBox(height: 20),
            if (operationsDB.isNotEmpty)
            IconButton(
                onPressed: () {
                
                  limite = limite + 5;
                  Provider.of<OperationsProvider>(context, listen: false).getAllOperationsDB(desde: desde, limite: limite);
                },
                icon: Icon(
                  Icons.add_circle_outline_outlined,
                  size: 30,
                  color: primary(context).withOpacity(0.3),
                )),
            ],
          ),
          const SizedBox(height: 100)
        ],
      ),
    );
  }
}

// ignore: must_be_immutable

