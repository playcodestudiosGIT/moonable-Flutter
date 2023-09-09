import 'package:flutter/material.dart';
import 'package:moonable/data/clients_upload_dts.dart';
import 'package:moonable/models/cliente_model.dart';

class UploadClientsDTT extends StatelessWidget {
  final List<Cliente?> clientes;
  const UploadClientsDTT({super.key, required this.clientes});

  @override
  Widget build(BuildContext context) {
    final wSize = MediaQuery.of(context).size.width;
    final hSize = MediaQuery.of(context).size.height;

    return Column(
      children: [
        SizedBox(
          height: hSize - 138,
          width: wSize,
          // constraints: const BoxConstraints(maxWidth: 1200, minHeight: 400),
          child: ListView(
            children: [
              PaginatedDataTable(
                actions: [
                  IconButton(onPressed: () {}, icon: const Icon(Icons.filter_alt_sharp)),
                  IconButton(onPressed: () {}, icon: const Icon(Icons.list)),
                  IconButton(onPressed: () {}, icon: const Icon(Icons.view_module_rounded)),
                ],
                arrowHeadColor: Theme.of(context).colorScheme.primary,
                rowsPerPage: 30,
                dataRowMaxHeight: 50,
                checkboxHorizontalMargin: 24,
                header: Text(
                  'Lista de Clientes',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                columns: const [
                  DataColumn(label: Text('TASK ID')),

                ],
                source: ClientsUploadDTS(context: context, clientes: clientes),
              ),
            ],
          ),
        ),
        // Container(width: wSize, height: 60, color: Colors.red)//Theme.of(context).colorScheme.background)
      ],
    );
  }
}
