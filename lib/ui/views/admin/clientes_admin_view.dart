import 'package:flutter/material.dart';
import 'package:moonable/providers/list_clients_provider.dart';
import 'package:moonable/settings/constants.dart';
import 'package:moonable/ui/widgets/client_item.dart';
import 'package:provider/provider.dart';

class ClientsAdminView extends StatefulWidget {
  const ClientsAdminView({super.key});

  @override
  State<ClientsAdminView> createState() => _ClientsAdminViewState();
}

class _ClientsAdminViewState extends State<ClientsAdminView> {
  @override
  void initState() {
    Provider.of<ListClientsProvider>(context, listen: false).getAllClientsDB();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final clientsProvider = Provider.of<ListClientsProvider>(context);

    final List<ClientItem> clientsDB = clientsProvider.allClientsDB
        .map(
          (e) => ClientItem(client: e),
        )
        .toList();

  

    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 30),
          Row(
            children: [
              const SizedBox(width: 30),
              Text('Lista de clientes', style: text32Headline(context)),
            ],
          ),
          const SizedBox(height: 30),
          Column(
            children: [...clientsDB],
          ),
          const SizedBox(height: 100)
        ],
      ),
    );
  }
}
