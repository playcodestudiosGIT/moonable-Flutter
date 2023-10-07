import 'package:flutter/material.dart';
import 'package:moonable/models/cliente_model.dart';
import 'package:moonable/models/operation_model.dart';
import 'package:moonable/providers/operations_provider.dart';
import 'package:provider/provider.dart';

import '../../../providers/clients_provider.dart';

class ConfirmDeleteDialog extends StatefulWidget {
  final dynamic obj;
  const ConfirmDeleteDialog({super.key, required this.obj});

  @override
  State<ConfirmDeleteDialog> createState() => _ConfirmDeleteDialogState();
}

class _ConfirmDeleteDialogState extends State<ConfirmDeleteDialog> {
  bool objIs = false;

  @override
  void initState() {
    if (widget.obj is Client) objIs = true;
    if (widget.obj is Operation) objIs = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      surfaceTintColor: Colors.redAccent,
      title: const Icon(Icons.warning),
      content: Container(
        constraints: const BoxConstraints(maxWidth: 300, maxHeight: 80),
        child: Center(
          child: (objIs)
              ? Text(
                  'Seguro que desea eliminar cliente \n${widget.obj.firstName} ${widget.obj.lastName}?')
              : Text(
                  'Seguro que desea eliminar operacion \n${widget.obj.ibanWallet}'),
        ),
      ),
      actions: [
        OutlinedButton(
            onPressed: () {
              Navigator.pop(context, false);
            },
            child: const Text('Cancelar')),
        FilledButton(
            onPressed: (objIs)
                ? () async {
                    await Provider.of<ClientsProvider>(context, listen: false)
                        .deleteClient(widget.obj);
                    if (context.mounted) {
                      Navigator.pop(context, true);
                    }
                  }
                : () async {
                    await Provider.of<OperationsProvider>(context,
                            listen: false)
                        .deleteOperation(widget.obj);
                    if (context.mounted) {
                      Navigator.pop(context, true);
                    }
                  },
            child: const Text('Borrar'))
      ],
    );
  }
}
