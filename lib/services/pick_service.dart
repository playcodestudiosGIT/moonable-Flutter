import 'package:file_picker/file_picker.dart';
import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
import 'package:moonable/models/cliente_load_model.dart';

import 'package:moonable/models/order_load_model.dart';
import 'package:moonable/providers/list_orders_provider.dart';
import 'package:provider/provider.dart';

import '../providers/list_clients_provider.dart';

class PickServices {
  static pickOrders(BuildContext context) async {
    Provider.of<ListOrdersProvider>(context, listen: false).isLoading = true;
    FilePickerResult? pickedFile = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['xlsx'],
      allowMultiple: false,
    );

    if (pickedFile == null) {
      if (context.mounted) Provider.of<ListOrdersProvider>(context, listen: false).isLoading = false;
      return;
    }

    /// file might be picked
    List<OrderLoad> orders = [];
    var bytes = pickedFile.files.single.bytes;
    var excel = Excel.decodeBytes(bytes!);
    var table = excel.tables.keys.first;
    for (var i = 4; i <= 100; i++) {
      final row = excel.tables[table]?.rows[i];

      if (row == null || row[0]?.value == null) {
      } else {
        final order = OrderLoad(
          orderId: row[0]?.value.toString() ?? 'N/A',
          platform: row[1]?.value.toString() ?? 'N/A',
          businessName: row[2]?.value.toString() ?? 'N/A',
          firstName: row[3]?.value.toString() ?? 'N/A',
          lastName: row[4]?.value.toString() ?? 'N/A',
          ibanWallet: row[5]?.value.toString() ?? 'N/A',
          fiatAmount: row[6]?.value.toString() ?? 'N/A',
          fiatType: row[7]?.value.toString() ?? 'N/A',
          exchangeRate: row[8]?.value.toString() ?? 'N/A',
          totalAssetPurchase: row[9]?.value.toString() ?? 'N/A',
          assetType: row[10]?.value.toString() ?? 'N/A',
          percent: row[11]?.value.toString() ?? 'N/A',
          dueDate: row[12]?.value.toString() ?? 'N/A',
        );

        orders.add(order);
      }
    }
    if (context.mounted) {
      Provider.of<ListOrdersProvider>(context, listen: false).orders = orders;
      Provider.of<ListOrdersProvider>(context, listen: false).isLoading = false;
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
    List<ClienteLoad> clients = [];
    var bytes = pickedFile.files.single.bytes;
    var excel = Excel.decodeBytes(bytes!);
    var table = excel.tables.keys.first;
    for (var i = 1; i <= 100; i++) {
      final row = excel.tables[table]?.rows[i];

      if (row == null) {
        // print('empty');
      } else {
        
        final cliente = ClienteLoad(
          businessName: row[0]?.value.toString() ?? 'N/A',
          firstName: row[1]?.value.toString() ?? 'N/A',
          lastName: row[2]?.value.toString() ?? 'N/A',
          ibanWallet: [row[3]?.value?.toString() ?? '', row[4]?.value?.toString() ?? '', row[5]?.value?.toString() ?? ''],
          tier: row[6]?.value.toString().split("-")[0].trim() ?? 'N/A',
          tierStatus: row[6]?.value.toString().split("-")[1].trim() ?? 'N/A',
          clientType: row[7]?.value.toString() ?? 'N/A',
          registryDate: row[8]?.value.toString() ?? 'N/A',
          countryResidency: row[9]?.value.toString() ?? 'N/A',
          nationality: row[10]?.value.toString() ?? 'N/A',
          birth: row[11]?.value.toString() ?? 'N/A',
          documentNumber: row[12]?.value.toString() ?? 'N/A',
          expirationDate: row[13]?.value.toString() ?? 'N/A',
          clientId: row[14]?.value.toString() ?? 'N/A',
          tierRisk: row[15]?.value.toString() ?? 'N/A',
          residenceLand: row[16]?.value.toString() ?? 'N/A',
          nationalityLand: row[17]?.value.toString() ?? 'N/A',
          ibanLand: row[18]?.value.toString() ?? 'N/A',
          residenceRisk: (row[19]!.value.toString().isEmpty) ? '5' : row[19]!.value.toString(),
          nationalityRisk: (row[20]!.value.toString().isEmpty) ? '5' : row[20]!.value.toString(),
          ibanGeoRisk: (row[21]!.value.toString().isEmpty) ? '5' : row[21]!.value.toString(),
          userAge: row[22]?.value.toString() ?? 'N/A',
          userAgeRisk: (row[20]!.value.toString().isEmpty) ? '5' : row[23]!.value.toString(),
          userTypeRisk: (row[24]!.value.toString().isEmpty) ? '5' : row[24]!.value.toString(),
          concatenacionIban: [row[25]?.value?.toString() ?? '', row[26]?.value?.toString() ?? '', row[27]?.value?.toString() ?? ''],
          concatenacionBusinessNameIban: [row[28]?.value?.toString() ?? '', row[29]?.value?.toString() ?? '', row[30]?.value?.toString() ?? ''],
          auxRiesgo: row[31]?.value.toString() ?? 'N/A',
        );

        clients.add(cliente);
      }
    }
    if (context.mounted) {
      Provider.of<ListClientsProvider>(context, listen: false).clientsLoad = clients;
    }
  }
}
