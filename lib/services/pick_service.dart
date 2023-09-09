import 'package:file_picker/file_picker.dart';
import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
import 'package:moonable/models/order_model.dart';
import 'package:moonable/providers/list_orders_provider.dart';
import 'package:provider/provider.dart';

class PickServices {
  static pickOrders(BuildContext context) async {
    Provider.of<ListOrdersProvider>(context, listen: false).isLoading = true;
    FilePickerResult? pickedFile = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['xlsx'],
      allowMultiple: false,
    );

    if (pickedFile == null) {
      Provider.of<ListOrdersProvider>(context, listen: false).isLoading = false;
      return;
    }

    /// file might be picked
    List<Order> orders = [];
    var bytes = pickedFile.files.single.bytes;
    var excel = Excel.decodeBytes(bytes!);
    var table = excel.tables.keys.first;
    for (var i = 4; i <= 100; i++) {
      final row = excel.tables[table]?.rows[i];

      if (row == null || row[0]?.value == null) {
        print(null);
      } else {
        final order = Order(
          orderId: row[0]?.value.toString() ?? '',
          platform: row[1]?.value.toString() ?? '',
          businessName: row[2]?.value.toString() ?? 'no data',
          firstName: row[3]?.value.toString() ?? '',
          lastName: row[4]?.value.toString() ?? '',
          ibanWallet: row[5]?.value.toString() ?? '',
          fiatAmount: row[6]?.value.toString() ?? '',
          fiatType: row[7]?.value.toString() ?? '',
          exchangeRate: row[8]?.value.toString() ?? '',
          totalAssetPurchase: row[9]?.value.toString() ?? '',
          assetType: row[10]?.value.toString() ?? '',
          percent: row[11]?.value.toString() ?? '',
          dueDate: row[12]?.value.toString() ?? '',
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
    List<Order> orders = [];
    var bytes = pickedFile.files.single.bytes;
    var excel = Excel.decodeBytes(bytes!);
    var table = excel.tables.keys.first;
    for (var i = 4; i <= 100; i++) {
      final row = excel.tables[table]?.rows[i];

      if (row == null || row[0]?.value == null) {
        print(null);
      } else {
        final order = Order(
          orderId: row[0]?.value.toString() ?? '',
          platform: row[1]?.value.toString() ?? '',
          businessName: row[2]?.value.toString() ?? 'no data',
          firstName: row[3]?.value.toString() ?? '',
          lastName: row[4]?.value.toString() ?? '',
          ibanWallet: row[5]?.value.toString() ?? '',
          fiatAmount: row[6]?.value.toString() ?? '',
          fiatType: row[7]?.value.toString() ?? '',
          exchangeRate: row[8]?.value.toString() ?? '',
          totalAssetPurchase: row[9]?.value.toString() ?? '',
          assetType: row[10]?.value.toString() ?? '',
          percent: row[11]?.value.toString() ?? '',
          dueDate: row[12]?.value.toString() ?? '',
        );

        orders.add(order);
      }
    }
    if (context.mounted) {
      Provider.of<ListOrdersProvider>(context, listen: false).orders = orders;
    }
  }
}
