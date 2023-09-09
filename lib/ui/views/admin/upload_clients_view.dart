import 'package:flutter/material.dart';
import 'package:moonable/models/cliente_model.dart';
import 'package:moonable/ui/widgets/datatables/upload_clients_dtt_view.dart';
import 'package:provider/provider.dart';

import '../../../providers/clientes_provider.dart';
import '../../widgets/botones/floating_button_csv_orders.dart';

class UploadClientsView extends StatelessWidget {
  const UploadClientsView({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Cliente?> clientes = Provider.of<ClientesProvider>(context).clientes;
    return Scaffold(
      floatingActionButton: const FloatingButtonCsvOrders(),
      body: UploadClientsDTT(clientes: clientes),
    );
  }
}



