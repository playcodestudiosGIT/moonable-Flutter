import 'package:flutter/material.dart';
import 'package:moonable/models/cliente_model.dart';

class ClientsUploadDTS extends DataTableSource {
  List<Cliente?> clientes;
  final BuildContext context;
  ClientsUploadDTS({required this.clientes, required this.context});

  @override
  DataRow getRow(int index) {
    final Cliente? cliente = clientes[index];
    if (cliente != null) {
      return DataRow(
        
        cells: [
        DataCell(
          Container(
          alignment: Alignment.centerLeft,
          width: 70,
          height: 50,
          child: FittedBox(child: Text(cliente.nombre, style: Theme.of(context).textTheme.bodySmall)),
        )),
        
      ]);
    }
    return const DataRow(cells: []);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => clientes.length;

  @override
  int get selectedRowCount => 0;
}
