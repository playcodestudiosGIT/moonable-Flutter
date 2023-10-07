import 'package:flutter/material.dart';
import 'package:moonable/models/cliente_model.dart';
import 'package:moonable/providers/clients_provider.dart';
import 'package:moonable/settings/constants.dart';
import 'package:moonable/ui/widgets/client_item.dart';
import 'package:provider/provider.dart';

import '../../widgets/dialogs/create_edit_client_dialog.dart';

class ClientsAdminView extends StatefulWidget {
  const ClientsAdminView({super.key});

  @override
  State<ClientsAdminView> createState() => _ClientsAdminViewState();
}

class _ClientsAdminViewState extends State<ClientsAdminView> {
  @override
  void initState() {
    Provider.of<ClientsProvider>(context, listen: false).getAllClientsDB();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final clientsProvider = Provider.of<ClientsProvider>(context);

    const Client? client = null;
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 30),
          Row(
            children: [
              const SizedBox(width: 30),
              Text('Lista de clientes', style: text32Headline(context)),
              const Spacer(),
              IconButton(
                  onPressed: () async {
                    await showDialog(
                        context: context,
                        builder: (context) =>
                            const CreateEditClientDialog(client: client));
                    setState(() {});
                  },
                  icon: const Icon(Icons.person_add_alt_1)),
              const SizedBox(width: 30)
            ],
          ),
          const SizedBox(height: 15),
          ...clientsProvider.allClientsDB
              .map(
                (e) => ClientItem(client: e),
              )
              .toList().reversed,
          const SizedBox(height: 100)
        ],
      ),
    );
  }
}
