import 'package:file_picker/file_picker.dart';
import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
import 'package:moonable/models/cliente_model.dart';

import 'package:moonable/providers/operations_provider.dart';
import 'package:provider/provider.dart';

import '../models/operation_model.dart';
import '../providers/clients_provider.dart';

class PickServices {
  static pickOp(BuildContext context) async {
    Provider.of<OperationsProvider>(context, listen: false).isLoading = true;
    FilePickerResult? pickedFile = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['xlsx'],
      allowMultiple: false,
    );

    if (pickedFile == null) {
      if (context.mounted) {
        Provider.of<OperationsProvider>(context, listen: false).isLoading =
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
        final millis = (double.tryParse(row[12]?.value.toString() ?? "00000")! -
                gsDateBase) *
            gsDateFactor;
        final operation = Operation(
            client: '',
            createdAt: DateTime.now(),
            updatedAt: DateTime.now(),
            uid: '',
            estado: true,
            platform: row[1]?.value.toString() ?? 'OKX',
            ibanWallet: row[5]?.value.toString() ?? '000000',
            fiatAmount: row[6]?.value ?? 0.0,
            fiatType: row[7]?.value.toString() ?? 'EUR',
            exchangeRate: row[8]?.value ?? 0.0,
            assetType: row[10]?.value.toString() ?? 'EUR',
            percent: row[11]?.value ?? 0.0,
            dueDate: DateTime.fromMillisecondsSinceEpoch(millis.toInt(),
                isUtc: true));

        operations.add(operation);
      }
    }
    if (context.mounted) {
      Provider.of<OperationsProvider>(context, listen: false).operationsLoad =
          operations;
      Provider.of<OperationsProvider>(context, listen: false).isLoading = false;
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
    List<Client> clients = [];
    var bytes = pickedFile.files.single.bytes;
    var excel = Excel.decodeBytes(bytes!);
    var table = excel.tables.keys.first;
    for (var i = 1; i <= 100; i++) {
      final row = excel.tables[table]?.rows[i];

      if (row == null) {
        // print('empty');
      } else {
        final cliente = Client(
            businessName: row[0]?.value.toString() ?? '',
            firstName: row[1]?.value.toString() ?? '',
            lastName: row[2]?.value.toString() ?? '',
            ibanWallet: [
              row[3]?.value?.toString() ?? '',
            ],
            tier: row[6]?.value.toString().split("-")[0].trim() ?? 'Tier - 0',
            tierStatus:
                row[6]?.value.toString().split("-")[1].trim() ?? 'Pending',
            clientType: row[7]?.value.toString() ?? 'Individual',
            registryDate: row[8]?.value.toString() ?? '',
            operations: [],
            countryResidency: row[9]?.value.toString() ?? '',
            nationality: row[10]?.value.toString() ?? '',
            birth: row[11]?.value.toString() ?? '',
            documentNumber: row[12]?.value.toString() ?? '',
            expirationDate: row[13]?.value.toString() ?? '',
            residenceLand: row[16]?.value.toString() ?? '',
            nationalityLand: row[17]?.value.toString() ?? '',
            userAge: row[22]?.value.toString() ?? '',
            auxRiesgo: row[23]?.value.toString() ?? '',
            estado: true,
            createdAt: DateTime.now(),
            updatedAt: DateTime.now(),
            uid: '');

        clients.add(cliente);
      }
    }
    if (context.mounted) {
      Provider.of<ClientsProvider>(context, listen: false).clientsLoad =
          clients;
    }
  }
}
