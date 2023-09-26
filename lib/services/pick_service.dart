import 'package:file_picker/file_picker.dart';
import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
import 'package:moonable/models/cliente_model.dart';

import 'package:moonable/providers/list_operations_provider.dart';
import 'package:provider/provider.dart';

import '../models/operation_model.dart';
import '../providers/list_clients_provider.dart';

class PickServices {
  static pickOp(BuildContext context) async {
    Provider.of<ListOperationsProvider>(context, listen: false).isLoading =
        true;
    FilePickerResult? pickedFile = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['xlsx'],
      allowMultiple: false,
    );

    if (pickedFile == null) {
      if (context.mounted) {
        Provider.of<ListOperationsProvider>(context, listen: false).isLoading =
            false;
      }
      return;
    }

    /// file might be picked
    List<Operation> operations = [];
    var bytes = pickedFile.files.single.bytes;
    var excel = Excel.decodeBytes(bytes!);
    var table = excel.tables.keys.first;
    
    for (var i = 4; i <= 100; i++) {
      final row = excel.tables[table]?.rows[i];

      if (row == null || row[0]?.value == null) {

      } else {
        const gsDateBase = 2209161600 / 86400;
        const gsDateFactor = 86400000;
        final millis = (double.tryParse(row[12]?.value.toString() ?? "00000")! - gsDateBase) * gsDateFactor;
        final operation = Operation(
            platform: row[1]?.value.toString() ?? 'N/A',
            ibanWallet: row[5]?.value.toString() ?? '000000',
            fiatAmount: row[6]?.value ?? 0.0,
            fiatType: row[7]?.value.toString() ?? 'N/A',
            exchangeRate: row[8]?.value ?? 0.0,
            assetType: row[10]?.value.toString() ?? 'N/A',
            percent: row[11]?.value ?? 0.0,
            dueDate: DateTime.fromMillisecondsSinceEpoch(millis.toInt(), isUtc: true)
            );

        operations.add(operation);
      }
    }
    if (context.mounted) {
      Provider.of<ListOperationsProvider>(context, listen: false)
          .operationsLoad = operations;
      Provider.of<ListOperationsProvider>(context, listen: false).isLoading =
          false;
    }
  }

  static pickClients(BuildContext context) async {
    FilePickerResult? pickedFile = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['xlsx'],
      allowMultiple: false,
    );
    if (pickedFile == null) return;

    /// file might be picked
    List<Cliente> clients = [];
    var bytes = pickedFile.files.single.bytes;
    var excel = Excel.decodeBytes(bytes!);
    var table = excel.tables.keys.first;
    for (var i = 1; i <= 100; i++) {
      final row = excel.tables[table]?.rows[i];

      if (row == null) {
        // print('empty');
      } else {
        final cliente = Cliente(
          businessName: row[0]?.value.toString() ?? 'N/A',
          firstName: row[1]?.value.toString() ?? 'N/A',
          lastName: row[2]?.value.toString() ?? 'N/A',
          ibanWallet: [
            row[3]?.value?.toString() ?? '',
          ],
          tier: row[6]?.value.toString().split("-")[0].trim() ?? 'N/A',
          tierStatus: row[6]?.value.toString().split("-")[1].trim() ?? 'N/A',
          clientType: row[7]?.value.toString() ?? 'Individual',
          registryDate: row[8]?.value.toString() ?? 'N/A',
          operations: [],
          countryResidency: row[9]?.value.toString() ?? 'N/A',
          nationality: row[10]?.value.toString() ?? 'N/A',
          birth: row[11]?.value.toString() ?? 'N/A',
          documentNumber: row[12]?.value.toString() ?? 'N/A',
          expirationDate: row[13]?.value.toString() ?? 'N/A',
          residenceLand: row[16]?.value.toString() ?? 'N/A',
          nationalityLand: row[17]?.value.toString() ?? 'N/A',
          userAge: row[22]?.value.toString() ?? 'N/A',
          auxRiesgo: row[23]?.value.toString() ?? 'N/A',
        );

        clients.add(cliente);
      }
    }
    if (context.mounted) {
      Provider.of<ListClientsProvider>(context, listen: false).clientsLoad =
          clients;
    }
  }
}
