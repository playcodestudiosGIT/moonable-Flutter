import 'package:flutter/material.dart';
import 'package:moonable/providers/conf/imputs_decoration.dart';
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
              const Spacer(),
              IconButton(
                  onPressed: () {
                    showDialog(
                        context: context, builder: (context) => DialogClient());
                  },
                  icon: const Icon(Icons.person_add_alt_1)),
              const SizedBox(width: 30)
            ],
          ),
          const SizedBox(height: 15),
          ...clientsDB,
          const SizedBox(height: 100)
        ],
      ),
    );
  }
}

// ignore: must_be_immutable
class DialogClient extends StatefulWidget {
  DialogClient({super.key});
  String clientType = 'Individual';
  @override
  State<DialogClient> createState() => _DialogClientState();
}

class _DialogClientState extends State<DialogClient> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: SizedBox(
        height: 450,
        width: 340,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Agregar cliente', style: text22Title(context),),
            const SizedBox(height: 30),
            Expanded(
              child: SingleChildScrollView(
                child: Column(children: [
                  DropdownButton(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                value: widget.clientType,
                isExpanded: true,
                underline: Container(),
                items: const [
                  DropdownMenuItem(
                    value: 'Individual',
                    child: Padding(
                      padding: EdgeInsets.only(left: 8.0),
                      child: Text('Individual'),
                    ),
                  ),
                  DropdownMenuItem(
                      value: 'Business',
                      child: Padding(
                        padding: EdgeInsets.only(left: 8.0),
                        child: Text('Business'),
                      ))
                ],
                onChanged: (value) {
                  setState(() {
                    widget.clientType = value!;
                  });
                },
                ),
                if (widget.clientType == 'Individual') ...[
                const SizedBox(height: 10),
                TextField(
                    decoration: InputsDeco.textFormDeco(
                        label: 'First Name', icon: Icons.person)),
                const SizedBox(height: 10),
                TextField(
                    decoration: InputsDeco.textFormDeco(
                        label: 'Last Name', icon: Icons.assignment_ind)),
                ],
                if (widget.clientType == 'Business') ...[
                const SizedBox(height: 10),
                TextField(
                    decoration: InputsDeco.textFormDeco(
                        label: 'Business Name', icon: Icons.business)),
                ],
                const SizedBox(height: 10),
                TextField(
                  decoration: InputsDeco.textFormDeco(
                      label: 'IBAN Wallet', icon: Icons.assured_workload)),
                const SizedBox(height: 10),
                TextField(
                  decoration: InputsDeco.textFormDeco(
                      label: 'Country resicency', icon: Icons.public)),
                const SizedBox(height: 10),
                TextField(
                  decoration: InputsDeco.textFormDeco(
                      label: 'Nationality', icon: Icons.language)),
                
                ],),
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
